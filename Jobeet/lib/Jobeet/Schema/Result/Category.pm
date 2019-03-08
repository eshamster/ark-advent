package Jobeet::Schema::Result::Category;
use v5.16.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;

__PACKAGE__->table('jobeet_category');

__PACKAGE__->add_columns(
    id => PK_INTEGER,
    name => VARCHAR,
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['name']);

1;
