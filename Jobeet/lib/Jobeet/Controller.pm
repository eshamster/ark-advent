package Jobeet::Controller;
use Ark 'Controller';
use Jobeet::Models;

# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    $c->res->body('Ark Default Index');
}

# Note:
# "Private"の部分はattributes(属性)と呼ばれるもの。
# importの際に同じ属性の関数をまとめてimportしたりできる。
# Note:
# end = コントローラの実行の最後に実行される特別なアクション
sub end : Private {
    my ($self, $c) = @_;

    # レスポンスがまだ定義されていない場合
    unless ($c->res->body or $c->res->status =~ /^3\d\d/) {
        # MT ビューに処理を配送する
        $c->forward( $c->view('MT') );
    }
}


__PACKAGE__->meta->make_immutable;
