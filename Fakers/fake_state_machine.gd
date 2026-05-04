## This is a fake class
@tool
extends StateMachine
class_name FakeStateMachine


var state_pool_initialized: bool = false


func _initialize_state_pool(sp: StatePool):
	if sp != null and sp is StatePool:
		state_pool_initialized = true
