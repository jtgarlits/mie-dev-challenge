-- Optional: drop everything for a clean slate in dev/testing
DROP TABLE IF EXISTS session_expansions;
DROP TABLE IF EXISTS session_players;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS expansions;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS games;

-- ==========================================
-- 1) 'games' Table
--  - game_type: 'competitive' or 'cooperative'
--  - complexity: optional rating (1–5 or 1–10)
-- ==========================================
CREATE TABLE IF NOT EXISTS games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    publisher VARCHAR(100),
    description TEXT,
    min_players INT,
    max_players INT,
    game_type ENUM('competitive','cooperative') DEFAULT 'competitive',
    complexity INT DEFAULT 3,  -- Simple rating: 1=light, 5=heavy
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 2) 'expansions' Table
--  - references a parent game
-- ==========================================
CREATE TABLE IF NOT EXISTS expansions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_game_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    FOREIGN KEY (parent_game_id) REFERENCES games(id)
);

-- ==========================================
-- 3) 'players' Table
-- ==========================================
CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL
);

-- ==========================================
-- 4) 'sessions' Table
--  - date_played: base date
--  - start_time, end_time: track how long the session lasted
--  - winner_id: references the winning player (if any)
-- ==========================================
CREATE TABLE IF NOT EXISTS sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    date_played DATE NOT NULL,
    start_time DATETIME,
    end_time DATETIME,
    notes TEXT,
    winner_id INT,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (winner_id) REFERENCES players(id)
);

-- ==========================================
-- 5) 'session_players' Table (Join table)
--  - Each player who participated in a session
--  - score, rank optional to track result
-- ==========================================
CREATE TABLE IF NOT EXISTS session_players (
    session_id INT NOT NULL,
    player_id INT NOT NULL,
    score INT,
    rank INT,
    PRIMARY KEY (session_id, player_id),
    FOREIGN KEY (session_id) REFERENCES sessions(id),
    FOREIGN KEY (player_id) REFERENCES players(id)
);

-- ==========================================
-- 6) 'session_expansions' Table (Optional)
--  - If you want to record which expansions were used in each session
-- ==========================================
CREATE TABLE IF NOT EXISTS session_expansions (
    session_id INT NOT NULL,
    expansion_id INT NOT NULL,
    PRIMARY KEY (session_id, expansion_id),
    FOREIGN KEY (session_id) REFERENCES sessions(id),
    FOREIGN KEY (expansion_id) REFERENCES expansions(id)
);

-- =====================================================
-- Insert Sample Data
-- =====================================================

-- 6A) Insert several GAMES
INSERT INTO games (name, publisher, description, min_players, max_players, game_type, complexity)
VALUES
('Catan', 'Kosmos', 'Build roads and trade resources.', 3, 4, 'competitive', 3),
('Pandemic', 'Z-Man Games', 'Team up to cure diseases worldwide.', 2, 4, 'cooperative', 3),
('Carcassonne', 'Hans im Glück', 'Tile-laying in medieval France.', 2, 5, 'competitive', 2),
('Azul', 'Next Move Games', 'Tile drafting pattern game.', 2, 4, 'competitive', 2),
('7 Wonders', 'Repos Productions', 'Draft cards to build a civilization.', 2, 7, 'competitive', 3),
('Gloomhaven', 'Cephalofair Games', 'Deep dungeon crawler with legacy elements.', 1, 4, 'cooperative', 5),
('Ticket to Ride', 'Days of Wonder', 'Build train routes across the map.', 2, 5, 'competitive', 2),
('Spirit Island', 'Greater Than Games', 'Complex co-op with spirits defending an island.', 1, 4, 'cooperative', 5);

-- 6B) Insert EXPANSIONS referencing parent games
-- Let's add expansions for a few of these games
INSERT INTO expansions (parent_game_id, name, description)
VALUES
-- For Catan (id=1)
(1, 'Seafarers', 'Sailing and exploring new islands.'),
(1, 'Cities & Knights', 'Added complexity with knights and city improvements.'),
-- For Pandemic (id=2)
(2, 'On the Brink', 'More roles, challenges, and viruses.'),
-- For Carcassonne (id=3)
(3, 'Inns & Cathedrals', 'Adds bigger tiles and new scoring rules.'),
-- For 7 Wonders (id=5)
(5, 'Babel', 'Add a shared tower with global effects.'),
-- For Gloomhaven (id=6)
(6, 'Forgotten Circles', 'Additional storylines and classes.'),
-- For Ticket to Ride (id=7)
(7, 'Europe Map', 'Adds tunnels, ferries, and stations.'),
-- For Spirit Island (id=8)
(8, 'Branch & Claw', 'Adds beasts, disease, events, and more fear.');


-- 7) Insert PLAYERS (8 total)
INSERT INTO players (player_name)
VALUES
('Jake'),
('Ben'),
('Jacob'),
('Brandon'),
('Lucy'),
('Alyssa'),
('Manny'),
('Bill');

-- 8) Insert SESSIONS
-- We'll track date_played, possible start/end times, notes, and a winner.
-- For winner_id, reference the players table (1=Jake, 2=Ben, etc.)
INSERT INTO sessions (game_id, date_played, start_time, end_time, notes, winner_id)
VALUES
-- Session 1: Catan
(1, '2025-03-01', '2025-03-01 19:00:00', '2025-03-01 21:00:00', 'Catan with basic rules. Resource mania.', 1),
-- Session 2: Catan with expansions
(1, '2025-03-08', '2025-03-08 18:30:00', '2025-03-08 21:00:00', 'Used Seafarers expansion. Close game!', 4),
-- Session 3: Pandemic
(2, '2025-03-02', '2025-03-02 20:00:00', '2025-03-02 21:15:00', 'A tense co-op victory!', 2),  -- winner ID is arbitrary or you can leave it null for co-op
-- Session 4: Carcassonne
(3, '2025-03-10', '2025-03-10 18:00:00', '2025-03-10 19:30:00', 'Meeple war in farmland.', 3),
-- Session 5: Azul
(4, '2025-03-12', '2025-03-12 19:45:00', '2025-03-12 20:45:00', 'Brilliant tile patterns.', 2),
-- Session 6: 7 Wonders
(5, '2025-03-15', '2025-03-15 18:15:00', '2025-03-15 19:45:00', 'Drafting wonders. Tied for second place.', 1),
-- Session 7: Gloomhaven
(6, '2025-03-20', '2025-03-20 17:00:00', '2025-03-20 21:00:00', 'Beat scenario #3, just barely survived.', 5), -- if co-op, winner is optional
-- Session 8: Ticket to Ride
(7, '2025-04-01', '2025-04-01 20:00:00', '2025-04-01 21:30:00', 'Longest route bonus decided the winner.', 6),
-- Session 9: Spirit Island
(8, '2025-04-02', '2025-04-02 19:00:00', '2025-04-02 22:00:00', 'Co-op success, overcame the invaders.', 7),
-- Session 10: Pandemic with expansions
(2, '2025-03-25', '2025-03-25 19:00:00', '2025-03-25 20:30:00', 'Tried On The Brink expansion. Lost badly.', 3),
-- Session 11: Carcassonne
(3, '2025-03-22', '2025-03-22 18:00:00', '2025-03-22 19:15:00', 'Used Inns & Cathedrals expansions. Manny soared in points.', 7),
-- Session 12: 7 Wonders
(5, '2025-03-18', '2025-03-18 20:00:00', '2025-03-18 21:00:00', 'Babel expansion tried. Interesting twists.', 8);

-- 9) Insert into SESSION_PLAYERS
--   We define which players attended each session, plus score/rank if you want.
INSERT INTO session_players (session_id, player_id, score, rank)
VALUES
-- Session 1 (id=1): Jake(1), Ben(2), Lucy(5), Manny(7) [Jake won]
(1, 1, 10, 1), 
(1, 2, 8, 2),
(1, 5, 6, 3),
(1, 7, 4, 4),

-- Session 2 (id=2): Brandon(4), Bill(8), Alyssa(6), Manny(7) [Brandon won]
(2, 4, 12, 1),
(2, 8, 10, 2),
(2, 6, 8, 3),
(2, 7, 5, 4),

-- Session 3 (id=3): Pandemic co-op: Jake(1), Ben(2), Jacob(3), Brandon(4)
-- winner is "2" but it's co-op. We'll just store rank=1 for all for a “shared victory” or something
(3, 1, 0, 1),
(3, 2, 0, 1),
(3, 3, 0, 1),
(3, 4, 0, 1),

-- Session 4 (id=4): Carcassonne with winner=Jacob(3)
(4, 1, 20, 2),
(4, 3, 25, 1),
(4, 6, 15, 3),

-- Session 5 (id=5): Azul with winner=Ben(2)
(5, 2, 60, 1),
(5, 4, 55, 2),
(5, 5, 48, 3),
(5, 7, 30, 4),

-- Session 6 (id=6): 7 Wonders with winner=Jake(1)
(6, 1, 65, 1),
(6, 2, 62, 2),
(6, 3, 55, 3),
(6, 8, 50, 4),

-- Session 7 (id=7): Gloomhaven, co-op, winner=5 (Lucy?), just a placeholder
(7, 1, 0, 1),
(7, 5, 0, 1),
(7, 6, 0, 1),
(7, 3, 0, 1),

-- Session 8 (id=8): Ticket to Ride, winner=6 (Alyssa)
(8, 6, 120, 1),
(8, 2, 110, 2),
(8, 4, 95, 3),

-- Session 9 (id=9): Spirit Island, co-op, winner=7 (Manny)
(9, 3, 0, 1),
(9, 7, 0, 1),
(9, 8, 0, 1),

-- Session 10 (id=10): Pandemic On The Brink, winner=Jacob(3)
(10, 1, 0, 2),
(10, 2, 0, 2),
(10, 3, 0, 1),
(10, 5, 0, 2),

-- Session 11 (id=11): Carcassonne with expansions
(11, 7, 28, 1),  -- Manny soared
(11, 6, 20, 2),
(11, 1, 15, 3),

-- Session 12 (id=12): 7 Wonders Babel
(12, 5, 60, 2),
(12, 8, 65, 1),  -- Bill is winner
(12, 2, 55, 3),
(12, 3, 52, 4);

-- 10) (Optional) Insert into SESSION_EXPANSIONS if used expansions in some sessions
INSERT INTO session_expansions (session_id, expansion_id)
VALUES
-- Session 2 used 'Seafarers' for Catan
(2, 1),
-- Session 10 used 'On the Brink' for Pandemic
(10, 3),
-- Session 11 used 'Inns & Cathedrals' for Carcassonne
(11, 4),
-- Session 12 used 'Babel' for 7 Wonders
(12, 5);
