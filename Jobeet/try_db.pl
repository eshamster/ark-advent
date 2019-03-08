#!/usr/bin/env perl -w

use v5.16.3;
use strict;
use warnings;
use utf8;
use lib 'lib';

use Jobeet::Schema;

my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');
my $category_rs = $schema->resultset('Category');

my $category = $category_rs->create(
    {
        name => 'new category',
    });

print $category_rs->count . "\n";
