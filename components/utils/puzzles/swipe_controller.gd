class_name SwipeController
extends VisibleOnScreenNotifier2D

@export var viewport: SubViewport
var mask: ViewportTexture

@export var transition_delay : float = 3.0

@export_group("Config")
@export var completation_percentage: float = 0.85
@export var sample_step: int = 20

@export var hide_blur_image: bool = false
@export var blur_image: Sprite2D


@export var checking_time: float = 0.5
var timer: float = 0
var is_enabled:bool = false

func _ready() -> void:
	mask = viewport.get_texture()
	self.screen_entered.connect(on_screen_enter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_enabled:
		timer += delta
		if timer >= checking_time:
			timer = 0
			if check_puzzle_completion():
				is_enabled = false
				complete_puzzle()


func complete_puzzle():
	if hide_blur_image:
		blur_image.visible = false
	
	await get_tree().create_timer(transition_delay).timeout
	SignalManager.next_panel.emit()

func check_puzzle_completion() -> bool:
	var progress =  1 - _calculate_progress()
	return progress >= completation_percentage

#returns 1 on full clean image
func _calculate_progress() -> float:
	var image: Image = mask.get_image()
	
	var width = image.get_width()
	var height = image.get_height()
	
	var samples: int = 0
	var clean_samples: int = 0
	
	for i in range(0, width, sample_step):
		for j in range(0, height, sample_step):
			samples += 1
			
			var px = image.get_pixel(i, j)
			if px.r < 0.1:
				clean_samples += 1
	print(float(clean_samples) / float(samples))
	return float(clean_samples) / float(samples)

func on_screen_enter():
	is_enabled = true
