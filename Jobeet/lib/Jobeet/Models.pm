package Jobeet::Models;
use strict;
use warnings;
# Note: モデルクラスであることの宣言
use Ark::Models '-base';

# Note:
# registerで登録したモデルクラスの取得
# 1. use Jobeet::Models;
# 2. 登録名を指定して取得する(↓いずれか)
#    - my $obj = models('Schema::Job');
#    - my $obj = models->get('Schema::Job');
#    - my $obj = Jobeet::Schema->get('Schema::Job');

# Note: registerで登録したモデルクラスのは必要になった時点でロードされる
register Schema => sub {
    my $self = shift;

    my $conf = $self->get('conf')->{database}
    or die 'require database config';

    $self->ensure_class_loaded('Jobeet::Schema');
    Jobeet::Schema->connect(@$conf);
};

# Schema/Result 以下のモジュールを自動的に登録する
autoloader qr/^Schema::/ => sub { # qr: 正規表現を定義
    my ($self, $name) = @_;

    my $schema = $self->get('Schema');
    for my $t ($schema->sources) {
        $self->register( "Schema::$t" => sub { $schema->resultset($t) });
    }
};

1;
