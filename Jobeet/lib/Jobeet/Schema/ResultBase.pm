package Jobeet::Schema::ResultBase;
use v5.16.3;
use strict;
use warnings;
use parent 'DBIx::Class';

use JSON qw/to_json from_json/;

# Result(テーブル定義)系の共通部分をまとめたクラス
# 各Resultクラスはこのクラスを継承する

# 少なくともResultとして働くためにはCoreのLoadが必要
__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);

sub insert {
    my $self = shift;

    my $now = Jobeet::Schema->now;
    $self->created_at( $now ) if $self->can('created_at');
    $self->updated_at( $now ) if $self->can('updated_at');

    $self->next::method(@_);
}

sub update {
    my $self = shift;

    if ($self->can('updated_at')) {
        $self->updated_at(Jobeet::Schema->now);
    }

    $self->next::method(@_);
}

sub inflate_json_column {
    my $pkg = shift;
    my @columns = @_;

    for my $column (@columns) {
        $pkg->inflate_column(
            $column, # カラム名
            {
                # カラムデータ -> オブジェクト
                # Note:
                # $p && from_json($p) は以下と同じ(はず)
                # if ($p) { from_json($p); } else { undef; }
                inflate => sub { my $p = shift; $p && from_json($p); },
                # オブジェクト -> カラムデータ
                deflate => sub { my $p = shift; $p && to_json($p); },
            }
            );
    }
}

1;
