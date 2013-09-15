% -*- coding: utf-8 -*-

-module(post, [Id, Slug::string(), Guid::string(), Visible, AuthorId, BlogId, Subject::string(), Excerpt::string(), Content::string(), Format::string(), Created, Updated, Published]).
-compile(export_all).

-belongs_to(blog).
-belongs_to(author).

perm_uri() ->
    B = blog(),
    {{Year, Month, _}, _} = Created,
    MonthName = berl_std:month_to_name(Month),
    B:url() ++ integer_to_list(Year) ++ "/" ++ MonthName ++ "/" ++ Slug.

% eof
