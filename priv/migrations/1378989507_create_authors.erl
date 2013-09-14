%% Migration: create_users

{create_users,
 fun(up) ->
         boss_db:execute(
           "CREATE TABLE authors (
              id SERIAL PRIMARY KEY,
              username CHARACTER VARYING(250) NOT NULL,
              name CHARACTER VARYING(250) NOT NULL,
              email CHARACTER VARYING(250),
              url CHARACTER VARYING(250),
              password CHARACTER VARYING(256)
            )"
          );
    (down) ->
         boss_db:execute("DROP TABLE users")
 end}.
