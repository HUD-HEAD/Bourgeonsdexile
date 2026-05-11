class_name SettingsController extends CanvasLayer

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
const CURSOR_STEP = 0.05

static  var has_been_initialized = false
static var player_preferences: PlayerPreferences

func _ready() -> void:
	_initialize()
	_set_initial_values()
	
	#Asign delegates for sliders, buttons & toggle
	music_slider.connect("value_changed", _on_music_slider_value_changed)
	sfx_slider.connect("value_changed", _on_sfx_slider_value_changed)
	cursor_slider.connect("value_changed", _on_cursor_slide_value_changed)
	fullscreen_check.connect("toggled", _on_fullscreen_check_toggled)
	reset_button.connect("pressed", _reset_player_preferences)
	close_button.connect("pressed", _on_close_button_pressed)

func _set_initial_values():
	# Cargar valores guardados
	music_slider.value = player_preferences.music_volume
	sfx_slider.value = player_preferences.sfx_volume
	cursor_slider.value = player_preferences.cursor_size
	fullscreen_check.button_pressed = player_preferences.is_fullscreen
	
	# Configurar rango del cursor slider
	cursor_slider.min_value = CURSOR_MIN
	cursor_slider.max_value = CURSOR_MAX
	cursor_slider.step = CURSOR_STEP

static func _initialize():
	if !has_been_initialized:
		has_been_initialized = true
		#Load Player Preferences
		player_preferences = PlayerPreferences.load_player_preferences()
	
		# Apply save values
		_apply_settings()
	

static func _apply_settings():
	_apply_music_volume(player_preferences.music_volume)
	_apply_sfx_volume(player_preferences.sfx_volume)
	_apply_cursor_size(player_preferences.cursor_size)
	_apply_fullscreen(player_preferences.is_fullscreen)

# ── Sliders ──────────────────────────────────────────
func _on_music_slider_value_changed(value: float) -> void:
	player_preferences.music_volume = value
	_apply_music_volume(value)
	_save_player_preferences()

func _on_sfx_slider_value_changed(value: float) -> void:
	player_preferences.sfx_volume = value
	_apply_sfx_volume(value)
	_save_player_preferences()

func _on_cursor_slide_value_changed(value: float) -> void:
	player_preferences.cursor_size = value
	_apply_cursor_size(value)
	_save_player_preferences()

# ── Fullscreen ────────────────────────────────────────
func _on_fullscreen_check_toggled(pressed: bool) -> void:
	player_preferences.is_fullscreen = pressed
	_apply_fullscreen(pressed)
	_save_player_preferences()
# ── Reset Player Preferences ────────────────────────────────────────
func _reset_player_preferences():
	player_preferences = PlayerPreferences.reset_player_preferences()
	_apply_settings()
	_set_initial_values()

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
	#queue_free()
	SceneManager.close_settings()

# ── Aplicar valores ───────────────────────────────────
static func _apply_music_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

static func _apply_sfx_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Sfx"), value)

static func _apply_cursor_size(value: float) -> void:
	CustomCursor.update_cursor_scale(value)

static func _apply_fullscreen(value: bool) -> void:
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

 # ── Save Player Preferences ───────────────────────────────────
func _save_player_preferences() -> void:
	player_preferences.save()
