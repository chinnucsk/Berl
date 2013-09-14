% -*- coding: utf-8 -*-

-module(berl_posts_controller, [Req]).
-compile(export_all).

index('GET', []) ->
    StdVars = berl_std:std_vars(Req),
    case berl_std:blog(Req) of
        undefined ->
            Posts = boss_db:find(post, [{visible, 'equals', true}], [{limit, 10}, {order_by, published}, {order_by, created}, {descending, true}]);

        Blog ->
            Posts = boss_db:find(post, [{blog_id, 'equals', Blog:id()}, {visible, 'equals', true}], [{limit, 10}, {order_by, published}, {order_by, created}, {descending, true}])
    end,

    {ok, [{posts, Posts}] ++ StdVars}.

show('GET', [Slug]) ->
    StdVars = berl_std:std_vars(Req),
    case berl_std:blog(Req) of
        undefined ->
            not_found;

        Blog ->
            case boss_db:find_first(post, [{blog_id, 'equals', Blog:id()}, {visible, 'equals', true}, {slug, 'equals', Slug}]) of
                undefined ->
                    not_found;
                Post ->
                    {ok, [{post, Post}] ++ StdVars}
            end
    end.


% eof
