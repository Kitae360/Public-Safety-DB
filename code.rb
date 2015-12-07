require 'highline/import'
require_relative 'person_helper.rb'
require_relative 'car_helper.rb'
require_relative 'permit_helper.rb'
require_relative 'ticket_helper.rb'
#Code is split up into six files
#This file basically contains general menus that 
#lead to specifc blocks of code in the four helper files included.
#Typically 1-3 blocks of code represent specific features of this application
class Menu

def initialize()#Creates reference/attribute from each helper file
	@person = Person_helper.new
	@car = Car_helper.new
	@permit = Permit_helper.new
	@ticket = Ticket_helper.new
	say("*Please type in available menu numbers*\n\n")
	start()#Type in a number to select an option!
end

def start()
	say("Welcome to the Public Safety Database!")
	say("What would you like to do?\n\n")
	#Only one account is available to log in
	choose do |menu|
		menu.choice :"log_in" do log_in() end
		menu.choice :"turn off" do say("\nTerminating...\n") 	
		end
	end
end

#Username and password checker
def log_in()
	username = ask("\nEnter your username: ") { |q| q.echo = true }
	password = ask("Enter your password: ") { |q| q.echo = "*" }
	say("\n")
	if username == "kswag" and password == "1234"
		return options()#q.echo is a highline functon that reads passwords
	else say("You put wrong ID or Password")#and can replace characters with '*'
		return start()
	end
end

#Main menu, gives three options to user and directs them to fuctions
def options()#shown in the list. The fucntions are are below this fuction
	@list = ["manage_database", "check_information", "manage_ticket"]
	say("Successfully logged in!\n\n")
	say("What would you like to do?")
	choose do |menu| #menu.choices works with the list created and assigns fucntions
		#to each option
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"sign out" do start() end
	end
end

#Similar to options(), each option in the list is assigned to a function
def manage_database()
	@list = ["insert", "update", "delete"]
	say("\nHow do you want to manage the database?")
	choose do |menu|
		menu.choices(*@list) do |chosen| send(chosen) end
		menu.choice :"go back" do options() end
	end
end

def insert()
	say("\nWhat do you want to do?")
	choose do |menu|#Insert, update, and delete have similar format
		menu.choice :"insert person info" do @person.insert_person_info() end
		menu.choice :"insert car info" do @car.insert_car_info() end
		menu.choice :"insert parking permit info" do @permit.insert_parking_permit_info() end
		menu.choice :"go back" do manage_database() end
	end#When the user chooses, they are directed to a correlated helper file.rb
	say("\nWhat do you want to do now?")
	choose do |menu|#In the helper file, references are done to database.db for sql commands
		menu.choice :"insert" do insert() end
		menu.choice :"go back" do manage_database() end
	end

end

def update()
	say("\nWhat do you want to do?")
	choose do |menu|
		menu.choice :"update person info" do @person.update_person_info() end
		menu.choice :"update car info" do @car.update_car_info() end
		menu.choice :"update parking permit info" do @permit.update_parking_permit_info() end
		menu.choice :"go back" do manage_database() end
	end
	say("\nWhat do you want to do now?")
	choose do |menu|
		menu.choice :"update" do update() end
		menu.choice :"go back" do manage_database() end
	end

end


def delete()
	say("\nWhat do you want to do?")
	choose do |menu|
		menu.choice :"delete person info" do @person.delete_person_info() end
		menu.choice :"delete car info" do @car.delete_car_info() end
		menu.choice :"delete parking permit info" do @permit.delete_parking_permit_info() end
		menu.choice :"go back" do manage_database() end
	end
	say("\nWhat do you want to do now?")
	choose do |menu|
		menu.choice :"delete" do delete() end
		menu.choice :"go back" do manage_database() end
	end

end
#The user can look up a specific person or the entire database
def check_information()
	say("\nHow do want to check info?")
	choose do |menu|#An ID number is used to filter to one person in the database
		menu.choice :"View All Data" do view_data() end
		menu.choice :"Search" do search_data() end
		menu.choice :"go back" do options() end
	end
end


def view_data()
	say("\nWhich data do you want to check?")
	choose do |menu|#Basic SQL "Selects" & "From" commands from helper files
		menu.choice :"Student data" do @person.view_student_data() end
		menu.choice :"Faculty data" do @person.view_faculty_data() end
		menu.choice :"People data" do @person.view_people_data() end
		menu.choice :"Car data" do @car.view_car_data() end
		menu.choice :"Permit data" do @permit.view_permit_data() end
		menu.choice :"go back" do check_information() end
	end #Commands can be seen in database.db
	say("\nWhat do you want to do now?")
	choose do |menu|#Select * from [list of tables]
		menu.choice :"View All Data" do view_data() end
		menu.choice :"go back" do check_information() end
	end
end


def search_data()
	say("\nWhich data do you want to serch?")
	choose do |menu|#Function that filters out to one user with ID
		menu.choice :"People data" do @person.search_people_data() end
		menu.choice :"Car data" do @car.search_car_data() end
		menu.choice :"Permit data" do @permit.search_permit_data() end
		menu.choice :"go back" do check_information() end
	end
	say("\nWhat do you want to do now?")
	choose do |menu|
		menu.choice :"Search Data" do search_data() end
		menu.choice :"go back" do check_information() end
	end
end

def manage_ticket()
	say("\nHow do you want to manage ticket?")
	choose do |menu|#Simply directs user to functions below
		menu.choice :"give ticket" do give_ticket() end
		menu.choice :"pay ticket" do pay_ticket() end
		menu.choice :"view ticketa" do view_tickets() end
		menu.choice :"search ticket" do search_ticket() end
		menu.choice :"go back" do options() end
	end
end

def view_tickets()
	@ticket.view_ticket_func()
	say("\nWhat do you want to do now?")
	choose do |menu|#Opens up the ticket table in database.rb to user
		menu.choice :"view tickets" do view_tickets() end
		menu.choice :"go back" do manage_ticket() end
	end
end

#The three functions below direct the user to ticket helper with whatever option
def give_ticket()
	@ticket.insert_ticket()
	say("\nWhat do you want to do now?")
	choose do |menu|
		menu.choice :"give_ticket" do give_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

def pay_ticket()
	@ticket.pay_ticket_fuc()
	say("\nWhat do you want to do now?")
	choose do |menu|
		menu.choice :"pay_ticket" do pay_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

def search_ticket()
	@ticket.search_ticket()
	say("\nWhat do you want to do now?")
	choose do |menu|
		menu.choice :"search ticket" do search_ticket() end
		menu.choice :"go back" do manage_ticket() end
	end
end

end

Menu.new
