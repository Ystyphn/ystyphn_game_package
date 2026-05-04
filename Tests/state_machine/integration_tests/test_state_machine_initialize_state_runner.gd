extends GutTest


var state_machine: StateMachine


func before_each() -> void:
	state_machine = FakeStateMachine.new()


func test_return_error_if_state_machine_has_no_state_runner_child() -> void:
	state_machine._initialize_state_runner()
	
	assert_engine_error('Node not found: "StateRunner"')


func test_can_set_state_runner_if_state_machine_has_state_runner_child() -> void:
	var state_runner: StateRunner = partial_double(StateRunner).new()
	
	state_runner.set_name("StateRunner")
	
	state_machine.add_child(state_runner)
	
	state_machine._initialize_state_runner()
	
	assert_eq(state_machine.get_state_runner(), state_runner)


func test_initialize_state_runner_will_set_state_machine_reference_to_the_state_runner() -> void:
	var state_runner: StateRunner = partial_double(StateRunner).new()
	
	stub(state_runner.set_state_machine).to_do_nothing()
	
	state_runner.set_name("StateRunner")
	
	state_machine.add_child(state_runner)
	
	state_machine._initialize_state_runner()
	
	assert_called(state_runner.set_state_machine.bind(state_machine))
