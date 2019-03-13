use strict;
use warnings;

use Test::More tests => 11;
use Jobeet::Test;
use Jobeet::Models;

my $datafile = models('home')->subdir(qw/sql fixtures/)->file('default.pl');
do $datafile or die $!;

# 存在「しない」カテゴリのページにアクセスする場合
{
    # Note:
    # ctx_get: Jobeet::Test を通して Ark::Test からインポートしたもの
    my $c = ctx_get('/category/foo');

    # アクションが正しく呼ばれているか
    is $c->req->action->reverse, 'category/show', 'action called ok';

    # 存在しない場合404を正しく返すか
    is $c->res->status, '404', '404 status ok';
    ok !$c->stash->{category}, 'category not set';
    ok !$c->stash->{jobs}, 'jobs not set';
}

# 存在「する」カテゴリのページにアクセスする場合
{
    my $c = ctx_get('/category/design');

    is $c->req->action->reverse, 'category/show', 'action called ok';

    is $c->res->status, '200', '200 status ok';
    isa_ok $c->stash->{category}, 'Jobeet::Schema::Result::Category';
    isa_ok $c->stash->{jobs}, 'Jobeet::Schema::ResultSet::Job';
    is $c->stash->{category}->slug, 'design', 'slug ok';
}

# ページャのテスト
{
    my $c = ctx_get('/category/programming');
    is $c->stash->{jobs}->pager->current_page, 1, 'current page 1 ok';
}
{
    my $c = ctx_get('/category/programming?page=2');
    is $c->stash->{jobs}->pager->current_page, 2, 'current page 2 ok';
}

done_testing;
