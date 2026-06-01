class_name AudioConfiguration extends Resource

enum sfx_type{
	click = 0,
	puzzle_correct_piece = 1,
	movile_selection = 2,
	resolve_puzzle = 3,
	gun_shots = 2100,
	c1_3_relief_sound = 1300,
	c1_3_eating_sound = 1301,
	c1_3_paper_sound = 1302,
	
	
	c2_1_1_gun_shot_selection = 2101
	,c2_1_2_clean_cristal = 2102
	,c2_1_3_gun_wind_window = 2103
	,c2_1_4_plastic_blocks = 2104
	,c2_1_5_childs_playing = 2105
	,c2_1_6_textil = 2106
	,c2_1_7_mmm_woman = 2107
	,c2_1_10_child_move = 2108
	,c2_1_11_hands = 2109
	,c2_1_12_child_move2 = 2110
	,c2_1_13_sad_moment = 2111
	,c2_1_14_doors_open = 2112
	,c2_1_15_car = 2113
	,c2_1_19_car = 2114	
}

enum loop_type{
	none = -1,
	c1_3_steps_loop = 1300,
	c1_3_colombia_space_sound_loop = 1301,
	c1_3_city_sound_loop = 1302,
	c1_3_steps_inside_loop = 1303,
	c1_3_steps_outside_loop = 1304,
	
	c2_1_wind_loop_0_to_16 = 2100,
	c2_1_Thense_moment_panel_14 = 2101,
	c2_1_gun_shots_loop_15_to_19 = 2102,
	c2_1_steps_15_to_19 = 2103,
	c2_1_voices_loop_15_to_19 = 2104,
	c2_1_motocycle_running_sound_loop_20_and_23 = 2105,
	c2_1_motocycle_not_running = 2106,
}

enum music_type{
	c1_3_migration_theme = 1300,
	c2_1_starting_theme = 2100,
	c2_1_starting_theme_sad_moment_panel_10_to_15 = 2101,
	c2_1_walking_theme_panel_15_to_20 = 2102,
	c2_1_motocycle_panel_20_to_24 = 2103,
}

@export var sfx_configuration: Array[sfx_config]
@export var loop_configuration: Array[loop_config]
@export var music_configuration: Array[music_config]
