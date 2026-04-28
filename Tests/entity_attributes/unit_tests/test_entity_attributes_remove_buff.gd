extends GutTest


var entity_attributes: EntityAttributes


func before_each() -> void:
	entity_attributes = EntityAttributes.new()
	entity_attributes.set_ticker_ref(partial_double(ProcessTicker, DOUBLE_STRATEGY.INCLUDE_NATIVE).new())
	entity_attributes.set_entity(double(EntityClass).new())


func test_remove_buff_removes_buff_from_array() -> void:
	var buff: Buff = double(Buff).new()

	entity_attributes.add_buff(buff)

	entity_attributes.remove_buff(buff)

	assert_false(entity_attributes.get_buffs().has(buff))


func test_remove_buff_disconnects_tick_signal() -> void:
	var buff: Buff = double(Buff).new()

	entity_attributes.add_buff(buff)

	entity_attributes.remove_buff(buff)

	assert_false(entity_attributes.get_ticker_ref().is_connected("tick_finished", buff._tick), 
		"Passed if not connected")


func test_remove_buff_nonexistent_buff_pushes_error() -> void:
	var buff: Buff = double(Buff).new()

	entity_attributes.remove_buff(buff)

	assert_push_error("Specified buff wasn't in the __buffs array!")


func test_remove_buff_nonexistent_does_not_disconnect_signal() -> void:
	var buff: Buff = double(Buff).new()

	entity_attributes.remove_buff(buff)
	
	assert_push_error("Specified buff wasn't in the __buffs array!")
	assert_not_called(entity_attributes.get_ticker_ref().disconnect.bind("tick_finished", buff._tick))


func test_remove_buff_only_removes_target_buff() -> void:
	var buff_1: Buff = double(Buff).new()
	var buff_2: Buff = double(Buff).new()

	entity_attributes.add_buff(buff_1)
	entity_attributes.add_buff(buff_2)

	entity_attributes.remove_buff(buff_1)

	assert_false(entity_attributes.get_buffs().has(buff_1))
	assert_true(entity_attributes.get_buffs().has(buff_2))


func test_remove_buff_twice_second_call_errors() -> void:
	var buff: Buff = double(Buff).new()

	entity_attributes.add_buff(buff)

	entity_attributes.remove_buff(buff)
	entity_attributes.remove_buff(buff)

	assert_push_error("Specified buff wasn't in the __buffs array!")
