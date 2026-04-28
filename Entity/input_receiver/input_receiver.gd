@abstract
extends Node
class_name InputReceiver


@warning_ignore("unused_signal") # I know what I'm doing!
signal input_processed(input: GameInput)



@export var __monitoring: bool

var __entity: ControllableEntity


func get_entity() -> ControllableEntity:
	return __entity


func is_monitoring() -> bool:
	return __monitoring


func set_entity(e: ControllableEntity) -> void:
	__entity = e


func set_monitoring(switch: bool) -> void:
	__monitoring = switch
