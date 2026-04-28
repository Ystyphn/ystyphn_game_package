extends GutTest


class FakeTickerAttributes extends TickerAttributes:
	func _tick(_delta: float) -> void:
		pass


var ticker_attributes: FakeTickerAttributes


func before_each():
	ticker_attributes = FakeTickerAttributes.new()


func test_setget_attributes_ref() -> void:
	var physical_attributes: PhysicalAttributes = double(PhysicalAttributes).new()
	
	ticker_attributes.set_attributes_ref(physical_attributes)
	
	assert_eq(ticker_attributes.get_attributes_ref(), physical_attributes, 
		"Ticker Attributes must already have reference to physical attributes")


func test_setget_entity_ref() -> void:
	var entity: EntityClass = double(EntityClass).new()
	
	ticker_attributes.set_entity_ref(entity)
	
	assert_eq(ticker_attributes.get_entity_ref(), entity, 
		"Ticker attributes must already have reference to entity")


func test_setget_lifetime() -> void:
	ticker_attributes.set_lifetime(10.0)
	
	assert_eq(ticker_attributes.get_lifetime(), 10.0, "Ticker attributes must now have lifetime")
