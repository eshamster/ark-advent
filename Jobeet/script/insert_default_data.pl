#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use FindBin::Libs;

use Jobeet::Models;

my $datafile = models('home')->subdir(qw/sql fixtures/)->file('default.pl');
do $datafile or die $!;
