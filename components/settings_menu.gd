extends CanvasLayer

@onready var music_slider = $TextureRect/MusicSlider
@onready var sfx_slider = $TextureRect/SFXSlider
@onready var cursor_slider = $TextureRect/CursorSlide
@onready var fullscreen_check = $TextureRect/FullscreenCheck
@onready var close_button = $TextureRect/CloseButton
@onready var credits_button = $TextureRect/CreditsButton
@onready var reset_button = $TextureRect/ResetButton

# Botones de idioma
@onready var btn_es = $TextureRect/HBoxContainer/Button_ES
@onready var btn_en = $TextureRect/HBoxContainer/Button_EN
@onready var btn_fr = $TextureRect/HBoxContainer/Button_FR
@onready var btn_it = $TextureRect/HBoxContainer/Button_IT
@onready var btn_zh = $TextureRect/HBoxContainer/Button_ZH
@onready var btn_ar = $TextureRect/HBoxContainer/Button_AR
@onready var btn_jp = $TextureRect/HBoxContainer/Button_JP
@onready var btn_fa = $TextureRect/HBoxContainer/Button_FA

const CURSOR_MIN = 0.5
const CURSOR_MAX = 2.0

func _ready() -> void:
	# Cargar valores guardados
	music_slider.value = GameManager.music_volume
	sfx_slider.value = GameManager.sfx_volume
	cursor_slider.value = GameManager.cursor_size
	fullscreen_check.button_pressed = GameManager.is_fullscreen
	
	# Aplicar valores actuales
	_apply_music_volume(GameManager.music_volume)
	_apply_sfx_volume(GameManager.sfx_volume)
	_apply_cursor_size(GameManager.cursor_size)
	_apply_fullscreen(GameManager.is_fullscreen)
	
	# Configurar rango del cursor slider
	cursor_slider.min_value = CURSOR_MIN
	cursor_slider.max_value = CURSOR_MAX
	cursor_slider.step = 0.1

# ── Sliders ──────────────────────────────────────────
func _on_music_slider_value_changed(value: float) -> void:
	GameManager.music_volume = value
	_apply_music_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	GameManager.sfx_volume = value
	_apply_sfx_volume(value)

func _on_cursor_slide_value_changed(value: float) -> void:
	GameManager.cursor_size = value
	_apply_cursor_size(value)

# ── Fullscreen ────────────────────────────────────────
func _on_fullscreen_check_toggled(pressed: bool) -> void:
	GameManager.is_fullscreen = pressed
	_apply_fullscreen(pressed)

# ── Idiomas ───────────────────────────────────────────
func _on_button_es_pressed() -> void:
	GameManager.language = "ES"

func _on_button_en_pressed() -> void:
	GameManager.language = "EN"

func _on_button_fr_pressed() -> void:
	GameManager.language = "FR"

func _on_button_it_pressed() -> void:
	GameManager.language = "IT"

func _on_button_zh_pressed() -> void:
	GameManager.language = "ZH"

func _on_button_ar_pressed() -> void:
	GameManager.language = "AR"

func _on_button_jp_pressed() -> void:
	GameManager.language = "JP"

func _on_button_fa_pressed() -> void:
	GameManager.language = "FA"

# ── Créditos ──────────────────────────────────────────
func _on_credits_button_pressed() -> void:
	$Credits.visible = true  # si lo tienes como hijo directo
	var credits_scene = ResourceLoader.load("res://scenes/menus/credits.tscn")
	var credits_instance = credits_scene.instantiate()
	get_tree().root.add_child(credits_instance)

# ── Reset ─────────────────────────────────────────────
func _on_reset_button_pressed() -> void:
	GameManager.music_volume = 1.0
	GameManager.sfx_volume = 1.0
	GameManager.cursor_size = 1.0
	GameManager.is_fullscreen = false
	GameManager.language = "EN"
	
	# Actualizar UI
	music_slider.value = 1.0
	sfx_slider.value = 1.0
	cursor_slider.value = 1.0
	fullscreen_check.button_pressed = false
	
	# Aplicar
	_apply_music_volume(1.0)
	_apply_sfx_volume(1.0)
	_apply_cursor_size(1.0)
	_apply_fullscreen(false)

# ── Cerrar ────────────────────────────────────────────
func _on_close_button_pressed() -> void:
	queue_free()

# ── Aplicar valores ───────────────────────────────────
func _apply_music_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _apply_sfx_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Sfx"), value)

func _apply_cursor_size(value: float) -> void:
	# Conectar con tu CustomManager si maneja el cursor
	pass

func _apply_fullscreen(value: bool) -> void:
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
