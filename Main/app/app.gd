@abstract
extends Node2D
class_name App


var _main_stage: MainStage
var _stage_ui_adapter: StageUIAdapter
var _ui_manager: UIManager


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
