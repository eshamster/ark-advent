package Jobeet::Schema::Result::Category;
use v5.16.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';

use String::CamelCase qw(decamelize);
use Data::Page::Navigation;

use Jobeet::Schema::Types;

use Jobeet::Models;

__PACKAGE__->table('jobeet_category');

__PACKAGE__->add_columns(
    id => PK_INTEGER,
    name => VARCHAR,
    slug => NULLABLE_VARCHAR,
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->add_unique_constraint(['slug']);

__PACKAGE__->has_many( jobs => 'Jobeet::Schema::Result::Job', 'category_id');
__PACKAGE__->has_many(
    category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'category_id',
    {
        # 無駄なインデックスを作らせないため
        is_foreign_key_constraint => 0,
        # (名前の通り)
        cascade_delete => 0,
    });

__PACKAGE__->many_to_many( affiliates => category_affiliate => 'affiliate' );

# --- utils --- #

sub get_active_jobs {
    my $self = shift;
    my $attr = shift || {};

    # search の第一引数は検索条件 (WHERE)
    # search の第二引数は検索の属性 (LIMIT, ORDER BY, ...)
    $self->jobs(
        { expires_at => { '>=', models('Schema')->now } },
        {
            order_by => { -desc => 'created_at' },
            defined $attr->{rows} ? (rows => $attr->{rows}) : (),
            defined $attr->{page} ? (page => $attr->{page}) : (),
        }
    );
}

sub insert {
    my $self = shift;

    $self->slug(decamelize $self->name);

    $self->next::method(@_);
}

sub update {
    my $self = shift;

    if ($self->is_column_changed('name')) {
        $self->slug(decamelize $self->name);
    }

    $self->next::method(@_);
}

1;
