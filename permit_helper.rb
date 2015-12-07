require 'highline/import'
require 'sqlite3'
require_relative 'database.rb'
require_relative 'helper.rb'

class Permit_helper

def initialize()
	@DB = Database.new
	@help = Helper.new
end

def insert_parking_permit_info()
	id = @help.find_person_info()
	if id != nil
	lp = @help.find_car_info()
	if lp != nil
	if @DB.check_exist_permit_with_lp(lp) == [[0]]
	p =  @help.question("\n\nWhat is the permit number?: ")
	if @DB.check_exist_permit_with_pn(p) == [[0]]
	y = @help.question("What is the type of the permit?: ")
	say("\n\nIs this data correct?")
	if HighLine.agree("ID: #{id}, License Plate Number: #{lp}, Permit Number: #{p}, Type: #{y} (y/n)") == true
		@DB.insert_into_permit(id, lp, p, y)
	else 
		say("\n\nPlease insert correct data")
		insert_parking_permit_info()
	end
	else say("\n\nGiven permit number already exists")
	end
	else say("\n\nCar with given license plate already has a parking permit")
	end
	else say("\n\nyou cannot give parking permit if there is no car")
	end 
	else say("\n\nyou cannot give parking permit if there is no person")
	end
end


def update_parking_permit_info()
	if @DB.check_permit_exist() == [[1]]
	pn = @help.question("\n\nWhat is the parking permit number?")
	if @DB.check_exist_permit_with_pn(pn) == [[1]]
	say("Now insert new data")
	y = @help.question("What is the type of the permit?: ")
	if HighLine.agree("\n\nIs this data correct? Permit Number: #{pn}, Type: #{y} (y/n)") == true
		@DB.update_parking_permit(pn, y)
	else
		say("\n\nPlease insert correct data")
		update_parking_permit_info
	end
	else say("\n\nThere is no parking permit that matches with given info")
	end
	else say("\n\nThere is no parking permit to update")
	end
	
end



def delete_parking_permit_info()
	if @DB.check_permit_exist() == [[1]]
	p =  @help.question("\n\nWhat is the permit number?: ")
	if @DB.check_exist_permit_with_pn(p) == [[1]]
		say("Data with given info is deleted")
		@DB.delete_parking_permit(p)
	else say("\n\nParking permit with given permit number doesn't exist")
	end
	else say("\n\nThere is no parking permit to delete")
	end
end

def view_permit_data()
	if @DB.check_permit_exist() == [[0]]
		say("\n\nThere is no data to search") 
	else
		@DB.select_permit_data()
	end
end

def search_permit_data()
	if @DB.check_permit_exist() == [[0]]
		say("\n\nThere is no data to search") 
	else
		pn = @help.question("\n\nWhat is the permit number?: ")
		if @DB.check_permit_exist_pn(pn) == [[1]]
		@DB.select_with_pn(pn)
		else say("\n\nThere is no permit with given permit number")
		end
	end
end

end
