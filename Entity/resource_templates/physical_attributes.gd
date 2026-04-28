extends Resource
class_name PhysicalAttributes



@export var __agility: float = 1.0
@export var __dexterity: float = 1.0
@export var __endurance: float = 1.0
@export var __health: float = 1.0
@export var __intelligence: float = 1.0
@export var __max_health: float = 1.0 
@export var __max_stamina: float = 1.0
@export var __stamina: float = 1.0
@export var __strength: float = 1.0
@export var __weight: float = 1.0

var __max_rage: float = 100.0
var __rage: float = 0.0


func get_agility() -> float:
	return __agility


func get_dexterity() -> float:
	return __dexterity


func get_endurance() -> float:
	return __endurance


func get_health() -> float:
	return __health


func get_intelligence() -> float:
	return __intelligence


func get_max_health() -> float:
	return __max_health


func get_max_rage() -> float:
	return __max_rage


func get_max_stamina() -> float:
	return __max_stamina


func get_rage() -> float:
	return __rage


func get_stamina() -> float:
	return __stamina


func get_strength() -> float:
	return __strength


func get_weight() -> float:
	return __weight


func set_agility(a: float) -> void:
	__agility = max(a, 0.01)
	

func set_dexterity(d: float) -> void:
	__dexterity = max(d, 0.01)
	

func set_endurance(e: float) -> void:
	__endurance = max(e, 0.01)
	

func set_health(h: float) -> void:
	__health = max(h, 0.01)


func set_intelligence(i: float) -> void:
	__intelligence = max(i, 0.01)


func set_max_health(mh: float) -> void:
	__max_health = max(mh, 0.01)


func set_max_rage(mr: float) -> void:
	__max_rage = mr


func set_max_stamina(ms: float) -> void:
	__max_stamina = ms


func set_rage(r: float) -> void:
	__rage = r


func set_stamina(s: float) -> void:
	__stamina = max(s, 0.01)


func set_strength(s: float) -> void:
	__strength = max(s, 0.01)


func set_weight(w: float) -> void:
	__weight = max(w, 0.01)
