extends GutTest



func test_setget_base_speed() -> void:
	var entity_attributes = EntityAttributes.new()
	entity_attributes.set_base_speed(20.0)
	assert_eq(entity_attributes.get_base_speed(), 20.0)


func test_setget_entity() -> void:
	var entity: FakeEntity = FakeEntity.new()
	var entity_attributes = EntityAttributes.new()
	entity_attributes.set_entity(entity)
	assert_eq(entity_attributes.get_entity(), entity, "Testing setter and getter of __entity_ref")


func test_setget_max_rage() -> void:
	var entity_attributes = EntityAttributes.new()
	entity_attributes.set_max_rage(100.0)
	assert_eq(entity_attributes.get_max_rage(), 100.0, "Testing the setter and getter of max_rage")


func test_setget_rage() -> void:
	var entity_attributes = EntityAttributes.new()
	entity_attributes.set_rage(5.0)
	assert_eq(entity_attributes.get_rage(), 5.0, "Testing the setter and getter of rage")


func test_setget_ticker_ref() -> void:
	var ticker: ProcessTicker = double(ProcessTicker).new()
	var entity_attributes: = EntityAttributes.new()
	
	entity_attributes.set_ticker_ref(ticker)
	assert_eq(entity_attributes.get_ticker_ref(), ticker, "Testing the setter and getter of ticker")
