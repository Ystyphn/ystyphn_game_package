extends RefCounted
class_name StatePool


var __pool: Array[State]
var __state_machine: StateMachine


func add_state(s: State) -> void:
	__pool.append(s)


## Returns first instance of the [State] from the __pool with the name [param s_name]
func get_state(s_name: String) -> State:
	for state in __pool:
		if state.get_name() == s_name:
			return state
	return null


func get_state_machine() -> StateMachine:
	return __state_machine


func get_states() -> PackedStringArray:
	var s_arr: PackedStringArray = []
	
	for state in __pool:
		s_arr.append(state.get_name())
	
	return s_arr


## Automatically called by [method StateMachine._ready]
func initialize(sm: StateMachine) -> void:
	for state in __pool:
		state.set_state_machine(sm)
		state.initialize(sm.get_root_object())


## Removes all instances of state with the name specified in [param s_name].
func remove_state(s_name: String) -> void:
	for state in __pool:
		if state.get_name() == s_name:
			__pool.erase(state)


func set_state_machine(sm: StateMachine) -> void:
	__state_machine = sm
