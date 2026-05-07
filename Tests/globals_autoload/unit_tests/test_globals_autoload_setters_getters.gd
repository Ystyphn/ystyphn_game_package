extends GutTest


var globals: GlobalsAutoload


func before_each() -> void:
	globals = FakeGlobals.new()


func test_setget_stage() -> void:
	var stage: MainStage = MainStage.new()
	globals.set_stage(stage)
	assert_eq(globals.get_stage(), stage)


func test_setget_stage_ui_adapter() -> void:
	var stage_ui_adapter: StageUIAdapter = StageUIAdapter.new()
	globals.set_stage_ui_adapter(stage_ui_adapter)
	assert_eq(globals.get_stage_ui_adapter(), stage_ui_adapter)


func test_setget_ui_manager() -> void:
	var ui_manager: UIManager = FakeUIManager.new()
	globals.set_ui_manager(ui_manager)
	assert_eq(globals.get_ui_manager(), ui_manager)
