@tool
@abstract
extends Node
class_name StateMachine

@export var __initial_state: String
@export var __root_path: NodePath

var __current_state: State
var __previous_state: State
var __root_object: Object
var __state_pool: StatePool
var __state_runner: StateRunner


func _ready() -> void:
	update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	var has_state_runner: bool = false
	
	for child in get_children():
		if child is StateRunner:
			has_state_runner = true
			break
	
	if not has_state_runner:
		warnings.append("This state machine has no state runner. This will not run any states...")
	
	return warnings


func _notification(_what: int) -> void:
	if _what == NOTIFICATION_CHILD_ORDER_CHANGED:
		update_configuration_warnings()


## @experimental
## I don't know if it was necessary to remove states in game.
func _remove_state(_s_name: String) -> void:
	pass


func _set_previous_state(state: State) -> void:
	__previous_state = state


func _set_state_runner(s_runner: StateRunner) -> void:
	__state_runner = s_runner


## Returns the [b]name[/b] of the __current_state, [b]NOT[/b] the [State] object itself
func get_current_state() -> String:
	return __current_state.get_name()


## Returns the reference (a [State] object) of the current state.
func get_current_state_ref() -> State:
	return __current_state


func get_initial_state() -> String:
	return __initial_state


## Returns the [b]name[/b] of the __previous_state, [b]NOT[/b] the [State] object itself
func get_previous_state() -> String:
	if __previous_state == null:
		push_error("Error in ", self, " previous state doesn't exist!")
		assert(__previous_state != null, "__previous_state must not be null!")
	return __previous_state.get_name()


func get_root_path() -> NodePath:
	return __root_path


func get_root_object() -> Object:
	return __root_object


func get_state_pool() -> StatePool:
	return __state_pool


func get_state_runner() -> StateRunner:
	return __state_runner


func set_current_state(state: State) -> void:
	__current_state = state


func set_initial_state(s_name: String) -> void:
	__initial_state = s_name


func set_root_object(obj: Object) -> void:
	__root_object = obj


func set_root_path(path: NodePath) -> void:
	__root_path = path


func set_state_pool(sp: StatePool) -> void:
	__state_pool = sp


func transition_to(s_name: String, tp: TransitionParameter = null) -> void:
	__state_runner.stop_process()
	
	if __current_state:
		__current_state.exit()
	__previous_state = __current_state
	__current_state = __state_pool.get_state(s_name)
	__current_state.enter(tp)
	
	__state_runner.start_process()
