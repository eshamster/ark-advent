<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Jobeet - Your best job board</title>
    <link rel="shortcut icon" href="/favicon.ico" />
    <!-- Note: "? block ... ?"  = テンプレートのブロック -->
    <? block javasripts => '' ?>
    <? block stylesheets => '' ?>
  </head>
  <body>
    <div id="container">
      <div id="header">
        <!-- Note: "?= ... ?"  = コマンド実行結果の挿入? -->
        <h1><a href="<?= $c->uri_for('/') ?>">
          <img src="/images/logo.jpg" alt="Jobeet Job Board" />
        </a></h1>

        <div id="sub_header">
          <div class="post">
            <h2>Ask for people</h2>
            <form action="" method="get">
              <input type="text" name="keywords" id ="search_keywords" />
              <input type="submit" value="search" />
              <div class="help">
                Enter some keywords (city, country, position, ...)
              </div>
            </form>
          </div>
        </div>
      </div>

      <div id="content">
        <div class="content">
? block content => '';
        </div>
      </div>

      <div id="footer">
        <div class="content">
          <span class="symfony">
            <img src="/images/jobeet-mini.png" />
            powered by Ark
          </span>
          <ul>
            <li><a href="">About Jobe</a></li>
            <li class="feed"><a href="">Full feed</a></li>
            <li><a href="">Jobeet API</a></li>
            <li class="last"><a href="">Affiliates</a></li>
          </ul>
        </div>
      </div>
    </div>
  </body>
</html>
