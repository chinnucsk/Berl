% -*- coding: utf-8 -*-

-module(berl_std).
-export([std_vars/1, blog/1, hostname/1, month_to_name/1]).

std_vars(Req) ->
    case blog(Req) of
        undefined ->
            [
             {rss_uri, "http://wer.kennt-wayne.de/feed.rss"},
             {atom_uri, "http://wer.kennt-wayne.de/feed.atom"}
            ];
        Blog ->
            [
             {blog, Blog},
             {rss_uri, Blog:url() ++ "feed.rss"},
             {atom_uri, Blog:url() ++ "feed.atom"}
            ]
    end.

blog(Req) ->
    Hostname = hostname(Req),
    boss_db:find_first(blog, [{host, 'equals', Hostname}]).

hostname(Req) ->
    Host = Req:header(host),
    re:replace(Host, ":\\d+$", "").

month_to_name(Mon) ->
    lists:nth(Mon, ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"]).

% eof
