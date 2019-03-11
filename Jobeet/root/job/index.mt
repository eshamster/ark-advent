? extends 'common/base'

<!-- stylesheets ブロックの上書き -->
? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('css/jobs.css') ?>" />
? }

<!-- content ブロックの上書き -->
? block content => sub {
<div id="jobs">
? for my $category ($c->stash->{categories}->all) {
  <div class="category_<?= lc $category->name?>">
    <div class="category">
      <div class="feed">
        <a href="">Feed</a>
      </div>
      <h1>
        <a href="<?= $c->uri_for('/category', $category->slug) ?>">
          <?= $category->name?>
        </a>
      </h1>
    </div>

    <table class="jobs">
? my $i = 0;
? my $max_rows = $c->config->{max_jobs_on_homepage};
? for my $job ($category->get_active_jobs({ rows => $max_rows })) {
      <tr class="<?= $i++ % 2 == 0 ? 'even' : 'odd'?>">
        <td class="location"><? $job->location?></td>
        <td class="position"
          <a href="<?= $c->uri_for('/job', $job->id)?>">
            <?= $job->position?>
          </a>
        </td>
        <td class="company"><?= $job->company?></td>
      </tr>
? } # end for $job
    </table>

    <!-- $max_rows件以上の場合はカテゴリページへのリンクを表示 -->
? my $count = $category->get_active_jobs->count;
? my $rest = $count - $max_rows;
? if ($rest > 0) {
    <div class="more_job">
      and <a href="<?= $c->uri_for('/category', $category->slug)?>"><?= $rest ?></a>
      more..
    </div>
? } # end if
  </div>
? } # end for $category
</div>
? } # end block content
