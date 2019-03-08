#!/usr/bin/env perl -w

use strict;
use warnings;
use utf8;
use lib 'lib';
use feature qw(say);

use Jobeet::Models;
use Getopt::Long;
use GitDDL;

GetOptions(
    # my %optionsで空のハッシュ変数optionsを作成しつつ
    # そのリファレンスをGetOptionsの第1引数として渡している
    \my %options,
    qw/dry-run/
);

# config.pl で設定した値を取り出す
my $dsn = models('conf')->{database}->[0];
# Note:
# <プロジェクトルート> = <Gitルート/Jobeet> になっており、
# <プロジェクトルート> = <Gitルート> の前提で書かれている
# Advent Calendarとはパス設定が異なるので注意 !
my $gd = GitDDL->new(
    work_tree => models('home')->stringify . "/..",
    ddl_file => './Jobeet/sql/schema.sql',
    dsn => models('conf')->{database},
);

my $db_version = '';
eval {
    open my $fh, '>', \my $stderr;
    local *STDERR = $fh;
    $db_version = $gd->database_version;
};

if (!$db_version) {
    $gd->deploy;
    say 'done migrate';
    exit;
}

if ($gd->check_version) {
    say 'Database is already latest';
} else {
    print $gd->diff . "\n";

    if (!options{'dry-run'}) {
        $gd->upgrade_database;
        say 'done migrate';
    }
}
