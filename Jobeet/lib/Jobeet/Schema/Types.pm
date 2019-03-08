package Jobeet::Schema::Types;
use v5.16.3;
use strict;
use warnings;
use parent 'Exporter';
our @EXPORT = qw/PK_INTEGER INTEGER NULLABLE_VARCHAR VARCHAR TEXT TINYINT DATETIME/;

sub PK_INTEGER {
    # +{}: (コードブロックでなく) 無名ハッシュであることを明示する構文
    +{
        data_type => 'INTEGER',
        is_nullable => 0,
        is_auto_increment => 1,
        # extra: https://metacpan.org/pod/DBIx::Class::ResultSource#extra
        # CHECK: 特定のDBに固有の属性を追加している？
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub INTEGER {
    +{
        data_type => 'INTEGER',
        is_nullable => 0,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub TINYINT {
    +{
        data_type => 'TINYINT',
        is_nullable => 0,
        default_value => 0,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub NULLABLE_VARCHAR {
    +{
        data_type => 'VARCHAR',
        size => 255,
        is_nullable => 0,
        @_,
    };
}

sub VARCHAR {
    +{
        data_type => 'VARCHAR',
        size => 255,
        is_nullable => 0,
        @_,
    };
}

sub TEXT {
    +{
        data_type => 'TEXT',
        is_nullable => 0,
        @_,
    };
}

sub DATETIME {
    +{
        data_type => 'DATETIME',
        is_nullable => 0,
        timezone => Jobeet::Schema->TZ,
        @_,
    };
}

1;
