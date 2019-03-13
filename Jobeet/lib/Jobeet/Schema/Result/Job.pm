package Jobeet::Schema::Result::Job;
use v5.16.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Models;
use Jobeet::Schema::Types;
use Digest::SHA1 qw/sha1_hex/;
use Data::UUID;

__PACKAGE__->table('jobeet_job');

__PACKAGE__->add_columns(
    id => PK_INTEGER,
    category_id => INTEGER,
    type => NULLABLE_VARCHAR,
    position => VARCHAR,
    location => VARCHAR,
    description => TEXT,
    how_to_apply => TEXT,
    token => VARCHAR,
    is_public => TINYINT(
        default_value => 1,
    ),
    is_activated => TINYINT,
    email => VARCHAR,
    company => NULLABLE_VARCHAR,
    logo => NULLABLE_VARCHAR,
    url => NULLABLE_VARCHAR,
    expires_at => DATETIME,
    created_at => DATETIME,
    updated_at => DATETIME,
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['token']);

__PACKAGE__->belongs_to( category => 'Jobeet::Schema::Result::Category', 'category_id');

sub insert {
    my $self = shift;

    $self->expires_at( models('Schema')->now->add(days => models('conf')->{active_days}) );
    $self->token( sha1_hex(Data::UUID->new->create) );
    $self->next::method(@_);
}

# --- action --- #

sub publish {
    my ($self) = @_;
    $self->update({ is_activated => 1 });
}

# --- util --- #

sub is_expired {
    my ($self) = @_;
    $self->days_before_expired < 0;
}

sub days_before_expired {
    my ($self) = @_;
    ($self->expires_at - models('Schema')->now)->days;
}

sub expires_soon {
    my ($self) = @_;
    $self->days_before_expired < 5;
}

1;
