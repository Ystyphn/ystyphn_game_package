extends GutTest


class FakeDebuff extends Debuff:
	func _tick(_delta: float) -> void:
		pass


class FakeBuff extends Buff:
	func _tick(_delta: float) -> void:
		pass


var entity_attributes: EntityAttributes


func before_each() -> void:
	entity_attributes = EntityAttributes.new()
	entity_attributes.set_entity(double(EntityClass).new())
	entity_attributes.set_ticker_ref(partial_double(ProcessTicker, DOUBLE_STRATEGY.INCLUDE_NATIVE).new())


func test_add_debuff_can_add_debuff_properly() -> void:
	var debuff_1: Debuff = double(Debuff).new()
	var debuff_2: Debuff = double(Debuff).new()
	
	entity_attributes.add_debuff(debuff_1)
	entity_attributes.add_debuff(debuff_2)
	
	assert_eq(entity_attributes.__debuffs, [debuff_1, debuff_2], "Debuffs should have the two values")


func test_add_debuff_adds_reference_to_entity_and_entity_attributes() -> void:
	var entity: EntityClass = double(EntityClass).new()
	var debuff_1: Debuff = double(Debuff).new()
	var debuff_2: Debuff = double(Debuff).new()
	
	entity_attributes.set_entity(entity)
	
	entity_attributes.add_debuff(debuff_1)
	entity_attributes.add_debuff(debuff_2)
	
	assert_called(debuff_1.set_attributes_ref.bind(entity_attributes))
	assert_called(debuff_2.set_attributes_ref.bind(entity_attributes))
	
	assert_called(debuff_1.set_entity_ref.bind(entity))
	assert_called(debuff_2.set_entity_ref.bind(entity))


func test_add_debuff_connects_process_ticker_tick_function_to_the_debuffs() -> void:
	var process_ticker: ProcessTicker = partial_double(ProcessTicker, DOUBLE_STRATEGY.INCLUDE_NATIVE).new()
	var debuff_1: Debuff = double(Debuff).new()
	var debuff_2: Debuff = double(Debuff).new()
	
	entity_attributes.set_ticker_ref(process_ticker)
	assert_eq(entity_attributes.get_ticker_ref(), process_ticker, "Testing if the ticker was the same as expected.")
	
	entity_attributes.add_debuff(debuff_1)
	assert_true(process_ticker.is_connected("tick_finished", debuff_1._tick))
	
	entity_attributes.add_debuff(debuff_2)
	assert_true(process_ticker.is_connected("tick_finished", debuff_2._tick))


func test_add_buff_connects_process_ticker_tick_function_to_the_debuffs() -> void:
	var process_ticker: ProcessTicker = partial_double(ProcessTicker, DOUBLE_STRATEGY.INCLUDE_NATIVE).new()
	var buff_1: Buff = double(Buff).new()
	var	buff_2: Buff = double(Buff).new()
	
	entity_attributes.set_ticker_ref(process_ticker)
	
	entity_attributes.add_buff(buff_1)
	assert_true(process_ticker.is_connected("tick_finished", buff_1._tick))
	
	entity_attributes.add_buff(buff_2)
	assert_true(process_ticker.is_connected("tick_finished", buff_2._tick))


func test_get_debuff_by_idx_is_working_properly() -> void:
	var debuff_1: Debuff = FakeDebuff.new()
	var debuff_2: Debuff = FakeDebuff.new()
	
	entity_attributes.add_debuff(debuff_1)
	entity_attributes.add_debuff(debuff_2)
	
	assert_eq(entity_attributes.get_debuff_by_idx(0), debuff_1, "Debuff should be debuff_1")
	assert_eq(entity_attributes.get_debuff_by_idx(1), debuff_2, "Debuff should be debuff_2")


func test_debuff_should_not_have_multiple_existing_debuff_of_the_same_object():
	var debuff_1: Debuff = FakeDebuff.new()
	
	entity_attributes.add_debuff(debuff_1)
	entity_attributes.add_debuff(debuff_1)
	
	assert_eq(entity_attributes.get_debuffs(), [debuff_1], "Debuff must only be debuff_1")
	assert_push_error("Debuff's already in array")


func test_add_buff_can_add_buff_properly() -> void:
	var buff_1: Buff = FakeBuff.new()
	var buff_2: Buff = FakeBuff.new()
	
	entity_attributes.add_buff(buff_1)
	entity_attributes.add_buff(buff_2)
	
	assert_eq(entity_attributes.__buffs, [buff_1, buff_2], "Buffs should have the two values")


func test_add_buff_adds_reference_to_entity_and_entity_attributes() -> void:
	var entity: EntityClass = double(EntityClass).new()
	var buff_1: Buff = double(Buff).new()
	var buff_2: Buff = double(Buff).new()
	
	entity_attributes.set_entity(entity)
	
	entity_attributes.add_buff(buff_1)
	entity_attributes.add_buff(buff_2)
	
	assert_called(buff_1.set_attributes_ref.bind(entity_attributes))
	assert_called(buff_2.set_attributes_ref.bind(entity_attributes))
	
	assert_called(buff_1.set_entity_ref.bind(entity))
	assert_called(buff_2.set_entity_ref.bind(entity))


func test_get_buff_by_idx_is_working_properly() -> void:
	var buff_1: Buff = FakeBuff.new()
	var buff_2: Buff = FakeBuff.new()
	
	entity_attributes.add_buff(buff_1)
	entity_attributes.add_buff(buff_2)
	
	assert_eq(entity_attributes.get_buff_by_idx(0), buff_1, "Buff should be buff_1")
	assert_eq(entity_attributes.get_buff_by_idx(1), buff_2, "Buff should be buff_2")


func test_buff_should_not_have_multiple_existing_buff_of_the_same_object():
	var buff_1: Buff = FakeBuff.new()
	
	entity_attributes.add_buff(buff_1)
	entity_attributes.add_buff(buff_1)
	
	assert_eq(entity_attributes.get_buffs(), [buff_1], "Buff must only be buff_1")
	assert_push_error("Buff's already in array")
