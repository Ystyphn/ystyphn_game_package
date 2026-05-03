extends GutTest


var hitbox_2d: HitBox2D


func before_each() -> void:
	hitbox_2d = HitBox2D.new()


func test_get_entity_groups() -> void:
	var entity: EntityClass = FakeEntity.new()
	
	entity.add_to_group("entity_1")
	entity.add_to_group("entity_2")
	
	hitbox_2d.set_entity_ref(entity)
	
	assert_eq(hitbox_2d.get_entity_groups(), [&"entity_1", &"entity_2"])


func test_setget_entity_ref() -> void:
	var entity: EntityClass = FakeEntity.new()
	
	hitbox_2d.set_entity_ref(entity)
	
	assert_eq(hitbox_2d.get_entity_ref(), entity)
