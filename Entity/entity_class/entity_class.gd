@abstract
extends CharacterBody2D
class_name EntityClass

enum ENTITY_TYPES {NONE, BIONIC, NON_BIONIC}

@export var __entity_type: ENTITY_TYPES = ENTITY_TYPES.NONE
## This will be needed to set the state machine reference of this entity in the
## child classes.
@export var __state_machine_path: NodePath

var __entity_attributes: EntityAttributes
var __state_machine: StateMachine


func apply_damage(dmg: Damage) -> void:
	if __state_machine == null:
		push_error("State machine was not set!")
		return
	
	var raw_dmg: float = dmg.get_damage()
	var final_dmg: float = raw_dmg * (raw_dmg / (raw_dmg + __entity_attributes.get_bonus_defense()))
	var debuff: Debuff = dmg.get_debuff()
	
	final_dmg = round(final_dmg * 100.0) / 100.0
	
	__entity_attributes.set_health(__entity_attributes.get_health() - final_dmg)
	
	if debuff:
		__entity_attributes.add_debuff(debuff)
	
	__state_machine.transition_to("hurt")


func get_entity_attributes() -> EntityAttributes:
	return __entity_attributes


func get_entity_type() -> ENTITY_TYPES:
	return __entity_type


func get_state_machine() -> StateMachine:
	return __state_machine


func get_state_machine_path() -> NodePath:
	return __state_machine_path


func set_entity_attributes(pa: EntityAttributes) -> void:
	__entity_attributes = pa


func set_state_machine(sm: StateMachine) -> void:
	__state_machine = sm


func set_state_machine_path(smp: NodePath) -> void:
	__state_machine_path = smp
