#!/usr/bin/env perl

use strict;

use Data::Dumper;
use DBI;

my $old_db = DBI->connect("dbi:Pg:dbname=burp", "ckruse", "");
my $new_db = DBI->connect("dbi:Pg:dbname=berl", "ckruse", "");

my $user_map = {};
my $blog_map = {};
my $blog_user_map = {};

my $sth = $old_db->prepare("SELECT * FROM authors");
$sth->execute;

my $insert = $new_db->prepare("INSERT INTO authors (username, name, email, url) VALUES (?, ?, ?, ?)");

while(my $row = $sth->fetchrow_hashref) {
  $insert->execute($row->{username}, $row->{name}, $row->{email}, $row->{url});
  $user_map->{$row->{id}} = $new_db->selectrow_arrayref("SELECT MAX(id) FROM authors")->[0];
}

my $sth = $old_db->prepare("SELECT * FROM blog_authors ORDER BY author_id DESC");
$sth->execute();

while(my $row = $sth->fetchrow_hashref) {
  $blog_user_map->{$row->{blog_id}} = $row->{author_id} unless defined $blog_user_map->{$row->{blog_id}};
}

my $sth = $old_db->prepare("SELECT * FROM blogs");
$sth->execute();

my $insert = $new_db->prepare("INSERT INTO blogs (name, description, keywords, url, host, author_id) VALUES (?, ?, ?, ?, ?, ?)");

while(my $row = $sth->fetchrow_hashref) {
  my $host = $row->{url};
  $host =~ s/http:\/\/|\/$//g;

  $insert->execute($row->{title}, $row->{description}, '', $row->{url}, $host, $user_map->{$blog_user_map->{$row->{id}}});

  $blog_map->{$row->{id}} = $new_db->selectrow_arrayref("SELECT MAX(id) FROM blogs")->[0];
}


my $sth = $old_db->prepare("SELECT * FROM posts");
$sth->execute();

my $insert = $new_db->prepare("INSERT INTO posts (slug, visible, author_id, blog_id, subject, excerpt, content, format, created, updated, published) VALUES (?, ?, ?, ?, ?, ?, ?, 'html', ?, ?, ?)");

while(my $row = $sth->fetchrow_hashref) {
  $insert->execute($row->{uri_tag}, $row->{visible}, $user_map->{$row->{author_id}}, $blog_map->{$row->{blog_id}}, $row->{subject}, $row->{excerpt}, $row->{content}, $row->{created}, $row->{updated}, $row->{published});
}

# eof
