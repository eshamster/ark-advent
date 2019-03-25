package Jobeet;
use Ark;

use_model 'Jobeet::Models'; # ← 作成時点で書いてあった :-)
our $VERSION = '0.01';

__PACKAGE__->meta->make_immutable;

# プラグインの読み込み
use_plugins
  qw{
        Session
        Session::State::Cookie
        Session::Store::Model

        I18N
};

# プラグインの設定
config 'Plugin::Session' => {
    expires => '+30d', # セッション期限
};

config 'Plugin::Session::State::Cookie' => {
    cookie_name => 'jobeet_session',
};

config 'Plugin::Session::Store::Model' => {
    model => 'cache', # models('cache')
};

__END__

=head1 NAME

Jobeet -

=head1 SYNOPSIS

use Jobeet;

=head1 DESCRIPTION

Jobeet is

=head1 AUTHOR

eshamster E<lt>hamgoostar@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
