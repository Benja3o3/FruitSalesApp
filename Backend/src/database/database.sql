CREATE DATABASE appventas;

\c appventas;

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  type varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS working_day (
  id SERIAL PRIMARY KEY,
  date timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS fruit (
  id SERIAL PRIMARY KEY,
  name varchar(255) NOT NULL,
  price int NOT NULL,
  icon varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS position_history (
  id SERIAL PRIMARY KEY,
  coordinates point NOT NULL,
  user_id int NOT NULL,
  working_day_id int NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS fruit_sell (
  id SERIAL PRIMARY KEY,
  created_by int NOT NULL,
  fruit_id int NOT NULL,
  working_day_id int NOT NULL,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (fruit_id) REFERENCES fruit(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE IF NOT EXISTS working_day_user (
  id SERIAL PRIMARY KEY,
  working_day_id int NOT NULL,
  user_id int NOT NULL,
  FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS current_position (
  id SERIAL PRIMARY KEY,
  latitude float NOT NULL,
  longitude float NOT NULL,
  user_id int NOT NULL,
  working_day_id int NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (working_day_id) REFERENCES working_day(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO users VALUES (DEFAULT, 'admin', '$2b$10$rgLWiEIs1HdDJHwZIc.U1ubfnne03WRtZbYgrQELsmdG6gRtSEdsS', 'vendedor'); 

INSERT INTO fruit 
VALUES
(DEFAULT, 'Frambuesa', 3000, 'frambuesa.png'), 
(DEFAULT, 'Frutilla', 2000, 'frutilla.png'), 
(DEFAULT, 'Arandano', 2500, 'arandano.png'), 
(DEFAULT, 'Melon', 2500, 'melon.png');