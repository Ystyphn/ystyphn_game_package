extends Area2D
class_name HitBox2D


@export var __entity_path: NodePath

var __entity_ref: EntityClass


func _ready() -> void:
	if __entity_path.is_empty():
		push_error("Entity path not set!")
		return
	__entity_ref = get_node(__entity_path)


func apply_damage(dmg: Damage) -> void:
	if __entity_ref == null:
		push_error("__entity_ref not set!")
		return
	__entity_ref.apply_damage(dmg)


func get_entity_groups() -> Array[StringName]:
	return __entity_ref.get_groups()


func get_entity_ref() -> EntityClass:
	return __entity_ref


func set_entity_ref(er: EntityClass) -> void:
	__entity_ref = er
