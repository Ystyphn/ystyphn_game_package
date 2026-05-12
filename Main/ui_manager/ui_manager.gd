@tool
@abstract
extends Control
class_name UIManager

## The stringname of the UI that will be rendered by default
@export var __initial_ui: StringName

var __current_ui: UserInterface
var __ui_pool: UIPool


@abstract func _ready() -> void


func get_current_ui() -> UserInterface:
	return __current_ui


func get_current_ui_name() -> StringName:
	return __current_ui.get_stringname()


func get_initial_ui() -> StringName:
	return __initial_ui


func get_ui_pool() -> UIPool:
	return __ui_pool


func has_ui(ui: UserInterface) -> bool:
	return __ui_pool.has_ui(ui)


func has_ui_with_name(_name: StringName) -> bool:
	return __ui_pool.has_ui_with_name(_name)


func set_current_ui(ui: UserInterface) -> void:
	__current_ui = ui


func set_initial_ui(ui_name: StringName) -> void:
	__initial_ui = ui_name


func set_ui_pool(up: UIPool) -> void:
	__ui_pool = up


func transition_to(_ui_stringname: StringName, _param: TransitionParameter = null) -> void:
	if __ui_pool == null:
		push_error("UI pool was not set!")
		return
	
	if __ui_pool.get_by_name(_ui_stringname) == null:
		push_error("UI with the specified stringname wasn't found")
		return
	
	var new_ui: UserInterface = __ui_pool.get_by_name(_ui_stringname)
	
	# Current UI should remove itself from the scene tree upon exit() function was called
	if __current_ui != null:
		__current_ui.exit()
	__current_ui = new_ui
	add_child(__current_ui)
	__current_ui.enter(_param)
