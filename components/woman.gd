extends Node2D

@export var char_area : Area2D
@export var anim_sprite: AnimatedSprite2D

const WALK_SPEED = 75

var walking : bool

func _ready() -> void:
	char_area.area_entered.connect(_on_area_entered)
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()
	
func _process(delta: float) -> void:
	if walking:
		self.global_position.x += WALK_SPEED*delta
	
func _on_area_entered(area : Area2D):
	_stop_walking()
	
	
func _start_walking():
	walking = true
	anim_sprite.play("walking")

func _stop_walking():
	anim_sprite.play("idle")
	walking = false
	
