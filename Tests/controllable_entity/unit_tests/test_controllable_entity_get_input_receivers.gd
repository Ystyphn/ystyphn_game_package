extends GutTest


# =========================================================
# VALID BEHAVIOR TESTS
# =========================================================

func test_get_input_receivers_returns_all_input_receivers() -> void:
	var controllable_entity := FakeControllableEntity.new()
	var input_receivers := Node.new()

	var input_receiver_a = double(InputReceiver).new()
	var input_receiver_b = double(InputReceiver).new()

	input_receivers.add_child(input_receiver_a)
	input_receivers.add_child(input_receiver_b)

	controllable_entity.set("__input_receivers", input_receivers)

	var result: Array[InputReceiver] = controllable_entity.get_input_receivers()

	assert_eq(result.size(), 2)
	assert_eq(result[0], input_receiver_a)
	assert_eq(result[1], input_receiver_b)


func test_get_input_receivers_returns_empty_array_when_container_has_no_children() -> void:
	var controllable_entity := FakeControllableEntity.new()
	var input_receivers := Node.new()

	controllable_entity.set("__input_receivers", input_receivers)

	var result: Array[InputReceiver] = controllable_entity.get_input_receivers()

	assert_eq(result.size(), 0)


# =========================================================
# BREAK / FAILURE TESTS
# These expose weaknesses in the current implementation
# =========================================================

func test_get_input_receivers_breaks_when_input_receivers_is_null() -> void:
	var controllable_entity := FakeControllableEntity.new()
	
	assert_eq(controllable_entity.get_input_receivers(), [])
	assert_push_error("Input receivers was not set!")


func test_get_input_receivers_breaks_when_container_has_non_input_receiver_children() -> void:
	var controllable_entity := FakeControllableEntity.new()
	var input_receivers := Node.new()

	var invalid_child := Node.new()
	input_receivers.add_child(invalid_child)

	controllable_entity.set("__input_receivers", input_receivers)
	
	assert_eq(controllable_entity.get_input_receivers(), [])
	assert_push_error("Unexpected node type was found!")
