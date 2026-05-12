@tool
@abstract
extends Node2D
class_name App


var _main_stage: MainStage
var _stage_ui_adapter: StageUIAdapter
var _ui_manager: UIManager


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	var has_ui_layer: bool = false
	var has_stage_layer: bool = false
	
	for child in get_children():
		# Prematurely exit if this node already have both stage and UI layer
		if has_ui_layer and has_stage_layer:
			break
		
		if child is UILayer:
			has_ui_layer = true
		if child is StageLayer:
			has_stage_layer = true
	
	if not has_ui_layer:
		warnings.append("This node has no UI layer. Can't render User Interface.")
	if not has_stage_layer:
		warnings.append("This node has no Stage layer. Can't play anything if no Stage layer")
	
	return warnings


func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		update_configuration_warnings()


func get_main_stage() -> MainStage:
	return _main_stage


func get_stage_ui_adapter() -> StageUIAdapter:
	return _stage_ui_adapter


func get_ui_manager() -> UIManager:
	return _ui_manager


func set_main_stage(ms: MainStage) -> void:
	_main_stage = ms


func set_stage_ui_adapter(sua: StageUIAdapter) -> void:
	_stage_ui_adapter = sua


func set_ui_manager(um: UIManager) -> void:
	_ui_manager = um
