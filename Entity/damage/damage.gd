extends Object
class_name Damage


var __damage: float = 0.0
var __debuff: Debuff


func get_damage() -> float:
	return __damage


func get_debuff() -> Debuff:
	return null


func set_damage(d: float) -> void:
	__damage = d


func set_debuff(d: Debuff) -> void:
	__debuff = d
