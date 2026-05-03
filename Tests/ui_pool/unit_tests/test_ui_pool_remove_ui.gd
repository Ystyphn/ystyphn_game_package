extends GutTest


var ui_pool: UIPool


func before_each() -> void:
	ui_pool = UIPool.new()


func test_remove_ui_can_indeed_remove_ui() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	
	assert_eq(ui_pool.get_by_name("standard_ui"), ui_1)
	assert_eq(ui_pool.get_by_name("shop_ui"), ui_2)
	
	ui_pool.remove_ui(ui_1)
	
	assert_false(ui_pool.has_ui_with_name("standard_ui"))
	assert_eq(ui_pool.__ui_array.size(), 1)
	
	ui_pool.remove_ui(ui_2)
	
	assert_false(ui_pool.has_ui_with_name("shop_ui"))
	assert_eq(ui_pool.__ui_array.size(), 0)
	
	
func test_remove_ui_with_stringname_can_indeed_remove_ui() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	var ui_3: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	stub(ui_3.get_stringname).to_return(&"ship_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	ui_pool.append_ui(ui_3)
	
	assert_eq(ui_pool.get_by_name("standard_ui"), ui_1)
	assert_eq(ui_pool.get_by_name("shop_ui"), ui_2)
	assert_eq(ui_pool.get_by_name("ship_ui"), ui_3)
	
	ui_pool.remove_ui_with_stringname("standard_ui")
	ui_pool.remove_ui_with_stringname("ship_ui")
	
	assert_false(ui_pool.has_ui_with_name("standard_ui"))
	assert_false(ui_pool.has_ui_with_name("ship_ui"))
	assert_eq(ui_pool.__ui_array.size(), 1)
	
