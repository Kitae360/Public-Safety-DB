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



Co_Table_crud.new
