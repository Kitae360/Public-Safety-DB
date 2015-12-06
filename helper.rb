require 'highline/import'
require 'sqlite3'
require_relative 'database.rb'

class Helper

def initialize()
	@DB = Database.new
end

def find_person_with_id()
	id = question("What is the ID of the person?: ")
	if @DB.check_exist_person_with_id(id) == [[1]]
		return id
	else say("Person with given ID does not exist")
		return nil
	end
end

def find_person_with_name()
	fn =  question("What is the first name of the person?: ")
	ln = question("What is the last name of the person?: ") 
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
	else say("Person with given name does not exist")
			return nil
	end
end

def find_car_with_lp()
	lp = question("What is the license plate number of the car?: ")
	if @DB.check_exist_car_with_lp(lp) == [[1]]
		return lp
	else say("Car with given license plate number does not exist")
		return nil
	end
end

def find_car_with_model()
	model = question("What is the model of the car?: ") 
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


def search_ticket_func()
	say("How do you want to find the ticket?")
	tn = choose do |menu|
		menu.choice :"serch by ticket number" do search_with_ticket_number() end
		menu.choice :"serch by license plate number" do search_with_license_plate() end
	end
	return tn
end

def search_with_ticket_number()
	tn = question("Type ticket number: ")
	if @DB.check_ticnum_exist(tn) == [[1]]
		return tn
	else
		return nil
	end
end

def search_with_license_plate()
	lp = question("Type the license plate number of the car")
	if @DB.check_exist_tic_with_lp(lp) == [[1]]
		puts @DB.select_ticket_with_lp(lp)
		list = @DB.select_ticket_num_with_lp(lp)
		num = question("Type the number of the one that you were looking for")
		a = list[num.to_i - 1]
		if a != nil
		b = a[0]
		return b
		else 
			return nil
		end
	else say("There is no car with given license plate")
		return nil
	end
end

def question(question)
	ask(question) do |q|
	q.responses[:not_valid] = "Your input cannot be empty"
	q.validate = Proc.new {|d| d != ""}
	end
end

end
