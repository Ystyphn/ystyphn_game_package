extends GutTest


var user_interface: UserInterface


func before_each() -> void:
	user_interface = FakeUserInterface.new()


func test_setget_stringname() -> void:
	user_interface.set_stringname("standard_ui")
	assert_eq(user_interface.get_stringname(), "standard_ui")


func test_setget_animation_player() -> void:
	var animation_player: AnimationPlayer = AnimationPlayer.new()
	user_interface.set_animation_player(animation_player)
	assert_eq(user_interface.get_animation_player(), animation_player)


func test_setget_animation_player_path() -> void:
	var anim_path: NodePath = NodePath("AnimationPlayer")
	user_interface.set_animation_player_path(anim_path)
	assert_eq(user_interface.get_animation_player_path(), anim_path)
