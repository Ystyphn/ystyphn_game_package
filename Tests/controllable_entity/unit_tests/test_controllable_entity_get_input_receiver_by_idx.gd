extends GutTest



func test_get_input_receiver_by_idx_returns_child_at_index() -> void:
	var controllable_entity := FakeControllableEntity.new()
	var input_receivers := Node.new()

	var input_receiver_a = double(InputReceiver).new()
	var input_receiver_b = double(InputReceiver).new()

	input_receivers.add_child(input_receiver_a)
	input_receivers.add_child(input_receiver_b)

	# Inject private dependency for test setup
	controllable_entity.set("__input_receivers", input_receivers)

	var result = controllable_entity.get_input_receiver_by_idx(1)

	assert_eq(
		result,
		input_receiver_b,
		"Should return the input receiver at the requested index."
	)


func test_get_input_receiver_by_idx_returns_null_when_input_receivers_not_set() -> void:
	var controllable_entity := FakeControllableEntity.new()

	var result = controllable_entity.get_input_receiver_by_idx(0)
	
	assert_push_error("Input receivers not set!")
	assert_null(
		result,
		"Should return null when input receivers container is not set."
	)


func test_get_input_receiver_by_idx_returns_null_when_index_out_of_bounds() -> void:
	var controllable_entity := FakeControllableEntity.new()
	var input_receivers := Node.new()

	var input_receiver = double(InputReceiver).new()
	input_receivers.add_child(input_receiver)

	controllable_entity.set("__input_receivers", input_receivers)

	var result = controllable_entity.get_input_receiver_by_idx(99)
	
	assert_push_error("Supplied index out of bounds!")
	assert_null(
		result,
		"Should return null when requested index is outside child bounds."
	)
