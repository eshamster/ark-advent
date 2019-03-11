package Jobeet::Controller::Job;
use Ark 'Controller';

# Note: carton exec perl script/dev/skeltion.pl controller Job で作成

use Jobeet::Models;
# Note:
# 下記スケルトンで追加されたものであるが、今回のケースではなくても同じ。
# デフォルトがコントーラ名("Job")を小文字にしたものであるため。
has '+namespace' => default => 'job';

# Note:
# ":Private" = URLとは対応しない処理を記述する。
# 他のアクションから $c->forward('メソッド名') のように呼び出せる。

# Note:
# "auto" = メインの処理が始まる前に自動的に呼び出される
sub auto :Private {
    1;
}

# Note:
# Pathの引数が空のため、コントローラのルート ("/job") にマッチ。
# 例えば ":Path('hoge') とすると "/job/hoge"にマッチ

# Note:
# ":Args(0)" = 引数を0個受けとる (1つも受け取らない)
# ":Args(1)" とすると、/job/* にマッチするようになる
sub index :Path :Args(0) {
    my ($self, $c) = @_;

    # Note:
    # stashはコントローラとビューの間で変数を共有するために利用する
    $c->stash->{jobs} = models('Schema::Job');
}

__PACKAGE__->meta->make_immutable;

1;
