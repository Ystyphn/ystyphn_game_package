extends GutTest


var state_pool: StatePool


func before_each() -> void:
	state_pool = StatePool.new()


func test_setget_state_machine() -> void:
	var state_machine: FakeStateMachine = FakeStateMachine.new()
	state_pool.set_state_machine(state_machine)
	assert_eq(state_pool.get_state_machine(), state_machine)
