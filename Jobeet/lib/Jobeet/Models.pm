package Jobeet::Models;
use strict;
use warnings;
use Ark::Models '-base';

# 今のところは、registerという関数でモデルを登録するということだけ理解しておく。
# 細部は別の章で見る。

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
}

1;
