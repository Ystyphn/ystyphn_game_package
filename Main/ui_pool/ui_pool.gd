extends RefCounted
class_name UIPool


var __ui_array: Array[UserInterface]


## Appends [UserInterface] instance to [param __ui_array] if it is not yet added.
func append_ui(ui: UserInterface) -> void:
	# Error if the UI has no string name
	if ui.get_stringname() == "" or ui.get_stringname() == null:
		push_error("Specified UI has no stringname. Please add stringname to every UI you will add to the UI pool...")
		return
	# Error if the UI is being duplicated
	if __ui_array.has(ui):
		push_error("UI instance already exists in the UI array, ignoring this call...")
		return
	# Error if the UI's string name has a duplicate
	if has_ui_with_name(ui.get_stringname()):
		push_error("A user interface instance's stringname conflicts with another user interface instance with the same name. Ignoring this call...")
		return
	
	__ui_array.append(ui)


## Return a [UserInterface] instance if it exists in the [param __ui_array]
func get_by_name(_name: StringName) -> UserInterface:
	for ui in __ui_array:
		ui = ui as UserInterface
		if ui.get_stringname() == _name:
			return ui
	return null


func has_ui(ui: UserInterface) -> bool:
	return __ui_array.has(ui)


func has_ui_with_name(_name: StringName) -> bool:
	for ui in __ui_array:
		ui = ui as UserInterface
		if ui.get_stringname() == _name:
			return true
	return false
	
	
## Erase the specified [UserInterface] instance from the [param __ui_pool] only if it exsits. Otherwise, pass silently.
func remove_ui(ui: UserInterface) -> void:
	# Pass silently if the UI doesn't exists
	if not __ui_array.has(ui):
		return
	
	__ui_array.erase(ui)


## Erase the first instance of the specified [UserInterface] with specified [param _name] if it exists.
func remove_ui_with_stringname(_name: StringName) -> void:
	for ui in __ui_array:
		ui = ui as UserInterface
		if ui.get_stringname() == _name:
			__ui_array.erase(ui)
			
