#!/usr/bin/env perl -w

use strict;
use warnings;
use lib 'lib';
use FindBin::Libs;

use Jobeet::Models;

my $job_rs = models('Schema::Job');
my $cat_rs = models('Schema::Category');

# --- create default Categories --- #
for my $category_name (qw/Design Programming Manager Administrator/) {
    $cat_rs->create({ name => $category_name });
}

my $programming_category =
    $cat_rs->find({ name => 'Programming' });

# --- create default Jobs --- #

# 期限内データ
my $design_category = $cat_rs->find({ name => 'Design' });
$design_category->add_to_jobs({
    type         => 'part-time',
    company      => 'Extreme Sensio',
    logo         => 'extreme-sensio.gif',
    url          => 'http://www.extreme-sensio.com/',
    position     => 'Web Designer',
    location     => 'Paris, France',
    description  => q[Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Utenim ad minim veniam, quis nostrud exercitation ullamco laborisnisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in. Voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpaqui officia deserunt mollit anim id est laborum.],
  how_to_apply   => 'Send your resume to fabien.potencier [at] sensio.com',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_extreme_sensio',
    email        => 'job@example.com',
});

# 期限切れデータ
my $job = $job_rs->create({
    category_id  => $programming_category->id,
    company      => 'Sensio Labs',
    position     => 'Web Developer',
    location     => 'Paris, France',
    description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    how_to_apply => 'Send your resume to lorem.ipsum [at] dolor.sit',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_expired',
    email        => 'job@example.com',
});

$job->update({
    created_at => '2005-12-01',
    expires_at => '2005-12-31',
});

# 大量追加
for my $i (100 .. 160) {
    my $job = $job_rs->create({
        category_id  => $programming_category->id,
        company      => "Company $i",
        position     => 'Web Developer',
        location     => 'Paris, France',
        description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
        how_to_apply => "Send your resume to lorem.ipsum [at] company_${i}.sit",
        is_public    => 1,
        is_activated => 1,
        token        => "job_$i",
        email        => 'job@example.com',
    });
}
