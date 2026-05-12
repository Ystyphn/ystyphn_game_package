extends GutTest


var ui_manager: UIManager


func before_each() -> void:
	ui_manager = FakeUIManager.new()


func test_transition_to_function_will_change_current_ui() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	var ui_pool: UIPool = double(UIPool).new()
	
	ui_manager.set_ui_pool(ui_pool)
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	stub(ui_pool.get_by_name.bind(&"shop_ui")).to_return(ui_2)
	
	ui_manager.set_current_ui(ui_1)
	assert_eq(ui_manager.get_current_ui(), ui_1)
	
	ui_manager.transition_to("shop_ui")
	assert_eq(ui_manager.get_current_ui(), ui_2)


func test_transition_to_can_change_into_new_ui_even_if_current_ui_is_null() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_pool: UIPool = double(UIPool).new()
	
	ui_manager.set_ui_pool(ui_pool)
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_pool.get_by_name.bind(&"standard_ui")).to_return(ui_1)
	
	ui_manager.transition_to("standard_ui")
	assert_eq(ui_manager.get_current_ui(), ui_1)


func test_transition_to_function_can_exit_and_enter_of_the_ui() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	var ui_pool: UIPool = double(UIPool).new()
	
	ui_manager.set_ui_pool(ui_pool)
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	stub(ui_1.enter).to_do_nothing()
	stub(ui_2.exit).to_do_nothing()
	stub(ui_pool.get_by_name.bind(&"shop_ui")).to_return(ui_2)
	
	ui_manager.set_current_ui(ui_1)
	assert_eq(ui_manager.get_current_ui(), ui_1)
	
	ui_manager.transition_to("shop_ui")
	assert_called(ui_1.exit)
	assert_called(ui_2.enter.bind(null))


func test_transition_to_will_push_error_if_no_ui_pool_was_supplied() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	
	ui_manager.set_current_ui(ui_1)
	ui_manager.transition_to("ship_ui")
	
	assert_push_error("UI pool was not set!")


func test_transition_to_function_will_push_error_if_the_a_ui_with_specified_stringname_does_not_exists() -> void:
	var ui_1: UserInterface = double(FakeUserInterface).new()
	var ui_2: UserInterface = double(FakeUserInterface).new()
	var ui_pool: UIPool = double(UIPool).new()
	
	ui_manager.set_ui_pool(ui_pool)
	
	stub(ui_1.get_stringname).to_return(&"standard_ui")
	stub(ui_2.get_stringname).to_return(&"shop_ui")
	stub(ui_pool.get_by_name.bind(&"shop_ui")).to_return(ui_2)
	
	ui_manager.set_current_ui(ui_1)
	assert_eq(ui_manager.get_current_ui(), ui_1)
	
	ui_manager.transition_to("ship_ui")
	assert_push_error("UI with the specified stringname wasn't found")
