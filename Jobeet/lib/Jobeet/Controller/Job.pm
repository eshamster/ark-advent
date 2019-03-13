package Jobeet::Controller::Job;
use Ark 'Controller';
# Note: フォームを利用するために必要
with 'Ark::ActionClass::Form';

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
    $c->stash->{categories} = models('Schema::Category')->get_with_jobs;
}

# /job/{job_token} (詳細)
sub show :Path :Args(1) {
    my ($self, $c, $job_token) = @_;

    $c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
        or $c->detach('/default');
}

# /job/create (新規作成)
sub create :Local :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    # Note: フォームクラスのひも付け
    $c->stash->{form} = $self->form;

    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
        # (良い感じにやってくれるすごい関数かと思ったら自作だった -> create_from_form)
        # (とはいえ、form->paramsをほぼそのままINSERT(create)に利用できている)
        my $job = models('Schema::Job')->create_from_form($self->form);
        $c->redirect($c->uri_for('/job', $job->token));
    }
}


# --- 以下 :Chained --- #

# Note:
# 中間アクション。
#   - ":Chained" の引数は必ず'/'にする
#   - ":CaptureArgs" を利用する
# ":CaptureArgs"をつけることで":Parivate"同様に、
# 直接アクセスすることはできなくなる。
# お試し: ":CaptureArgs(2)"とすると、
# 例えばeditアクションのパスは "/job/*/*/edit"になる
sub job :Chained('/') :PathPart :CaptureArgs(1) {
    my ($self, $c, $job_token) = @_;

    $c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
        or $c->detach('/default');
}

# 末端アクション
#   - ":Args" を利用する
# /job/{job_token}/edit (編集) (PathPart = "edit")
sub edit :Chained('job') :PathPart :Args(0) :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    my $job = $c->stash->{job};

    $c->stash->{form} = $self->form;

    if ($c->req->method eq 'POST') {
        if ($self->form->submitted_and_valid) {
            $job->update_from_form($self->form);
            $c->redirect($c->uri_for('/job', $job->token));
        }
    } else {
        $self->form->fill
            ({
                $job->get_columns,
                    category => $job->category->slug,
             });
    }
}

# /job/{job_token}/delete (削除) (PathPart = "delete")
sub delete :Chained('job') :PathPart :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{job}->delete;
    $c->redirect($c->uri_for('/job'));
}

# /job/{job_token}/publish (有効化) (PathPart = "publish")
sub publish :Chained('job') :PathPart {
    my ($self, $c) = @_;

    my $job = $c->stash->{job};

    $job->publish;
    $c->redirect($c->uri_for('/job', $job->token));
}

__PACKAGE__->meta->make_immutable;

1;
