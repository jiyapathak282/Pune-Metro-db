create database punemetrodb;
show databases;
use punemetrodb;
CREATE TABLE StationCategory (
    category_code VARCHAR(10) PRIMARY KEY,
    description VARCHAR(255)
);
CREATE TABLE Station (
    station_id SERIAL PRIMARY KEY,
    station_code VARCHAR(10) ,
    station_name VARCHAR(150) ,
    address VARCHAR(255),
    city VARCHAR(100),
    district VARCHAR(100) ,
    state VARCHAR(100),
    platform_count INT,
    track_count INT,
    parking VARCHAR(50),
    bicycle VARCHAR(50),
    zone VARCHAR(50),
    division VARCHAR(50),
    category_code VARCHAR(10),
    daily_passengers BIGINT
    );
    CREATE TABLE Platform (
    platform_id SERIAL PRIMARY KEY,
    station_id INT NOT NULL,
    platform_number VARCHAR(10),
    length_m INT,
    shelter BOOLEAN DEFAULT TRUE,
    has_display_board BOOLEAN DEFAULT TRUE
    
);
CREATE TABLE Line (
    line_id SERIAL PRIMARY KEY,
    line_name VARCHAR(200) UNIQUE,
    description TEXT
);
CREATE TABLE LineStation (
    line_id INT,
    station_id INT,
    seq_no INT, -- sequence along the line
    PRIMARY KEY (line_id, station_id)
    
);
CREATE TABLE Train (
    train_id SERIAL PRIMARY KEY,
    train_number VARCHAR(20) UNIQUE,
    train_name VARCHAR(200),
    source_station_id INT,
    dest_station_id INT,
    category VARCHAR(50)
    
);
    
CREATE TABLE StationStop (
    train_id INT,
    station_id INT,
    arrival_time TIME,
    departure_time TIME,
    halt_minutes INT,
    stop_seq INT,
    platform_number VARCHAR(10),
    PRIMARY KEY (train_id, station_id)
);
CREATE TABLE Facility (
    facility_id SERIAL PRIMARY KEY,
    facility_name VARCHAR(100) 
);
CREATE TABLE StationFacility (
    station_id INT,
    facility_id INT,
    details VARCHAR(255),
    PRIMARY KEY (station_id, facility_id)
    
);
CREATE TABLE StationStats (
    id SERIAL PRIMARY KEY,
    station_id INT,
    stat_date DATE,
    halting_trains INT,
    originating_trains INT,
    terminating_trains INT,
    passenger_count int
    
);

#inserting values
INSERT INTO StationCategory (category_code, description) VALUES
('NSG-1', 'Non-Suburban Grade 1 (major junction)'),
('A', 'A category'),
('C', 'Suburban');
select*from StationCategory;
INSERT INTO Station (
    station_name, address, city, district, state, platform_count, 
    parking, bicycle, zone, division, category_code, daily_passengers
) VALUES
('PCMC', 'Old Mumbai-Pune Highway, Pimpri', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'TRUE', 'Purple Line', 'Pune Division', 'A1', 18000),
('Sant Tukaram Nagar', 'Near Bhosari Flyover, Pimpri', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'FALSE', 'Purple Line', 'Pune Division', 'A2', 14500),
('Phugewadi', 'Nashik Road, Kasarwadi', 'Pune', 'Pune', 'Maharashtra', 2, 'FALSE', 'FALSE', 'Purple Line', 'Pune Division', 'B1', 12000),
('Shivajinagar', 'Jangali Maharaj Road, Shivajinagar', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'TRUE', 'Purple Line', 'Pune Division', 'A1', 23000),
('Civil Court', 'Near Pune Municipal Corp., Shivajinagar', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'TRUE', 'Purple Line', 'Pune Division', 'A1', 25000),
('Budhwar Peth', 'Near Dagdusheth Temple', 'Pune', 'Pune', 'Maharashtra', 2, 'FALSE', 'FALSE', 'Purple Line', 'Pune Division', 'B2', 17500),
('Vanaz', 'Paud Road, Kothrud', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'FALSE', 'Purple Line', 'Pune Division', 'A2', 19000),
('Garware College', 'Karve Road, Erandwane', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'FALSE', 'Purple Line', 'Pune Division', 'B1', 16000),
('Deccan Gymkhana', 'J.M. Road, Deccan', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'FALSE', 'Purple Line', 'Pune Division', 'B2', 20000),
('Ramwadi', 'Nagar Road, Kalyani Nagar', 'Pune', 'Pune', 'Maharashtra', 2, 'TRUE', 'TRUE', 'Purple Line', 'Pune Division', 'A3', 15500);
SELECT*FROM Station;
INSERT INTO Facility(facility_id, facility_name) VALUES
(1, 'Parking Area'),
(2, 'Bicycle Stand'),
(3, 'Elevator'),
(4, 'Escalator'),
(5, 'Wheelchair Access'),
(6, 'Drinking Water'),
(7, 'Restroom'),
(8, 'Customer Care Centre'),
(9, 'Automatic Ticket Vending Machine'),
(10, 'Security CCTV'),
(11, 'Lost and Found'),
(12, 'Public Announcement System'),
(13, 'Shops and Food Kiosks'),
(14, 'Fire Safety Equipment'),
(15, 'First Aid Room'),
(16, 'Digital Information Display Board'),
(17, 'Solar Energy Panels'),
(18, 'Wi-Fi Service'),
(19, 'Smart Card Recharge Counter'),
(20, 'Emergency Help Booth');
SELECT*FROM facility;
INSERT INTO Line ( line_id,line_name) VALUES
(1, 'Purple Line (PCMC Bhavan to Swargate)'),
(2, 'Aqua Line (Vanaz to Ramwadi)'),
(3, 'Pink Line (District Court to Megapolis, Hinjawadi)'),
(4,'Proposed Line (Civil Court to Loni Kalbhor)'),
(5,' Proposed Line (Khadakwasla to Kharadi)'),
(6,' Proposed Spur Line (SNDT to Manik Baug via Warje)'),
(7,'Proposed Ring Line (Ambedkar Chowk to Kirloskar via Viman Nagar)'),
(8,' Proposed Extension (Vanaz to Chandni Chowk)'),
(9,' Proposed Extension (Ramwadi to Wagholi)');
SELECT*FROM line;
INSERT INTO LineStation (line_id, station_id, seq_no) VALUES  # line1 PCMC bhavan to SWARGATE
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(1, 4, 4),
(1, 5, 5),
(1, 6, 6),
(1, 7, 7),
(1, 8, 8);
INSERT INTO LineStation (line_id, station_id, seq_no) VALUES #line 2 Vanaz to Ramwadi
(2, 1, 1),
(2, 2, 2),
(2, 3, 3),
(2, 4, 4),
(2, 5, 5),
(2, 6, 6),
(2, 7, 7),
(2, 8, 8),
(2, 9, 9),
(2, 10, 10),
(2, 11, 11),
(2, 12, 12),
(2, 13, 13),
(2, 14, 14),
(2, 15, 15);
SELECT*FROM lineStation;
#ffor line 1 Purple line
INSERT INTO Platform (platform_id, station_id, platform_number, length_m, shelter, has_display_board) VALUES
(1, 1, '1', 130, TRUE, TRUE),  #PCMC Bhavan
(2, 2, '1', 130, TRUE, TRUE),  #Sant Tukaram Nagar
(3, 3, '1', 130, TRUE, TRUE),  # Bhosari (Nashik Phata)
(4, 4, '1', 130, TRUE, TRUE),  # Dapodi
(5, 5, '1', 130, TRUE, TRUE),  # Range Hills
(6, 6, '1', 130, TRUE, TRUE),  # Shivajinagar
(7, 7, '1', 130, TRUE, TRUE),  # Mandai
(8, 8, '1', 130, TRUE, TRUE);  # Swargate
#for line 2 AQUA LINE
INSERT INTO Platform (platform_id, station_id, platform_number, length_m, shelter, has_display_board) VALUES
(9, 1, '1', 130, TRUE, TRUE), # Vanaz
(10, 2, '1', 130, TRUE, TRUE), #Anand Nagar
(11, 3, '1', 130, TRUE, TRUE), # Ideal Colony
(12, 4, '1', 130, TRUE, TRUE), # Nal Stop
(13, 5, '1', 130, TRUE, TRUE), # Garware College
(14, 6, '1', 130, TRUE, TRUE), # Deccan Gymkhana
(15, 7, '1', 130, TRUE, TRUE), # Chhatrapati Sambhaji Udyan
(16, 8, '1', 130, TRUE, TRUE), #PMC Bhavan
(17, 9, '1', 130, TRUE, TRUE),# Mangalwar Peth (R.T.O)
(18, 10, '1', 130, TRUE, TRUE), # Pune Railway Station
(19, 11, '1', 130, TRUE, TRUE), # Ruby Hall Clinic
(20, 12, '1', 130, TRUE, TRUE), # Bund Garden
(21, 13, '1', 130, TRUE, TRUE), # Yerawada
(22, 14, '1', 130, TRUE, TRUE), # Kalyani Nagar
(23, 15, '1', 130, TRUE, TRUE); #Ramwadi
SELECT*FROM Platform;

INSERT INTO StationFacility (station_id, facility_id, details) VALUES
(1, 1, 'Parking available for cars and two-wheelers'), #PCMC Bhavan
(1, 2, 'Restrooms available near platform 1'),
(1, 3, 'Elevator and escalator access provided'),

(2, 2, 'Restrooms and water dispensers near exit gate A'), #Sant Tukaram Nagar
(2, 4, 'Shops and food kiosks inside concourse'),

(3, 1, 'Two-wheeler parking available near main gate'), #Bhosari (Nashik Phata)
(3, 5, 'Security and CCTV coverage active'),

(4, 2, 'Clean restrooms maintained daily'),#Dapodi
(4, 3, 'Escalators operational between concourse and platform'),

(5, 1, 'Limited car parking zone available'), # Range Hills
(5, 4, 'Small food stalls near ticket counter'),

(6, 2, 'Restrooms on both ends of station'),#Shivajinagar
(6, 3, 'Elevators and tactile flooring for accessibility'),

(7, 4, 'Shops, ATMs and snack kiosks'),    # Mandai
(7, 5, 'Security check and help desk available'),

(8, 1, 'Ample parking near Swargate interchange'), #Swargate
(8, 2, 'Restroom and water point near gate B'),
(8, 3, 'Elevator and digital display boards available');
SELECT*FROM stationfacility;
INSERT INTO StationStats (id, station_id, stat_date, halting_trains, originating_trains, terminating_trains, passenger_count) VALUES
(1, 1, '2025-10-19', 80, 10, 8, 12500),   # PCMC Bhavan (major terminal)
(2, 2, '2025-10-19', 75, 0, 0, 9200),     # Sant Tukaram Nagar
(3, 3, '2025-10-19', 72, 0, 0, 8700),     #Bhosari (Nashik Phata)
(4, 4, '2025-10-19', 68, 0, 0, 7600),     # Dapodi
(5, 5, '2025-10-19', 65, 0, 0, 7200),     # Range Hills
(6, 6, '2025-10-19', 90, 4, 2, 14000),    # Shivajinagar (busy interchange)
(7, 7, '2025-10-19', 60, 0, 0, 6800),     # Mandai
(8, 8, '2025-10-19', 82, 9, 10, 15300),   # Swargate (terminal station)
(9, 9, '2025-10-19', 88, 12, 11, 11000),  # Vanaz (Aqua Line terminal)
(10, 10, '2025-10-19', 70, 0, 0, 8500),   # Garware College
(11, 11, '2025-10-19', 65, 0, 0, 7800),   # Deccan Gymkhana
(12, 12, '2025-10-19', 60, 0, 0, 6900),   # PMC Bhavan
(13, 13, '2025-10-19', 72, 0, 0, 9500),   # Pune Railway Station
(14, 14, '2025-10-19', 68, 0, 0, 8000),   #Yerawada
(15, 15, '2025-10-19', 84, 7, 8, 13000);  #Ramwadi (Aqua Line terminal)
SELECT*FROM stationstats;
INSERT INTO StationStop (train_id, station_id, arrival_time, departure_time, halt_minutes, stop_seq, platform_number) VALUES
(101, 1, '06:00:00', '06:02:00', 2, 1, '1A'),  #PCMC Bhavan
(101, 2, '06:05:00', '06:07:00', 2, 2, '1B'),  #Sant Tukaram Nagar
(101, 3, '06:10:00', '06:12:00', 2, 3, '1C'),  #Bhosari (Nashik Phata)
(101, 4, '06:15:00', '06:17:00', 2, 4, '1D'),  # Dapodi
(101, 5, '06:20:00', '06:22:00', 2, 5, '1E'),  #Range Hills
(101, 6, '06:25:00', '06:27:00', 2, 6, '1F'),  #Shivajinagar
(101, 7, '06:30:00', '06:32:00', 2, 7, '1G'),  #Mandai
(101, 8, '06:35:00', '06:37:00', 2, 8, '1H'); # Swargate
SELECT*FROM stationstop;
INSERT INTO Train (train_id, train_number, train_name, source_station_id, dest_station_id, category) VALUES
(101, 'PM01', 'Purple Line Express', 1, 8, 'Express'),   #PCMC Bhavan to Swargate
(102, 'PM02', 'Purple Line Local', 1, 8, 'Local'),
(201, 'AM01', 'Aqua Line Express', 9, 15, 'Express'),    #Vanaz to Ramwadi
(202, 'AM02', 'Aqua Line Local', 9, 15, 'Local'),
(103, 'PM03', 'Purple Line Night Service', 6, 8, 'Night'),
(203, 'AM03', 'Aqua Line Night Service', 10, 15, 'Night');
SELECT*FROM Train;
#QURIES
#joins
#1 list all stations along with their lines
SELECT s.station_name, l.line_name
FROM linestation ls
JOIN line l ON ls.line_id = l.line_id
JOIN station s ON ls.station_id = s.station_id;
show tables;
#2 show all platforms at a station
SELECT s.station_name, p.platform_number, p.length_m
FROM platform p
JOIN station s ON p.station_id = s.station_id;
#3 show all trains with their source and destination stations
SELECT t.train_number, t.train_name, src.station_name AS source, dest.station_name AS destination
FROM Train t
JOIN station src ON t.source_station_id = src.station_id
JOIN station dest ON t.dest_station_id = dest.station_id;
#4 show facilities at a station
SELECT s.station_name, f.facility_name, sf.details
FROM stationfacility sf
JOIN station s ON sf.station_id = s.station_id
JOIN facility f ON sf.facility_id = f.facility_id;
show tables;
#5 show trains stopping at a specific station
SELECT t.train_number, t.train_name, ss.arrival_time, ss.departure_time
FROM stationstop ss
JOIN train t ON ss.train_id = t.train_id
WHERE ss.station_id = 6; 
#quries
update station
set station_code ='PCMC'
where station_name ='PCMC';
SET SQL_SAFE_UPDATES =0;
#query using aggregrate functions
# to find the station with maximum passengers
SELECT station_id, passenger_count
FROM StationStats
WHERE passenger_count = (
    SELECT MAX(passenger_count)
    FROM StationStats
);
#find the minnimum passengers
SELECT station_id, passenger_count
FROM StationStats
WHERE passenger_count = (
    SELECT MIN(passenger_count)
    FROM StationStats
);
#finf total passengers across all stations
SELECT SUM(passenger_count) AS total_passengers
FROM StationStats;
#AvG passengers per stations
SELECT AVG(passenger_count) AS average_passengers
FROM StationStats;
#count of stations
SELECT COUNT(*) AS total_station
FROM Station;
#using select query 
SELECT train_number, train_name FROM train;
#select passenger count for all stations
SELECT station_id, passenger_count 
FROM StationStats;
#select platforms longer than 120m
SELECT station_id, platform_number, length_m 
FROM Platform
WHERE length_m > 120;
#select station stats for a particular date
SELECT * 
FROM StationStats
WHERE stat_date = '2025-10-19';
#stating top 3 stations with the highest passenger count
SELECT s.station_name, ss.passenger_count, ss.halting_train, ss.originating_train
FROM stationstat ss
JOIN station s ON ss.station_id = s.station_id
ORDER BY ss.passenger_count DESC
LIMIT 3;
CREATE TABLE Station_Travel_Info (
    station_id INT,
    transport_mode VARCHAR(50),
    average_time_minutes INT,
    metro_time_minutes INT
);
use punemetrodb;
INSERT INTO Station_Travel_Info (station_id, transport_mode, average_time_minutes, metro_time_minutes)
VALUES
(1, 'Car', 25, 15),
(1, 'Bus', 35, 15),
(1, 'Bike', 18, 15),

(2, 'Car', 20, 12),
(2, 'Bus', 30, 12),
(2, 'Bike', 15, 12),

(3, 'Car', 28, 17),
(3, 'Bus', 38, 17),
(3, 'Bike', 20, 17),

(4, 'Car', 26, 14),
(4, 'Bus', 33, 14),
(4, 'Bike', 18, 14),

(5, 'Car', 30, 16),
(5, 'Bus', 40, 16),
(5, 'Bike', 22, 16),

(6, 'Car', 22, 10),
(6, 'Bus', 35, 10),
(6, 'Bike', 15, 10),

(7, 'Car', 28, 13),
(7, 'Bus', 38, 13),
(7, 'Bike', 20, 13),

(8, 'Car', 25, 12),
(8, 'Bus', 33, 12),
(8, 'Bike', 18, 12),

(9, 'Car', 27, 13),
(9, 'Bus', 37, 13),
(9, 'Bike', 19, 13),

(10, 'Car', 32, 15),
(10, 'Bus', 45, 15),
(10, 'Bike', 22, 15);
show tables;
select*from station_travel_info;