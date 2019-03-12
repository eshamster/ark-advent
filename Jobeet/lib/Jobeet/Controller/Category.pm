package Jobeet::Controller::Category;
use Ark 'Controller';

use Jobeet::Models;
has '+namespace' => default => 'category';

sub auto :Private {
    1;
}

sub show :Path :Args(1) {
    my ($self, $c, $category_name) = @_;

    my $category = models('Schema::Category')->find({ slug => $category_name })
        or $c->detach('/default');

    $c->stash->{category} = $category;
    $c->stash->{jobs} = $category->get_active_jobs(
        {
            rows => models('conf')->{max_jobs_on_category},
            # NOTE:
            # URLのクエリ (http://...?page=1) 取り出し。
            # 渡す側は $c->req->uri_with({ page => $pager->last_page })
            # のようにすると、現在のページの特定のクエリだけ書き換えたURLを作成できる。
            # ↑ root/category/show.mt を参照
            page => $c->req->parameters->{page} || 1,
        });
}

__PACKAGE__->meta->make_immutable;

