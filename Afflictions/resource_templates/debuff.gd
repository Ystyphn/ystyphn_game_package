@abstract
extends TickerAttributes
class_name Debuff


@export var __debuff_name: String


func get_debuff_name() -> String:
	return __debuff_name


func set_debuff_name(name: String) -> void:
	__debuff_name = name
