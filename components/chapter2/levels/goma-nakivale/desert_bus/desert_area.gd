class_name DesertArea
extends Area2D

@export var type: puzzle_type = puzzle_type.normal
@export var next_puzzle: PuzzleSpawner

enum puzzle_type{
	normal = 0,
	hole_area = 1,
	bodaboda_broke = 2,
}

func on_finish_puzzle():
	if type == puzzle_type.hole_area:
		InputManager.show_mouse()
		next_puzzle._on_spawner_clicked()
