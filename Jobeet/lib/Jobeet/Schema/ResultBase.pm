package Jobeet::Schema::Result::Job;
use v5.16.3;
use strict;
use warnings;
use parent 'DBIx::Class';

# Result(テーブル定義)系の共通部分をまとめたクラス
# 各Resultクラスはこのクラスを継承する

# 少なくともResultとして働くためにはCoreのLoadが必要
__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);


1;
