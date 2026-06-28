extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	if not DirAccess.dir_exists_absolute("user://USERDATA"):
		DirAccess.make_dir_absolute("user://USERDATA")
	if not DirAccess.dir_exists_absolute("user://USERDATA/APPS"):
		DirAccess.make_dir_absolute("user://USERDATA/APPS")
	if not DirAccess.dir_exists_absolute("user://USERDATA/GAME"):
		DirAccess.make_dir_absolute("user://USERDATA/GAME")
	if not DirAccess.dir_exists_absolute("user://USERDATA/MUSIC"):
		DirAccess.make_dir_absolute("user://USERDATA/MUSIC")
	if not DirAccess.dir_exists_absolute("user://USERDATA/SYSTEM"):
		DirAccess.make_dir_absolute("user://USERDATA/SYSTEM")
	if not DirAccess.dir_exists_absolute("user://USERDATA/SYSTEM/CACHE"):
		DirAccess.make_dir_absolute("user://USERDATA/SYSTEM/CACHE")
	if not DirAccess.dir_exists_absolute("user://USERDATA/SYSTEM/cef-data"):
		DirAccess.make_dir_absolute("user://USERDATA/SYSTEM/cef-data")
	if not DirAccess.dir_exists_absolute("user://USERDATA/USER"):
		DirAccess.make_dir_absolute("user://USERDATA/USER")
	await get_tree().create_timer(1).timeout
	if DirAccess.get_directories_at("user://USERDATA/USER").size() == 0 or not DirAccess.dir_exists_absolute("user://USERDATA/USER"):
		get_tree().change_scene_to_file("res://Scenes/setup.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/login.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
