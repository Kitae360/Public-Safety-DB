require_relative 'database.rb'

class People
def initialize
	@db = Database.new
	say("people crud test")
	say("before insert")
	@db.select_people_data()
	@db.insert_into_people('f','l','id','e','dn','ha','ca')
	say("after insert")
	@db.select_people_data()
	@db.update_into_people('fm','lm','id','em','dnm','ham','cam')
	say("after update")
	@db.select_people_data()
	@db.delete_person_info_main('id')
	say("after delete")
	@db.select_people_data()
end
end

class Car
def initialize
	@db = Database.new
	say("car crud test")
	say("before insert")
	@db.select_car_data()
	@db.insert_into_car('l', 'r', 'c', 'm')
	say("after insert")
	@db.select_car_data()
	@db.update_into_car('l', 'mmr', 'yukc', 'wefwefm')
	say("after update")
	@db.select_car_data()
	@db.delete_car_info('l')
	say("after delete")
	@db.select_car_data()
end
end

class Permit
def initialize
	@db = Database.new
	say("permit crud test")
	@db.insert_into_people('f','l','id','e','dn','ha','ca')
	@db.insert_into_car('l', 'r', 'c', 'm')
	say("before insert")
	@db.select_permit_data()
	@db.insert_into_permit('id', 'l', 'p', 'y')
	say("after insert")
	@db.select_permit_data()
	@db.update_parking_permit('p', 'qwfy')
	say("after update")
	@db.select_permit_data()
	@db.delete_parking_permit('p')
	say("after delete")
	@db.select_permit_data()
	@db.delete_car_info('l')
	@db.delete_person_info_main('id')
end
end

class Ticket
def initialize
	@db = Database.new
	say("ticket crud test")
	say("before insert")
	@db.select_ticket_with_lp('lp')
	@db.insert_into_car('lp', 'r', 'c', 'm')
	@db.insert_ticket('lp', 'tn', 'pr', 'du', 'rea', 'from')
	say("after insert")
	@db.select_ticket_with_lp('lp')
	@db.update_ticket('tn')
	say("after update")
	@db.select_ticket_with_lp('lp')
	@db.delete_ticket_info('tn')
	say("after delete")
	@db.select_ticket_with_lp('lp')
	@db.delete_car_info('lp')
end
end

People.new
Car.new
Permit.new
Ticket.new
