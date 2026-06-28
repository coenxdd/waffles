extends Control

var UserCount
var SelectedProfile = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GetProfiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("down"):
		if not SelectedProfile == $Panel/Container/VBoxContainer.get_child_count():
			get_node("Panel/Container/VBoxContainer/" + str(SelectedProfile)).selected = false
			$Panel/Container/VBoxContainer.position.y -= 61
			SelectedProfile += 1
			get_node("Panel/Container/VBoxContainer/" + str(SelectedProfile)).selected = true
	elif Input.is_action_just_released("up"):
		if not SelectedProfile == 1:
			get_node("Panel/Container/VBoxContainer/" + str(SelectedProfile)).selected = false
			SelectedProfile -= 1
			get_node("Panel/Container/VBoxContainer/" + str(SelectedProfile)).selected = true
			$Panel/Container/VBoxContainer.position.y += 61
	elif Input.is_action_just_released("A"):
		if SelectedProfile == UserCount + 1:
			get_tree().change_scene_to_file("res://Scenes/setup.tscn")
		else:
			Profile.LoadProfile(SelectedProfile)
			get_tree().change_scene_to_file("res://Scenes/Flash_Dash.tscn")

func GetProfiles():
	var profilearray = DirAccess.get_directories_at("user://USERDATA/USER/")
	UserCount = profilearray.size()
	print("Found " + str(UserCount) + " Profiles")
	var loopcount = 1
	for I in range(0,UserCount):
		var thing = preload("res://Scenes/login/button.tscn").instantiate()
		$Panel/Container/VBoxContainer.add_child(thing)
		
		if FileAccess.file_exists("user://USERDATA/USER/" + str(loopcount) + "/userpfp.png"):
			var image = Image.new()
			image.load("user://USERDATA/USER/" + str(loopcount) + "/userpfp.png")
			var texture=ImageTexture.create_from_image(image)
			$Panel/Container/VBoxContainer/PROFILE/PFP.texture = texture
		
		var file = FileAccess.open("user://USERDATA/USER/" + str(loopcount) + "/user.json", FileAccess.READ)
		var metadict = JSON.parse_string(file.get_as_text())
		$Panel/Container/VBoxContainer/PROFILE/PlayerName.text = metadict.playername
		$Panel/Container/VBoxContainer/PROFILE/UserName.text = metadict.username
		
		$Panel/Container/VBoxContainer/PROFILE.name = str(loopcount)
		loopcount += 1
	var cthing = preload("res://Scenes/login/create.tscn").instantiate()
	$Panel/Container/VBoxContainer.add_child(cthing)
	$Panel/Container/VBoxContainer/Create.name = str(loopcount)
	get_node("Panel/Container/VBoxContainer/" + str(SelectedProfile)).selected = true
