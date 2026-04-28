@abstract
extends TickerAttributes
class_name Buff


@export var __buff_name: String


func get_buff_name() -> String:
	return __buff_name


func set_buff_name(name: String) -> void:
	__buff_name = name
