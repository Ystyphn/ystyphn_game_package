@abstract
extends RefCounted
class_name State


var __name: String
var __root_object: Object
var __state_machine: StateMachine


## Called every transition to a new state. Interface method.
@abstract func enter(_params: TransitionParameter) -> void

## Called every transition from an old state. Interface method.
@abstract func exit() -> void

## This will be necessary to set run initializations
@abstract func initialize(_ro: Object)

## Corresponds to [method Node._physics_process] that'll be called every physics tick, 
## called eveytime by [method StateRunner._physics_process].
## Interface method.
@abstract func physics_update(_delta: float) -> void


## Corresponds to [method Node._process] that'll be called every frame ticks,
## called everytime by [method StateRunner._process].
## Interface method.
@abstract func process_update(_delta: float) -> void


## Corresponds to [method Node._unhandled_input]
func unhandled_input(_event: InputEvent) -> void:
	pass


func get_state_machine() -> StateMachine:
	return __state_machine


## Get name for a state instance.
func get_name() -> String:
	return __name


func get_root_object() -> Object:
	return __root_object


## Set name for a state instance.
func set_name(n: String) -> void:
	var n_list: PackedStringArray = n.to_lower().split(" ")
	if n == "":
		push_error("No name supplied")
		return
	if n_list.size() > 1:
		while n_list.has(""):
			n_list.erase("")
		__name = "_".join(n_list)
	else:
		__name = n_list[0]


func set_root_object(ro: Object) -> void:
	__root_object = ro


func set_state_machine(sm: StateMachine) -> void:
	__state_machine = sm
