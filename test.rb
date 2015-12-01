require 'minitest/autorun'
require_relative 'code.rb' 

class Test_When_no_Table_Exist < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
	end
	
	def test_check_co_exist
		 assert_equal [[0]], @db.check_co_exist()
	end

	def test_check_sco_exist
		 assert_equal [[0]], @db.check_sco_exist()
	end

	def test_check_car_exist
		 assert_equal [[0]], @db.check_car_exist()
	end

	def test_check_pp_exist
		 assert_equal [[0]], @db.check_pp_exist()
	end

	def test_check_tickets_exist
		assert_equal [[0]], @db.check_tickets_exist()
	end

	def test_select_co
		assert_equal say("There isn't any registered car owners(DMV)"), @db.select_co()	
	end

	def test_select_car
		assert_equal say("There isn't any registered cars"), @db.select_car()
	end

	def test_select_sco
		assert_equal say("There isn't any registered car owners(school)"), @db.select_sco()
	end

	def test_select_pp
		assert_equal say("There isn't any parking permit"), @db.select_pp()
	end

	def test_select_ticket
		assert_equal say("There isn't any tickets"), @db.select_tickets()	
	end

	def test_check_car_dmv_regnum_exist
		assert_equal [[0]], @db.check_car_dmv_regnum_exist('r_num')
	end

	def test_check_car_school_regnum_exist
		assert_equal [[0]], @db.check_car_school_regnum_exist('r_num')
	end

	def test_check_car_school_dlnum_exist
		assert_equal [[0]], @db.check_car_school_dlnum_exist('dl_n')
	end

	def test_check_car_dlnum_exist
		assert_equal [[0]], @db.check_car_dlnum_exist('dl_n')
	end

	def test_check_car_school_sid_exist
		assert_equal [[0]], @db.check_car_school_sid_exist('si_N')
	end

	def test_check_car_lp_exist
		assert_equal [[0]], @db.check_car_lp_exist('lp')
	end

	def test_check_pp_lp_exist
		assert_equal [[0]], @db.check_pp_lp_exist('lp')	
	end

	def test_check_pp_pnum_exist
		assert_equal [[0]], @db.check_pp_pnum_exist('pn')
	end

	def test_check_ticket_pnum_exist
		assert_equal [[0]], @db.check_ticket_pnum_exist('pn')
	end

	def test_check_ticket_num_exist
		assert_equal [[0]], @db.check_ticket_num_exist('tn')	
	end
	
	def teardown
	end
end

class Test_When_co_Table_Exist < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'r_num')
	end
	
	def test_check_co_exist
		 assert_equal [[1]], @db.check_co_exist()
	end

	def test_check_sco_exist
		 assert_equal [[0]], @db.check_sco_exist()
	end

	def test_check_car_exist
		 assert_equal [[0]], @db.check_car_exist()
	end

	def test_check_pp_exist
		 assert_equal [[0]], @db.check_pp_exist()
	end

	def test_check_tickets_exist
		assert_equal [[0]], @db.check_tickets_exist()
	end

	def test_select_car
		assert_equal say("There isn't any registered cars"), @db.select_car()
	end

	def test_select_sco
		assert_equal say("There isn't any registered car owners(school)"), @db.select_sco()
	end

	def test_select_pp
		assert_equal say("There isn't any parking permit"), @db.select_pp()
	end

	def test_select_ticket
		assert_equal say("There isn't any tickets"), @db.select_tickets()	
	end

	def test_check_car_dmv_regnum_exist
		assert_equal [[1]], @db.check_car_dmv_regnum_exist('r_num')
	end

	def test_check_car_school_regnum_exist
		assert_equal [[0]], @db.check_car_school_regnum_exist('r_num')
	end

	def test_check_car_school_dlnum_exist
		assert_equal [[0]], @db.check_car_school_dlnum_exist('dl_n')
	end

	def test_check_car_dlnum_exist
		assert_equal [[0]], @db.check_car_dlnum_exist('dl_n')
	end

	def test_check_car_school_sid_exist
		assert_equal [[0]], @db.check_car_school_sid_exist('si_N')
	end

	def test_check_car_lp_exist
		assert_equal [[0]], @db.check_car_lp_exist('lp')
	end

	def test_check_pp_lp_exist
		assert_equal [[0]], @db.check_pp_lp_exist('lp')	
	end

	def test_check_pp_pnum_exist
		assert_equal [[0]], @db.check_pp_pnum_exist('pn')
	end

	def test_check_ticket_pnum_exist
		assert_equal [[0]], @db.check_ticket_pnum_exist('pn')
	end

	def test_check_ticket_num_exist
		assert_equal [[0]], @db.check_ticket_num_exist('tn')	
	end
	
	def teardown
		@db.delete_owner_dmv_info('r_num')
	end
end

class Test_When_Sco_Table_Exist < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'r_num')
		@db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'r_num', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
	end
	
	def test_check_co_exist
		 assert_equal [[1]], @db.check_co_exist()
	end

	def test_check_sco_exist
		 assert_equal [[1]], @db.check_sco_exist()
	end

	def test_check_car_exist
		 assert_equal [[0]], @db.check_car_exist()
	end

	def test_check_pp_exist
		 assert_equal [[0]], @db.check_pp_exist()
	end

	def test_check_tickets_exist
		assert_equal [[0]], @db.check_tickets_exist()
	end

	def test_select_car
		assert_equal say("There isn't any registered cars"), @db.select_car()
	end

	def test_select_pp
		assert_equal say("There isn't any parking permit"), @db.select_pp()
	end

	def test_select_ticket
		assert_equal say("There isn't any tickets"), @db.select_tickets()	
	end

	def test_check_car_dmv_regnum_exist
		assert_equal [[1]], @db.check_car_dmv_regnum_exist('r_num')
	end

	def test_check_car_school_regnum_exist
		assert_equal [[1]], @db.check_car_school_regnum_exist('r_num')
	end

	def test_check_car_school_dlnum_exist
		assert_equal [[1]], @db.check_car_school_dlnum_exist('dl_n')
	end

	def test_check_car_dlnum_exist
		assert_equal [[0]], @db.check_car_dlnum_exist('dl_n')
	end

	def test_check_car_school_sid_exist
		assert_equal [[1]], @db.check_car_school_sid_exist('si_N')
	end

	def test_check_car_lp_exist
		assert_equal [[0]], @db.check_car_lp_exist('lp')
	end

	def test_check_pp_lp_exist
		assert_equal [[0]], @db.check_pp_lp_exist('lp')	
	end

	def test_check_pp_pnum_exist
		assert_equal [[0]], @db.check_pp_pnum_exist('pn')
	end

	def test_check_ticket_pnum_exist
		assert_equal [[0]], @db.check_ticket_pnum_exist('pn')
	end

	def test_check_ticket_num_exist
		assert_equal [[0]], @db.check_ticket_num_exist('tn')	
	end
	
	def teardown
		@db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('r_num')
	end
end

class Test_When_car_Table_Exist < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'r_num')
		@db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'r_num', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
		@db.insert_car_info('model', 'color', 'year_of_car',  'lp', 'dl_n')
	end
	
	def test_check_co_exist
		 assert_equal [[1]], @db.check_co_exist()
	end

	def test_check_sco_exist
		 assert_equal [[1]], @db.check_sco_exist()
	end

	def test_check_car_exist
		 assert_equal [[1]], @db.check_car_exist()
	end

	def test_check_pp_exist
		 assert_equal [[0]], @db.check_pp_exist()
	end

	def test_check_tickets_exist
		assert_equal [[0]], @db.check_tickets_exist()
	end

	def test_select_pp
		assert_equal say("There isn't any parking permit"), @db.select_pp()
	end

	def test_select_ticket
		assert_equal say("There isn't any tickets"), @db.select_tickets()	
	end

	def test_check_car_dmv_regnum_exist
		assert_equal [[1]], @db.check_car_dmv_regnum_exist('r_num')
	end

	def test_check_car_school_regnum_exist
		assert_equal [[1]], @db.check_car_school_regnum_exist('r_num')
	end

	def test_check_car_school_dlnum_exist
		assert_equal [[1]], @db.check_car_school_dlnum_exist('dl_n')
	end

	def test_check_car_dlnum_exist
		assert_equal [[1]], @db.check_car_dlnum_exist('dl_n')
	end

	def test_check_car_school_sid_exist
		assert_equal [[1]], @db.check_car_school_sid_exist('si_N')
	end

	def test_check_car_lp_exist
		assert_equal [[1]], @db.check_car_lp_exist('lp')
	end

	def test_check_pp_lp_exist
		assert_equal [[0]], @db.check_pp_lp_exist('lp')	
	end

	def test_check_pp_pnum_exist
		assert_equal [[0]], @db.check_pp_pnum_exist('pn')
	end

	def test_check_ticket_pnum_exist
		assert_equal [[0]], @db.check_ticket_pnum_exist('pn')
	end

	def test_check_ticket_num_exist
		assert_equal [[0]], @db.check_ticket_num_exist('tn')	
	end
	
	def teardown
		@db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('r_num')
		@db.delete_car_info('lp')
	end
end

class Test_When_parking_permit_Table_Exist < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'r_num')
		@db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'r_num', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
		@db.insert_car_info('model', 'color', 'year_of_car',  'lp', 'dl_n')
		@db.insert_parking_permit_info('type', 'length', 'pn', 'lp')
	end
	
	def test_check_co_exist
		 assert_equal [[1]], @db.check_co_exist()
	end

	def test_check_sco_exist
		 assert_equal [[1]], @db.check_sco_exist()
	end

	def test_check_car_exist
		 assert_equal [[1]], @db.check_car_exist()
	end

	def test_check_pp_exist
		 assert_equal [[1]], @db.check_pp_exist()
	end

	def test_check_tickets_exist
		assert_equal [[0]], @db.check_tickets_exist()
	end

	def test_select_ticket
		assert_equal say("There isn't any tickets"), @db.select_tickets()	
	end

	def test_check_car_dmv_regnum_exist
		assert_equal [[1]], @db.check_car_dmv_regnum_exist('r_num')
	end

	def test_check_car_school_regnum_exist
		assert_equal [[1]], @db.check_car_school_regnum_exist('r_num')
	end

	def test_check_car_school_dlnum_exist
		assert_equal [[1]], @db.check_car_school_dlnum_exist('dl_n')
	end

	def test_check_car_dlnum_exist
		assert_equal [[1]], @db.check_car_dlnum_exist('dl_n')
	end

	def test_check_car_school_sid_exist
		assert_equal [[1]], @db.check_car_school_sid_exist('si_N')
	end

	def test_check_car_lp_exist
		assert_equal [[1]], @db.check_car_lp_exist('lp')
	end

	def test_check_pp_lp_exist
		assert_equal [[1]], @db.check_pp_lp_exist('lp')	
	end

	def test_check_pp_pnum_exist
		assert_equal [[1]], @db.check_pp_pnum_exist('pn')
	end

	def test_check_ticket_pnum_exist
		assert_equal [[0]], @db.check_ticket_pnum_exist('pn')
	end

	def test_check_ticket_num_exist
		assert_equal [[0]], @db.check_ticket_num_exist('tn')	
	end
	
	def teardown
		@db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('r_num')
		@db.delete_car_info('lp')
		@db.delete_parking_permit_info('pn')
	end
end


class Test_When_ticket_Table_Exist < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_owner_dmv_info('name_F', 'name_M', 'name_L', 'r_num')
		@db.insert_owner_school_info('fir', 'mid', 'las', 'dl_n', 'si_N', 'r_num', 'p_n', 'sig', 'pic', 'email', 'bd', 'per_add', 'curr_add')
		@db.insert_car_info('model', 'color', 'year_of_car',  'lp', 'dl_n')
		@db.insert_parking_permit_info('type', 'length', 'pn', 'lp')
		@db.insert_ticket('tn', 're', 'due', 200, 'from', 'to', 'pn')
	end
	
	def test_check_co_exist
		 assert_equal [[1]], @db.check_co_exist()
	end

	def test_check_sco_exist
		 assert_equal [[1]], @db.check_sco_exist()
	end

	def test_check_car_exist
		 assert_equal [[1]], @db.check_car_exist()
	end

	def test_check_pp_exist
		 assert_equal [[1]], @db.check_pp_exist()
	end

	def test_check_tickets_exist
		assert_equal [[1]], @db.check_tickets_exist()
	end

	def test_check_car_dmv_regnum_exist
		assert_equal [[1]], @db.check_car_dmv_regnum_exist('r_num')
	end

	def test_check_car_school_regnum_exist
		assert_equal [[1]], @db.check_car_school_regnum_exist('r_num')
	end

	def test_check_car_school_dlnum_exist
		assert_equal [[1]], @db.check_car_school_dlnum_exist('dl_n')
	end

	def test_check_car_dlnum_exist
		assert_equal [[1]], @db.check_car_dlnum_exist('dl_n')
	end

	def test_check_car_school_sid_exist
		assert_equal [[1]], @db.check_car_school_sid_exist('si_N')
	end

	def test_check_car_lp_exist
		assert_equal [[1]], @db.check_car_lp_exist('lp')
	end

	def test_check_pp_lp_exist
		assert_equal [[1]], @db.check_pp_lp_exist('lp')	
	end

	def test_check_pp_pnum_exist
		assert_equal [[1]], @db.check_pp_pnum_exist('pn')
	end

	def test_check_ticket_pnum_exist
		assert_equal [[1]], @db.check_ticket_pnum_exist('pn')
	end

	def test_check_ticket_num_exist
		assert_equal [[1]], @db.check_ticket_num_exist('tn')	
	end

	def test_check_car_dmv_regnum_exist_wrong
		assert_equal [[0]], @db.check_car_dmv_regnum_exist('af')
	end

	def test_check_car_school_regnum_exist_wrong
		assert_equal [[0]], @db.check_car_school_regnum_exist('af')
	end

	def test_check_car_school_dlnum_exist_wrong
		assert_equal [[0]], @db.check_car_school_dlnum_exist('af')
	end

	def test_check_car_dlnum_exist_wrong
		assert_equal [[0]], @db.check_car_dlnum_exist('af')
	end

	def test_check_car_school_sid_exist_wrong
		assert_equal [[0]], @db.check_car_school_sid_exist('af')
	end

	def test_check_car_lp_exist_wrong
		assert_equal [[0]], @db.check_car_lp_exist('af')
	end

	def test_check_pp_lp_exist_wrong
		assert_equal [[0]], @db.check_pp_lp_exist('af')	
	end

	def test_check_pp_pnum_exist_wrong
		assert_equal [[0]], @db.check_pp_pnum_exist('af')
	end

	def test_check_ticket_pnum_exist_wrong
		assert_equal [[0]], @db.check_ticket_pnum_exist('af')
	end

	def test_check_ticket_num_exist_wrong
		assert_equal [[0]], @db.check_ticket_num_exist('af')	
	end

	def test_select_dnum_with_id
		assert_equal 'dl_n',@db.select_dnum_with_id('si_N')	
	end

	def test_select_rnum_with_id
		assert_equal 'r_num', @db.select_rnum_with_id('si_N')
	end

	def test_select_lp_with_dnum
		assert_equal 'lp', @db.select_lp_with_dnum('dl_n')
	end

	def test_select_pn_with_lp
		assert_equal 'pn' ,@db.select_pn_with_lp('lp')
	end
	
	def teardown
		@db.delete_owner_school_info('dl_n')
		@db.delete_owner_dmv_info('r_num')
		@db.delete_car_info('lp')
		@db.delete_parking_permit_info('pn')
		@db.delete_ticket('tn')
	end
end

