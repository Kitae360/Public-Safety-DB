require_relative 'code.rb' 

class Co_Table_crud
	def initialize()
		@db = Database.new
		puts "before insert"
		puts @db.select_co()
		puts "after insert"
		puts @db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'rn')
		puts @db.select_co()
		puts "after update"
		puts @db.update_owner_dmv_info('me_F', 'me_M', 'me_L', 'rn')
		puts @db.select_co()
		puts "after delete"
		puts @db.delete_owner_dmv_info('rn')
		puts @db.select_co()
	end
end

class Sco_Table_crud
	def initialize()
		@db = Database.new
		puts "before insert"
		puts @db.select_sco()
		puts "after insert"
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'rn')
		puts @db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'rn', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
		puts @db.select_sco()
		puts "after update"
		puts @db.update_owner_school_info('name_F', 'name_M', 'name_L', 'dl_n', 'p_num', 'sig', 'pic', 'em', 'bd', 'per_add', 'curr_add')
		puts @db.select_sco()
		puts "after delete"
		puts @db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('rn')
		puts @db.select_sco()
	end
end

class Car_Table_crud
	def initialize()
		@db = Database.new
		puts "before insert"
		puts @db.select_car()
		puts "after insert"
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'rn')
		@db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'rn', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
		puts @db.insert_car_info('model', 'color', 'year_of_car', 'lp', 'dl_n')
		puts @db.select_car()
		puts "after update"
		puts @db.update_car_info('mo', 'c', 'ye', 'lp')
		puts @db.select_car()
		puts "after delete"
		puts @db.delete_car_info('lp')
		@db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('rn')
		puts @db.select_car()
	end
end

class PP_Table_crud
	def initialize()
		@db = Database.new
		puts "before insert"
		puts @db.select_pp()
		puts "after insert"
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'rn')
		@db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'rn', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
		@db.insert_car_info('model', 'color', 'year_of_car', 'lp', 'dl_n')
		@db.insert_parking_permit_info('type', 'length', 'pn', 'lp')
		puts @db.select_pp()
		puts "after update"
		puts @db.update_parking_permit_info('t', 'l', 'pn')
		puts @db.select_pp()
		puts "after delete"
		puts @db.delete_parking_permit_info('pn')
		@db.delete_car_info('lp')
		@db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('rn')
		puts @db.select_pp()
	end
end

class Ticket_Table_crd
	def initialize()
		@db = Database.new
		puts "before insert"
		puts @db.select_tickets()
		puts "after insert"
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'rn')
		@db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'rn', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
		@db.insert_car_info('model', 'color', 'year_of_car', 'lp', 'dl_n')
		@db.insert_parking_permit_info('type', 'length', 'pn', 'lp')
		@db.insert_ticket('tn', 'reason', 'due_date', 200, 'from_who', 'to_whom', 'car_permit')
		puts @db.select_tickets()
		puts "after delete"
		puts @db.delete_ticket('tn')
		puts @db.delete_parking_permit_info('pn')
		@db.delete_car_info('lp')
		@db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('rn')
		puts @db.select_tickets()
	end
end



Co_Table_crud.new
Sco_Table_crud.new
Car_Table_crud.new
PP_Table_crud.new
Ticket_Table_crd.new
