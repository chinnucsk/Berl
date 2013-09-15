% -*- coding: utf-8 -*-

-module(berl_custom_filters).
-compile(export_all).

% put custom filters in here, e.g.
%
% my_reverse(Value) ->
%     lists:reverse(binary_to_list(Value)).
%
% "foo"|my_reverse   => "oof"

rfc_822(Value) ->
    datetime:datetime_encode(Value, 'GMT', rss).

atom_date(Value) ->
    datetime:datetime_encode(Value, 'GMT', atom).

% eof
