extends Area2D

@export var companions_to_stop : Array[Companion]
@export var people_waiting : Array[Woman]
@export var puzzle : DragDropPuzzle
@export var camera : Camera2D

@export var obstacle_leader : Area2D


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	obstacle_leader.area_entered.connect(_on_obstacle_leader_entered)
	
func _on_obstacle_leader_entered(_area2d : Area2D):
	for person : Woman in people_waiting:
		person.anim_sprite.flip_h = true
	
func _on_area_entered(_area2d : Area2D):
	for companion : Companion in companions_to_stop:
		companion.follow_model = false
		companion._stop_walking()

	camera.reparent(companions_to_stop[0], true)

func _on_puzzle_complete():
	for person : Woman in people_waiting:
		person._stop_walking()
	
	var rejoin_timeout : Signal
	for companion : Companion in companions_to_stop:
		rejoin_timeout = companion.rejoin_model()
	rejoin_timeout.connect(_on_rejoined)
	
func _on_rejoined():
	for companion : Companion in companions_to_stop:
		companion.follow_model = true
	
	var leader : Woman = companions_to_stop[0].model
	camera.reparent(leader, true)
	
	for person : Woman in people_waiting:
		person.anim_sprite.flip_h = false
		person._start_walking()
	
