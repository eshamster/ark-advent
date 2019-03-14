use strict;
use warnings;

use Test::More;
use Jobeet::Test;
use Jobeet::Models;
use JSON;

my $datafile = models('home')->subdir(qw/sql fixtures/)->file('default.pl');
do $datafile or die $!;

# 存在しないトークン
{
    my $res = request( GET => '/api/not-exist-token/jobs' );
    is $res->code, 404, '404 ok';
}

# 存在するトークン
{
    # Note:
    # 記事では single メソッドを利用しているが、バージョン 0.08100 以降、
    # 複数の行を返す場合は下記の警告が出るようになった。
    #   Query returned more than one row
    # そのため、代わりに "->find({}, {rows => 1})" を利用している。
    # Cf. https://metacpan.org/pod/DBIx::Class::ResultSet#Note
    my $data = models('Schema::Affiliate')->find({}, {rows => 1});

    my $res = request( GET => '/api/' . $data->token . '/jobs' );
    is $res->code, 200, '200 ok';
    like $res->content_type, qr|application/json|, 'content_type ok';
}

done_testing;
