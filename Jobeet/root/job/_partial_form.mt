? my $form = shift;

<form method="post">
  <tfoot>
    <tr>
      <td colspan="2">
        <input type="submit" value="Preview your job" />
      </td>
    </tr>
  </tfoot>
  <tbody>
?   for my $field (qw/category type company url position location description how_to_apply email/) {
    <tr>
      <th><?= raw_string $form->label($field) ?></th>
      <td>
?           if ($form->is_error($field)) {
        <ul class="error_list">
?               for my $err (@{ $form->error_messages($field) }){
          <li><?= raw_string $err ?></li>
?               }
        </ul>
?           }
        <?= raw_string $form->input($field) ?>
      </td>
    </tr>
?   } # end for
  </tbody>
</form>
