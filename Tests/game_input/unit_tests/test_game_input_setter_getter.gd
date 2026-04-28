extends GutTest


var game_input: GameInput


func before_each() -> void:
	game_input = GameInput.new()


func test_setget_input_name() -> void:
	game_input.set_input_name("dash")
	assert_eq(game_input.get_input_name(), "dash")


func test_setget_input_type() -> void:
	game_input.set_input_type(GameInput.INPUT_TYPE.KEYBOARD_INPUT)
	assert_eq(game_input.get_input_type(), GameInput.INPUT_TYPE.KEYBOARD_INPUT)


func test_setget_input_value() -> void:
	game_input.set_input_value(1)
	assert_eq(game_input.get_input_value(), 1)
