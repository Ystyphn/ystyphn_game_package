extends GutTest


var ui_pool: UIPool


func before_each() -> void:
	ui_pool = UIPool.new()


func test_get_by_name() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	
	assert_eq(ui_pool.get_by_name("standard_ui"), ui_1)
	assert_eq(ui_pool.get_by_name("shop_ui"), ui_2)
	assert_null(ui_pool.get_by_name("ship_ui"))
	
	
