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

for my $table (qw/Job Category CategoryAffiliate Affiliate/) {
    register "Schema::$table" => sub {
        my $self = shift;
        $self->get('Schema')->resultset($table);
    };
}

1;
