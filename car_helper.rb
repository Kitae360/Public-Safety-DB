require 'highline/import'
require 'sqlite3'
require_relative 'database.rb'
require_relative 'helper.rb'
#@help.question 
class Car_helper
#This helper file and other helper files generate questions to the user and stores user
#input into the database. This helper file and other basically intereact with database.rb
def initialize()
	@DB = Database.new
	@help = Helper.new
end

def insert_car_info()
	l = @help.question("\n\nWhat is the license plate number?: ")
	if @DB.check_exist_car_with_lp(l) == [[0]] #Prompts for user input of car information
	r =  @help.question("What is the registeration number?: ")
	c = @help.question("What is the color?: ") 
	m = @help.question("What is the model?: ") 
	say("\n\nIs this data correct?")
	say("License Plate Number: #{l}, Registration Number: #{r}")
	if HighLine.agree("Color: #{c}, Model: #{m} (y/n)") == true
		@DB.insert_into_car(l, r, c, m)
	else#After all data is given, data is directed through database.rb (with SQL code in the file)
		say("\n\nPlease insert correct data")
	end
	else say("\n\nCar with given license plate number already exists")
	end#Redirects to insert menu
end



def update_car_info()
	if @DB.check_car_exist() == [[1]]
	l = @help.find_car_info()
	if l != nil
	say("Now put new data")
	r =  @help.question("\n\nWhat is the registration number?: ")
	c = @help.question("What is the color?: ") 
	m = @help.question("What is the model?: ") 
	say("\n\nIs this data correct?")#Promopts user for questions
	say("License Plate Number: #{l}, Registration Number: #{r}")
	if HighLine.agree("Color: #{c},Model: #{m} (y/n)") == true
		@DB.update_into_car(l, r, c, m)
	else
		say("\n\nPlease insert correct data")
		update_car_info()
	end#If the user fails input, they are taken back to the menu
	else say("\n\nThere is no car that matches with given info")
	end
	else say("\n\nThere is no car information to update")
	end
end

def delete_car_info()#Checks if car exists through index
	if @DB.check_car_exist() == [[1]]
	lp = @help.find_car_info()
	if lp != nil#Else it comapres values and deletes
	if (@DB.check_exist_permit_with_lp(lp) == [[0]] and @DB.check_ticket_exist_lp(lp) == [[0]])
		say("Data with given info is deleted")	
		@DB.delete_car_info(lp)
	else 
	if HighLine.agree("\n\nThere is a parking permit and/or tickets attached to it. Do you want to erase those data also? (y/n)") == true
		say("Data with given info is deleted")
		delete_permit_before_car(lp)#License plate number is used to refer permit
		delete_ticket_before_car(lp)
		@DB.delete_car_info(lp)
	else say("\n\nThen you cannot erase this car information")
	end
	end
	else say("\n\nThere is no matching information to delete")
	end
	else say("\n\nThere is no car information to delete")
	end
end

def delete_permit_before_car(lp)
	if @DB.check_exist_permit_with_lp(lp) == [[1]]
	p = @DB.get_permit_with_lp(lp)
	@DB.delete_parking_permit(p)
	else nil 
	end#Similar process to previous function
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
		say("\n\nThere is no data to search") 
	else
		@DB.select_car_data()
	end
end

def search_car_data()
	if @DB.check_car_exist() == [[0]]
		say("\n\nThere is no data to search") 
	else
		lp = @help.find_car_info()
		@DB.select_with_lp(lp)
	end
end

end
