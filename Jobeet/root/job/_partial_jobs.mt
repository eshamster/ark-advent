? my @jobs = @_;

<table class="jobs">
? my $i = 0;
? my $max_rows = $c->config->{max_jobs_on_homepage};
? for my $job (@jobs) {
  <tr class="<?= $i++ % 2 == 0 ? 'even' : 'odd'?>">
    <td class="location">
      <?= $job->location?>
    </td>
    <td class="position">
      <?= $job->position?>
    </td>
    <td class="company">
      <?= $job->company?>
    </td>
  </tr>
? } # end for $job
</table>
