#!/usr/bin/env perl -w

use v5.16.3;
use strict;
use warnings;
use utf8;
use lib 'lib';

use Jobeet::Schema;

my $schema = Jobeet::Schema->connect('dbi:SQLite:./database.db');
$schema->deploy;
