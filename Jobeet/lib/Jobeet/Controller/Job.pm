package Jobeet::Controller::Job;
use Ark 'Controller';

# Note: carton exec perl script/dev/skeltion.pl controller Job で作成

use Jobeet::Models;
has '+namespace' => default => 'job';

sub auto :Private {
    1;
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    # Note:
    # stashはコントローラとビューの間で変数を共有するために利用する
    $c->stash->{jobs} = models('Schema::Job');
}

__PACKAGE__->meta->make_immutable;

1;
