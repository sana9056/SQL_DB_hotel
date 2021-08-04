--  Getting information about the user
SELECT
  u.id,
  u.user_name,
  u.email,
  u.token,
  u.avatar_blob_id,
  CONCAT(p.first_name, ' ', p.last_name) AS name,
  p.birthday,
  typeuser
  FROM users AS u 
   JOIN profiles AS p
    ON u.id = p.user_id;
    
 /*   
-- Rooms by description
SELECT
 rooms_id as id,
 (SELECT title FROM rooms WHERE rooms.id = short_description_rooms.rooms_id) as title,
 (SELECT type_of_room FROM type_of_room WHERE type_of_room.id = type_of_room_rooms.type_of_room_id) AS type_of_room
 FROM type_of_room_rooms;
 */