extends Node
class_name StateRunner


var __state_machine: StateMachine


func _physics_process(delta: float) -> void:
	if __state_machine == null:
		push_error("Can't run physics process. No state machine detected.")
		return
	if __state_machine.get_current_state_ref() != null:
		__state_machine.get_current_state_ref().physics_update(delta)


func _process(delta) -> void:
	if __state_machine == null:
		push_error("Can't run process. No state machine detected.")
		return
	if __state_machine.get_current_state_ref() != null:
		__state_machine.get_current_state_ref().process_update(delta)


func get_state_machine() -> StateMachine:
	return __state_machine


func set_state_machine(sm: StateMachine) -> void:
	__state_machine = sm


## @experimental
## Starts the _physics_process() and _process(). Used when transitioning between states.
func start_process() -> void:
	set_physics_process(true)
	set_process(true)


## @experimental
## Stops the _physics_process() and _process(). Used when transitioning between states.
func stop_process() -> void:
	set_physics_process(false)
	set_process(false)
