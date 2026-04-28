extends GutTest


var state_runner: StateRunner


func before_each() -> void:
	state_runner = StateRunner.new()


func test_physics_process_and_process_can_call_the_physics_update_and_process_update_of_current_state_of_state_machine() -> void:
	var state_machine: FakeStateMachine = FakeStateMachine.new()
	var state_1: FakeState = double(FakeState).new()
	var delta: float = 0.0017
	
	stub(state_1.get_name).to_return("idle")
	
	state_machine.__current_state = state_1
	
	state_runner.set_state_machine(state_machine)
	
	state_runner._physics_process(delta)
	state_runner._process(delta)
	
	assert_called(state_1.physics_update.bind(delta))
	assert_called(state_1.process_update.bind(delta))
