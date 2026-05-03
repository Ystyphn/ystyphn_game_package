extends GutTest


var ui_manager: FakeUIManager


func before_each() -> void:
	ui_manager = FakeUIManager.new()


func test_get_current_ui_name() -> void:
	var ui: UserInterface = double(FakeUserInterface).new()
	
	stub(ui.get_stringname).to_return("standard_ui")
	
	ui_manager.set_current_ui(ui)
	
	assert_eq(ui_manager.get_current_ui_name(), "standard_ui")


func test_has_ui() -> void:
	var ui_pool: UIPool = double(UIPool).new()
	var ui: UserInterface = FakeUserInterface.new()
	
	stub(ui_pool.has_ui).to_return(true)
	
	ui_manager.set_ui_pool(ui_pool)
	
	assert_true(ui_manager.has_ui(ui))


func test_has_ui_with_name() -> void:
	var ui_pool: UIPool = double(UIPool).new()
	
	stub(ui_pool.has_ui_with_name).to_return(true)
	
	ui_manager.set_ui_pool(ui_pool)
	
	assert_true(ui_manager.has_ui_with_name("standard_ui"))


func test_setget_current_ui() -> void:
	var ui: UserInterface = FakeUserInterface.new()
	ui_manager.set_current_ui(ui)
	assert_eq(ui_manager.get_current_ui(), ui)


func test_setget_initial_ui() -> void:
	ui_manager.set_initial_ui("standard_ui")
	assert_eq(ui_manager.get_initial_ui(), "standard_ui")


func test_setget_ui_pool() -> void:
	var ui_pool: UIPool = UIPool.new()
	ui_manager.set_ui_pool(ui_pool)
	assert_eq(ui_manager.get_ui_pool(), ui_pool)
