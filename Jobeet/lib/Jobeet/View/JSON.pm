package Jobeet::View::JSON;
use Ark 'View::JSON';

# Note:
# Ark::View::JSON では $c->stash のデータを全て JSON 化するが、
# $c->stash->{json} のみを JSON 化するように変更する。
has '+expose_stash' => (
    default => 'json',
);

1;
