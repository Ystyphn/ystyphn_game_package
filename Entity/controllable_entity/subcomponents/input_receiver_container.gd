@tool
extends Node
class_name InputReceiverContainer


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	
	var has_input_receiver: bool = false
	
	for child in get_children():
		if child is InputReceiver:
			has_input_receiver = true
			break
	
	if not has_input_receiver:
		warnings.append("No state input receiver added. Your controllable entity might not take any instructions.")
	
	return warnings


func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		update_configuration_warnings()
