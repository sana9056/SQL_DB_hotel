-- Indexes for rooms
CREATE INDEX rooms_title_idx ON rooms(title);
-- CREATE INDEX rooms_title_short_description_idx ON rooms(title, short_desription);

-- Index for profiles
CREATE INDEX profiles_first_name_last_name_idx ON profiles(first_name, last_name);

-- Index for visiters
CREATE INDEX visiters_first_name_last_name_idx ON visiters(first_name, last_name);
