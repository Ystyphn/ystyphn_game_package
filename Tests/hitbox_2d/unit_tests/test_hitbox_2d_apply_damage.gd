extends GutTest

var hitbox_2d
var entity
var damage


func before_each() -> void:
	hitbox_2d = HitBox2D.new()

	# GUT doubles of real classes
	entity = double(EntityClass).new()
	damage = double(Damage).new()


func after_each() -> void:
	hitbox_2d = null
	entity = null
	damage = null


func test_apply_damage_forwards_damage_to_entity() -> void:
	# Arrange
	hitbox_2d.__entity_ref = entity

	# Stub + spy setup
	watch_signals(entity) # only if EntityClass emits signals (optional)

	# Act
	hitbox_2d.apply_damage(damage)

	# Assert
	assert_called(entity, "apply_damage")
	assert_called(entity.apply_damage.bind(damage))


func test_apply_damage_with_null_entity_does_not_call_apply_damage() -> void:
	# Arrange
	hitbox_2d.__entity_ref = null

	# Act
	hitbox_2d.apply_damage(damage)

	# Assert
	assert_push_error("__entity_ref not set!")
	assert_not_called(entity, "apply_damage")
