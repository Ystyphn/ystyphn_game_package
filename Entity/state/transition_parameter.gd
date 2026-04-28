extends RefCounted
class_name TransitionParameter


var named_params: Dictionary = {}
var params: Array = []


## Adds a key and value to [param named_params]
func add_named_param(key: StringName, value: Variant) -> void:
	if key in named_params.keys(): # Prevents redundant values
		return
	named_params[key] = value


## Adds a param to the [param params] array
func add_param(value: Variant) -> void:
	if value in params: # Prevents redundant values
		return
	params.append(value)


## Return the value the supplied key associates with
func get_named_param(key: StringName) -> Variant:
	if key in named_params.keys():
		return named_params[key]
	else:
		return null


## Returns the value in the specified index
func get_param_by_index(idx: int) -> Variant:
	# Filter out of bounds negative indices
	if idx < 0 and abs(idx) > params.size():
		push_error("Specified index is out of bounds!")
		return null
	
	# Filter out of bounds indices
	if idx > params.size() - 1:
		push_error("Specified index is out of bounds!")
		return null
	else:
		return params[idx]


## Checks if the specified key was in the [param named_params]
func has_named_param(key: StringName) -> bool:
	if key in named_params:
		return true
	else:
		return false


## Checks if the specified value is in the [param params]
func has_param(value: Variant) -> bool:
	if value in params:
		return true
	else:
		return false
