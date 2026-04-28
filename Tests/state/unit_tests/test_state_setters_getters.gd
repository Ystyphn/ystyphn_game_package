extends GutTest


var state: State


func after_each() -> void:
	state = null


func before_each() -> void:
	state = FakeState.new()


func test_setget_name() -> void:
	state.set_name("IDLe")
	assert_eq(state.get_name(), "idle")
	
	state.set_name("fLy_By")
	assert_eq(state.get_name(), "fly_by")
	
	state.set_name("walk  by")
	assert_eq(state.get_name(), "walk_by")
	
	state.set_name("walk       fly     by")
	assert_eq(state.get_name(), "walk_fly_by")
	
	state.set_name("")
	assert_push_error("No name supplied")


func test_setget_root_object() -> void:
	var obj: Object = Object.new()
	
	state.set_root_object(obj)
	
	assert_eq(state.get_root_object(), obj, "Testing setter and getter of __root_object")


func test_setget_state_machine() -> void:
	var sm: FakeStateMachine = FakeStateMachine.new()
	
	state.set_state_machine(sm)
	
	assert_eq(state.get_state_machine(), sm, "Testing setter and getter of __state_machine")
