require 'highline/import'
require 'sqlite3'
require_relative 'database.rb'
require_relative 'helper.rb'

class Car_helper

def initialize()
	@DB = Database.new
	@help = Helper.new
end

def insert_car_info()
	l = @help.question("What is the license plate number of the car?: ")
	if @DB.check_exist_car_with_lp(l) == [[0]]
	r =  @help.question("What is the registeration number of the car?: ")
	c = @help.question("What is the color of the car?: ") 
	m = @help.question("What is the model of the car?: ") 
	say("Is this data correct?")
	say("License Plate Number: #{l}, Registration Number: #{r}")
	if HighLine.agree("Color: #{c},Model: #{m} (y/n)") == true
		@DB.insert_into_car(l, r, c, m)
	else
		say("Please insert correct data")
		insert_car_info()
	end
	else say("Car with a given license plate number already exist")
	end
end



def update_car_info()
	if @DB.check_car_exist() == [[1]]
	l = @help.find_car_info()
	if l != nil
	r =  @help.question("What is the registeration number of the car?: ")
	c = @help.question("What is the color of the car?: ") 
	m = @help.question("What is the model of the car?: ") 
	say("Is this data correct?")
	say("License Plate Number: #{l}, Registration Number: #{r}")
	if HighLine.agree("Color: #{c},Model: #{m} (y/n)") == true
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

def delete_car_info()
	if @DB.check_car_exist() == [[1]]
	lp = @help.find_car_info()
	if lp != nil
	if (@DB.check_exist_permit_with_lp(lp) == [[0]] and @DB.check_ticket_exist_lp(lp) == [[0]])
		@DB.delete_car_info(lp)
	else 
	if HighLine.agree("There is a parking permit and/or tickets attached to it. Do you want to erase those data also? (y/n)") == true
		delete_permit_before_car(lp)
		delete_ticket_before_car(lp)
		@DB.delete_car_info(lp)
	else say("Then you cannot erase this car information")
	end
	end
	else say("There is no matching information to delete")
	end
	else say("There is no car information to delete")
	end
end

def delete_permit_before_car(lp)
	if @DB.check_exist_permit_with_lp(lp) == [[1]]
	p = @DB.get_permit_with_lp(lp)
	@DB.delete_parking_permit(p)
	else nil 
	end
end


def delete_ticket_before_car(lp)
	if @DB.check_ticket_exist_lp(lp) == [[1]]
	p = @DB.get_ticnum_with_lp(lp)
	@DB.delete_ticket_info(p)
	else nil
	end
end

def view_car_data()
	if @DB.check_car_exist() == [[0]]
		say("There is no data to search") 
	else
		@DB.select_car_data()
	end
end

def search_car_data()
	if @DB.check_car_exist() == [[0]]
		say("There is no data to search") 
	else
		lp = @help.find_car_info()
		@DB.select_with_lp(lp)
	end
end

end
