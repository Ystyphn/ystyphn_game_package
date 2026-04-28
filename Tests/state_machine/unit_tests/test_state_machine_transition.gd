extends GutTest


var state_machine: FakeStateMachine


func after_each() -> void:
	state_machine = null


func before_each() -> void:
	state_machine = FakeStateMachine.new()


func test_can_transition_properly() -> void:
	var transition_parameter: TransitionParameter = TransitionParameter.new()
	var idle_state = double(State).new()
	var walk_state = double(State).new()
	var state_pool = double(StatePool).new()
	var state_runner = double(StateRunner).new()
	
	# Mocking functions
	stub(idle_state.get_name).to_return("idle")
	stub(walk_state.get_name).to_return("walk")
	stub(state_pool.get_state.bind("idle")).to_return(idle_state)
	stub(state_pool.get_state.bind("walk")).to_return(walk_state)
	
	# Set everything up
	state_machine.set_current_state(idle_state)
	state_machine.set_state_pool(state_pool)
	state_machine._set_state_runner(state_runner)
	
	# Check if everything needed to start things up state was set up
	assert_eq(state_machine.get_state_pool(), state_pool)
	assert_eq(state_machine.get_current_state(), "idle")
	assert_eq(state_machine.get_state_runner(), state_runner)
	
	state_machine.transition_to("walk", transition_parameter)
	
	# Main assertions
	assert_called(state_runner.stop_process)
	assert_called(state_runner.start_process)
	assert_called(walk_state.enter.bind(transition_parameter))
	assert_called(idle_state.exit)
	assert_eq(state_machine.get_current_state(), "walk")
