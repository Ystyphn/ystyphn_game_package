extends PhysicalAttributes
class_name EntityAttributes


const BASE_CRIT_CHANCE: float = 0.05
const BASE_DEFENSE: float = 10.0

var __base_speed: float = 25.0
var __buffs: Array[Buff]
var __debuffs: Array[Debuff]
var __entity_ref: EntityClass
## @experimental
## I still don't know if [ProcessTicker] was really needed by this class.
var __ticker_ref: ProcessTicker


func add_buff(b: Buff) -> void:
	if b in __buffs:
		push_error("Buff's already in array")
		return
	
	if __ticker_ref == null:
		push_error("Process Ticker isn't set!")
		return
		
	__ticker_ref.connect("tick_finished", b._tick)
	b.set_attributes_ref(self)
	
	b.set_entity_ref(__entity_ref)
	b.set_attributes_ref(self)
	
	__buffs.append(b)


func add_debuff(d: Debuff) -> void:
	if d in __debuffs:
		push_error("Debuff's already in array.")
		return
	
	if __ticker_ref == null:
		push_error("Process Ticker isn't set!")
		return
		
	__ticker_ref.connect("tick_finished", d._tick)
	
	d.set_entity_ref(__entity_ref)
	d.set_attributes_ref(self)
	
	__debuffs.append(d)


func get_base_speed() -> float:
	return __base_speed


func get_bonus_damage() -> float:
	var a: float = 0.5
	var b: float = 0.3
	var k: float = 0.03
	var bonus_dmg: float = (__strength * a + __dexterity * b)/(1 + k*(__strength + __dexterity))
	
	return bonus_dmg


func get_bonus_defense() -> float:
	var a: float = 0.03
	var b: float = 0.02
	var k: float = 0.5
	var bonus_def: float = 1 + a * __strength + b * __endurance
	var penalty: float = 1 - k * ((__max_health - __health)/__max_health)
	
	return BASE_DEFENSE * bonus_def * penalty


func get_buffs() -> Array[Buff]:
	return __buffs


func get_buff_by_idx(idx: int) -> Buff:
	return __buffs[idx]


func get_crouch_speed() -> float:
	var a = 0.3
	var health_penalty = (__health/__max_health)
	var weight_penalty = 1 + (__weight/(__strength + __agility))
	var penalty = 1 / weight_penalty * health_penalty
	
	return get_speed() * a * penalty


func get_critical_chance() -> float:
	var a: float = 0.05
	var b: float = 0.03
	var bonus: float = a*__dexterity + b*__intelligence
	var penalty: float = __health / __max_health

	return BASE_CRIT_CHANCE + bonus * penalty


func get_critical_multiplier() -> float:
	var a: float = 0.04
	var b: float = 0.05 
	var c: float = 0.03 
	var d: float = 0.02 
	var e: float = 0.01 
	return 1 + (a*__strength + b*__dexterity + c*__intelligence) + d*__rage + e*(__rage*__strength)


func get_debuffs() -> Array[Debuff]:
	return __debuffs


func get_debuff_by_idx(idx: int) -> Debuff:
	return __debuffs[idx]


func get_entity() -> EntityClass:
	return __entity_ref


func get_max_rage() -> float:
	return __max_rage


func get_rage() -> float:
	return __rage


func get_speed() -> float:
	var bonus: float = 1 + log(1 + __agility)
	var penalty: float = 1 + (__weight / (__strength + 1))
	
	return __base_speed * (bonus/penalty)


func get_sprint_speed() -> float:
	var k: float = 5.0
	var walk_speed: float = get_speed()
	var speed_boost: float = 1 + (log(1 + __agility) + 0.5 * log(1 + __strength))/k
	var penalty: float = 1 - ((__max_health - __health) / __max_health) * (1 / (1 + 0.5 * __endurance))
	
	return walk_speed + (walk_speed * (speed_boost - 1)) * penalty


func get_ticker_ref() -> ProcessTicker:
	return __ticker_ref


func remove_buff(buff: Buff) -> void:
	if buff not in __buffs:
		push_error("Specified buff wasn't in the __buffs array!")
		return
	
	__buffs.erase(buff)
	__ticker_ref.disconnect("tick_finished", buff._tick)


func remove_debuff(debuff: Debuff) -> void:
	if debuff not in __debuffs:
		push_error("Specified debuff wasn't in the __debuffs array!")
		return
	
	__debuffs.erase(debuff)
	__ticker_ref.disconnect("tick_finished", debuff._tick)


func set_base_speed(_speed: float) -> void:
	__base_speed = _speed


func set_entity(e: EntityClass) -> void:
	__entity_ref = e


func set_max_rage(mr: float) -> void:
	__max_rage = max(mr, 0.01)


func set_rage(r: float) -> void:
	__rage = max(r, 0.01)


func set_ticker_ref(t: ProcessTicker) -> void:
	__ticker_ref = t
