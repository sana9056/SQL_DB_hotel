-- Room Views
CREATE OR REPLACE VIEW rooms_view AS
SELECT id, title, short_description FROM rooms;


CREATE OR REPLACE VIEW type_of_room_view AS
SELECT r.id, r.title, tr.type_of_room_id, t.type_of_room
  FROM rooms r
   LEFT JOIN type_of_room_rooms AS tr
    ON r.id = tr.type_of_room_id
   LEFT JOIN type_of_room AS t
    ON t.type_of_room_id = tr.type_of_room_id;
