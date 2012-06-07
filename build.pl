#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

use JSON;

my $str_content;
{
  undef $/;
  my $fh;
  open $fh, "content.json";
  $str_content = <$fh>;
}

my $out;
open $out, ">programmers_thesaurus.html";

my $content = from_json($str_content);

print $out <<"EOS";
  <!doctype html>
  <html>
    <head>
      <meta charset='utf-8'>
      <title>The Programmer's Thesaurus</title>
    </head>
    <body>
      <h1>The Programmer's Thesaurus</h1>
      <dl>
EOS

for my $entry (sort { $a->{title} cmp $b->{title} } @$content) {
  say $out "<dt>$entry->{title}</dt><dd>", join(", ", sort @{$entry->{entries}}),
    "</dd>";
}

print $out <<"EOS";
      </dl>
    </body>
  </html>
EOS
