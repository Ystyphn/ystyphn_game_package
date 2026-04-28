extends GutTest


var entity_attributes: EntityAttributes


func before_each() -> void:
	entity_attributes = EntityAttributes.new()
	entity_attributes.set_ticker_ref(partial_double(ProcessTicker, DOUBLE_STRATEGY.INCLUDE_NATIVE).new())
	entity_attributes.set_entity(double(EntityClass).new())


func _test_remove_debuff_removes_debuff_from_array() -> void:
	var debuff: Debuff = double(Debuff).new()

	entity_attributes.add_debuff(debuff)

	entity_attributes.remove_debuff(debuff)

	assert_false(entity_attributes.get_debuffs().has(debuff))


func _test_remove_debuff_disconnects_tick_signal() -> void:
	var debuff: Debuff = double(Debuff).new()

	entity_attributes.add_debuff(debuff)

	entity_attributes.remove_debuff(debuff)

	assert_false(entity_attributes.get_ticker_ref().is_connected("tick_finished", debuff._tick), 
		"Passed if not connected")


func _test_remove_debuff_nonexistent_debuff_pushes_error() -> void:
	var debuff: Debuff = double(Debuff).new()

	entity_attributes.remove_debuff(debuff)

	assert_push_error("Specified debuff wasn't in the __debuffs array!")


func _test_remove_debuff_nonexistent_does_not_disconnect_signal() -> void:
	var debuff: Debuff = double(Debuff).new()

	entity_attributes.remove_debuff(debuff)
	
	assert_push_error("Specified debuff wasn't in the __debuffs array!")
	assert_not_called(entity_attributes.get_ticker_ref().disconnect.bind("tick_finished", debuff._tick))


func _test_remove_debuff_only_removes_target_debuff() -> void:
	var debuff_1: Debuff = double(Debuff).new()
	var debuff_2: Debuff = double(Debuff).new()

	entity_attributes.add_debuff(debuff_1)
	entity_attributes.add_debuff(debuff_2)

	entity_attributes.remove_debuff(debuff_1)

	assert_false(entity_attributes.get_debuffs().has(debuff_1))
	assert_true(entity_attributes.get_debuffs().has(debuff_2))


func _test_remove_debuff_twice_second_call_errors() -> void:
	var debuff: Debuff = double(Debuff).new()

	entity_attributes.add_debuff(debuff)

	entity_attributes.remove_debuff(debuff)
	entity_attributes.remove_debuff(debuff)

	assert_push_error("Specified debuff wasn't in the __debuffs array!")
