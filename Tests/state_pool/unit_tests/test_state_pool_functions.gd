extends GutTest


var state_pool: StatePool


func after_each() -> void:
	state_pool = null


func before_each() -> void:
	state_pool = StatePool.new()


func test_initialize() -> void:
	var idle_state = double(State).new()
	var walk_state = double(State).new()
	var sm: StateMachine = FakeStateMachine.new()
	
	state_pool.add_state(idle_state)
	state_pool.add_state(walk_state)
	
	state_pool.initialize(sm)
	
	assert_called(idle_state.set_state_machine)
	assert_called(walk_state.set_state_machine)


func test_add_state() -> void:
	var idle_state = double(State).new()
	var walk_state = double(State).new()
	
	state_pool.add_state(idle_state)
	state_pool.add_state(walk_state)
	
	assert_eq(state_pool.__pool.size(), 2, "Testing add_state() of StatePool")


func test_get_state() -> void:
	var idle_state = double(State).new()
	
	stub(idle_state.get_name).to_return("idle")
	
	state_pool.add_state(idle_state)
	assert_eq(state_pool.get_state("idle"), idle_state as State, "Testing get_state() of StatePool")


func test_get_states() -> void:
	var idle_state = double(State).new()
	var walk_state = double(State).new()
	
	stub(idle_state.get_name).to_return("idle")
	stub(walk_state.get_name).to_return("walk")
	
	state_pool.add_state(idle_state)
	state_pool.add_state(walk_state)
	
	assert_eq(state_pool.get_states(), PackedStringArray(["idle", "walk"]), "Testing get_states() of StatePool")


func test_remove_state() -> void:
	var idle_state = double(State).new()
	var walk_state = double(State).new()
	
	stub(idle_state.get_name).to_return("idle")
	stub(walk_state.get_name).to_return("walk")
	
	state_pool.add_state(idle_state)
	state_pool.add_state(walk_state)
	
	state_pool.remove_state("walk")
	assert_eq(state_pool.get_states(), PackedStringArray(["idle"]), "Testing remove_state() of StatePool")
