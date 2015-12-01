require 'highline/import'
require 'sqlite3'

class Database

def initialize()
	create_database()
	@db = SQLite3::Database.open 'file.db'	
end

#create the database file if it does not exist.
def create_database()
	puts `sqlite3 file.db < DATABASE.sql`
end

#check if Car_Owner_school table exists
def check_sco_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Car_Owner_SCHOOL)"
end
	
#if Car_Owner_school table exists, shows all data in it
def select_sco()
	if (check_sco_exist() == [[0]])
		say("There isn't any registered car owners(school)")
	else
		puts @db.execute "SELECT *FROM Car_Owner_SCHOOL"
	end
end

#check if Car_Owner_dmv table exists
def check_co_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Car_Owner_DMV)"
end

#if Car_Owner_dmv table exists, shows all data in it
	def select_co()
	if (check_co_exist() == [[0]])
		say("There isn't any registered car owners(DMV)")
	else
		puts @db.execute "SELECT *FROM Car_Owner_DMV"
	end
end

#check if Car table exists
def check_car_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Car)"
end

#if Car table exists, shows all data in it
def select_car()
	if (check_car_exist() == [[0]])
		say("There isn't any registered cars")
	else
		puts @db.execute "SELECT *FROM Car"
	end
end

#check if parking_permit table exists
def check_pp_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit)"
end

#if Parking_permit table exists, shows all data in it
def select_pp()
	if  (check_pp_exist() == [[0]])
		say("There isn't any parking permit")
	else
		puts @db.execute "SELECT *FROM Parking_Permit"
	end
end

#find the co-responding driver's license number with given student ID number
def select_dnum_with_id(key)
	dnum = @db.execute "SELECT Drivers_License_num FROM Car_Owner_SCHOOL WHERE School_ID_NUM = '#{key.delete("'")}'"
	dnu = dnum[0]
	dn = dnu[0]
	return dn
end

#find the co-responding registeration number with given student ID number
def select_rnum_with_id(key)
	rnum = @db.execute "SELECT regis_num FROM Car_Owner_SCHOOL WHERE School_ID_NUM = '#{key.delete("'")}'"
	rnu = rnum[0]
	rn = rnu[0]
	return rn
end

#find the co-responding license plate number with given driver's license number
def select_lp_with_dnum(dnum)
	lpp = @db.execute "SELECT License_Plate FROM Car WHERE owner_d_num = '#{dnum.delete("'")}'"
	lp = lpp[0]
	l = lp[0]
	return l
end

#find the co-responding parking permit number with given license plate number
def select_pn_with_lp(lp)
	pnn = @db.execute "SELECT Permit_num FROM Parking_Permit WHERE LP_CAR = '#{lp.delete("'")}'"
	pn = pnn[0]
	p = pn[0]
	return p
end

#find all info from Car_Owner_DMV where Registration  number is given
def select_co_with_rn(rn)
	puts @db.execute "SELECT *FROM Car_Owner_DMV WHERE Registration_num ='#{rn.delete("'")}'"	
end

#find all info from Car_Owner_SCHOOL where Drivers License number is given
def select_sco_with_dnum(dnum)
	puts @db.execute "SELECT *FROM Car_Owner_SCHOOL WHERE Drivers_License_num = '#{dnum.delete("'")}'"	
end

#find all info from Car where License Plate number is given
def select_car_with_lp(lp)
	puts @db.execute "SELECT *FROM Car WHERE License_Plate = '#{lp.delete("'")}'"
end

#find all info from Parking_Permit where Permit number is given
def select_pp_with_pn(pn)
	puts @db.execute "SELECT *FROM Parking_Permit WHERE Permit_num = '#{pn.delete("'")}'"
end

#collect info and insert ticket into database
def insert_ticket(t_num, re, due, pr, from, to, perm)
	@db.execute "INSERT INTO Ticket(Ticket_num, Reason, Due_date, Price, From_who, To_Whom, car_permit) VALUES ('#{t_num.delete("'")}', '#{re.delete("'")}', '#{due.delete("'")}', #{pr.to_i}, '#{from.delete("'")}', '#{to.delete("'")}', '#{perm.delete("'")}')"
end

#delete the ticket with given ticket number
def delete_ticket(ticnum)
	@db.execute "DELETE FROM Ticket WHERE Ticket_num = '#{ticnum.delete("'")}'"	
end

#delete the car_owner_school date with given driver's license number
def delete_owner_school_info(dnum)
	@db.execute "DELETE FROM Car_Owner_SCHOOL WHERE Drivers_License_num = '#{dnum.delete("'")}'"	
end

#delete the car_onwer_dmv data with the given registeration number
def delete_owner_dmv_info(rnum)
	@db.execute "DELETE FROM Car_Owner_DMV WHERE Registration_num = '#{rnum.delete("'")}'"	
end

#find the sum of the ticekt fine and change the suspension statue of the car
def update_suspension(pernum)
	price = @db.execute "SELECT SUM(Price) FROM Ticket WHERE car_permit = '#{pernum.delete("'")}'"
	pricee = price[0]
	priceee = pricee[0]
	undate_suspension_func(priceee, pernum)
end

#check if total fine is more or less then 300
def undate_suspension_func(price, pernum)
	if price == nil or price <= 300
		return @db.execute "UPDATE Parking_Permit SET Suspension = 'false' WHERE Permit_num = '#{pernum.delete("'")}';"
	elsif price > 300
		return @db.execute "UPDATE Parking_Permit SET Suspension = 'true' WHERE Permit_num = '#{pernum.delete("'")}';"
	end	
end

#check if there is any cars with suspened parking permits
def check_suspension_exist()
	answer = @db.execute "SELECT EXISTS (SELECT *FROM Parking_permit WHERE Suspension = 'true')"
end

#if there is any cars with suspened parking permit, show it on the screen
def select_suspension()
	if (check_suspension_exist() == [[0]])
		say("There isn't any cars with suspension")
	else
		puts @db.execute "SELECT *FROM Parking_permit WHERE Suspension = 'true'"
	end
end

#collect data and insert into car_owner_dmv table
def insert_owner_dmv_info(name_F, name_M, name_L, r_num)
	@db.execute "INSERT INTO Car_Owner_DMV(Owner_Name_F, Owner_Name_M, Owner_Name_L, Registration_num) VALUES ('#{name_F.delete("'")}', '#{name_M.delete("'")}', '#{name_L.delete("'")}', '#{r_num.delete("'")}')"
end

#delete the data in car table with given license plate number
def delete_car_info(lp)
	@db.execute "DELETE FROM Car WHERE License_Plate = '#{lp.delete("'")}'"
end

#delete the data in parking permit table with given parking permit number
def delete_parking_permit_info(pnum)
	@db.execute "DELETE FROM Parking_Permit WHERE Permit_num = '#{pnum.delete("'")}'"		
end

#collect data and insert into car table
def insert_car_info(model, color, year_of_car, license_plate, owner_d_num)
	@db.execute "INSERT INTO Car(Model, Color, Year_of_car, License_Plate, owner_d_num) VALUES ('#{model.delete("'")}', '#{color.delete("'")}', '#{year_of_car.delete("'")}', '#{license_plate.delete("'")}', '#{owner_d_num.delete("'")}')" 		
end

#collect data and insert into parking pemit table
def insert_parking_permit_info(type, length, permit_num, lp_CAR)
	@db.execute "INSERT INTO Parking_Permit(Type, Length, Permit_num, Suspension, LP_CAR) VALUES ('#{type.delete("'")}', '#{length.delete("'")}', '#{permit_num.delete("'")}', 'false', '#{lp_CAR.delete("'")}')"		
end

#collect data and insert into car owner school talbe
def insert_owner_school_info(fir, mid, las, dl_n, si_N, re_n, p_n, sig, pic, email, bd, per_add, curr_add)
	@db.execute "INSERT INTO Car_Owner_SCHOOL(Owner_Name_F, Owner_Name_M, Owner_Name_L, Drivers_License_num, School_ID_NUM, regis_num, Phone_num, Signature, Picture,Email, Birthday, Per_add, Curr_add) VALUES ('#{fir.delete("'")}', '#{mid.delete("'")}', '#{las.delete("'")}', '#{dl_n.delete("'")}', '#{si_N.delete("'")}', '#{re_n.delete("'")}', '#{p_n.delete("'")}', '#{sig.delete("'")}', '#{pic.delete("'")}', '#{email.delete("'")}', '#{bd.delete("'")}', '#{per_add.delete("'")}', '#{curr_add.delete("'")}')" 	
end

#check if there is any ticket
def check_tickets_exist()
	@db.execute "SELECT EXISTS (SELECT *FROM Ticket)"
end

#if there is any tickets, show them on the screen
def select_tickets()
	if (check_tickets_exist() == [[0]])
		say("There isn't any tickets")
	else
		puts @db.execute "SELECT *FROM Ticket"
	end
end

#update the info in parking permit table with given permit number
def update_parking_permit_info(type, length, permit_num)
	@db.execute "UPDATE Parking_Permit SET Type = '#{type.delete("'")}', Length = '#{length.delete("'")}' WHERE Permit_num = '#{permit_num.delete("'")}'"	
end
	
#update the info in the car owner school table with given driver's license number
def update_owner_school_info(name_F, name_M, name_L, dl_num, p_num, sig, pic, em, bd, per_add, curr_add)
	@db.execute "UPDATE Car_Owner_SCHOOL SET Owner_Name_F = '#{name_F.delete("'")}', Owner_Name_M = '#{name_M.delete("'")}', Owner_Name_L = '#{name_L.delete("'")}', Phone_num = '#{p_num.delete("'")}', Signature = '#{sig.delete("'")}', Picture = '#{pic.delete("'")}', Email = '#{em.delete("'")}', Birthday = '#{bd.delete("'")}', Per_add = '#{per_add.delete("'")}', Curr_add = '#{curr_add.delete("'")}' WHERE Drivers_License_num = '#{dl_num.delete("'")}'"
end

#update the info in the car owner dmv table with given registeration number
def update_owner_dmv_info(me_F, me_M, me_L, r_num)
	@db.execute "UPDATE Car_Owner_DMV SET Owner_Name_F = '#{me_F.delete("'")}', Owner_Name_M = '#{me_M.delete("'")}', Owner_Name_L = '#{me_L.delete("'")}' WHERE Registration_num = '#{r_num.delete("'")}'"
end

#update the infro in the car table with given license plate number
def update_car_info(mo, c, ye, l_P)
	@db.execute "UPDATE Car SET Model = '#{mo.delete("'")}', Color = '#{c.delete("'")}', Year_of_car = '#{ye.delete("'")}' WHERE License_Plate = '#{l_P.delete("'")}'"
end

#get parking permit number of the car with ticekt number 
def get_permitnum_with_ticketnum(ticnum)
	pernum = @db.execute "SELECT car_permit FROM Ticket WHERE Ticket_num = '#{ticnum.delete("'")}'"
	per = pernum[0]
	pn = per[0]
	return pn
end

#check if car owner dmv data with given registeration number exist
def check_car_dmv_regnum_exist(rn)
	@db.execute "SELECT EXISTS (SELECT *FROM Car_Owner_DMV WHERE Registration_num = '#{rn.delete("'")}')"
end

#check if car owner school data with given registeration number exist
def check_car_school_regnum_exist(rn)
	@db.execute "SELECT EXISTS (SELECT *FROM Car_Owner_SCHOOL WHERE regis_num = '#{rn.delete("'")}')"
end

#check if car owner school data with given driver's license number exist
def check_car_school_dlnum_exist(dl)
	@db.execute "SELECT EXISTS (SELECT *FROM Car_Owner_SCHOOL WHERE Drivers_License_num = '#{dl.delete("'")}')"
end
	
#check if car data with given driver's license number exist
def check_car_dlnum_exist(dnum)
	@db.execute "SELECT EXISTS (SELECT *FROM Car WHERE owner_d_num = '#{dnum.delete("'")}')"
end

#check if car owner school data with given student ID number exist
def check_car_school_sid_exist(si_NUM)
	@db.execute "SELECT EXISTS (SELECT *FROM Car_Owner_SCHOOL WHERE School_ID_NUM = '#{si_NUM.delete("'")}')"
end
	
#check if car data with given license plate number exist
def check_car_lp_exist(license_Plate)
	@db.execute "SELECT EXISTS (SELECT *FROM Car WHERE License_Plate = '#{license_Plate.delete("'")}')"
end

#check if parking permit data with given license plate number exist
def check_pp_lp_exist(lp)
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit WHERE LP_CAR = '#{lp.delete("'")}')"
end

#check if parking permit data with given parking permit number exist
def check_pp_pnum_exist(pn)
	@db.execute "SELECT EXISTS (SELECT *FROM Parking_Permit WHERE Permit_num = '#{pn.delete("'")}')"	
end

#check if ticket data with given parking permit number exist
def check_ticket_pnum_exist(pnum)
	@db.execute "SELECT EXISTS (SELECT *FROM Ticket WHERE car_permit = '#{pnum.delete("'")}')"
end

#check if ticket data with given ticket number exist
def check_ticket_num_exist(tn)
	@db.execute "SELECT EXISTS (SELECT *FROM Ticket WHERE Ticket_num = '#{tn.delete("'")}')"
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

#distribution. send user to the other function depend on their input
def insert()
	@list = ["insert_owner_dmv_info", "insert_owner_school_info", "insert_car_info", "insert_parking_permit_info"]
	say("Which table to you want to insert new information?")
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

#collect data and insert into car owner school table
def insert_owner_school_info()
	if (@DB.check_co_exist() == [[1]])
	say("Here is the list of existing cars(DMV)")
	@DB.select_co()
	regis_num = ask("Type the registeration number of the car: ")
	if (@DB.check_car_dmv_regnum_exist(regis_num) == [[1]])
		dl_num = ask("Type the driver's license number of the car owner: ")
	if (@DB.check_car_school_dlnum_exist(dl_num) == [[0]])
		si_NUM = ask("Type the shcool ID number of the car owner: ")
	if (@DB.check_car_school_sid_exist(si_NUM) == [[0]])
		name_F = ask("Type the first name of the car owner: ")
		name_M = ask("Type the middle name of the car owner: ")
		name_L = ask("Type the last name of the car owner: ")
		phone_num = ask("Type the phone number of the car owner('XXX-XXX-XXXX'): ")
		signature = ask("Type the signiture of the car owner: ")
		pic = ask("Type the picture of the car owner: ")
		email = ask("Type the e-mail of the car owner: ")
		birthday = ask("Type the birthday of the car owner('YYYY-MM-DD'): ")
		per_add = ask("Type the perminent address of the car owner: ")
		curr_add = ask("Type the current address of the car owner: ")
		@DB.insert_owner_school_info(name_F, name_M, name_L, dl_num, si_NUM, regis_num, phone_num, signature, pic, email, birthday, per_add, curr_add)
	else say("Given student ID number already exists")
	end
	else say("Given driver's license number already exists")
	end
	else say("Given registeration number does not exists")
	end
	else say("There is no car that is registered")
	end
end

#collect data and insert into car owner dmv table
def insert_owner_dmv_info()
	registration_num = ask("Type the registration number of the car: ")
	if (@DB.check_car_dmv_regnum_exist(registration_num) == [[0]])
		owner_Name_F = ask("Type the first name of the car owner: ")
		owner_Name_M = ask("Type the middle name of the car owner: ")
		owner_Name_L = ask("Type the last name of the car owner: ")
		@DB.insert_owner_dmv_info(owner_Name_F.gsub("'", ""), owner_Name_M, owner_Name_L, registration_num)
	else
		say("Given registeration number alreayd exist")
	end
end

#collect data and insert into car table
def insert_car_info()
	if (@DB.check_sco_exist() == [[1]])
	say("Here is the list of existing car owners")
	@DB.select_sco()
	owner_d_num = ask("Type the driver's license number of the car owner: ")
	if (@DB.check_car_school_dlnum_exist(owner_d_num) == [[1]])
		license_Plate = ask("Type the license plate number of the car: ")
	if (@DB.check_car_lp_exist(license_Plate) == [[0]])
		model = ask("Type the model name of the car: ")
		color = ask("Type the color of the car: ")
		year_of_car = ask("Type the year of the car: ")
		@DB.insert_car_info(model, color, year_of_car, license_Plate, owner_d_num)
	else say("Given license plate already exists")
	end
	else say("Given driver's license number does not exist")
	end
	else say("There is no car owner to own a car")
	end
end

#collect data and insert into parking permit table
def insert_parking_permit_info()
	if (@DB.check_car_exist() == [[1]])
	say("Here is the list of registered cars in school")
	@DB.select_car()
	lp_CAR = ask("Type the license plate number of the car: ")
	if (@DB.check_car_lp_exist(lp_CAR) == [[1]]) 
	if (@DB.check_pp_lp_exist(lp_CAR) == [[0]])
	permit_num = ask("Type the parking permit number: ")
	if (@DB.check_pp_pnum_exist(permit_num) == [[0]])
	type = ask("Type the type of the parking permit: ")
	length = ask("Type the length of the parking permit('YYYY-MM-DD'): ")
	@DB.insert_parking_permit_info(type, length, permit_num, lp_CAR)
	else say("Given permit number already exists")
	end
	else say("Given car already has parking permit")
	end
	else say("Given license plate does not exist")
	end
	else say("There is no car to give a parking permit")
	end
end

#distribution. send user to the other function depend on their input
def update()
	@list = ["update_owner_dmv_info", "update_owner_school_info", "update_car_info", "update_parking_permit_info"]
	say("Which table to you want to update information?")
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

#collect data and update car owner school table
def update_owner_school_info()
	if (@DB.check_sco_exist() == [[1]])
	say("Here is the list of car owners")
	puts @DB.select_sco()
	dl_num = ask("Type the driver's license number of the car owner: ")
	if (@DB.check_car_school_dlnum_exist(dl_num) == [[1]])
	name_F = ask("Type the first name of the car owner: ")
	name_M = ask("Type the middle name of the car owner: ")
	name_L = ask("Type the last name of the car owner: ")
	phone_num = ask("Type the phone number of the car owner('XXX-XXX-XXXX'): ")
	signature = ask("Type the signiture of the car owner: ")
	picture = ask("Type the picture of the car owner: ")
	email = ask("Type the e-mail of the car owner: ")
	birthday = ask("Type the birthday of the car owner('YYYY-MM-DD'): ")
	per_add = ask("Type the perminent address of the car owner: ")
	curr_add = ask("Type the current of the car owner: ")
	@DB.update_owner_school_info(name_F, name_M, name_L, dl_num, phone_num, signature, picture, email, birthday, per_add, curr_add)
	else say("Given driver's license number does not exist")
	end
	else say("There isn't any car onwer information to update")
	end
end

#collect data and update car owner dmv table
def update_owner_dmv_info()
	if (@DB.check_co_exist() == [[1]])
	say("Here is the list of registered car owners")
	puts @DB.select_co()
	registration_num = ask("Type the registration number of the car you want to update: ")
	if (@DB.check_car_dmv_regnum_exist(registration_num) == [[1]])
	owner_Name_F = ask("Type the first name of the car owner: ")
	owner_Name_M = ask("Type the middle name of the car owner: ")
	owner_Name_L = ask("Type the last name of the car owner: ")	
	@DB.update_owner_dmv_info(owner_Name_F, owner_Name_M, owner_Name_L, registration_num)
	else say("Given registeration number does not exist")
	end
	else say("There isn't any car onwer information to update")
	end
end

#collect data and update car table
def update_car_info()
	if (@DB.check_car_exist() == [[1]])
	say("Here is the list of registered cars")
	puts @DB.select_car()
	license_Plate = ask("Type the license plate number of the car: ")
	if (@DB.check_car_lp_exist(license_Plate) == [[1]])
	model = ask("Type the model name of the car: ")
	color = ask("Type the color of the car: ")
	year_of_car = ask("Type the year of the car: ")
	@DB.update_car_info(model, color, year_of_car, license_Plate)
	else say("Given license plate does not exist")
	end
	else say("There isn't any car information to update")
	end
end

#collect data and update parking permit table
def update_parking_permit_info()
	if (@DB.check_pp_exist() == [[1]])
	say("Here is the list of parking permits")
	puts @DB.select_pp()
	permit_num = ask("Type the parking permit number: ")
	if (@DB.check_pp_pnum_exist(permit_num) == [[1]])
	type = ask("Type the type of the parking permit: ")
	length = ask("Type the length of the parking permit('YYYY-MM-DD'): ")
	@DB.update_parking_permit_info(type, length, permit_num)
	else say("Given parking permit number does not exist")
	end
	else say("There isn't any parking permit information to update")
	end
end

#distribution. send user to the other function depend on their input
def delete()
	@list = ["delete_owner_dmv_info", "delete_owner_school_info", "delete_car_info", "delete_parking_permit_info"]
	say("Which table to you want to delete information?")
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

#delete data with given driver's license number from car owner school table
def delete_owner_school_info()
	if (@DB.check_sco_exist() == [[1]])
	puts @DB.select_sco()
	dnum = ask("Type the driver's license number of the person you want to delete: ")
	if (@DB.check_car_school_dlnum_exist(dnum) == [[1]])
	if (@DB.check_car_dlnum_exist(dnum) == [[0]])
	@DB.delete_owner_school_info(dnum)
	else say("You cannot erase this data. Other data is depended on it")
	end
	else say("Given driver's license number does not exist")
	end
	else say("There isn't any car owner information to delete")
	end
end

#delete data with given rigisteration number from car owner dmv table
def delete_owner_dmv_info()
	if (@DB.check_co_exist() == [[1]])
	puts @DB.select_co()
	rnum = ask("Type the car registration number of the person you want to delete: ")
	if (@DB.check_car_dmv_regnum_exist(rnum) == [[1]])
	if (@DB.check_car_school_regnum_exist(rnum) == [[0]])
	@DB.delete_owner_dmv_info(rnum)
	else say("You cannot erase this data. Other data is depended on it")
	end
	else say("Given registeration number does not exist")
	end
	else say("There isn't any car owner information to delete")
	end
end

#delete data with given license plate number from car table
def delete_car_info()
	if (@DB.check_car_exist() == [[1]])
	puts @DB.select_car()
	lp = ask("Type the plate number of the car you want to delete: ")
	if (@DB.check_car_lp_exist(lp) == [[1]])
	if (@DB.check_pp_lp_exist(lp) == [[0]])
	@DB.delete_car_info(lp)
	else say("You cannot erase this data. Other data is depended on it")
	end
	else say("Given license plate does not exist")
	end
	else say("There isn't any car information to delete")
	end
end

#delete data with given parking permit number from parking permit table
def delete_parking_permit_info()
	if (@DB.check_pp_exist() == [[1]])
	puts @DB.select_pp()
	pnum = ask("Type the permit number of the car you want to delete: ")
	if (@DB.check_pp_pnum_exist(pnum) == [[1]])
	if (@DB.check_ticket_pnum_exist(pnum) == [[0]])
	@DB.delete_parking_permit_info(pnum)
	else say("You cannot erase this data. Other data is depended on it")
	end
	else say("Given permit number does not exist")
	end
	else say("There isn't any parking permit information to delete")
	end
end

#distribution. send user to the other function depend on their input
def check_information()
	@list = ["check_info", "search_with_studnet_ID"]
	say("What kind of information do you want?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do options() end
	end
end

#distribution. send user to the other function depend on their input
def check_info()
	@list = ["check_owner_dmv_info", "check_owner_school_info", "check_car_info", "check_parking_permit_info"]
	say("Which table do you want to check?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do check_information() end
	end
end

#show car owner school table
def check_owner_school_info()
	@DB.select_sco()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_owner_school_info" do check_owner_school_info() end
		menu.choice :"go back" do check_info() end
	end
end

#show car owner dmv table
def check_owner_dmv_info()
	@DB.select_co()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_owner_dmv_info" do check_owner_dmv_info() end
		menu.choice :"go back" do check_info() end
	end
end

#show car table
def check_car_info()
	@DB.select_car()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_car_info" do check_car_info() end
		menu.choice :"go back" do check_info() end
	end
end

#show parking permit table
def check_parking_permit_info()
	@DB.select_pp()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_parking_permit_info" do check_parking_permit_info() end
		menu.choice :"go back" do check_info() end
	end
end

#runs search_with_id() function then send user to different function based on their input
def search_with_studnet_ID()
	search_with_id()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"search_with_studnet_ID" do search_with_studnet_ID() end
		menu.choice :"go back" do check_information() end
	end
end

#search all info from all tables that is related to the given ID number
def search_with_id()
	if (@DB.check_sco_exist() == [[1]])
	say("Here is the list of car owners(School)")
	@DB.select_sco()
	id = ask("Type the ID number of the person you want to search: ")
	if (@DB.check_car_school_sid_exist(id) == [[1]])
	dnum = @DB.select_dnum_with_id(id)
	rn = @DB.select_rnum_with_id(id)
	say("Here is the car owner dmv info")
	@DB.select_co_with_rn(rn)
	say("Here is the car owner school info")
	@DB.select_sco_with_dnum(dnum)
	if (@DB.check_car_dlnum_exist(dnum) == [[1]])
	lp = @DB.select_lp_with_dnum(dnum)
	say("Here is the car info")
	@DB.select_car_with_lp(lp)
	if (@DB.check_pp_lp_exist(lp) == [[1]])
	pn = @DB.select_pn_with_lp(lp)
	say("Here is the parking permit info")
	@DB.select_pp_with_pn(pn)
	else say("Parking permit does not exist")
	end
	else say("Car info and Parking permit info do not exist")
	end
	else say("That ID does not exist")
	end
	else say("There is no car owner with student ID")
	end
	
end

#distribution. send user to the other function depend on their input
def manage_ticket()
	@list = ["give_ticket", "pay_ticket", "check_tickets", "check_suspension"]
	say("How do you want to manage ticket?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do options() end
	end
end

#runs insert_ticket function then send user to different function based on their input
def give_ticket()
	insert_ticket()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"give_ticket" do give_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

#check if input is a number
def is_num?(input)
	input.to_s == input.to_i.to_s
	end

#collect data and insert ticket into ticket table
def insert_ticket()
	if (@DB.check_pp_exist() == [[1]])
	say("Here is the list of parking permits")
	@DB.select_pp()
	car_permit = ask("Type parking permit number: ")
	if (@DB.check_pp_pnum_exist(car_permit) == [[1]])
	ticket_num = ask("Type ticket number: ")
	if (@DB.check_ticket_num_exist(ticket_num) == [[0]])
	price = ask("Type the price of the ticket: ")
	if is_num?(price)
	due_date = ask("Type ticket's due date('YYYY-MM-DD'): ")
	reason = ask("Type the reason for this ticket: ")
	from_who = ask("Type who is giving the ticket: ")
	to_whom = ask("Type who is getting the ticket: ")
	@DB.insert_ticket(ticket_num, reason, due_date, price, from_who, to_whom, car_permit)
	@DB.update_suspension(car_permit)
	else say("Price has to be an integer")
	end
	else say("That ticket number already exist")
	end
	else say("That parking permit number does not exist")
	end
	else say("There is no parking permit to give ticket")
	end
end

#runs delete_ticket function then send user to different function based on their input
def pay_ticket()
	delete_ticket()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"pay_ticket" do pay_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

#delete the ticket with given ticket number if it exists
def delete_ticket()
	if (@DB.check_tickets_exist() == [[1]])
	say("This is the list of ticket")
	@DB.select_tickets()
	ticnum = ask("Type ticket number: ")
	if (@DB.check_ticket_num_exist(ticnum) == [[1]])	
	pernum = @DB.get_permitnum_with_ticketnum(ticnum)
	@DB.delete_ticket(ticnum)
	@DB.update_suspension(pernum)
	else say("That ticket number does not exist")
	end
	else say("There is no ticket to pay")
	end
end

#show the list of tickets
def check_tickets()
	@DB.select_tickets()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_tickets" do check_tickets() end
		menu.choice :"go back" do manage_ticket() end
	end
end

#show the list of cars with suspended parking permit
def check_suspension
	@DB.select_suspension()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_suspension" do check_suspension() end
		menu.choice :"go back" do manage_ticket() end
	end
end

end
