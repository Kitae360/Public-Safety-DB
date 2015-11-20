.header on
.mode column

CREATE TABLE Car_Owner_DMV(
Owner_Name_F TEXT,
Owner_Name_M TEXT,
Owner_Name_L TEXT,
Registration_num INTEGER,
PRIMARY KEY (Registration_num)
);


CREATE TABLE Car_Owner_SCHOOL(
Owner_Name_F TEXT,
Owner_Name_M TEXT,
Owner_Name_L TEXT,
Drivers_License_num INTEGER,
School_ID_NUM INTEGER,
regis_num INTEGER,
Phone_num INTEGER,
Signature TEXT,
Picture TEXT,
Email TEXT,
Birthday DATE,
Per_add TEXT,
Curr_add TEXT,
PRIMARY KEY (Drivers_License_num),
FOREIGN KEY (regis_num) REFERENCES Car_Owner_DMV(Registration_num)
);

CREATE TABLE Car(
Model TEXT,
Color TEXT,
Year_of_car INTEGER,
License_Plate TEXT,
owner_d_num INTEGER,
PRIMARY KEY (License_Plate),
FOREIGN KEY (owner_d_num) REFERENCES Car_Owner_SCHOOL(Drivers_License_num)
);

CREATE TABLE Parking_Permit(
Type TEXT,
Length DATE,
Permit_num INTEGER,
Suspension BOOLEAN,
LP_CAR TEXT UNIQUE,
PRIMARY KEY (Permit_num),
FOREIGN KEY (LP_CAR) REFERENCES Car(License_Plate)
);

CREATE TABLE Ticket(
Ticket_num INTEGER,
Reason TEXT,
Due_date DATE,
Price INTEGER,
From_who TEXT,
To_Whom TEXT,
car_permit INTEGER,
PRIMARY KEY (Ticket_num),
FOREIGN KEY (car_permit) REFERENCES Parking_Permit(Permit_num)
);


