extends GutTest


var state_machine: FakeStateMachine


func after_each():
	state_machine = null


func before_each():
	state_machine = FakeStateMachine.new()


func test_setget_previous_state() -> void:
	var state: State = double(State).new()
	stub(state.get_name).to_return("idle")
	
	state_machine._set_previous_state(state)
	
	assert_eq(state_machine.get_previous_state(), 
			"idle", "Testing previous state setter and getter")


func test_setget_state_pool() -> void:
	var state_pool: StatePool = StatePool.new()
	
	state_machine.set_state_pool(state_pool)
	
	assert_eq(state_machine.get_state_pool(), state_pool, "Testing setter and getter of __state_pool")


func test_setget_state_runner() -> void:
	var state_runner: StateRunner = StateRunner.new()
	
	state_machine._set_state_runner(state_runner)
	
	assert_eq(state_machine.get_state_runner(), state_runner, "Testing setget for __state_runner")


func test_setget_current_state() -> void:
	var state: State = double(State).new()
	stub(state.get_name).to_return("idle")
	
	state_machine.set_current_state(state)
	
	assert_eq(state_machine.get_current_state(), &"idle", "Test setter and getter of __current_state")


func test_setget_current_state_to_return_empty_string_if_no_current_state_yet() -> void:
	assert_eq(state_machine.get_current_state(), &"")


func test_setget_root_object() -> void:
	var obj: Object = Object.new()
	
	state_machine.set_root_object(obj)
	
	assert_eq(state_machine.get_root_object(), obj, "Test setter and getter of __root_object")


func test_setget_root_path() -> void:
	var path: NodePath = NodePath("MockPlayer")
	state_machine.set_root_path(path)
	assert_eq(state_machine.get_root_path(), path)
	assert_eq(state_machine.__root_path, path)
