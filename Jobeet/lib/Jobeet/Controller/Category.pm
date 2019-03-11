package Jobeet::Controller::Category;
use Ark 'Controller';

use Jobeet::Models;
has '+namespace' => default => 'category';

sub auto :Private {
    1;
}

sub index :Path :Args(1) {
    my ($self, $c, $category_name) = @_;
}

__PACKAGE__->meta->make_immutable;

