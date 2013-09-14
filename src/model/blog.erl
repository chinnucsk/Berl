% -*- coding: utf-8 -*-

-module(blog, [Id, Name::string(), Description::string(), Keywords::string(), Url::string(), Host::string(), AuthorId]).
-compile(export_all).

-belongs_to(author).

% eof
