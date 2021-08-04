-- Хранимые фукнкции и процедуры

-- Check user by id
DROP FUNCTION IF EXISTS is_user_by_id_exists;
DELIMITER //

CREATE FUNCTION is_user_by_id_exists (user_id INT)
RETURNS BOOLEAN READS SQL DATA
BEGIN
  RETURN EXISTS(SELECT 1 FROM users WHERE id = user_id);
END//

DELIMITER ;

-- Get user info by id
DROP PROCEDURE IF EXISTS get_user_profile_by_user_id;
DELIMITER //
CREATE PROCEDURE get_user_info_by_id(id INT)
BEGIN
	SELECT * FROM profiles AS p WHERE p.user_id = id;
END //
DELIMITER ;



-- триггеры

-- Actor first name and last name validation
DELIMITER //
CREATE TRIGGER validate_actors_first_name_last_name_insert BEFORE INSERT ON actors
FOR EACH ROW BEGIN
  IF NEW.first_name IS NULL AND NEW.last_name IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Both fist name and last name are NULL';
  END IF;
END//

-- Profiles first name and last name validation
DELIMITER //
CREATE TRIGGER validate_profiles_first_name_last_name_insert BEFORE INSERT ON profiles
FOR EACH ROW BEGIN
  IF NEW.first_name IS NULL AND NEW.last_name IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Both fist name and last name are NULL';
  END IF;
END//

-- Users first name and last name validation
DELIMITER //
CREATE TRIGGER validate_users_user_name_email_insert BEFORE INSERT ON users
FOR EACH ROW BEGIN
  IF NEW.user_name IS NULL AND NEW.email IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Both user name and email are NULL';
  END IF;
END//