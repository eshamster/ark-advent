package Jobeet::Schema;
use v5.16.3;
use strict;
use warnings;
use parent 'DBIx::Class:Schema';
use DateTime;

# ResultクラスとResultSetクラスのコードをロードする
#   - Result: データベースの1つのテーブルに対応する
#   - ResultSet: 同名のResultクラスの集合を表す
__PACKAGE__->load_namespaces;

# 日付処理関連
sub TZ { state $TZ = DateTime::TimeZone->new(name => 'Asia/Tokyo') }
sub now { DateTime->now(time_zone => shift->TZ, locale => 'ja') }
sub today { shift->now->truncate(to => 'day') }

1;
