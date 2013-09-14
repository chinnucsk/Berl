% -*- coding: utf-8 -*-

-module(berl_berl_controller, [Req]).
-compile(export_all).

not_found(_, _) ->
    {output, "Page could not be found"}.

error(_, _) ->
    {output, "internal server error"}.

% eof
