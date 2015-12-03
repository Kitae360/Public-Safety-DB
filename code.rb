require 'highline/import'
require 'sqlite3'

class Database

def initialize()
	create_database()
	@db = SQLite3::Database.open 'f.db'	
end

#create the database file if it does not exist.
def create_database()
	puts `sqlite3 f.db < data.sql`
end

def insert_into_people(f,l,id,e,dn,ha,ca)
	@db.execute "INSERT INTO People(first_name, last_name, Person_ID, email,  driver_license_num, home_address, current_address) VALUES ('#{f}', '#{l}', '#{id}', '#{e}', '#{dn}', '#{ha}', '#{ca}')"
end

def update_into_people(f,l,id,e,dn,ha,ca)
	@db.execute "UPDATE People SET first_name = '#{f}', last_name = '#{l}', email = '#{e}', driver_license_num = '#{dn}', home_address = '#{ha}', current_address = '#{ca}'WHERE Person_ID = '#{id}'"
end

def insert_into_student(iden, c, d)
	@db. execute "INSERT INTO Student(Person_ID, class, dorm_name) VALUES ('#{iden}', '#{c}', '#{d}')"
end

def insert_into_faculty(id, dp)
	@db. execute "INSERT INTO Faculty(Person_ID, department_name) VALUES ('#{id}', '#{dp}')"
end

def insert_into_dvm(f,l,id)
	@db. execute "INSERT INTO DMV_owner(first_name, last_name, Person_ID) VALUES ('#{f}', '#{l}', '#{id}')"
end

def insert_into_car(l, r, c, m)
	@db.execute "INSERT INTO Car(License_plate_num, registration_number, color, model) VALUES ('#{l}', '#{r}', '#{c}', '#{m}')"
end

def update_into_car(l, r, c, m)
	@db.execute "UPDATE Car SET registration_number = '#{r}', color = '#{c}', model = '#{m}' WHERE License_plate_num = '#{l}'"
end

def insert_into_permit(i, l, p, y)
	@db.execute "INSERT INTO Parking_Permit(Person_ID, License_plate_num, Permit_num, type, suspension) VALUES ('#{i}', '#{l}', '#{p}', '#{y}', 'false')"
end

def update_parking_permit(pn, y)
	@db.execute "UPDATE Parking_Permit SET type = '#{y}' WHERE Permit_num = '#{pn}'"
end

def check_exist_person_with_id(id)
	@db.execute "SELECT EXISTS (SELECT *FROM People WHERE Person_ID = '#{id}')"
end

def check_exist_person_with_name(fn, ln)
	@db.execute "SELECT EXISTS (SELECT *FROM People WHERE first_name = '#{fn}' AND last_name = '#{ln}')"
end

def check_exist_car_with_lp(lp)
	@db.execute "SELECT EXISTS (SELECT *FROM Car WHERE License_plate_num = '#{lp}')"
end

def check_exist_car_with_model(model)
	@db.execute "SELECT EXISTS (SELECT *FROM Car WHERE model = '#{model}')"
end

def check_exist_permit_with_pn(pn)
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit WHERE Permit_num = '#{pn}')"
end

def check_exist_permit_with_id(id)
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit WHERE Person_ID = '#{id}')"
end

def check_exist_permit_with_lp(lp)
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit WHERE License_plate_num = '#{lp}')"
end

def select_person_with_name_all(fn, ln)
	@db.execute "SELECT *FROM People WHERE first_name = '#{fn}' AND last_name = '#{ln}'"
end

def select_person_with_name_id(fn, ln)
	@db.execute "SELECT Person_ID FROM People WHERE first_name = '#{fn}' AND last_name = '#{ln}'"
end

def select_car_with_model_all(model)
	@db.execute "SELECT *FROM Car WHERE model = '#{model}'"
end

def select_car_with_model_lp(model)
	@db.execute "SELECT License_plate_num FROM Car WHERE model = '#{model}'"
end

def select_with_lp(lp)
	puts @db.execute "SELECT *FROM Car WHERE License_plate_num = '#{lp}'"
end

def select_with_id(id)
	puts @db.execute "SELECT *FROM People WHERE Person_ID = '#{id}'"
end

def select_with_pn(pn)
	puts @db.execute "SELECT *FROM Parking_Permit WHERE Permit_num = '#{pn}'"
end		

def check_people_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM People)"
end

def check_car_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Car)"
end

def check_permit_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit)"
end

def delete_parking_permit(p)
	@db.execute "DELETE FROM Parking_Permit WHERE Permit_num = '#{p}'"
end

def delete_car_info(lp)
	@db.execute "DELETE FROM Car WHERE License_plate_num = '#{lp}'"
end

def delete_person_info_main(id)
	@db.execute "DELETE FROM People WHERE Person_ID = '#{id}'"
end

def delete_person_info_side(id)
	@db.execute "DELETE FROM Student WHERE Person_ID = '#{id}'"
	@db.execute "DELETE FROM Faculty WHERE Person_ID = '#{id}'"
	@db.execute "DELETE FROM DMV_owner WHERE Person_ID = '#{id}'"
end

def get_permit_with_lp(lp)
	pn = @db.execute "SELECT Permit_num FROM Parking_Permit WHERE License_plate_num = '#{lp}'"
	p = pn[0] 
	a = p[0]
	return a
end

def get_permit_with_id(id)
	pn = @db.execute "SELECT Permit_num FROM Parking_Permit WHERE Person_ID = '#{id}'"
	p = pn[0] 
	a = p[0]
	return a
end

def select_people_data()
	puts @db.execute "SELECT *FROM People"
end

def select_car_data()
	puts @db.execute "SELECT *FROM Car"
end

def select_permit_data()
	puts @db.execute "SELECT *FROM Parking_Permit"
end

end

class Menu

def initialize()
	@DB = Database.new
	say("Please interact using numbers")
	start()
end

def start()
	say("welcome to the public safety database")
	say("what do you want to do?")
	#distribution. send user to the other functions depend on their input
	choose do |menu|
		menu.choice :"log_in" do log_in() end
		menu.choice :"turn off" do say("ok bye") 	
		end
	end
end

#check if user puts correct user name and password
def log_in()
	username = ask("Enter your username: ") { |q| q.echo = true }
	password = ask("Enter your password: ") { |q| q.echo = "*" }
	if username == "kswag" and password == "1234"
		return options()
	else say("You put wrong ID or Password")
		return start()
	end
end

#distribution. send user to the other function depend on their input
def options()
	@list = ["manage_database", "check_information", "manage_ticket"]
	say("what do you want to do?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"sign out" do start() end
	end
end

#distribution. send user to the other function depend on their input
def manage_database()
	@list = ["insert", "update", "delete"]
	say("How do you want to manage the database?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do options() end
	end
end

def insert()
	@list = ["insert_person_info", "insert_car_info", "insert_parking_permit_info"]
	say("What do you want to do?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do manage_database() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"insert" do insert() end
		menu.choice :"go back" do manage_database() end
	end

end


def insert_person_info()
	id = ask("What is the ID of the person?: ", String)
	if @DB.check_exist_person_with_id(id) == [[0]]
	f =  ask("What is the first name of the person?: ", String)
	l = ask("What is the last name of the person?: ", String) 
	e = ask("What is the email of the person?: ", String) 
	dn = ask("What is the driver's license number of the person?: ", String) 
	ha = ask("What is the home address of the person?: ", String) 
	ca = ask("What is the current address of the person?: ", String)
	if HighLine.agree("Is this data correct? #{f}, #{l}, #{e}, #{dn}, #{ha}, #{ca} (y/n)") == true
		@DB.insert_into_people(f,l,id,e,dn,ha,ca)
	if HighLine.agree("Is this person a student?(y/n): ") == true
		add_student_info(id)
	else 
	end
	if HighLine.agree("Is this person a faculty?(y/n): ") == true
		add_faculty_info(id)
	else
	end
	if HighLine.agree("Is this person and person who registered car in DMV same person?(y/n)") == false
		add_dmv_owner_info(id)
	else
	end
	else 
		say("Please insert correct data")
		insert_person_info()
	end
	else
		say("Sorry Person with given ID already exists")
	end
end

def add_student_info(id)
	id = id
	cl = ask("What is class standing of this person?: ", String) 
	d = ask("Which dorm does this person live in?: ", String) 
	if HighLine.agree("Is this data correct? #{cl}, #{d} (y/n)") == true
		@DB.insert_into_student(id, cl, d)
	else
		say("Please insert correct data")
		add_student_info(id)
	end
end

def add_faculty_info(id)
	id = id
	de = ask("What department does this person work in?: ", String) 
	if HighLine.agree("Is this data correct? #{de} (y/n)") == true
		@DB.insert_into_faculty(id, de)
	else
		say("Please insert correct data")
		add_faculty_info(id)
	end
end

def add_dmv_owner_info(id)
	id = id
	f =  ask("What is the first name of the car owner in DMV?: ", String)
	l = ask("What is the last name of the car owner in DMV?: ", String) 
	if HighLine.agree("Is this data correct? #{f}, #{l} (y/n)") == true
		@DB.insert_into_dvm(f,l,id)
	else
		say("Please insert correct data")
		add_dmv_owner_info(id)
	end
end

def insert_car_info()
	l = ask("What is the license plate number of the car?: ", String)
	if @DB.check_exist_car_with_lp(l) == [[0]]
	r =  ask("What is the registeration number of the car?: ", String)
	c = ask("What is the color of the car?: ", String) 
	m = ask("What is the model of the car?: ", String) 
	if HighLine.agree("Is this data correct? #{l}, #{r}, #{c}, #{m} (y/n)") == true
		@DB.insert_into_car(l, r, c, m)
	else
		say("Please insert correct data")
		insert_car_info()
	end
	else say("Car with a given license plate number already exist")
	end
end

def insert_parking_permit_info()
	id = find_person_info()
	if id != nil
	lp = find_car_info()
	if lp != nil
	if @DB.check_exist_permit_with_lp(lp) == [[0]]
	p =  ask("What is the permit number?: ", String)
	if @DB.check_exist_permit_with_pn(p) == [[0]]
	y = ask("What is the type of the permit?: ", String)
	if HighLine.agree("Is this data correct? #{id}, #{lp}, #{p}, #{y} (y/n)") == true
		@DB.insert_into_permit(id, lp, p, y)
	else 
		say("Please insert correct data")
		insert_parking_permit_info()
	end
	else say("Given permit number already exists")
	end
	else say("Car with given license plate already has a parking permit")
	end
	else say("you cannot give parking permit if there is no car")
	end 
	else say("you cannot give parking permit if there is no person")
	end
end

def update()
	@list = ["update_person_info", "update_car_info", "update_parking_permit_info"]
	say("What do you want to do?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do manage_database() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"update" do update() end
		menu.choice :"go back" do manage_database() end
	end

end

def update_person_info()
	if @DB.check_people_exist() == [[1]]
	id = find_person_info()
	if id != nil
	f =  ask("What is the first name of the person?: ", String)
	l = ask("What is the last name of the person?: ", String) 
	e = ask("What is the email of the person?: ", String) 
	dn = ask("What is the driver's license number of the person?: ", String) 
	ha = ask("What is the home address of the person?: ", String) 
	ca = ask("What is the current address of the person?: ", String)
	if HighLine.agree("Is this data correct? #{f}, #{l}, #{e}, #{dn}, #{ha}, #{ca} (y/n)") == true
		@DB.update_into_people(f,l,id,e,dn,ha,ca)
		@DB.delete_person_info_side(id)
	if HighLine.agree("Is this person a student?(y/n): ") == true
		add_student_info(id)
	else 
	end
	if HighLine.agree("Is this person a faculty?(y/n): ") == true
		add_faculty_info(id)
	else
	end
	if HighLine.agree("Is this person and person who registered car in DMV same person?(y/n)") == false
		add_dmv_owner_info(id)
	else
	end
	else 
		say("Please insert correct data")
		update_person_info()
	end
	else
		say("There is no person who matches up with given info")
	end
	else say("There is no people information to update")
	end
end

def update_car_info()
	if @DB.check_car_exist() == [[1]]
	l = find_car_info()
	if l != nil
	r =  ask("What is the registeration number of the car?: ", String)
	c = ask("What is the color of the car?: ", String) 
	m = ask("What is the model of the car?: ", String) 
	if HighLine.agree("Is this data correct? #{l}, #{r}, #{c}, #{m} (y/n)") == true
		@DB.update_into_car(l, r, c, m)
	else
		say("Please insert correct data")
		update_car_info()
	end
	else say("There is no car that matches with given info")
	end
	else say("There is no car information to update")
	end
end

def update_parking_permit_info()
	if @DB.check_permit_exist() == [[1]]
	pn = ask("What is the parking permit number?")
	if check_exist_permit_with_pn(pn) == [[1]]
	y = ask("What is the type of the permit?: ", String)
	if HighLine.agree("Is this data correct? #{pn}, #{y} (y/n)") == true
		@DB.update_parking_permit(pn, y)
	else
		say("Please insert correct data")
		update_parking_permit_info
	end
	else say("There is no parking permit that matches with given info")
	end
	else say("There is no parking permit to update")
	end
	
end

def delete()
	@list = ["delete_person_info", "delete_car_info", "delete_parking_permit_info"]
	say("What do you want to do?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do manage_database() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"delete" do delete() end
		menu.choice :"go back" do manage_database() end
	end

end

def delete_person_info()
	if @DB.check_people_exist() == [[1]]
	id = find_person_info()
	if id != nil
	if @DB.check_exist_permit_with_id(id) == [[0]]
		@DB.delete_person_info_side(id)
		@DB.delete_person_info_main(id)
	else 
	if HighLine.agree("There is a parking permit attached to it. Do you want to erase parking permit also? (y/n)") == true
		p = @DB.get_permit_with_id(id)
		@DB.delete_parking_permit(p)
		@DB.delete_person_info_side(id)
		@DB.delete_person_info_main(id)
	else say("Then you cannot erase this car information")
	end
	end
	else say("There is no matching information to delete")
	end
	else say("There is no people information to delete")
	end
end

def delete_car_info()
	if @DB.check_car_exist() == [[1]]
	lp = find_car_info()
	if lp != nil
	if @DB.check_exist_permit_with_lp(lp) == [[0]]
		@DB.delete_car_info(lp)
	else 
	if HighLine.agree("There is a parking permit attached to it. Do you want to erase parking permit also? (y/n)") == true
		p = @DB.get_permit_with_lp(lp)
		@DB.delete_parking_permit(p)
		@DB.delete_car_info(lp)
	else say("Then you cannot erase this car information")
	end
	end
	else say("There is no matching information to delete")
	end
	else say("There is no car information to delete")
	end
end

def delete_parking_permit_info()
	if @DB.check_permit_exist() == [[1]]
	p =  ask("What is the permit number?: ", String)
	if @DB.check_exist_permit_with_pn(p) == [[1]]
		@DB.delete_parking_permit(p)
	else say("Parking permit with given permit number doesn't exist")
	end
	else say("There is no parking permit to delete")
	end
end

def find_person_with_id()
	id = ask("What is the ID of the person?: ", String)
	if @DB.check_exist_person_with_id(id) == [[1]]
		return id
	else say("Person with given ID does not exist")
		return nil
	end
end

def find_person_with_name()
	fn =  ask("What is the first name of the person?: ", String)
	ln = ask("What is the last name of the person?: ", String) 
	if @DB.check_exist_person_with_name(fn, ln) == [[1]]
		puts @DB.select_person_with_name_all(fn, ln)
		list = @DB.select_person_with_name_id(fn, ln)
		num = ask("Type the number of the one that you were looking for")
		a = list[num.to_i - 1]
		b = a[0]
			return b
	else say("Person with given name does not exist")
			return nil
	end
end

def find_car_with_lp()
	lp = ask("What is the license plate number of the car?: ", String)
	if @DB.check_exist_car_with_lp(lp) == [[1]]
		return lp
	else say("Car with given license plate number does not exist")
		return nil
	end
end

def find_car_with_model()
	model = ask("What is the model of the car?: ", String) 
	if @DB.check_exist_car_with_model(model) == [[1]]
		puts @DB.select_car_with_model_all(model)
		list = @DB.select_car_with_model_lp(model)
		num = ask("Type the number of the one that you were looking for")
		a = list[num.to_i - 1]
		b = a[0]
			return b
	else say("Car with given model does not exist")
			return nil
	end
end

def find_car_info()
	say("How do want to find car info?")
	lp = choose do |menu|
		menu.choice :"Search by License plate number" do find_car_with_lp() end
		menu.choice :"Search by model" do find_car_with_model() end
	end
	return lp
end

def find_person_info()
	say("How do want to find person info?")
	id = choose do |menu|
		menu.choice :"Search by ID" do find_person_with_id() end
		menu.choice :"Search by name" do find_person_with_name() end
	end
	return id
end

def check_information()
	say("How do want to check info?")
	choose do |menu|
		menu.choice :"View All Data" do view_data() end
		menu.choice :"Search" do search_data() end
		menu.choice :"go back" do options() end
	end
end

def view_data()
	say("Which data do you want to check?")
	choose do |menu|
		menu.choice :"People data" do view_people_data() end
		menu.choice :"Car data" do view_car_data() end
		menu.choice :"Permit data" do view_permit_data() end
		menu.choice :"go back" do check_information() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"View All Data" do view_data() end
		menu.choice :"go back" do check_information() end
	end
end

def view_people_data()
	@DB.select_people_data()
end

def view_car_data()
	@DB.select_car_data()
end

def view_permit_data()
	@DB.select_permit_data()
end

def search_data()
	say("Which data do you want to serch?")
	choose do |menu|
		menu.choice :"People data" do serch_people_data() end
		menu.choice :"Car data" do search_car_data() end
		menu.choice :"Permit data" do search_permit_data() end
		menu.choice :"go back" do check_information() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"Search Data" do search_data() end
		menu.choice :"go back" do check_information() end
	end
end

def serch_people_data()
	id = find_person_info()
	@DB.select_with_id(id)
end

def search_car_data()
	lp = find_car_info()
	@DB.select_with_lp(lp)
end

def search_permit_data()
	pn = ask("What is the permit number?: ", String)
	@DB.select_with_pn(pn)
end

end

Menu.new
