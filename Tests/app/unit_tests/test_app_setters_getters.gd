extends GutTest


var app: App


func before_each() -> void:
	app = FakeApp.new()
	

func test_app_can_be_created() -> void:
	assert_not_null(app)


func test_setget_main_stage() -> void:
	var main_stage: MainStage = MainStage.new()
	app.set_main_stage(main_stage)
	assert_eq(app.get_main_stage(), main_stage)


func test_setget_stage_ui_adapter() -> void:
	var stage_ui_adapter: StageUIAdapter = StageUIAdapter.new()
	app.set_stage_ui_adapter(stage_ui_adapter)
	assert_eq(app.get_stage_ui_adapter(), stage_ui_adapter)


func test_setget_ui_manager() -> void:
	var ui_manager: UIManager = FakeUIManager.new()
	app.set_ui_manager(ui_manager)
	assert_eq(app.get_ui_manager(), ui_manager)
