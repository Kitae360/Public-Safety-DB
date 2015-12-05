CREATE TABLE IF NOT EXISTS People(
first_name TEXT, 
last_name TEXT, 
Person_ID TEXT, 
email TEXT, 
driver_license_num TEXT, 
home_address TEXT, 
current_address TEXT,
PRIMARY KEY (Person_ID)
);

CREATE TABLE IF NOT EXISTS Student(
Person_ID TEXT, 
class TEXT, 
dorm_name TEXT,
PRIMARY KEY (Person_ID)
);

CREATE TABLE IF NOT EXISTS Faculty(
Person_ID TEXT, 
department_name TEXT,
FOREIGN KEY (Person_ID) REFERENCES People(Person_ID),
PRIMARY KEY (Person_ID)
);

CREATE TABLE IF NOT EXISTS DMV_owner(
first_name TEXT, 
last_name TEXT, 
Person_ID TEXT,
FOREIGN KEY (Person_ID) REFERENCES People(Person_ID),
PRIMARY KEY (Person_ID)
);

CREATE TABLE IF NOT EXISTS Car(
License_plate_num TEXT, 
registration_number TEXT,
color TEXT, 
model TEXT,
PRIMARY KEY (License_plate_num)
);

CREATE TABLE IF NOT EXISTS Parking_Permit(
Person_ID TEXT, 
License_plate_num TEXT, 
Permit_num TEXT, 
type TEXT,
suspension BOOLEAN,
PRIMARY KEY (Permit_num),
FOREIGN KEY (Person_ID) REFERENCES People(Person_ID),
FOREIGN KEY (License_plate_num) REFERENCES Car(License_plate_num)
);

CREATE TABLE IF NOT EXISTS Ticket(
License_plate_num TEXT,
ticket_num TEXT, 
price INTEGER, 
due_date TEXT,
reason TEXT, 
from_who TEXT,
statue TEXT,
PRIMARY KEY (ticket_num),
FOREIGN KEY (License_plate_num) REFERENCES Car(License_plate_num)
);



