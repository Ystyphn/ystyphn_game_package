extends GutTest


var user_interface: UserInterface


func before_each() -> void:
	user_interface = FakeUserInterface.new()


func test_user_interface_to_set_animation_player_when_animation_path_exists() -> void:
	var anim_path: NodePath = NodePath("AnimationPlayer")
	var animation_player: AnimationPlayer = AnimationPlayer.new()
	
	user_interface.set_animation_player_path(anim_path)
	animation_player.set_name("AnimationPlayer")
	
	user_interface.add_child(animation_player)
	user_interface._ready()
	
	assert_eq(user_interface.get_animation_player(), animation_player)
	
	
func test_user_interface_to_not_set_animation_player_when_animation_path_exists() -> void:
	var animation_player: AnimationPlayer = AnimationPlayer.new()
	
	user_interface.add_child(animation_player)
	
	user_interface._ready()
	
	assert_null(user_interface.get_animation_player())
