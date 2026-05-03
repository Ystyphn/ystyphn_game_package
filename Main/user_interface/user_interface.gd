@abstract
extends Control
class_name UserInterface


@export var __animation_player_path: NodePath

var __animation_player: AnimationPlayer
var __stringname: StringName


@abstract func enter(param: TransitionParameter) -> void
@abstract func exit() -> void


func _ready() -> void:
	# Skip if no animation path
	if __animation_player_path.is_empty():
		return
	
	set_animation_player(get_node(__animation_player_path))


func get_animation_player() -> AnimationPlayer:
	return __animation_player


func get_animation_player_path() -> NodePath:
	return __animation_player_path


func get_stringname() -> StringName:
	return __stringname


func set_animation_player(anim_player: AnimationPlayer) -> void:
	__animation_player = anim_player


func set_animation_player_path(anim_path: NodePath) -> void:
	__animation_player_path = anim_path


func set_stringname(s: StringName) -> void:
	__stringname = s
