require 'highline/import'
require_relative 'person_helper.rb'
require_relative 'car_helper.rb'
require_relative 'permit_helper.rb'
require_relative 'ticket_helper.rb'


class Menu

def initialize()
	@person = Person_helper.new
	@car = Car_helper.new
	@permit = Permit_helper.new
	@ticket = Ticket_helper.new
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
	say("What do you want to do?")
	choose do |menu|
		menu.choice :"insert person info" do @person.insert_person_info() end
		menu.choice :"insert car info" do @car.insert_car_info() end
		menu.choice :"insert parking permit info" do @permit.insert_parking_permit_info() end
		menu.choice :"go back" do manage_database() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"insert" do insert() end
		menu.choice :"go back" do manage_database() end
	end

end

def update()
	say("What do you want to do?")
	choose do |menu|
		menu.choice :"update person info" do @person.update_person_info() end
		menu.choice :"update car info" do @car.update_car_info() end
		menu.choice :"update parking permit info" do @permit.update_parking_permit_info() end
		menu.choice :"go back" do manage_database() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"update" do update() end
		menu.choice :"go back" do manage_database() end
	end

end


def delete()
	say("What do you want to do?")
	choose do |menu|
		menu.choice :"delete person info" do @person.delete_person_info() end
		menu.choice :"delete car info" do @car.delete_car_info() end
		menu.choice :"delete parking permit info" do @permit.delete_parking_permit_info() end
		menu.choice :"go back" do manage_database() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"delete" do delete() end
		menu.choice :"go back" do manage_database() end
	end

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
		menu.choice :"Student data" do @person.view_student_data() end
		menu.choice :"Faculty data" do @person.view_faculty_data() end
		menu.choice :"People data" do @person.view_people_data() end
		menu.choice :"Car data" do @car.view_car_data() end
		menu.choice :"Permit data" do @permit.view_permit_data() end
		menu.choice :"go back" do check_information() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"View All Data" do view_data() end
		menu.choice :"go back" do check_information() end
	end
end


def search_data()
	say("Which data do you want to serch?")
	choose do |menu|
		menu.choice :"People data" do @person.search_people_data() end
		menu.choice :"Car data" do @car.search_car_data() end
		menu.choice :"Permit data" do @permit.search_permit_data() end
		menu.choice :"go back" do check_information() end
	end
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"Search Data" do search_data() end
		menu.choice :"go back" do check_information() end
	end
end

def manage_ticket()
	say("How do you want to manage ticket?")
	choose do |menu|
		menu.choice :"give ticket" do give_ticket() end
		menu.choice :"pay ticket" do pay_ticket() end
		menu.choice :"view ticketa" do view_tickets() end
		menu.choice :"search ticket" do search_ticket() end
		menu.choice :"go back" do options() end
	end
end

def view_tickets()
	@ticket.view_ticket_func()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"view tickets" do view_tickets() end
		menu.choice :"go back" do manage_ticket() end
	end
end


def give_ticket()
	@ticket.insert_ticket()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"give_ticket" do give_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

def pay_ticket()
	@ticket.pay_ticket_fuc()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"pay_ticket" do pay_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

def search_ticket()
	@ticket.search_ticket()
	say("What do you want to do now?")
	choose do |menu|
		menu.choice :"search ticket" do search_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

end

Menu.new
