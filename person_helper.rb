require 'highline/import'
require 'sqlite3'
require_relative 'database.rb'
require_relative 'helper.rb'
#This helper file and other helper files generate questions to the user and stores user
#input into the database. This helper file and other basically intereact with database.rb
class Person_helper

def initialize()
	@DB = Database.new
	@help = Helper.new
end

def insert_person_info()
	id = @help.question("\n\nWhat is the ID of the person?: ")
	if @DB.check_exist_person_with_id(id) == [[0]]
	f =  @help.question("What is the first name?: ")
	l = @help.question("What is the last name?: ") 
	e = @help.question("What is the email?: ") 
	dn = @help.question("What is the driver's license number?: ") 
	ha = @help.question("What is the home address?: ") 
	ca = @help.question("What is the current address?: ")
	say("\n\nIs this data correct")
	say("\n\nID: #{id}, Fisrt Name: #{f}, Last Name: #{l}, Email: #{e}")
	if HighLine.agree("Driver's license number: #{dn}, Home Address: #{ha}, Current Address: #{ca} (y/n)") == true
		@DB.insert_into_people(f,l,id,e,dn,ha,ca)
	if HighLine.agree("\n\nIs this person a student?(y/n): ") == true
		add_student_info(id)
	else 
	end
	if HighLine.agree("\n\nIs this person a faculty?(y/n): ") == true
		add_faculty_info(id)
	else
	end
	if HighLine.agree("\n\nIs this the same person who registered the car at the DMV?(y/n)") == false
		add_dmv_owner_info(id)
	else
	end
	else 
		say("\n\nPlease insert correct data")
		insert_person_info()
	end
	else
		say("\n\nSorry Person with given ID already exists")
	end
end

def add_student_info(id)
	id = id
	cl = @help.question("What is class standing?: ") 
	d = @help.question("Which dorm does this person live in?: ") 
	say("\n\nIs this data correct?")
	if HighLine.agree("Class Standing: #{cl}, Dorm Name: #{d} (y/n)") == true
		@DB.insert_into_student(id, cl, d)
	else
		say("\n\nPlease insert correct data")
		add_student_info(id)
	end
end

def add_faculty_info(id)
	id = id
	de = @help.question("What department does this person work in?: ") 
	say("\n\nIs this data correct?")
	if HighLine.agree("Department Name: #{de} (y/n)") == true
		@DB.insert_into_faculty(id, de)
	else
		say("\n\nPlease insert correct data")
		add_faculty_info(id)
	end
end

def add_dmv_owner_info(id)
	id = id
	f =  @help.question("\n\nWhat is the first name of the car owner in DMV?: ")
	l = @help.question("What is the last name of the car owner in DMV?: ") 
	say("\n\nIs this data correct?")
	if HighLine.agree("\n\nFirst Name: #{f}, Last Name: #{l} (y/n)") == true
		@DB.insert_into_dvm(f,l,id)
	else
		say("\n\nPlease insert correct data")
		add_dmv_owner_info(id)
	end
end

def update_person_info()
	if @DB.check_people_exist() == [[1]]
	id = @help.find_person_info()
	if id != nil
	say("Now insert new data")
	f =  @help.question("\n\nWhat is the first name?: ")
	l = @help.question("What is the last name?: ") 
	e = @help.question("What is the email?: ") 
	dn = @help.question("What is the driver's license number?: ") 
	ha = @help.question("What is the home address?: ") 
	ca = @help.question("What is the current address?: ")
	say("\n\nIs this data correct")
	say("ID: #{id}, Fisrt Name: #{f}, Last Name: #{l}, Email: #{e}")
	if HighLine.agree("Driver's license number: #{dn}, Home Address: #{ha}, Current Address: #{ca} (y/n)") == true
		@DB.update_into_people(f,l,id,e,dn,ha,ca)
		@DB.delete_person_info_side(id)
	if HighLine.agree("\n\nIs this person a student?(y/n): ") == true
		add_student_info(id)
	else 
	end
	if HighLine.agree("\n\nIs this person a faculty?(y/n): ") == true
		add_faculty_info(id)
	else
	end
	if HighLine.agree("\n\nIs this the same person who registered the car in the DMV?(y/n)") == false
		add_dmv_owner_info(id)
	else
	end
	else 
		say("\n\nPlease insert correct data")
		update_person_info()
	end
	else
		say("\n\nThere is no person who matches up with given info")
	end
	else say("\n\nThere is no people information to update")
	end
end

def delete_person_info()
	if @DB.check_people_exist() == [[1]]
	id = @help.find_person_info()
	if id != nil
	if @DB.check_exist_permit_with_id(id) == [[0]]
		say("Data with given info is deleted")
		@DB.delete_person_info_side(id)
		@DB.delete_person_info_main(id)
	else 
	if HighLine.agree("\n\nThere is a parking permit attached. Do you want to erase parking permit also? (y/n)") == true
		delete_permit_before_peo(id)
	else say("\n\nThen you cannot erase this car information")
	end
	end
	else say("\n\nThere is no matching information to delete")
	end
	else say("\n\nThere is no people information to delete")
	end
end

def delete_permit_before_peo(id)
	p = @DB.get_permit_with_id(id)	
	@DB.delete_parking_permit(p)
	@DB.delete_person_info_side(id)
	@DB.delete_person_info_main(id)
end


def view_student_data()
	if @DB.check_student_exist() == [[1]]
	@DB.select_student_data()
	else say("\n\nThere is no data to show")
	end
end

def view_faculty_data()
	if @DB.check_faculty_exist() == [[1]]
	@DB.select_faculty_data()
	else say("\n\nThere is no data to show")
	end
end

def view_people_data()
	if @DB.check_people_exist() == [[0]]
		say("\n\nThere is no data to search") 
	else
		@DB.select_people_data()
	end
end


def search_people_data()
	if @DB.check_people_exist() == [[0]]
		say("\n\nThere is no data to search") 
	else
		id = @help.find_person_info()
		@DB.select_with_id(id)
	end
end
end
