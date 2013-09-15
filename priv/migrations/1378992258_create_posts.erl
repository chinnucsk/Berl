%% Migration: create_posts

{create_posts,
 fun(up) ->
         boss_db:execute("CREATE TYPE post_format_t AS ENUM('html', 'markdown', 'textile')"),
         boss_db:execute(
           "CREATE TABLE posts (
              id SERIAL PRIMARY KEY,
              slug CHARACTER VARYING(250) NOT NULL,
              guid CHARACTER VARYING(250) NOT NULL UNIQUE,
              visible BOOLEAN NOT NULL,
              author_id INTEGER NOT NULL REFERENCES authors(id) ON DELETE CASCADE ON UPDATE CASCADE,
              blog_id INTEGER NOT NULL REFERENCES blogs(id) ON DELETE CASCADE ON UPDATE CASCADE,
              subject CHARACTER VARYING(250) NOT NULL,
              excerpt TEXT,
              content TEXT NOT NULL,
              format post_format_t NOT NULL,
              created TIMESTAMP WITHOUT TIME ZONE,
              updated TIMESTAMP WITHOUT TIME ZONE,
              published TIMESTAMP WITHOUT TIME ZONE
            )"
          );
    (down) ->
         boss_db:execute("DROP TABLE posts"),
         boss_db:execute("DROP TYPE post_format_t")
 end}.
