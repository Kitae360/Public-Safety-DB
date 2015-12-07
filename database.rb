require 'highline/import'
require 'sqlite3'
#Select Exists functions check if data with given condition exists
#if it exists, it returns 1, if it doesn't, returns 0
class Database

def initialize()
	create_database() #Creation of database file
	@db = SQLite3::Database.open 'ps.db'	
end

#Use piping to apply SQL commands if the given database file does not exist
def create_database()
	puts `sqlite3 ps.db < data.sql`
end
#Functions down below consist of sql commands that correlate to specific tables
def insert_into_people(f,l,id,e,dn,ha,ca)
	@db.execute("INSERT INTO People (first_name, last_name, Person_ID, email,  driver_license_num, home_address, current_address) VALUES (?,?,?,?,?,?,?)", [f,l,id,e,dn,ha,ca])
end
#The parameters represent the user's input and are placed directly in the database
def update_into_people(f,l,id,e,dn,ha,ca)
	@db.execute("UPDATE People SET first_name = (?), last_name = (?), email = (?), driver_license_num = (?), home_address = (?), current_address = (?) WHERE Person_ID = (?)", [f,l,e,dn,ha,ca, id])
end

def insert_into_student(iden, c, d)
	@db.execute("INSERT INTO Student (Person_ID, class, dorm_name) VALUES ( ? , ? , ? )", [iden, c, d])
end

def insert_into_faculty(id, dp)
	@db.execute("INSERT INTO Faculty(Person_ID, department_name) VALUES (?,?)", [id, dp])
end

def insert_into_dvm(f,l,id)
	@db.execute("INSERT INTO DMV_owner(first_name, last_name, Person_ID) VALUES (?,?,?)", [f,l,id])
end

def insert_into_car(l, r, c, m)
	@db.execute("INSERT INTO Car(License_plate_num, registration_number, color, model) VALUES (?,?,?,?)", [l,r,c,m])
end

def update_into_car(l, r, c, m)
	@db.execute("UPDATE Car SET registration_number = (?), color = (?), model = (?) WHERE License_plate_num = (?)", [r,c,m,l])
end

def insert_into_permit(i, l, p, y)
	@db.execute("INSERT INTO Parking_Permit(Person_ID, License_plate_num, Permit_num, type, suspension) VALUES (?,?,?,?,?)", [i,l,p,y, 'false'])
end

def update_parking_permit(pn, y)
	@db.execute("UPDATE Parking_Permit SET type = (?) WHERE Permit_num = (?)", [y, pn])
end

def check_exist_person_with_id(id)
	@db.execute("SELECT EXISTS (SELECT *FROM People WHERE Person_ID = (?))", [id])
end

def check_exist_person_with_name(fn, ln)
	@db.execute("SELECT EXISTS (SELECT *FROM People WHERE first_name = (?) AND last_name = (?))", [fn, ln])
end

def check_exist_car_with_lp(lp)
	@db.execute("SELECT EXISTS (SELECT *FROM Car WHERE License_plate_num = (?))", [lp])
end

def check_exist_car_with_model(model)
	@db.execute("SELECT EXISTS (SELECT *FROM Car WHERE model = (?))", [model])
end

def check_exist_permit_with_pn(pn)
	@db.execute("SELECT EXISTS (SELECT *FROM Parking_Permit WHERE Permit_num = (?))",[pn])
end

def check_exist_permit_with_id(id)
	@db.execute("SELECT EXISTS (SELECT *FROM Parking_Permit WHERE Person_ID = (?))", [id])
end

def check_exist_permit_with_lp(lp)
	@db.execute("SELECT EXISTS (SELECT *FROM Parking_Permit WHERE License_plate_num = (?))", [lp])
end

def select_person_with_name_all(fn, ln)
	@db.execute("SELECT *FROM People WHERE first_name = (?) AND last_name = (?)", [fn, ln])
end

def select_person_with_name_id(fn, ln)
	@db.execute("SELECT Person_ID FROM People WHERE first_name = (?) AND last_name = (?)", [fn, ln])
end

def select_car_with_model_all(model)
	@db.execute("SELECT *FROM Car WHERE model = (?)", [model])
end

def select_car_with_model_lp(model)
	@db.execute("SELECT License_plate_num FROM Car WHERE model = (?)", [model])
end

def select_with_lp(lp)
	puts @db.execute("SELECT *FROM Car WHERE License_plate_num = (?)", [lp])
end

def select_with_id(id)
	puts @db.execute("SELECT *FROM People WHERE Person_ID = (?)", [id])
end

def select_with_pn(pn)
	puts @db.execute("SELECT *FROM Parking_Permit WHERE Permit_num = (?)", [pn])
end		

def check_people_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM People)"
end

def check_car_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Car)"
end

def check_car_exist_lp(lp)
	@db.execute("SELECT EXISTS (SELECT *FROM Car WHERE License_plate_num = (?))", [lp])
end

def check_permit_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit)"
end

def check_permit_exist_pn(pn)
	@db.execute("SELECT EXISTS (SELECT *FROM Parking_Permit WHERE Permit_num = (?))", [pn])
end

def delete_parking_permit(p)
	@db.execute("DELETE FROM Parking_Permit WHERE Permit_num = (?)", [p])
end

def delete_car_info(lp)
	@db.execute("DELETE FROM Car WHERE License_plate_num = (?)", [lp])
end

def delete_person_info_main(id)
	@db.execute("DELETE FROM People WHERE Person_ID = (?)", [id])
end

def delete_person_info_side(id)
	@db.execute("DELETE FROM Student WHERE Person_ID = (?)", [id])
	@db.execute("DELETE FROM Faculty WHERE Person_ID = (?)", [id])
	@db.execute("DELETE FROM DMV_owner WHERE Person_ID = (?)", [id])
end

def get_permit_with_lp(lp)
	pn = @db.execute("SELECT Permit_num FROM Parking_Permit WHERE License_plate_num = (?)", [lp])#Checks permit with license plate number. Function below does the same.
	p = pn[0] 
	a = p[0]
	return a
end

def get_permit_with_id(id)
	pn = @db.execute("SELECT Permit_num FROM Parking_Permit WHERE Person_ID = (?)", [id])
	p = pn[0] 
	a = p[0]
	return a
end
#Basic SQL commands in seperate functions for ease of calling a command
def select_people_data()
	puts @db.execute "SELECT *FROM People"
end

def select_student_data()
	puts @db.execute "select *FROM People JOIN Student ON People.Person_ID = Student.Person_ID"
end

def select_faculty_data()
	puts @db.execute "select *FROM People JOIN Faculty ON People.Person_ID = Faculty.Person_ID"
end

def select_car_data()
	puts @db.execute "SELECT *FROM Car"
end

def select_permit_data()
	puts @db.execute "SELECT *FROM Parking_Permit"
end

def insert_ticket(lp, tn, pr, du, rea, from)
	@db.execute("INSERT INTO Ticket(License_plate_num, ticket_num, price, due_date, reason, from_who, statue) VALUES (?,?,?,?,?,?,?)", [lp, tn, pr, du, rea, from, 'unpaid'])
end

def update_ticket(tn)
	@db.execute("UPDATE Ticket SET statue = 'paid' WHERE ticket_num = (?)", [tn])
end

def check_ticket(tn)
	puts @db.execute("select *FROM Ticket WHERE ticket_num = (?)", [tn])		
end

def check_ticket_exist_lp(lp)
	@db.execute("SELECT EXISTS (SELECT *FROM Ticket WHERE License_plate_num = (?))", [lp])
end

def get_ticnum_with_lp(lp)
	a = @db.execute("SELECT ticket_num FROM Ticket WHERE License_plate_num = (?)", [lp])
	b = a[0]
	c = b[0]
	return c
end

def delete_ticket_info(c)
	@db.execute("DELETE FROM Ticket WHERE ticket_num = (?)", [c])
end

def check_student_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Student)"
end

def check_faculty_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Faculty)"
end

def check_student_exist_id(id)
	@db.execute("SELECT EXISTS (SELECT *FROM Student WHERE Person_ID = (?))", [id])
end

def check_faculty_exist_id(id)
	@db.execute("SELECT EXISTS (SELECT *FROM Faculty WHERE Person_ID = (?))", [id])
end

def check_ticnum_exist(tn)
	@db.execute("SELECT EXISTS (SELECT *FROM Ticket WHERE ticket_num = (?))", [tn])
end

def select_ticket_with_lp(lp)
	puts @db.execute("SELECT *FROM Ticket WHERE License_plate_num = (?)", [lp])
end

def select_ticket_num_with_lp(lp)
	@db.execute("SELECT ticket_num FROM Ticket WHERE License_plate_num = (?)", [lp])
end

def check_exist_tic_with_lp(lp)
	@db.execute("SELECT EXISTS (SELECT ticket_num FROM Ticket WHERE License_plate_num = (?))", [lp])
end

def show_ticket_with_tn(tn)
	puts @db.execute("SELECT *FROM Ticket WHERE ticket_num = (?)", [tn])
end

def check_ticket_paid(tn)
	@db.execute("SELECT EXISTS (SELECT *FROM Ticket WHERE statue = 'paid' AND ticket_num = (?))", [tn])
end

def show_tickets()
	puts @db.execute "SELECT *FROM Ticket"
end

def check_ticket_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Ticket)"
end

end
