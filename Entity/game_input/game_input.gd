extends RefCounted
class_name GameInput


enum INPUT_TYPE {
	HUD_INPUT,
	KEYBOARD_INPUT,
	MOUSE_INPUT,
	AI_INPUT
}

const CENTER: int = 0
const UP: int = 1
const RIGHT: int = 2
const DOWN: int = 4
const LEFT: int = 8

const UP_RIGHT: int = UP | RIGHT
const DOWN_RIGHT: int = DOWN | RIGHT
const DOWN_LEFT: int = DOWN | LEFT
const UP_LEFT: int = UP | LEFT


var __input_name: StringName
var __input_type: INPUT_TYPE
var __input_value: Variant


func get_input_name() -> StringName:
	return __input_name


func get_input_type() -> INPUT_TYPE:
	return __input_type


func get_input_value() -> Variant:
	return __input_value


func set_input_name(name: StringName) -> void:
	__input_name = name


func set_input_type(type: INPUT_TYPE) -> void:
	__input_type = type


func set_input_value(value: Variant) -> void:
	__input_value = value
