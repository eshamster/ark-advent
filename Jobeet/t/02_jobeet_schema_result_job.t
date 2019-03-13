use strict;
use warnings;
use utf8;
use Test::More tests => 10;

use Jobeet::Test;
use Jobeet::Models;

# Note: binmode
# 指定したファイルハンドルをバイナリモード (<-> テキストモード) で入出力するようにする。
# 第2引数は付加的なオプション。
# ":utf8" (":encoding(UTF-8)"に同じ) で名前の通りデータをUTF-8として扱うことを指定する。
binmode(Test::More->builder->$_, ':utf8') for qw/failure_output output todo_output/;

{
    my $new_category = models('Schema::Category')->create({
        name => 'Programming',
    });

    # こぴぺ
    my $new_job = $new_category->add_to_jobs({
        type         => 'full-time',
        company      => 'Sensio Labs',
        logo         => 'sensio-labs.gif',
        url          => 'http://www.sensiolabs.com/',
        position     => 'Web Developer',
        location     => 'Paris, France',
        description  => q[You've already developed websites with symfony and you want to work with Open-Source technologies. You have a minimum of 3 years experience in web development with PHP or Java and you wish to participate to development of Web 2.0 sites using the best frameworks available.],
        how_to_apply => 'Send your resume to fabien.potencier [at] sensio.com',
        is_public    => 1,
        is_activated => 1,
        token        => 'job_sensio_labs',
        email        => 'job@example.com',
    });

    isa_ok $new_job, 'Jobeet::Schema::Result::Job';

    isa_ok $new_job->created_at, 'DateTime';
    isa_ok $new_job->updated_at, 'DateTime';
    isa_ok $new_job->expires_at, 'DateTime';
}

{
    my $job_rs = models('Schema::Job');

    my $design_category = models('Schema::Category')->create({
        name => 'Design',
    });

    # こぴぺ
    my $design_job_1 = $job_rs->create({
        category_id  => $design_category->id,
        company      => "Company 1",
        position     => 'Web Designer',
        location     => 'Paris, France',
        description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
        how_to_apply => "Send your resume to lorem.ipsum [at] company_1.sit",
        is_public    => 1,
        is_activated => 1,
        token        => "job_1",
        email        => 'job@example.com',
    });

    # こぴぺ
    my $design_job_2 = $job_rs->create({
        category_id  => $design_category->id,
        company      => "Company 2",
        position     => 'Web Designer',
        location     => 'Paris, France',
        description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
        how_to_apply => "Send your resume to lorem.ipsum [at] company_2.sit",
        is_public    => 1,
        is_activated => 1,
        token        => "job_2",
        email        => 'job@example.com',
    });

    # こぴぺ
    my $design_job_3 = $job_rs->create({
        category_id  => $design_category->id,
        company      => "Company 3",
        position     => 'Web Designer',
        location     => 'Paris, France',
        description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
        how_to_apply => "Send your resume to lorem.ipsum [at] company_3.sit",
        is_public    => 1,
        is_activated => 1,
        token        => "job_3",
        email        => 'job@example.com',
    });

    is $design_category->get_active_jobs->count, 3,
      'get_active_jobs: 登録した3つのjobの取得';


    my $yesterday = models('Schema')->now->subtract( days => 1 );
    $design_job_2->update({ expires_at => $yesterday });

    is $design_category->get_active_jobs->count, 2,
      'get_active_jobs: $design_job_2 が期限切れになったため、get_active_jobsの返り値に含まれなくなった';


    my $now = models('Schema')->now;
    my $one_hour_ago = $now->clone->subtract( hours => 1 );
    my $tomorrow = $now->clone->add( days => 1 );

    $design_job_1->update({ created_at => $now });
    $design_job_3->update({ created_at => $one_hour_ago });

    {
        my $first_job = $design_category->get_active_jobs->first;
        is $first_job->id, $design_job_1->id,
          'get_active_jobs: $design_job_1の方が新しいので、$design_category->get_active_jobs->first は $design_job_1';
    }

    $design_job_3->update({ created_at => $tomorrow });

    {
        my $first_job = $design_category->get_active_jobs->first;
        is $first_job->id, $design_job_3->id,
          'get_active_jobs: $design_job_3の方が新しいので、$design_category->get_active_jobs->first は $design_job_3';
    }


    {
        is $design_category->get_active_jobs->count, 2,
          'get_active_jobs: $design_category のアクティブなjobは2つ';
        is $design_category->get_active_jobs({ rows => 1 })->count, 1,
          'get_active_jobs: rows パラメータで1を指定したので1つだけ取得';
    }
}

done_testing;
