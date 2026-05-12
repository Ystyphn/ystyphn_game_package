@tool
extends Control
class_name CountingUI


@export var __icon: Texture2D = null:
	set(value):
		var texture_rect: TextureRect = get_node("HBoxContainer/TextureRect")
		__icon = value
		texture_rect.set_texture(__icon)

@export var __count: String = "":
	set(value):
		var label: Label = get_node("HBoxContainer/Label")
		__count = value
		label.set_text(__count)
