class_name NpcMovementController
extends VisibleOnScreenNotifier2D

@export var start_walking:bool = true
  
@export var char_area : Area2D
@export var puzzle: DragDropPuzzle
@export var anim_sprite: AnimatedSprite2D
@export var npc: Node2D

@export_group("movement_parameters")
@export var pre_puzzle_distance: float
@export var post_puzzle_distance: float
@export var movement_speed : float = 10

@export_group("scale_parameters")
@export var change_scale:bool = false
@export var idle_scale: float
@export var walking_scale: float
var next_distance: float

var is_moving: bool 

const idle_key: String = "idle"
const walking_key: String = "walking"

#only let the npc to stop once
var can_stop: bool

func _ready() -> void:
	is_moving = false
	can_stop = true
	if start_walking:
		npc.position.x += pre_puzzle_distance
	
	self.screen_entered.connect(_start_movement)
	char_area.area_entered.connect(_stop_movement)
	puzzle.puzzle_complete.connect(_continue_movement)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		npc.position.x += movement_speed * delta
		next_distance -= movement_speed * delta
		if next_distance <= 0:
			is_moving = false
			_stop_movement(null)

func _start_movement():
	if start_walking:
		anim_sprite.play(walking_key)
		is_moving = true
		next_distance = abs(pre_puzzle_distance)
		
		if change_scale:
			anim_sprite.scale = Vector2.ONE * walking_scale
	else:
		_stop_movement(null)

func _stop_movement(_area2d : Area2D):
	if can_stop:
		is_moving = false
		anim_sprite.play(idle_key)
		if change_scale:
			anim_sprite.scale = Vector2.ONE * idle_scale

func _continue_movement():
	anim_sprite.play(walking_key)
	is_moving = true
	can_stop = false
	next_distance = abs(post_puzzle_distance)
	
	if change_scale:
		anim_sprite.scale = Vector2.ONE * walking_scale
