CREATE TABLE IF NOT EXISTS movie (
    movieid uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    title text,
    synopsis text,
    imageurl text);

CREATE TABLE IF NOT EXISTS actor (
    actorid uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    name text,
    imageurl text);

CREATE TABLE IF NOT EXISTS genre (
    genreid uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    label text);

CREATE TABLE IF NOT EXISTS movie_actor (
    movieid uuid REFERENCES movie(movieid) ON DELETE CASCADE,
    actorid uuid REFERENCES actor(actorid) ON DELETE CASCADE,
    PRIMARY KEY (movieid, actorid));

CREATE TABLE IF NOT EXISTS movie_genre (
    movieid uuid REFERENCES movie(movieid) ON DELETE CASCADE,
    genreid uuid REFERENCES genre(genreid) ON DELETE CASCADE,
    PRIMARY KEY (movieid, genreid));
;

INSERT INTO movie(title, synopsis, imageurl) VALUES
    ('Movie One','This is the One Movie','movie1.jpg'),
    ('Movie Two','The Two Movie is the next','movie2.jpg'),
    ('Movie Three','The Trilogy','movie3.jpg'),
    ('Movie Four','Four movies is too much','movie4.jpg');

INSERT INTO actor(name, imageurl) VALUES
    ('Actor One','actor1.jpg'),
    ('Actor Two','actor2.jpg'),
    ('Actor Three','actor3.jpg'),
    ('Actor Four','actor4.jpg'),
    ('Actor Five','actor5.jpg');

INSERT INTO genre(label) VALUES
    ('Genre One'),
    ('Genre Two'),
    ('Genre Three');

INSERT INTO movie_actor VALUES
    ((SELECT movieid FROM movie WHERE title='Movie One'),(SELECT actorid FROM actor WHERE name='Actor One')),
    ((SELECT movieid FROM movie WHERE title='Movie One'),(SELECT actorid FROM actor WHERE name='Actor Two')),
    ((SELECT movieid FROM movie WHERE title='Movie Two'),(SELECT actorid FROM actor WHERE name='Actor Three')),
    ((SELECT movieid FROM movie WHERE title='Movie Two'),(SELECT actorid FROM actor WHERE name='Actor Four')),
    ((SELECT movieid FROM movie WHERE title='Movie Three'),(SELECT actorid FROM actor WHERE name='Actor Four')),
    ((SELECT movieid FROM movie WHERE title='Movie Three'),(SELECT actorid FROM actor WHERE name='Actor Five')),
    ((SELECT movieid FROM movie WHERE title='Movie Four'),(SELECT actorid FROM actor WHERE name='Actor One')),
    ((SELECT movieid FROM movie WHERE title='Movie Four'),(SELECT actorid FROM actor WHERE name='Actor Four'));

INSERT INTO movie_genre VALUES
    ((SELECT movieid FROM movie WHERE title='Movie One'),(SELECT genreid FROM genre WHERE label='Genre One')),
    ((SELECT movieid FROM movie WHERE title='Movie One'),(SELECT genreid FROM genre WHERE label='Genre Two')),
    ((SELECT movieid FROM movie WHERE title='Movie Two'),(SELECT genreid FROM genre WHERE label='Genre One')),
    ((SELECT movieid FROM movie WHERE title='Movie Three'),(SELECT genreid FROM genre WHERE label='Genre One')),
    ((SELECT movieid FROM movie WHERE title='Movie Three'),(SELECT genreid FROM genre WHERE label='Genre Two')),
    ((SELECT movieid FROM movie WHERE title='Movie Three'),(SELECT genreid FROM genre WHERE label='Genre Three'));