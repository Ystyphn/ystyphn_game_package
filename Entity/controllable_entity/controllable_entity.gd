@abstract
extends EntityClass
class_name ControllableEntity


@export var __input_receivers_path: NodePath

var __input_receivers: Node


func _ready() -> void:
	if __input_receivers_path.is_empty():
		push_error("Input receivers path was not set!")
		return
	
	__input_receivers = get_node(__input_receivers_path)
	
	for __input_receiver in get_input_receivers():
		__input_receiver.set_entity(self)
	
	if __state_machine_path.is_empty():
		push_error("State machine path was not set!")
		return
	
	var sm = get_node(__state_machine_path)
	if sm == null:
		push_error("Specified state machine path was not found!")
		return
	
	set_state_machine(sm)
	
	get_state_machine().set_root_object(self)


## Corresponds to the [method CharacterBody2D.set_velocity]. The ONLY purpose of this
## function is to only provide way for the unit test to spy. However, strictly use this instead of 
## [param set_velocity] directly just because that's the standard of my code.
func apply_velocity(vel: Vector2) -> void:
	set_velocity(vel)


func get_input_receivers() -> Array[InputReceiver]:
	var result: Array[InputReceiver] = []
	
	if __input_receivers == null:
		if __input_receivers_path.is_empty():
			push_error("Input receivers was not set!")
			return []
		else:
			if has_node(__input_receivers_path):
				__input_receivers = get_node(__input_receivers_path)
			else:
				push_error("Input receivers was not set!")
				return []
	
	for child in __input_receivers.get_children():
		if child is InputReceiver:
			result.append(child)
		else:
			push_error("Unexpected node type was found!")
			continue
	
	return result


func get_input_receiver_by_idx(idx: int) -> InputReceiver:
	if __input_receivers == null:
		push_error("Input receivers not set!")
		return null
	
	if idx > __input_receivers.get_child_count():
		push_error("Supplied index out of bounds!")
		return null
	
	return __input_receivers.get_children()[idx]


func get_input_receivers_path() -> NodePath:
	return __input_receivers_path


## Augments [method CharacterBody2D.move_and_slide] for unit testing
## and also for standard execution.
func move() -> void:
	move_and_slide()


func set_input_receivers_path(p: NodePath) -> void:
	__input_receivers_path = p
