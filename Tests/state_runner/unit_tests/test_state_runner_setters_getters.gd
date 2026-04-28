extends GutTest


var state_runner: StateRunner


func after_each() -> void:
	state_runner = null


func before_each() -> void:
	state_runner = StateRunner.new()


func test_setget_state_machine() -> void:
	var sm: StateMachine = FakeStateMachine.new()
	
	state_runner.set_state_machine(sm)
	
	assert_eq(state_runner.get_state_machine(), sm, "Test setter and getter of __state_machine")


func test_start_stop_process() -> void:
	add_child_autoqfree(state_runner)
	wait_process_frames(10, "Waiting for 10 process frames")
	
	state_runner.stop_process()
	assert_false(state_runner.is_physics_processing())
	assert_false(state_runner.is_processing())
	
	state_runner.start_process()
	assert_true(state_runner.is_physics_processing())
	assert_true(state_runner.is_processing())
