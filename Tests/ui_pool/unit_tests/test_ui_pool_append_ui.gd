extends GutTest


var ui_pool: UIPool


func before_each() -> void:
	ui_pool = UIPool.new()


func test_append_ui() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	
	assert_eq(ui_pool.__ui_array.size(), 2)
	assert_true(ui_pool.__ui_array.has(ui_1))
	assert_true(ui_pool.__ui_array.has(ui_2))
	


func test_append_ui_will_not_append_new_ui_if_it_already_exists() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	
	assert_push_error("UI instance already exists in the UI array, ignoring this call...")
	assert_eq(ui_pool.__ui_array.size(), 2)
	assert_true(ui_pool.__ui_array.has(ui_1))
	assert_true(ui_pool.__ui_array.has(ui_2))
	
	
func test_append_ui_to_not_append_ui_with_if_theres_another_ui_with_the_same_stringname() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	var ui_3: UserInterface = double(FakeUserInterface).new()
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"standard_ui")
	stub(ui_3.get_stringname).to_return(&"ship_ui")
	
	ui_pool.append_ui(ui_1)
	ui_pool.append_ui(ui_2)
	ui_pool.append_ui(ui_3)
	
	assert_push_error("A user interface instance's stringname conflicts with another user interface instance with the same name. Ignoring this call...")
	assert_eq(ui_pool.__ui_array.size(), 2)
	
	
func test_append_function_will_not_append_a_ui_with_no_stringname() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	
	ui_pool.append_ui(ui_1)
	
	assert_push_error("Specified UI has no stringname. Please add stringname to every UI you will add to the UI pool...")
	assert_eq(ui_pool.__ui_array.size(), 0)
