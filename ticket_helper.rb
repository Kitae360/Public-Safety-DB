require 'highline/import'
require 'sqlite3'
require_relative 'database.rb'
require_relative 'helper.rb'

class Ticket_helper

def initialize()
	@DB = Database.new
	@help = Helper.new
end

def insert_ticket()
	tn = @help.question("\n\nType ticket number: ")
	if @DB.check_ticnum_exist(tn) == [[0]]
	lp = @help.question("Type the license plate number: ")
	if @DB.check_car_exist_lp(lp) == [[1]]
	pr = ask("Type the price of the ticket: ", Integer)
	du = ask("Type ticket's due date('YYYY-MM-DD'): ")
	rea = @help.question("Type the reason of the ticket: ")	
	from = @help.question("Type who is giving the ticket: ")
	say("Is this data correct?")
	say("Licnese PLate number: #{lp}, Ticket Number: #{tn}, Price: #{pr}, Due: #{du}")
	if HighLine.agree("Reason: #{rea}, From: #{from} (y/n)") == true
	@DB.insert_ticket(lp, tn, pr, du, rea, from)
	else say("Please insert correct data")
		insert_ticket()
	end
	elsif @DB.check_car_exist_lp(lp) == [[0]]
		say("Car with given incense plate does not exist in database")
		if HighLine.agree("Would like to insert new car data? (y/n)") == true
			r =  @help.question("What is the registeration number of the car?: ")
			c = @help.question("What is the color of the car?: ") 
			m = @help.question("What is the model of the car?: ") 
			say("Is this data correct?")
			say("License Plate Number: #{lp}, Registration Number: #{r}")
			if HighLine.agree("Color: #{c},Model: #{m} (y/n)") == true
				@DB.insert_into_car(lp, r, c, m)
			say("Now we are giving ticket!")
				pr = ask("Type the price of the ticket: ", Integer)
				du = @help.question("Type ticket's due date('YYYY-MM-DD'): ")
				rea = @help.question("Type the reason of the ticket: ")	
				from = @help.question("Type who is giving the ticket: ")
				say("Is this data correct?")
				say("Licnese PLate number: #{lp}, Ticket Number: #{tn}, Price: #{pr}, Due: #{du}")
				if HighLine.agree("Reason: #{rea}, From: #{from} (y/n)") == true
				@DB.insert_ticket(lp, tn, pr, du, rea, from)
				else say("You need to insert correct data")
					insert_ticket()
				end
			else say("You need to insert correct data")
				insert_ticket()
			end
		else say("Then you cannot give ticket")
		end
	end
	else say("Ticket with given ticket number already ecxists")
	end	
end

def view_ticket_func()
	if @DB.check_ticket_exist() == [[1]]
	@DB.show_tickets()
	else
		say("There is no data to show")
	end
end

def pay_ticket_fuc()
	tn = @help.search_ticket_func()
	if @DB.check_ticnum_exist(tn) == [[1]]
	if @DB.check_ticket_paid(tn) == [[0]]
		@DB.update_ticket(tn)
	else say("Ticket with given ticket number is already paid")
	end
	else say("Ticket with given ticekt number does not exist")
	end

end

def search_ticket()
	tn = search_ticket_func()
	if tn == nil
		say("There is no data that matches with given info")
	else search_ticekt_function(tn)
	end
end

def search_ticket_func()
	@help.search_ticket_func()
end

def search_ticekt_function(tn)
	@DB.show_ticket_with_tn(tn)
end


end
