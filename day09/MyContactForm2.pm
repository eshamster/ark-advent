package MyContactForm2;
use Ark 'Form';

extends 'MyConstactForm';

# '+name' のように '+' をつけることで、
# 親で定義されたフィールドの一部だけ上書きできる。
param '+message' => (
    constraints => [
        'NOT_NULL',
        ['LENGTH', 0, 3000],
    ],
    );

param url => (
    label => 'URL',
    type => 'TextField',
    );

1;
