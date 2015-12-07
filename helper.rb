require 'highline/import'
require 'sqlite3'
require_relative 'database.rb'

class Helper

def initialize()
	@DB = Database.new
end

def find_person_with_id()
	id = question("\n\nWhat is the ID?: ")
	if @DB.check_exist_person_with_id(id) == [[1]]
		return id
	else say("\n\nerson with given ID does not exist")
		return nil
	end
end
#Similar to all to all the other helper functions, 
def find_person_with_name()
	fn =  question("\n\nWhat is the first name?: ")
	ln = question("What is the last name?: ") 
	if @DB.check_exist_person_with_name(fn, ln) == [[1]]
		puts @DB.select_person_with_name_all(fn, ln)
		list = @DB.select_person_with_name_id(fn, ln)
		num = question("Type the number of the one that you were looking for")
		a = list[num.to_i - 1]
		if a != nil
		b = a[0]
			return b
		else 
			return nil
		end
	else say("\n\nPerson with given name does not exist")
			return nil
	end
end

def find_car_with_lp()
	lp = question("\n\nWhat is the license plate number?: ")
	if @DB.check_exist_car_with_lp(lp) == [[1]]
		return lp
	else say("\n\nCar with given license plate number does not exist")
		return nil
	end
end

def find_car_with_model()
	model = question("\n\nWhat is the model?: ") 
	if @DB.check_exist_car_with_model(model) == [[1]]
		puts @DB.select_car_with_model_all(model)
		list = @DB.select_car_with_model_lp(model)
		num = question("Type the number of the one that you were looking for")
		a = list[num.to_i - 1]
		if a != nil
		b = a[0]
			return b
		else 
			return nil
		end
	else say("\n\nCar with given model does not exist")
			return nil
	end
end

def find_car_info()
	say("\n\nHow do want to find car info?")
	lp = choose do |menu|
		menu.choice :"Search by License plate number" do find_car_with_lp() end
		menu.choice :"Search by model" do find_car_with_model() end
	end
	return lp
end

def find_person_info()
	say("\n\nHow do want to find person info?")
	id = choose do |menu|
		menu.choice :"Search by ID" do find_person_with_id() end
		menu.choice :"Search by name" do find_person_with_name() end
	end
	return id
end


def search_ticket_func()
	say("\n\nHow do you want to find the ticket?")
	tn = choose do |menu|
		menu.choice :"serch by ticket number" do search_with_ticket_number() end
		menu.choice :"serch by license plate number" do search_with_license_plate() end
	end
	return tn
end

def search_with_ticket_number()
	tn = question("\n\nType ticket number: ")
	if @DB.check_ticnum_exist(tn) == [[1]]
		return tn
	else
		return nil
	end
end

def search_with_license_plate()
	lp = question("\n\nType the license plate number")
	if @DB.check_exist_tic_with_lp(lp) == [[1]]
		@DB.select_ticket_with_lp(lp)
		list = @DB.select_ticket_num_with_lp(lp)
		num = question("Type the number of the one that you were looking for")
		a = list[num.to_i - 1]
		if a != nil
		b = a[0]
		return b
		else 
			return nil
		end
	else say("\n\nThere is no car with given license plate")
		return nil
	end
end

#modifies ask function. Makes sure that user input is not ""
#if it is "", say the message
def question(question)
	ask(question) do |q|
	q.responses[:not_valid] = "\n\nYour input cannot be empty"
	q.validate = Proc.new {|d| d != ""}
	end
end

end
