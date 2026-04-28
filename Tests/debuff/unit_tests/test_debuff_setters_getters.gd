extends GutTest


class FakeDebuff extends Debuff:
	func _tick(_delta: float) -> void:
		pass


var debuff: Debuff


func before_each() -> void:
	debuff = FakeDebuff.new()


func test_setget_debuff_name() -> void:
	debuff.set_name("Poison I")
	
	assert_eq(debuff.get_name(), "Poison I")
