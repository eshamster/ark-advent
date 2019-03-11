my $home = Jobeet::Models->get('home');

+{
    default_view    => 'MT',
    database => [
        'dbi:SQLite:' . $home->file('database.db'), '', '',
        {
            sqlite_unicode => 1,
        },
    ],
};
