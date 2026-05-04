extends GutTest


var state_machine: StateMachine


func before_each() -> void:
	state_machine = FakeStateMachine.new()


func test_ready_can_create_root_reference() -> void:
	var player: PlayerCharacter = partial_double(PlayerCharacter).new()
	var root_path: NodePath = NodePath("../../MockPlayer")
	var state_runner: StateRunner = StateRunner.new()
	
	state_runner.set_name("StateRunner")
	
	stub(player._ready).to_do_nothing()
	
	state_machine.add_child(state_runner)
	state_machine.set_name("StateMachine")
	state_machine.set_root_path(root_path)
	
	player.set_name("MockPlayer")
	player.add_child(state_machine)
	
	add_child_autoqfree(player)
	
	assert_eq(state_machine.get_root_object(), player)


func test_ready_can_initialize_state_runner() -> void:
	var player: PlayerCharacter = partial_double(PlayerCharacter).new()
	var state_runner: StateRunner = StateRunner.new()
	var root_path: NodePath = NodePath("../../MockPlayer")
	
	stub(player._ready).to_do_nothing()
	
	state_runner.set_name("StateRunner")
	
	state_machine.add_child(state_runner)
	state_machine.set_name("StateMachine")
	state_machine.set_root_path(root_path)
	
	player.set_name("MockPlayer")
	player.add_child(state_machine)
	
	add_child_autoqfree(player)
	
	assert_eq(state_machine.get_state_runner(), state_runner)


func test_ready_can_initialize_state_pool() -> void:
	var player: PlayerCharacter = partial_double(PlayerCharacter).new()
	var state_runner: StateRunner = StateRunner.new()
	var root_path: NodePath = NodePath("../../MockPlayer")
	
	state_machine = state_machine as FakeStateMachine
	
	stub(player._ready).to_do_nothing()
	
	state_runner.set_name("StateRunner")
	
	state_machine.add_child(state_runner)
	state_machine.set_name("StateMachine")
	state_machine.set_root_path(root_path)
	
	player.set_name("MockPlayer")
	player.add_child(state_machine)
	
	add_child_autoqfree(player)
	
	assert_true(state_machine.state_pool_initialized, "This will be passed if the _initialize_state_pool() was called with StatePool variant")
