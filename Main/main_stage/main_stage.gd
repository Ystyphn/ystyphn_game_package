@tool
extends Node2D
class_name MainStage


func _ready() -> void:
	update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	var has_area_stage: bool = false
	
	for child in get_children():
		if child is AreaStage2D:
			has_area_stage = true
			break
	
	if not has_area_stage:
		warnings.append("This main stage has no area stage to run. Please add an AreaStage2D variant for this to run")
	
	return warnings
