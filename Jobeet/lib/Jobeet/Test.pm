package Jobeet::Test;
use Ark 'Test';

use File::Temp qw/tempdir/;
use Jobeet::Models;

# Note:
# (import は use 時に呼び出されるので)
# use Jobeet::Test;することで、テスト用の新しいデータベースが作成される

sub import {
    my ($class, $app, %options) = @_;
    $app ||= 'Jobeet';

    {
        # Note:
        # CLEANUP: プログラム終了時に一時フォルダを削除
        my $dir = tempdir( CLEANUP => 1 );

        models('conf')->{database} = [
            "dbi:SQLite:$dir/jobeet-test-database.db", undef, undef,
            { sqlite_unicode => 1, ignore_version => 1 },
           ];
        models('Schema')->deploy;
    }

    @_ = ($class, $app, %options);
    goto $class->can('SUPER::import');
}

1;
