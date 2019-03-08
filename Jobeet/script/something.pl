#!/usr/bin/env perl -w

use strict;
use warnings;
use lib 'lib';
use feature qw(say);

use Jobeet::Models;
my $json_string1 = '{"hoge": "fuga"}';
my $json_string2 = '{"foo": "bar"}';

my $data = models('Schema::Something')->create (
    {
        json_column1 => $json_string1,
        json_column2 => $json_string2,
    });

say $data->json_column1->{hoge}; # = fuga

my $json1 = { hoge => 'fuga' };
my $json2 = { foo => 'bar' };

my $data2 = models('Schema::Something')->create (
    {
        json_column1 => $json1,
        json_column2 => $json2,
    });

say $data2->json_column2->{foo}; # = bar

=pod
実行後のテーブルの中身を覗いてみる

$ sqlite3 ./database.db 
SQLite version 3.24.0 2018-06-04 14:10:15
Enter ".help" for usage hints.
sqlite> select * from jobeet_something;
{"hoge": "fuga"}|{"foo": "bar"}
{"hoge":"fuga"}|{"foo":"bar"}
=cut
