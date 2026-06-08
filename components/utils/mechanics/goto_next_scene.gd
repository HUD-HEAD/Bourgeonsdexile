extends VisibleOnScreenNotifier2D
@export_file("*.tscn") var next_scene : String

@onready var transition_scene: PackedScene = preload("res://scenes/menus/scene_transition.tscn")
var transition_scene_instance: SceneTransition


func _ready() -> void:
	screen_entered.connect(_on_screen_entered)

func _on_screen_entered():
	#Old implementation
	#SceneManager.goto_scene(next_scene)
	
	#With new implementation we pass the next scene to the transition_scene and will change scene after a delay
	transition_scene_instance = transition_scene.instantiate()
	transition_scene_instance.next_scene = next_scene
	
	GameManager.add_child(transition_scene_instance)
