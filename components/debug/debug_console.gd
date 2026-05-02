class_name DebugConsole extends CanvasLayer

@export var text_input : LineEdit
@export var output : RichTextLabel

var scene_list : ChapterList = ResourceLoader.load("res://components/debug/chapter_list.tres")


func _ready():
	text_input.text_submitted.connect(self._on_text_submitted)
	hide()

func _on_text_submitted(cmd):
	run_command(cmd)


func run_command(cmd: String) -> void:
	var expression = Expression.new()
	var parse_error = expression.parse(cmd)
	if parse_error != OK:
		# Code here to log and format the error to the dev console
		return
	
	var result = expression.execute([], self)
	if expression.has_execute_failed():
		output.text = "Command failed"
	else :
		output.text = "Command successful"

# Reload the current scene
func reload() -> void:
	get_tree().reload_current_scene()
	
func goto(chapter : int, scene : int):
	print_debug("Debug loading scene chapter ", chapter, " scene ", scene)
	if chapter < scene_list.chapters.size():
		var ch : Chapter =  scene_list.chapters[chapter]
		if scene < ch.ordered_scene_list.size():
			SceneManager.goto_scene(ch.ordered_scene_list[scene])
			
func toggle():
	if visible:
		hide()
	else :
		show()
		text_input.grab_focus()
