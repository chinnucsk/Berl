%% Migration: create_blogs

{create_blogs,
 fun(up) ->
         boss_db:execute(
           "CREATE TABLE blogs (
              id SERIAL PRIMARY KEY,
              name CHARACTER VARYING(250) NOT NULL,
              description CHARACTER VARYING(250) NOT NULL,
              keywords CHARACTER VARYING(250),
              url CHARACTER VARYING(250) NOT NULL,
              host CHARACTER VARYING(250) NOT NULL,
              author_id INTEGER NOT NULL REFERENCES authors(id) ON DELETE CASCADE ON UPDATE CASCADE
            )"
          );
    (down) ->
         boss_db:execute("DROP TABLE blogs")
 end}.
