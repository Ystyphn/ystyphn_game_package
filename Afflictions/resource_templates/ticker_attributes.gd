@abstract
extends PhysicalAttributes
class_name TickerAttributes


var __attributes_ref: PhysicalAttributes
var __entity_ref: EntityClass
var __lifetime: float


@abstract func _tick(_delta: float) -> void


## @experimental
## I don't think this was still necessary since I can just directly execute expiration process within _tick function
func expire() -> void:
	pass


func get_attributes_ref() -> PhysicalAttributes:
	return __attributes_ref


func get_entity_ref() -> EntityClass:
	return __entity_ref


func get_lifetime() -> float:
	return __lifetime


func set_attributes_ref(ar: PhysicalAttributes) -> void:
	__attributes_ref = ar


func set_entity_ref(er: EntityClass) -> void:
	__entity_ref = er


func set_lifetime(time: float) -> void:
	__lifetime = time
 
