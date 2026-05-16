
@abstract
extends State
class_name ControllableState 



@abstract func handle_input(gi: GameInput) -> void


func get_root_object() -> ControllableEntity:
	return __root_object as ControllableEntity
	
	
func initialize(ro: Object) -> void:
	if get_root_object() == ro:
		push_error("Specified controllable entity was already referenced!")
		print("-----------------------------------------------")
		print("Root object was: ", get_root_object())
		print("-----------------------------------------------\n")
		return
	
	set_root_object(ro)
	
	var root_object: ControllableEntity = __root_object as ControllableEntity
	var input_receivers: Array[InputReceiver] = root_object.get_input_receivers()
	
	# Connect input receiver's input_processed signal to handle input.
	if input_receivers.size() <= 0:
		push_warning("No input receiver detected. ControllableState won't be performing any actions")
	else:
		for receiver in input_receivers:
			receiver.connect("input_processed", handle_input)
	
