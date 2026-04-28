extends GutTest


class FakeInputReceiver extends InputReceiver:
	pass


var controllable_state: FakeControllableState


func before_each() -> void:
	controllable_state = FakeControllableState.new()


func test_initialize_sets_root_object() -> void:
	var controllable_entity: ControllableEntity = double(ControllableEntity).new()
	var input_receivers: Array[InputReceiver] = [
		FakeInputReceiver.new(), 
		FakeInputReceiver.new()
	]
	stub(controllable_entity.get_input_receivers).to_return(input_receivers)

	controllable_state.initialize(controllable_entity)

	assert_eq(
		controllable_state.get_root_object(),
		controllable_entity,
		"Initialize should assign the provided entity as root object."
	)


func test_initialize_connects_handle_input_to_all_input_receivers() -> void:
	var controllable_entity: ControllableEntity = double(ControllableEntity).new()

	var input_receivers: Array[InputReceiver] = [
		partial_double(InputReceiver, DOUBLE_STRATEGY.INCLUDE_NATIVE).new(),
		partial_double(InputReceiver, DOUBLE_STRATEGY.INCLUDE_NATIVE).new()
	]

	stub(controllable_entity.get_input_receivers).to_return(input_receivers)

	controllable_state.initialize(controllable_entity)

	for receiver in input_receivers:
		assert_true(
			receiver.is_connected("input_processed", controllable_state.handle_input),
			"Each input receiver should connect input_processed to handle_input."
		)


func test_initialize_handles_empty_input_receivers_gracefully() -> void:
	var controllable_entity: ControllableEntity = double(ControllableEntity).new()
	var input_receivers: Array[InputReceiver] = []
	
	stub(controllable_entity.get_input_receivers).to_return(input_receivers)

	controllable_state.initialize(controllable_entity)
	
	assert_push_warning("No input receiver detected. ControllableState won't be performing any actions")
	assert_eq(
		controllable_state.get_root_object(),
		controllable_entity,
		"Initialize should still complete successfully even with no input receivers."
	)


func test_initialize_does_not_duplicate_connections_when_called_twice() -> void:
	var controllable_entity: ControllableEntity = double(ControllableEntity).new()

	var input_receiver: InputReceiver = partial_double(
		InputReceiver,
		DOUBLE_STRATEGY.INCLUDE_NATIVE
	).new()
	var input_receivers: Array[InputReceiver] = [input_receiver]

	stub(controllable_entity.get_input_receivers).to_return(input_receivers)

	controllable_state.initialize(controllable_entity)
	controllable_state.initialize(controllable_entity)
	
	assert_push_error("Specified controllable entity was already referenced!")
	assert_eq(
		input_receiver.get_signal_connection_list("input_processed").size(),
		1,
		"Initialize should not create duplicate signal connections if called twice."
	)
