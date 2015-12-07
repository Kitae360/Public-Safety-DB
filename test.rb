require_relative 'database.rb'
require 'minitest/autorun'


class Test_Select_Exists < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_into_people('f','l','id','e','dn','ha','ca')
	end

	def test_check_ticket_exist
		assert_equal [[0]], @db.check_ticket_exist()	
	end

	def test_check_ticket_paid
		assert_equal [[0]], @db.check_ticket_paid('tn')
	end

	def test_check_exist_tic_with_lp
		assert_equal [[0]], @db.check_exist_tic_with_lp('lp')
	end
	
	def test_check_student_exist
		assert_equal [[0]], @db.check_student_exist()
	end

	def test_check_faculty_exist
		assert_equal [[0]], @db.check_faculty_exist()
	end

	def test_check_student_exist_id
		assert_equal [[0]], @db.check_student_exist_id('id')
	end

	def test_check_faculty_exist_id
		assert_equal [[0]], @db.check_faculty_exist_id('id')
	end

	def test_check_ticnum_exist
		assert_equal [[0]], @db.check_ticnum_exist('tn')
	end

	def test_check_ticket_exist_lp
		assert_equal [[0]], @db.check_ticket_exist_lp('lp')
	end

	def test_check_people_exist
		assert_equal [[1]], @db.check_people_exist()
	end

	def test_check_car_exist
		assert_equal [[0]], @db.check_car_exist()
	end

	def test_check_car_exist_lp
		assert_equal [[0]], @db.check_car_exist_lp('lp')
	end

	def test_check_permit_exist
		assert_equal [[0]], @db.check_permit_exist()
	end

	def test_check_permit_exist_pn
		assert_equal [[0]], @db.check_permit_exist_pn('pn')
	end

	def test_check_exist_person_with_id
		assert_equal [[1]], @db.check_exist_person_with_id('id')
	end

	def test_check_exist_person_with_id_false
		assert_equal [[0]], @db.check_exist_person_with_id('sd')
	end

	def test_check_exist_person_with_name
		assert_equal [[1]], @db.check_exist_person_with_name('f', 'l')
	end

	def test_check_exist_person_with_name_false
		assert_equal [[0]], @db.check_exist_person_with_name('n', 'ln')
	end

	def test_check_exist_car_with_lp
		assert_equal [[0]], @db.check_exist_car_with_lp('lp')
	end

	def test_check_exist_car_with_model
		assert_equal [[0]], @db.check_exist_car_with_model('model')
	end

	def test_check_exist_permit_with_pn
		assert_equal [[0]], @db.check_exist_permit_with_pn('pn')
	end

	def test_check_exist_permit_with_id
		assert_equal [[0]], @db.check_exist_permit_with_id('id')
	end

	def test_check_exist_permit_with_lp
		assert_equal [[0]], @db.check_exist_permit_with_lp('lp')
	end

	def teardown
		@db.delete_person_info_main('id')
	end
end


class Test_Select_Exists_person_ < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_into_people('f','l','id','e','dn','ha','ca')
		@db.insert_into_student('id', 'c', 'd')
		@db.insert_into_faculty('id', 'dp')
		@db.insert_into_dvm('f','l','id')
	end

	def test_check_ticket_exist
		assert_equal [[0]], @db.check_ticket_exist()	
	end

	def test_check_ticket_paid
		assert_equal [[0]], @db.check_ticket_paid('tn')
	end

	def test_check_exist_tic_with_lp
		assert_equal [[0]], @db.check_exist_tic_with_lp('lp')
	end
	
	def test_check_student_exist
		assert_equal [[1]], @db.check_student_exist()
	end

	def test_check_faculty_exist
		assert_equal [[1]], @db.check_faculty_exist()
	end

	def test_check_student_exist_id
		assert_equal [[1]], @db.check_student_exist_id('id')
	end

	def test_check_faculty_exist_id
		assert_equal [[1]], @db.check_faculty_exist_id('id')
	end

	def test_check_ticnum_exist
		assert_equal [[0]], @db.check_ticnum_exist('tn')
	end

	def test_check_ticket_exist_lp
		assert_equal [[0]], @db.check_ticket_exist_lp('lp')
	end

	def test_check_people_exist
		assert_equal [[1]], @db.check_people_exist()
	end

	def test_check_car_exist
		assert_equal [[0]], @db.check_car_exist()
	end

	def test_check_car_exist_lp
		assert_equal [[0]], @db.check_car_exist_lp('lp')
	end

	def test_check_permit_exist
		assert_equal [[0]], @db.check_permit_exist()
	end

	def test_check_permit_exist_pn
		assert_equal [[0]], @db.check_permit_exist_pn('pn')
	end

	def test_check_exist_person_with_id
		assert_equal [[1]], @db.check_exist_person_with_id('id')
	end

	def test_check_exist_person_with_id_false
		assert_equal [[0]], @db.check_exist_person_with_id('sd')
	end

	def test_check_exist_person_with_name
		assert_equal [[1]], @db.check_exist_person_with_name('f', 'l')
	end

	def test_check_exist_person_with_name_false
		assert_equal [[0]], @db.check_exist_person_with_name('n', 'ln')
	end

	def test_check_exist_car_with_lp
		assert_equal [[0]], @db.check_exist_car_with_lp('lp')
	end

	def test_check_exist_car_with_model
		assert_equal [[0]], @db.check_exist_car_with_model('model')
	end

	def test_check_exist_permit_with_pn
		assert_equal [[0]], @db.check_exist_permit_with_pn('pn')
	end

	def test_check_exist_permit_with_id
		assert_equal [[0]], @db.check_exist_permit_with_id('id')
	end

	def test_check_exist_permit_with_lp
		assert_equal [[0]], @db.check_exist_permit_with_lp('lp')
	end

	def teardown
		@db.delete_person_info_main('id')
		@db.delete_person_info_side('id')
	end
end


class Test_Select_Exists_car < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_into_car('lp', 'r', 'c', 'm')
	end

	def test_check_ticket_exist
		assert_equal [[0]], @db.check_ticket_exist()	
	end

	def test_check_ticket_paid
		assert_equal [[0]], @db.check_ticket_paid('tn')
	end

	def test_check_exist_tic_with_lp
		assert_equal [[0]], @db.check_exist_tic_with_lp('lp')
	end

	def test_check_ticnum_exist
		assert_equal [[0]], @db.check_ticnum_exist('tn')
	end

	def test_check_ticket_exist_lp
		assert_equal [[0]], @db.check_ticket_exist_lp('lp')
	end

	def test_check_car_exist
		assert_equal [[1]], @db.check_car_exist()
	end

	def test_check_car_exist_lp
		assert_equal [[1]], @db.check_car_exist_lp('lp')
	end

	def test_check_permit_exist
		assert_equal [[0]], @db.check_permit_exist()
	end

	def test_check_permit_exist_pn
		assert_equal [[0]], @db.check_permit_exist_pn('pn')
	end

	def test_check_exist_car_with_lp
		assert_equal [[1]], @db.check_exist_car_with_lp('lp')
	end

	def test_check_exist_car_with_lp_false
		assert_equal [[0]], @db.check_exist_car_with_lp('l')
	end

	def test_check_exist_car_with_model
		assert_equal [[0]], @db.check_exist_car_with_model('model')
	end

	def test_check_exist_permit_with_pn
		assert_equal [[0]], @db.check_exist_permit_with_pn('pn')
	end

	def test_check_exist_permit_with_id
		assert_equal [[0]], @db.check_exist_permit_with_id('id')
	end

	def test_check_exist_permit_with_lp
		assert_equal [[0]], @db.check_exist_permit_with_lp('lp')
	end

	def teardown
		@db.delete_car_info('lp')
	end
end

class Test_Select_Exists_permit < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_into_people('f','l','id','e','dn','ha','ca')
		@db.insert_into_car('lp', 'r', 'c', 'm')
		@db.insert_into_permit('i', 'l', 'p', 'y')
	end

	def test_check_ticket_exist
		assert_equal [[0]], @db.check_ticket_exist()	
	end

	def test_check_ticket_paid
		assert_equal [[0]], @db.check_ticket_paid('tn')
	end

	def test_check_exist_tic_with_lp
		assert_equal [[0]], @db.check_exist_tic_with_lp('lp')
	end

	def test_check_ticnum_exist
		assert_equal [[0]], @db.check_ticnum_exist('tn')
	end

	def test_check_ticket_exist_lp
		assert_equal [[0]], @db.check_ticket_exist_lp('lp')
	end

	def test_check_permit_exist
		assert_equal [[1]], @db.check_permit_exist()
	end

	def test_check_permit_exist_pn
		assert_equal [[1]], @db.check_permit_exist_pn('p')
	end

	def test_check_permit_exist_pn_false
		assert_equal [[1]], @db.check_permit_exist_pn('p')
	end

	def test_check_exist_car_with_model
		assert_equal [[1]], @db.check_exist_car_with_model('m')
	end

	def test_check_exist_permit_with_pn
		assert_equal [[0]], @db.check_exist_permit_with_pn('pn')
	end

	def test_check_exist_permit_with_id
		assert_equal [[1]], @db.check_exist_permit_with_id('i')
	end

	def test_check_exist_permit_with_lp
		assert_equal [[1]], @db.check_exist_permit_with_lp('l')
	end

	def teardown
		@db.delete_parking_permit('p')
		@db.delete_car_info('lp')
		@db.delete_person_info_main('id')
		@db.delete_person_info_side('id')
	end
end

class Test_Select_Exists_ticket < MiniTest::Unit::TestCase
	def setup
		@db = Database.new
		@db.insert_into_people('f','l','id','e','dn','ha','ca')
		@db.insert_into_car('lp', 'r', 'c', 'm')
		@db.insert_into_permit('i', 'l', 'p', 'y')
		@db.insert_ticket('lp', 'tn', 'pr', 'du', 'rea', 'from')
	end

	def test_check_ticket_exist
		assert_equal [[1]], @db.check_ticket_exist()	
	end

	def test_check_ticket_paid
		assert_equal [[0]], @db.check_ticket_paid('tn')
	end

	def test_check_ticnum_exist
		assert_equal [[1]], @db.check_ticnum_exist('tn')
	end

	def test_check_ticket_exist_lp
		assert_equal [[1]], @db.check_ticket_exist_lp('lp')
	end

	def test_check_ticnum_exist_false
		assert_equal [[0]], @db.check_ticnum_exist('t')
	end

	def test_check_ticket_exist_lp_false
		assert_equal [[0]], @db.check_ticket_exist_lp('l')
	end

	def teardown
		@db.delete_parking_permit('p')
		@db.delete_car_info('lp')
		@db.delete_person_info_main('id')
		@db.delete_person_info_side('id')
		@db.delete_ticket_info('tn')
	end
end
