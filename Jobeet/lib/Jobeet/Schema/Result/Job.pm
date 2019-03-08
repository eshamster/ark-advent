package Jobeet::Schema::Result::Job;
use v5.16.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';

__PACKAGE__->table('jobeet_job');

__PACKAGE__->add_columns(
    id => {
        date_type => 'INTEGER',
        is_nullable => 0,
        is_auto_increment => 1,
        # extra: https://metacpan.org/pod/DBIx::Class::ResultSource#extra
        # CHECK: 特定のDBに固有の属性を追加している？
        extra => {
            unsigned => 1,
        },
    },
    category_id => {
        data_type => 'INTEGER',
        is_nullable => 0,
        extra => {
            unsigned => 1,
        },
    },
    type => {
        data_type => 'VARCHAR',
        size => 255,
        is_nullable => 1,
    },
    position => {
        data_type => 'VARCHAR',
        size => 255,
        is_nullable => 0,
    },
    description => {
        data_type => 'TEXT',
        is_nullable => 0
    },
    how_to_apply => {
        data_type => 'TEXT',
        is_nullable => 0
    },
    token => {
        data_type => 'VARCHAR',
        size => 255,
        is_nullable => 0,
    },
    is_public => {
        data_type => 'TINYINT',
        is_nullable => 0,
        default_value => 1,
    },
    is_activated => {
        data_type => 'TINYINT',
        is_nullable => 0,
        default_value => 0,
    },
    email => {
        data_type => 'VARCHAR',
        size => 255,
        is_nullable => 0,
    },
    expired_at => {
        data_type => 'DATETIME',
        is_nullable => 0,
        timezone => Jobeet::Schema->TZ,
    },
    created_at => {
        data_type => 'DATETIME',
        is_nullable => 0,
        timezone => Jobeet::Schema->TZ,
    },
    updated_at => {
        data_type => 'DATETIME',
        is_nullable => 0,
        timezone => Jobeet::Schema->TZ,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['token']);

1;
