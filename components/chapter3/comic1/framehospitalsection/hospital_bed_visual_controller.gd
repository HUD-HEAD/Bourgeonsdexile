class_name HospitalBedVisualController
extends Node

@export var puzzle_piece_ref: Draggable
@export var drag_drop_puzzle_ref: DragDropPuzzle
@export var helper_sprite: Sprite2D

@export_group("visual parameters")
@export var max_scale: float = 1.1
@export var speed: float = 1
var alpha: float
var beat_animation: bool
var puzzle_completed: bool
var direction: int = 1

func _ready() -> void:
	#puzzle_piece_ref.mouse_entered.connect(_on_mouse_entered)
	#puzzle_piece_ref.mouse_exited.connect(_on_mouse_exited)
	puzzle_piece_ref.clicked.connect(_on_click)
	puzzle_piece_ref.dropped.connect(_on_drop)
	drag_drop_puzzle_ref.puzzle_complete.connect(_on_complete_puzzle)
	
	beat_animation = true
	helper_sprite.visible = false
	puzzle_completed = false

func _on_mouse_entered():
	pass

	
func _on_mouse_exited():
	pass


func _on_click():
	beat_animation = false
	helper_sprite.visible = true
	alpha = 0
	puzzle_piece_ref.scale = Vector2.ONE
	
func _on_drop():
	beat_animation = true
	alpha = 0
	helper_sprite.visible = false

func _on_complete_puzzle():
	puzzle_completed = true
	alpha = 0
	puzzle_piece_ref.scale = Vector2.ONE
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if beat_animation && !puzzle_completed:
		alpha += (delta * speed * direction)
		
		if alpha >= 1:
			direction = -1
			alpha = 1
		elif alpha <= 0:
			direction = 1
			alpha = 0
		
		puzzle_piece_ref.scale = Vector2.ONE * lerpf(1, max_scale, alpha)
	pass
