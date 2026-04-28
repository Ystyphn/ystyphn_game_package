extends GutTest


class FakeEntity extends EntityClass:
	pass


func test_ready_sets_entity_ref_when_entity_path_is_valid() -> void:
	# Arrange
	var parent := Node.new()
	parent.set_name("Parent")
	add_child_autoqfree(parent)

	var entity := FakeEntity.new()
	entity.set_name("Entity")
	parent.add_child(entity)

	var hitbox_2d := HitBox2D.new()
	hitbox_2d.__entity_path = NodePath("../Entity")
	parent.add_child(hitbox_2d)

	# Assert
	assert_eq(
		hitbox_2d.__entity_ref,
		entity,
		"Expected __entity_ref to be assigned to node at __entity_path."
	)


func test_ready_pushes_error_and_does_not_set_entity_ref_when_entity_path_is_null() -> void:
	# Arrange
	var hitbox_2d := HitBox2D.new()
	add_child_autofree(hitbox_2d)

	# Assert
	assert_push_error("Entity path not set!")
	assert_null(
		hitbox_2d.__entity_ref,
		"Expected __entity_ref to remain null when __entity_path is null."
	)
