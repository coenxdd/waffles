extends Node

func start(path, args):
	get_tree().change_scene_to_file("res://Scenes/blank.tscn")
	await get_tree().create_timer(1.5).timeout
	OS.execute(path, args)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Flash_Dash.tscn")
