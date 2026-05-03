extends GutTest


var ui_pool: UIPool


func before_each() -> void:
	ui_pool = UIPool.new()


func test_has_ui_can_return_true_or_false() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	
	assert_true(ui_pool.has_ui(ui_1))
	assert_true(ui_pool.has_ui(ui_2))
	assert_false(ui_pool.has_ui(FakeUserInterface.new()))
	
	
func test_has_ui_with_stringname_can_return_true_or_false() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	
	assert_true(ui_pool.has_ui_with_name("standard_ui"))
	assert_true(ui_pool.has_ui_with_name("shop_ui"))
	assert_false(ui_pool.has_ui_with_name("ship_ui"))
