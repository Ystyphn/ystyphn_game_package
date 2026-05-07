extends GutTest


var globals: GlobalsAutoload


func before_each() -> void:
	globals = FakeGlobals.new()


func test_change_ui_can_call_the_transition_to_function_of_ui_manager() -> void:
	var ui_manager: UIManager = double(FakeUIManager).new()
	var transition: TransitionParameter = TransitionParameter.new()
	
	stub(ui_manager.transition_to).to_do_nothing()
	
	globals.set_ui_manager(ui_manager)
	globals.change_ui("shop_ui", transition)
	
	assert_called(ui_manager.transition_to.bind("shop_ui", transition))


func test_change_ui_will_ignore_and_push_error_if_called_while_the_ui_manager_was_not_set() -> void:
	var transition: TransitionParameter = TransitionParameter.new()
	
	globals.change_ui("shop_ui", transition)
	
	assert_push_error("Cannot change UI because there's no UI manager")


func test_change_ui_will_pass_null_transition_parameter_if_no_transition_was_supplied() -> void:
	var ui_manager: UIManager = double(FakeUIManager).new()
	
	stub(ui_manager.transition_to).to_do_nothing()
	
	globals.set_ui_manager(ui_manager)
	globals.change_ui("shop_ui")
	
	assert_called(ui_manager.transition_to.bind("shop_ui", null))
