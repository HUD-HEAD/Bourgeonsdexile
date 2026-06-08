class_name Woman
extends Node2D

@export var char_area : Area2D
@export var anim_sprite: AnimatedSprite2D

@export var path_follow : PathFollow2D

@export var play_walking_sfx: bool = false

const WALK_SPEED = 75

var walking : bool

#TODO cleanup. Should we set a path on all scenes? 
var walk_along_path = false

func _ready() -> void:
	char_area.area_entered.connect(_on_area_entered)
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()
	
	if path_follow != null:
		walk_along_path = true


func _process(delta: float) -> void:
	if walking:
		if walk_along_path:
			path_follow.progress += WALK_SPEED*delta
		else:
			self.global_position.x += WALK_SPEED*delta


func switch_animation(anim_name : String):
	anim_sprite.animation = anim_name

func _on_area_entered(area : Area2D):
	_stop_walking()
	InputManager.show_mouse()

	
func _start_walking():
	walking = true
	anim_sprite.play("walking")
	if play_walking_sfx:
		AudioManager.play_walking_loop()

func _stop_walking():
	anim_sprite.play("idle")
	walking = false
	if play_walking_sfx:
		AudioManager.stop_walking_loop()
