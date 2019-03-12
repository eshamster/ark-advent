package MyContactForm;
use Ark 'Form';

param subject => (
    label => 'Subject',
    # type: フィールドの型。バリデーションルールが含まれる
    type => 'TextField',
    # constraints: 追加のバリデーションルールを設定する
    constraints => [
        'NOT_NULL',
        [ 'LENGTH', 0, 100 ],
    ],
    );

param message => (
    label => 'Message',
    type => 'TextField',
    # widget: 型指定以外の見た目を選択する
    widget => 'textarea',
    constraints => ['NOT_NULL'],
    );

param sender => (
    label => 'E-Mail',
    type => 'EmailField',
    constraints => ['NOT_NULL'],
    );

1;
