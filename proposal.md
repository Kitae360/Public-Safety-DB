# Skeleton:
1. There are three tables (People, Car, Permit)
2. People table has two attributes (name, Person_ID)
3. Car table has two attributes(License_plate_num, color)
4. Permit has three attributes(Person_ID, License_plate_num, Permit_num)
5. User can insert, update, delete, and read these three tables
6. When user wants to insert data in to permit table, user can find information from the People table by typing person's Person_ID, and also car from Car table by typing car's License_plate_num
7. When user wants to delete or update from People table, Car table, or Permit table, user can type Person_ID, License_plate_num, or Permit_num according which table they choose
8. Data that needs to be deleted from People or Car table can not be deleted if it relates to data in the Permit table
9. No attributes can be null

# Basic:
## Further implementation of data types:
1. When user is inserting into People table, depending either faculty or staff, user can add extra data.
	* Extra Data: 
	* Student table has three attributes(Person_ID, class, dorm_name)
	* Faculty table has two attributes(Person_ID, department_name)
2. If person who is registering a car at school is different than person who registered the car at DMV, user can add extra data
	* Extra Data: 
	* dmv_owner table has three attributes(first_name, last_name, Person_ID)
3. People table has 7 attributes (first_name, last_name, Person_ID, email, driver_license_num, home_address, current_address)
4. Car table has 4 attributes(License_plate_num, registration_number,color, model)
5. Permit has 4 attributes(Person_ID, License_plate_num, Permit_num, type)
6. User can delete data from People or Car table even if data from Permit table is related to it. It asks user if one wants to erase the permit also
7. When user wants to delete or update from People table, Car table, or Permit table user can type Person_ID/persons name, License_plate_num/model, or Permit_num according to which table they choose
8. User can search People table by typing person's Person_ID or person's name, and from Car table by typing car's License_plate_num, or model

#Solid:
## Futher implementations data types:
1. User can give a ticket to a car with a permit
2. Ticket table has 6 attributes(ticket_num, price, due_date, reason, from_who, permit_num)
3. User can check the list of tickets
4. User can delete ticket if car owner pays the fine

#Awesome:
1. User can give a ticket to a car without a permit
2. Ticket table has 5 attributes(ticket_num, price, due_date, reason, from_who)
3. Ticket_to_permit has 2 attributes (ticket_num, permit_num)
4. Ticket_without_permit has 2 attributes (ticket_num, license_plate_num)
5. Parking permit can be suspended if fine price adds upto more than $300
6. User can check suspended car lists
7. If car owner pays the ticket and fine goes down below $300, then suspension disappears


