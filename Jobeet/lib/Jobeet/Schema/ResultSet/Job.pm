package Jobeet::Schema::ResultSet::Job;
use strict;
use warnings;
use utf8;
use parent 'DBIx::Class::ResultSet';

use Jobeet::Models;

sub create_from_form {
    my ($self, $form) = @_;

    # Note: txn_scope_guard
    # トランザクションを生成する (txn = transaction)
    # Cf. https://metacpan.org/pod/DBIx::Class::Storage#txn_scope_guard
    my $txn_guard = models('Schema')->txn_scope_guard;

    # Note:
    # 基本的には、この後ろで $form->params をそのまま $self->create に渡しているが、
    # "category" フィールドのみ列名 ("category_id") と異なるため、
    # ここでいったん取り出した上で delete している
    my $category_id = delete $form->params->{category};
    my $category = models('Schema::Category')->find({ slug => $category_id })
        or die 'no such category_id: ', $category_id;

    my $job = $self->create(
        {
            category_id => $category->id,
            %{ $form->params },
        });

    $txn_guard->commit;

    $job;
}

sub latest_post {
    my ($self) = @_;

    my $r = $self->search( { is_activated => 1, },
                           { order_by => { -desc => 'created_at' } } );

    $r->first;
}

1;
