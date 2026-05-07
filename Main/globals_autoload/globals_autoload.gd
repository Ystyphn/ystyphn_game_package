@abstract
extends Node
class_name GlobalsAutoload


var stage: MainStage
## @experimental
## I still don't know if stage UI adapter is necessary or not
var stage_ui_adapter: StageUIAdapter
var ui_manager: UIManager


## Changes UI
func change_ui(ui_name: StringName, param: TransitionParameter = null) -> void:
	if ui_manager == null:
		push_error("Cannot change UI because there's no UI manager")
		return
	ui_manager.transition_to(ui_name, param)


func get_stage() -> MainStage:
	return stage


## @experimental
func get_stage_ui_adapter() -> StageUIAdapter:
	return stage_ui_adapter


func get_ui_manager() -> UIManager:
	return ui_manager


func set_stage(s: MainStage) -> void:
	stage = s


## @experimental
func set_stage_ui_adapter(sua: StageUIAdapter) -> void:
	stage_ui_adapter = sua


func set_ui_manager(um: UIManager) -> void:
	ui_manager = um
