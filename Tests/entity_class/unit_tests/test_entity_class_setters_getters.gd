extends GutTest


class FakeEntity extends EntityClass:
	pass


var entity: FakeEntity


func after_each() -> void:
	entity = null


func before_each() -> void:
	entity = FakeEntity.new()


func test_setget_entity_attributes() -> void:
	var object_param = double(EntityAttributes).new()
	
	entity.set_entity_attributes(object_param)
	
	assert_eq(
		entity.get_entity_attributes(),
		object_param,
		"Testing the setter and getter of entity_attributes"
	)


func test_setget_state_machine() -> void:
	var object_param = double(StateMachine).new()
	
	entity.set_state_machine(object_param)
	
	assert_eq(
		entity.get_state_machine(),
		object_param,
		"Testing the setter and getter of state_machine"
	)
