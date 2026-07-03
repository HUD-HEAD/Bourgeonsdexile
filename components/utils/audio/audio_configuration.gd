class_name AudioConfiguration extends Resource

enum sfx_type{
	click = 0,
	puzzle_correct_piece = 1,
	movile_selection = 2,
	resolve_puzzle = 3,
	bubble_correct_piece = 4,
	bubble_resolve_puzzle = 5,
	
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
	,c2_1_19_car = 2114,
	c2_3_water_drink = 2300,
	
}

enum loop_type{
	none = -1,
	
	c1_1_market_colombia = 1100,
	c1_1_breathing_loop = 1101,
	# c1_2_
	c1_2_jungle_steps = 1200,
	c1_2_jungle_ambience = 1201,
	c1_2_walking_water = 1202,
	c1_2_rain_loop = 1203,
	c1_2_memories_traumatic = 1204,
	c1_2_white_noise = 1205,
	
	c1_3_steps_loop = 1300,
	c1_3_colombia_space_sound_loop = 1301,
	c1_3_city_sound_loop = 1302,
	c1_3_steps_inside_loop = 1303,
	c1_3_steps_outside_loop = 1304,
	
	c1_4_bus_sound = 1400,
	
	c2_1_wind_loop_0_to_16 = 2100,
	c2_1_Thense_moment_panel_14 = 2101,
	c2_1_gun_shots_loop_15_to_19 = 2102,
	c2_1_steps_15_to_19 = 2103,
	c2_1_voices_loop_15_to_19 = 2104,
	c2_1_motocycle_running_sound_loop_20_and_23 = 2105,
	c2_1_motocycle_not_running = 2106,
	c2_1_motocycle_broke = 2107,
	
	c2_2_day_night_sound = 2200,
	c2_2_people_sound = 2201,
	c2_2_night_day_bus = 2202,
	c2_2_bus_sound = 2203,
	c2_2_bus_tense_moment  = 2204,
	c2_2_bus_movement = 2205,
	c2_2_bus_stop = 2206,
	c2_2_people = 2207,
	c2_2_wind = 2208,
	c2_3_bus_people = 2300,
	c2_3_breathing_sound = 2301,
	c2_3_city_space = 2302,
	
	#c2_4_
	c2_4_hospital_ambience_1_3 = 2400,
	c2_4_hospital_ambience_5_9_13 = 2401,
	c2_4_hospital_ambience_between = 2404,
	c2_4_hospital_ambience_13 = 2402,
	c2_4_hospital_ambience_14 = 2403,
	
	
	c3_1_Hospital_sound = 3100,
	c3_1_baby_crying = 3101,
	c3_2_Tv_loop = 3200,
	c3_2_Bus_ambient = 3201,
	c3_3_street_loop = 3300,
	
	c3_l_walking = 3500,
	c3_l_voices = 3501,
	c3_l_baby_sounds = 3502,
	c3_l_street_sounds = 3503,
	c3_l_house_sounds = 3504,
	c3_l_pharmacy_sound = 3505,
	c3_l_supermarket_sound = 3506,
	c3_l_museum_ambience = 3507,
	c3_l_nana = 3508,
	
}

enum music_type{
	c1_2_jungle_theme = 1200,
	c1_2_jungle_theme_after_traumatic_moment = 1201,
	c1_3_migration_theme = 1300,
	c1_4_final_theme = 1400,
	c2_1_starting_theme = 2100,
	c2_1_starting_theme_sad_moment_panel_10_to_15 = 2101,
	c2_1_walking_theme_panel_15_to_20 = 2102,
	c2_1_motocycle_panel_20_to_24 = 2103,
	c2_2_theme = 2200,
	c2_2_emotive_moment = 2201,
	c2_2_desert_theme = 2202,
	c2_3_theme  = 2300,
	c2_3_emotive_song  = 2301,
	c2_4_theme_stress = 2400,
	c2_4_credits = 2401,
	c3_1_theme = 3100,
	c3_2_lonely_theme = 3200,
	c3_2_war_theme = 3201,
	c3_2_new_life_theme = 3202,
	c3_3_theme = 3300,
	c3_4_museum_theme = 3400,
	c3_4_emotive_museum_theme = 3401,
	c3_l_levels_theme = 3500,
}

@export var sfx_configuration: Array[sfx_config]
@export var loop_configuration: Array[loop_config]
@export var music_configuration: Array[music_config]
