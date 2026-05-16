extends GutTest


var state_pool: StatePool


func before_each() -> void:
	state_pool = StatePool.new()


func test_initialize_can_set_state_machine_to_every_states() -> void:
	var state_1: FakeState = double(FakeState).new()
	var state_2: FakeState = double(FakeState).new()
	var state_3: FakeState = double(FakeState).new()
	var state_machine: FakeStateMachine = double(FakeStateMachine).new()
	
	# Stub set state machine
	stub(state_1.set_state_machine).to_do_nothing()
	stub(state_2.set_state_machine).to_do_nothing()
	stub(state_3.set_state_machine).to_do_nothing()
	
	# Add states
	state_pool.add_state(state_1)
	state_pool.add_state(state_2)
	state_pool.add_state(state_3)
	
	state_pool.initialize(state_machine)
	
	assert_called(state_1.set_state_machine.bind(state_machine))
	assert_called(state_2.set_state_machine.bind(state_machine))
	assert_called(state_3.set_state_machine.bind(state_machine))
	

func test_initialize_can_set_entity_reference_to_states() -> void:
	var state_1: FakeControllableState = double(FakeControllableState).new()
	var state_2: FakeControllableState = double(FakeControllableState).new()
	var state_3:  FakePlayerState = double(FakePlayerState).new()
	var state_machine: FakeStateMachine = double(FakeStateMachine).new()
	var entity: FakeControllableEntity = double(FakeControllableEntity).new()
	
	stub(state_machine.get_root_object).to_return(entity)
	
	# Stub set state machine
	stub(state_1.set_state_machine).to_do_nothing()
	stub(state_2.set_state_machine).to_do_nothing()
	stub(state_3.set_state_machine).to_do_nothing()
	
	# Stub set root object
	stub(state_1.set_root_object).to_do_nothing()
	stub(state_2.set_root_object).to_do_nothing()
	stub(state_3.set_root_object).to_do_nothing()
	
	# Add states
	state_pool.add_state(state_1)
	state_pool.add_state(state_2)
	state_pool.add_state(state_3)
	
	state_pool.initialize(state_machine)
	
	# Check if state machine was set
	assert_called(state_1.set_state_machine.bind(state_machine))
	assert_called(state_2.set_state_machine.bind(state_machine))
	assert_called(state_3.set_state_machine.bind(state_machine))
	
	# Check if entity reference was set
	assert_called(state_1.initialize.bind(entity))
	assert_called(state_2.initialize.bind(entity))
	assert_called(state_3.initialize.bind(entity))


# Extensions ---------------------------------------------------------------
func test_initialize_does_not_call_initialize_on_non_controllable_states() -> void:
#	var state_1: FakeState = double(FakeState).new()
#	var state_machine: FakeStateMachine = double(FakeStateMachine).new()
#	var entity: FakeControllableEntity = double(FakeControllableEntity).new()
	
#	stub(state_machine.get_root_object).to_return(entity)
	
#	stub(state_1.set_state_machine).to_do_nothing()
	
	# Spy initialize
#	stub(state_1.initialize).to_do_nothing()

#	state_pool.add_state(state_1)
	
#	state_pool.initialize(state_machine)
	
#	assert_called(state_1.set_state_machine.bind(state_machine))
	
#	assert_not_called(state_1.initialize)
	pass_test("Irrelevant test. State Pool should be able to call initialize() functions to every states")


func test_initialize_calls_get_root_object_only_when_needed() -> void:
	var state_1: FakeState = double(FakeState).new()
	var state_2: FakeControllableState = double(FakeControllableState).new()
	var state_machine: FakeStateMachine = double(FakeStateMachine).new()
	var entity: FakeControllableEntity = double(FakeControllableEntity).new()
	
	stub(state_machine.get_root_object).to_return(entity)
	
	stub(state_1.set_state_machine).to_do_nothing()
	stub(state_2.set_state_machine).to_do_nothing()
	stub(state_2.initialize).to_do_nothing()
	
	state_pool.add_state(state_1)
	state_pool.add_state(state_2)
	
	state_pool.initialize(state_machine)
	
	assert_called(state_machine.get_root_object)
	assert_called(state_2.initialize.bind(entity))


func test_initialize_propagates_same_state_machine_instance() -> void:
	var state_1: FakeState = double(FakeState).new()
	var state_2: FakeState = double(FakeState).new()
	var state_machine: FakeStateMachine = double(FakeStateMachine).new()
	
	stub(state_1.set_state_machine).to_do_nothing()
	stub(state_2.set_state_machine).to_do_nothing()
	
	state_pool.add_state(state_1)
	state_pool.add_state(state_2)
	
	state_pool.initialize(state_machine)
	
	assert_called(state_1.set_state_machine.bind(state_machine))
	assert_called(state_2.set_state_machine.bind(state_machine))


func test_initialize_multiple_controllable_states_receive_same_entity_instance() -> void:
	var state_1: FakeControllableState = double(FakeControllableState).new()
	var state_2: FakeControllableState = double(FakeControllableState).new()
	var state_machine: FakeStateMachine = double(FakeStateMachine).new()
	var entity: FakeControllableEntity = double(FakeControllableEntity).new()
	
	stub(state_machine.get_root_object).to_return(entity)
	
	stub(state_1.set_state_machine).to_do_nothing()
	stub(state_2.set_state_machine).to_do_nothing()
	stub(state_1.initialize).to_do_nothing()
	stub(state_2.initialize).to_do_nothing()
	
	state_pool.add_state(state_1)
	state_pool.add_state(state_2)
	
	state_pool.initialize(state_machine)
	
	assert_called(state_1.initialize.bind(entity))
	assert_called(state_2.initialize.bind(entity))
