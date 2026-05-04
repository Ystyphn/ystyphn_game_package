extends GutTest


var state_machine: StateMachine


func before_each() -> void:
	state_machine = FakeStateMachine.new()


func test_create_root_reference_can_create_root_reference_to_the_state_machine() -> void:
	var player: PlayerCharacter = partial_double(PlayerCharacter).new()
	var player_path: NodePath = NodePath("../../MockPlayer")
	
	stub(player._ready).to_do_nothing()
	
	state_machine.set_root_path(player_path)
	
	player.set_name("MockPlayer")
	player.set_state_machine(state_machine)
	player.add_child(state_machine)
	
	add_child_autoqfree(player)
	
	#state_machine._create_root_reference()
	assert_engine_error_count(1, "StateRunner was not set in this test")
	assert_eq(state_machine.get_root_object(), player)


func test_create_root_reference_will_push_error_if_the_root_path_is_empty() -> void:
	var player: PlayerCharacter = double(PlayerCharacter).new()
	
	stub(player.set_state_machine).to_do_nothing()
	
	player.set_state_machine(state_machine)
	
	state_machine._create_root_reference()
	
	assert_push_error("Root path was not set! Please set it up...")
	assert_null(state_machine.get_root_object())
	

func test_create_root_reference_will_push_error_if_the_root_path_cannot_be_found() -> void:
	var player: PlayerCharacter = double(PlayerCharacter).new()
	var player_path: NodePath = NodePath("../InvalidPlayer")
	
	state_machine.set_root_path(player_path)
	
	player.set_name("MockPlayer")
	player.set_state_machine(state_machine)
	
	state_machine._create_root_reference()
	
	assert_engine_error("Node not found")
	assert_null(state_machine.get_root_object())
