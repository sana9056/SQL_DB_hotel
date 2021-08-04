-- Создаём БД
DROP DATABASE IF EXISTS hotel;
CREATE DATABASE hotel;

-- Делаем её текущей
USE hotel;

-- Создаём таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  user_name VARCHAR(100) NOT NULL COMMENT "Логин пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  token VARCHAR(250) NOT NULL UNIQUE COMMENT "Токен для проверки пароля",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сотрудники";  

INSERT INTO users VALUES
  (1,"M.Vasilev", "MVasilev@mail.ru", "president9056", "1998-01-21 19:34:28","1991-01-07 17:35:49"),
  (2,"V.Vitalev", "VVitalevmail.ru", "Admin7856", "1998-02-21 19:44:28","1991-02-07 17:35:49"),
  (3,"R.Ryabina", "RRyabina@mail.ru", "worker4563", "1998-03-21 19:56:28","1991-03-07 17:35:49"),
  (4,"T.Novikova", "TNovikova@mail.ru", "worker1258", "1998-04-21 12:54:28","1991-04-07 17:35:49");

-- Таблица профилей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя",
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",  
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  gender ENUM ("m", "f", "ng") DEFAULT "ng" COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  typeuser VARCHAR(130) COMMENT "Тип пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили сотрудников";

INSERT INTO profiles VALUES
  (1,"Michail", "Vasilev", "5588", "m", "1980-07-21" , "admin", "1998-08-21 19:54:28","1991-01-07 17:35:49"),
  (2,"Valentin", "Vitalev", "5788", "m", "1985-6-15" , "menager", "1998-08-21 19:54:28","1991-01-07 17:35:49"),
  (3,"Roza", "Ryabina", "8988", "f", "1990-08-21" , "worker", "1998-08-21 19:54:28","1991-01-07 17:35:49"),
  (4,"Tatiana", "Novikova", "53488", "f", "2000-04-25" , "worker", "1998-08-21 19:54:28","1991-01-07 17:35:49");

-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

-- Таблица комнат
DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  title VARCHAR(100) NOT NULL COMMENT "Номер комнаты",
  short_description VARCHAR(250) NOT NULL COMMENT "Короткое описание комнаты",
  status_room VARCHAR(100) NOT NULL COMMENT "Статус занятости комнаты",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Комнаты";

INSERT INTO rooms VALUES
  (1,"1", "Однушка эконом", "Свободна", "1998-08-21 19:54:28","1991-01-07 17:35:49"),
  (2,"2", "Двушка стандартная", "Занята", "1998-08-21 19:54:28","1991-01-07 17:35:49"),
  (3,"3", "Однушка бизнес", "Свободна", "1998-08-21 19:54:28","1991-01-07 17:35:49"),
  (4,"4", "Трешка люкс", "Занята", "1998-08-21 19:54:28","1991-01-07 17:35:49");

-- Таблица типов комнат
DROP TABLE IF EXISTS type_of_room;
CREATE TABLE type_of_room (
  type_of_room_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  type_of_room VARCHAR(200) UNIQUE NOT NULL COMMENT "Тип комнаты"
) COMMENT "тип комнат";

INSERT INTO type_of_room VALUES
  (1,"Однокомнатные"),
  (2,"Двухкомнатные"),
  (3,"Трехкомнтатные"),
  (4,"Презедентский люкс");

-- Таблица связи типов комнат и комнат
CREATE TABLE type_of_room_rooms (
  type_of_room_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип",
  rooms_id INT UNSIGNED NOT NULL COMMENT "Ссылка на комнату",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (type_of_room_id, rooms_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между типов комнат и комнат";

-- Почему-то внешние ключи не могу настроить, запутался в наименованиях
/*-- Добавляем внешние ключи
ALTER TABLE type_of_room
  ADD CONSTRAINT type_of_room_id_fk 
    FOREIGN KEY (type_of_room_id) REFERENCES type_of_room(type_of_room_id)
	  ON DELETE CASCADE,
  ADD CONSTRAINT type_of_room_rooms_id_fk 
    FOREIGN KEY (rooms_id) REFERENCES rooms(id)
	  ON DELETE CASCADE;
 */
-- Таблица гостей
DROP TABLE IF EXISTS visiters;
CREATE TABLE visiters (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",  
  birthday DATE COMMENT "Дата рождения",
  pass INT UNSIGNED NOT NULL COMMENT "Номе паспорта",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Гости";

INSERT INTO visiters VALUES
  (1,"Andrey", "Plotov", "1998-08-21", "12325678", "1998-08-21 19:54:28","1991-01-07 17:35:49"),
  (2,"Vitaly", "Kastrov", "1998-02-16", "12234668", "1998-08-21 19:54:28","1991-01-07 17:35:49");

-- Таблица связи посетителей и комнат
CREATE TABLE visiters_rooms (
  visiters_id INT UNSIGNED NOT NULL COMMENT "Ссылка на посетителья",
  rooms_id INT UNSIGNED NOT NULL COMMENT "Ссылка на комнату",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (visiters_id, rooms_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между посетителем и комнатой";

INSERT INTO visiters_rooms VALUES
  (1, 1,"1991-01-07 17:35:49"),
  (2, 4,"1991-01-07 17:35:49");

-- Добавляем внешние ключи
ALTER TABLE visiters_rooms
  ADD CONSTRAINT visiters_rooms_visiters_id_fk 
    FOREIGN KEY (visiters_id) REFERENCES visiters(id)
	  ON DELETE CASCADE,
  ADD CONSTRAINT visiters_rooms_rooms_id_fk 
    FOREIGN KEY (rooms_id) REFERENCES rooms(id)
	  ON DELETE CASCADE;
	  
-- Таблица отзывов о комнате
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  rooms_id INT UNSIGNED NOT NULL COMMENT "Ссылка на комнату",   
  from_visiters_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  body TEXT NOT NULL COMMENT "Текст отзыва",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Отзывы";


-- Добавляем внешние ключи
ALTER TABLE comments
  ADD CONSTRAINT comments_rooms_id_to_id_fk 
    FOREIGN KEY (rooms_id) REFERENCES rooms(id),
  ADD CONSTRAINT comments_from_visiters_id_fk 
    FOREIGN KEY (from_visiters_id) REFERENCES visiters(id);

-- Пока что не работают отзывы
/*
INSERT INTO rooms VALUES
  (1, 1, 2, "Хорошая комната, обсуживание на уровне", "1998-08-21 19:54:28"),
  (1, 4, 3, "Было тихо и спокойно, спасибо", "1998-08-21 19:54:28");    
*/

