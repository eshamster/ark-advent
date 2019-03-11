package Jobeet::Schema::ResultSet::Category;
use strict;
use warnings;
use utf8;
use parent 'DBIx::Class::ResultSet';

use Jobeet::Models;

sub get_with_jobs {
    my $self = shift;

    # Note: 出力されるSQL
    # SELECT me.id, me.name, me.slug
    #   FROM jobeet_category me
    #     LEFT JOIN jobeet_job jobs
    #       ON jobs.category_id = me.id
    #   WHERE ( jobs.expires_at >= ? )
    #   GROUP BY me.name
    $self->search(
        { 'jobs.expires_at' => { '>=', models('Schema')->now->strftime("%F %T") } },
        { join => 'jobs', group_by => 'me.name' }
    );
}

1;
