require 'highline/import'
require 'sqlite3'

class Database
	def initialize()
		@db = SQLite3::Database.open 'file.db'
		@db.execute("PRAGMA foreign_keys = ON;")
		@db.execute("PRAGMA table_info(Car_Owner_DMV)")

	end

	def select_sco()
		puts @db.execute "SELECT *FROM Car_Owner_SCHOOL"
	end

	def select_co()
		puts @db.execute "SELECT *FROM Car_Owner_DMV"
	end

	def select_car()
		puts @db.execute "SELECT *FROM Car"
	end

	def select_pp()
		puts @db.execute "SELECT *FROM Parking_Permit"
	end

	def select_with_id(key)
		say("select_with_id")
	end

	def insert_ticket(t_num, reason, due_date, price, from_who, to_whom, car_permit)
		@db.execute "INSERT INTO Ticket(Ticket_num, Reason, Due_date, Price, From_who, To_Whom, car_permit) VALUES ('#{t_num}', '#{reason}', '#{due_date}', #{price.to_i}, '#{from_who}', '#{to_whom}', '#{car_permit}')"
	end

	def delete_ticket(ticnum)
		@db.execute "DELETE FROM Ticket WHERE Ticket_num = #{ticnum.to_i}"
	end

	def delete_from_sco(dnum)
		@db.execute "DELETE FROM Car_Owner_SCHOOL WHERE Drivers_License_num = #{dnum.to_i}"
	end

	def delete_from_co(rnum)
		@db.execute "DELETE FROM Car_Owner_DMV WHERE Registration_num = #{rnum.to_i}"	
	end

	def update_suspension(pernum)
		price = @db.execute "SELECT SUM(Price) FROM Ticket WHERE car_permit = #{pernum.to_i}"
		pricee = price[0]
		priceee = pricee[0]
		undate_suspension_func(priceee, pernum)
	end

	def undate_suspension_func(price, pernum)
		if price == nil or price <= 300
			return @db.execute "UPDATE Parking_Permit SET Suspension = 'false' WHERE Permit_num = #{pernum.to_i};"
		elsif price > 300
			return @db.execute "UPDATE Parking_Permit SET Suspension = 'true' WHERE Permit_num = #{pernum.to_i};"
		end	
	end

	def select_suspension()
		puts @db.execute "SELECT *FROM Parking_permit WHERE Suspension = 'true'"
	end

	def insert_into_co(name_F, name_M, name_L, r_num)
		@db.execute "INSERT INTO Car_Owner_DMV(Owner_Name_F, Owner_Name_M, Owner_Name_L, Registration_num) VALUES ('#{name_F}', '#{name_M}', '#{name_L}', '#{r_num.to_i}')"
	end

	def delete_from_car(lp)
		@db.execute "DELETE FROM Car WHERE License_Plate = '#{lp}'"	
	end

	def delete_from_pp(pnum)
		@db.execute "DELETE FROM Parking_Permit WHERE Permit_num = #{pnum.to_i}"		
	end

	def insert_into_car(model, color, year_of_car, license_plate, owner_d_num)
		@db.execute "INSERT INTO Car(Model, Color, Year_of_car, License_Plate, owner_d_num) VALUES ('#{model}', '#{color}', #{year_of_car.to_i}, '#{license_plate}', #{owner_d_num.to_i})" 	
	end

	def insert_into_pp(type, length, permit_num, lp_CAR)
		@db.execute "INSERT INTO Parking_Permit(Type, Length, Permit_num, Suspension, LP_CAR) VALUES ('#{type}', '#{length}', #{permit_num.to_i}, 'false', '#{lp_CAR}')"
	end

	def insert_into_sco(fir, mid, las, dl_n, si_N, re_n, p_n, sig, pic, email, bd, per_add, curr_add)
		@db.execute "INSERT INTO Car_Owner_SCHOOL(Owner_Name_F, Owner_Name_M, Owner_Name_L, Drivers_License_num, School_ID_NUM, regis_num, Phone_num, Signature, Picture,Email, Birthday, Per_add, Curr_add) VALUES ('#{fir}', '#{mid}', '#{las}', #{dl_n.to_i}, #{si_N.to_i}, #{re_n.to_i}, #{p_n.to_i}, '#{sig}', '#{pic}', '#{email}', '#{bd}', '#{per_add}', '#{curr_add}')" 
	end

	def select_tickets()
		puts @db.execute "SELECT *FROM Ticket"
	end

	def update_pp(type, length, permit_num, lp_CAR)
		@db.execute "UPDATE Parking_Permit SET Type = '#{type}', Length = '#{length}' WHERE Permit_num = #{permit_num.to_i}"
	end
	
	def update_sco(name_F, name_M, name_L, dl_num, si_NUM, regis_num, phone_num, signature, picture, email, birthday, per_add, curr_add)
		@db.execute "UPDATE Car_Owner_SCHOOL SET Owner_Name_F = '#{name_F}', Owner_Name_M = '#{name_M}', Owner_Name_L = '#{name_L}', School_ID_NUM = #{si_NUM.to_i}, Phone_num = #{phone_num.to_i}, Signature = '#{signature}', Picture = '#{picture}', Email = '#{email}', Birthday = '#{birthday}', Per_add = '#{per_add}', Curr_add = '#{curr_add}' WHERE Drivers_License_num = #{dl_num.to_i}"
	end

	def update_co(owner_Name_F, owner_Name_M, owner_Name_L, registration_num)
		@db.execute "UPDATE Car_Owner_DMV SET Owner_Name_F = '#{owner_Name_F}', Owner_Name_M = '#{owner_Name_M}', Owner_Name_L = '#{owner_Name_L}' WHERE Registration_num = #{registration_num.to_i}"
	end

	def update_car(model, color, year_of_car, license_Plate, owner_d_num)
		@db.execute "UPDATE Car SET Model = '#{model}', Color = '#{color}', Year_of_car = #{year_of_car.to_i} WHERE License_Plate = '#{license_Plate}'"
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
	choose do |menu|
		menu.choice :"log_in" do log_in() end
		menu.choice :"turn off" do say("ok bye") 	
		end
	end
end

def log_in()
	username = ask("Enter your username: ") { |q| q.echo = true }
	password = ask("Enter your password: ") { |q| q.echo = "*" }
	if username == "kswag" and password == "1234"
		return options()
	else say("You put wrong ID or Password")
		return start()
	end
end

def options()
	@list = ["manage_database", "check_info", "manage_ticket"]
	say("what do you want to do?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"sign out" do start() end
	end
end

def manage_database()
	@list = ["insert", "update", "delete"]
	say("How do you want to manage the database?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do options() end
	end
end

def insert()
	@list = ["insert_into_co", "insert_into_sco", "insert_into_car", "insert_into_pp"]
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

def insert_into_sco()
	name_F = ask("Type the first name of the car owner: ")
	name_M = ask("Type the middle name of the car owner: ")
	name_L = ask("Type the last name of the car owner: ")
	dl_num = ask("Type the driver's license number of the car owner: ")
	si_NUM = ask("Type the shcool ID number of the car owner: ")
	regis_num = ask("Type the registeration number of the car: ")
	phone_num = ask("Type the phone number of the car owner: ")
	signature = ask("Type the signiture of the car owner: ")
	pic = ask("Type the picture of the car owner: ")
	email = ask("Type the e-mail of the car owner: ")
	birthday = ask("Type the birthday of the car owner('YYYY-MM-DD'): ")
	per_add = ask("Type the perminent address of the car owner: ")
	curr_add = ask("Type the current of the car owner: ")
	@DB.insert_into_sco(name_F, name_M, name_L, dl_num, si_NUM, regis_num, phone_num, signature, pic, email, birthday, per_add, curr_add)
end

def insert_into_co()
	owner_Name_F = ask("Type the first name of the car owner: ")
	owner_Name_M = ask("Type the middle name of the car owner: ")
	owner_Name_L = ask("Type the last name of the car owner: ")
	registration_num = ask("Type the registration number of the car: ")
	@DB.insert_into_co(owner_Name_F, owner_Name_M, owner_Name_L, registration_num)
end

def insert_into_car()
	model = ask("Type the model name of the car: ")
	color = ask("Type the color of the car: ")
	year_of_car = ask("Type the year of the car: ")
	license_Plate = ask("Type the license plate number of the car: ")
	owner_d_num = ask("Type the driver's license number of the car owner: ")
	@DB.insert_into_car(model, color, year_of_car, license_Plate, owner_d_num)
end

def insert_into_pp()
	type = ask("Type the type of the parking permit: ")
	length = ask("Type the length of the parking permit('YYYY-MM-DD'): ")
	permit_num = ask("Type the parking permit number: ")
	lp_CAR = ask("Type the license plate number of the car: ")
	@DB.insert_into_pp(type, length, permit_num, lp_CAR)
end

def update()
	@list = ["update_co", "update_sco", "update_car", "update_pp"]
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

def update_sco()
	name_F = ask("Type the first name of the car owner: ")
	name_M = ask("Type the middle name of the car owner: ")
	name_L = ask("Type the last name of the car owner: ")
	dl_num = ask("Type the driver's license number of the car owner: ")
	si_NUM = ask("Type the shcool ID number of the car owner: ")
	regis_num = ask("Type the registeration number of the car: ")
	phone_num = ask("Type the phone number of the car owner: ")
	signature = ask("Type the signiture of the car owner: ")
	picture = ask("Type the picture of the car owner: ")
	email = ask("Type the e-mail of the car owner: ")
	birthday = ask("Type the birthday of the car owner('YYYY-MM-DD'): ")
	per_add = ask("Type the perminent address of the car owner: ")
	curr_add = ask("Type the current of the car owner: ")
	@DB.update_sco(name_F, name_M, name_L, dl_num, si_NUM, regis_num, phone_num, signature, picture, email, birthday, per_add, curr_add)
end

def update_co()
	owner_Name_F = ask("Type the first name of the car owner: ")
	owner_Name_M = ask("Type the middle name of the car owner: ")
	owner_Name_L = ask("Type the last name of the car owner: ")
	registration_num = ask("Type the registration number of the car: ")
	@DB.update_co(owner_Name_F, owner_Name_M, owner_Name_L, registration_num)
end

def update_car()
	model = ask("Type the model name of the car: ")
	color = ask("Type the color of the car: ")
	year_of_car = ask("Type the year of the car: ")
	license_Plate = ask("Type the license plate number of the car: ")
	owner_d_num = ask("Type the driver's license number of the car owner: ")
	@DB.update_car(model, color, year_of_car, license_Plate, owner_d_num)
end

def update_pp()
	type = ask("Type the type of the parking permit: ")
	length = ask("Type the length of the parking permit('YYYY-MM-DD'): ")
	permit_num = ask("Type the parking permit number: ")
	lp_CAR = ask("Type the license plate number of the car: ")
	@DB.update_pp(type, length, permit_num, lp_CAR)
end

def delete()
	@list = ["delete_from_co", "delete_from_sco", "delete_from_car", "delete_from_pp"]
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

def delete_from_sco()
	dnum = ask("Type the driver's license number of the person you want to delete: ")
	@DB.delete_from_sco(dnum)
end

def delete_from_co()
	rnum = ask("Type the car registration number of the person you want to delete: ")
	@DB.delete_from_co(rnum)
end

def delete_from_car()
	lp = ask("Type the plate number of the car you want to delete: ")
	@DB.delete_from_car(lp)
end

def delete_from_pp()
	pnum = ask("Type the permit number of the car you want to delete: ").to_i
	@DB.delete_from_pp(pnum)
end

def check_info()
	@list = ["check_table", "search"]
	say("What kind of information do you want?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do options() end
	end
end

def check_table()
	@list = ["check_co", "check_sco", "check_car", "check_pp"]
	say("Which table do you want to check?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do check_info() end
	end
end

def check_sco()
	@list = ["check_sco"]
	@DB.select_sco()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_sco" do check_sco() end
		menu.choice :"go back" do check_table() end
	end
end

def check_co()
	@DB.select_co()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_co" do check_co() end
		menu.choice :"go back" do check_table() end
	end
end

def check_car()
	@DB.select_car()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_car" do check_car() end
		menu.choice :"go back" do check_table() end
	end
end

def check_pp()
	@DB.select_pp()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_pp" do check_pp() end
		menu.choice :"go back" do check_table() end
	end
end

def search()
	search_with_id()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"search" do search() end
		menu.choice :"go back" do check_info() end
	end
end

def search_with_id()
	key = ask("Type the ID number of the person you want to search: ")
	@DB.select_with_id(key)
end

def manage_ticket()
	@list = ["give_ticket", "pay_ticket", "check_tickets", "check_suspension"]
	say("How do you want to manage ticket?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do options() end
	end
end

def give_ticket()
	insert_ticket()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"give_ticket" do give_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

def insert_ticket()
	ticket_num = ask("Type ticket number: ")
	reason = ask("Type the reason for this ticket: ")
	due_date = ask("Type ticket's due date('YYYY-MM-DD'): ")
	price = ask("Type the price of the ticket: ")
	from_who = ask("Type who is giving the ticket: ")
	to_whom = ask("Type who is getting the ticket: ")
	car_permit = ask("Type parking permit number: ")
	@DB.insert_ticket(ticket_num, reason, due_date, price, from_who, to_whom, car_permit)
	@DB.update_suspension(car_permit)
end

def pay_ticket()
	delete_ticket()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"pay_ticket" do pay_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

def delete_ticket()
	ticnum = ask("Type ticket number: ")
	pernum = ask("Type permit number of the car: ")
	@DB.delete_ticket(ticnum)
	@DB.update_suspension(pernum)
end

def check_tickets()
	@DB.select_tickets()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_tickets" do check_suspension() end
		menu.choice :"go back" do manage_ticket() end
	end
end

def check_suspension
	@DB.select_suspension()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"check_suspension" do check_suspension() end
		menu.choice :"go back" do manage_ticket() end
	end
end

end

Menu.new
