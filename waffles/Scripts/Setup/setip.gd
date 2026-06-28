extends Control

var CurrentPanel = 0
var InputDisabled = false
var SelectedPFP = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel0.show()
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	if InputDisabled == false:
		if CurrentPanel == 0:
			if Input.is_action_just_released("A"):
				CurrentPanel = 1
				$Panel1.show()
				$Panel0/AnimationPlayer.play("FadeOut")
				await $Panel0/AnimationPlayer.animation_finished
				$Panel0.hide()
				$AudioStreamPlayer.play()
		elif CurrentPanel == 1:
			if Input.is_action_just_released("A"):
				CurrentPanel = 2
				InputDisabled = true
				$Panel1/AnimationPlayer.play("FadeOut")
				$Panel2/AnimationPlayer.play("FadeIn")
				$Panel2.show()
				await $Panel1/AnimationPlayer.animation_finished
				$Panel2/TextEditWithOnScreenKeyboard/MarginContainer/VBoxContainer/Controls/Keyboards/Qwerty/LettersSmall/Q.grab_focus()
				$Panel1.hide()
		elif CurrentPanel == 4:
			if Input.is_action_just_released("down"):
				if not SelectedPFP == $Panel4/Panel/PFPholder/VBoxContainer.get_child_count():
					$Panel4/Panel/PFPholder/VBoxContainer.position.y -= 83
					SelectedPFP += 1
					$Panel4/Panel/SelectedPFPbig.texture = get_node("Panel4/Panel/PFPholder/VBoxContainer/" + str(SelectedPFP)).texture
			elif Input.is_action_just_released("up"):
				if not SelectedPFP == 1:
					SelectedPFP -= 1
					$Panel4/Panel/SelectedPFPbig.texture = get_node("Panel4/Panel/PFPholder/VBoxContainer/" + str(SelectedPFP)).texture
					$Panel4/Panel/PFPholder/VBoxContainer.position.y += 83
			elif Input.is_action_just_released("A"):
				CurrentPanel = 5
				$Panel5/Panel/Name.text = Profile.PlayerName
				$Panel5/Panel/GamerTag.text = Profile.UserName
				Profile.PlayerPFP = get_node("Panel4/Panel/PFPholder/VBoxContainer/" + str(SelectedPFP)).texture
				$Panel5/Panel/SelectedPFPbig.texture = Profile.PlayerPFP
				$Panel4/AnimationPlayer.play("FadeOut")
				$Panel5/AnimationPlayer.play("FadeIn")
				$Panel5.show()
				await $Panel4/AnimationPlayer.animation_finished
				$Panel4.hide()
		elif CurrentPanel == 5:
			if Input.is_action_just_released("B"):
				CurrentPanel = 2
				InputDisabled = true
				$Panel5/AnimationPlayer.play("FadeOut")
				$Panel2/AnimationPlayer.play("FadeIn")
				$Panel2.show()
				await $Panel5/AnimationPlayer.animation_finished
				$Panel2/TextEditWithOnScreenKeyboard/MarginContainer/VBoxContainer/Controls/Keyboards/Qwerty/LettersSmall/Q.grab_focus()
				$Panel5.hide()
			if Input.is_action_just_released("A"):
				CurrentPanel = 6
				$Panel5/AnimationPlayer.play("FadeOut")
				$Panel6/AnimationPlayer.play("FadeIn")
				$Panel6.show()
				await $Panel5/AnimationPlayer.animation_finished
				$Panel5.hide()
		elif CurrentPanel == 6:
			if Input.is_action_just_released("A"):
				$Panel6/AnimationPlayer.play("FadeOut")
				Profile.CreateProfile()
				await $Panel6/AnimationPlayer.animation_finished
				get_tree().change_scene_to_file("res://Scenes/Flash_Dash.tscn")

func _ON_NAME_SUBMIT(text: String) -> void:
	print("SETTING NAME " + text)
	Profile.PlayerName = text
	#$Panel2/TextEditWithOnScreenKeyboard.grab_focus()
	$Panel2/TextEditWithOnScreenKeyboard.release_focus()
	CurrentPanel = 3
	InputDisabled = true
	$Panel2/AnimationPlayer.play("FadeOut")
	$Panel3/AnimationPlayer.play("FadeIn")
	$Panel3.show()
	await $Panel2/AnimationPlayer.animation_finished
	$Panel3/TextEditWithOnScreenKeyboard/MarginContainer/VBoxContainer/Controls/Keyboards/Qwerty/LettersSmall/Q.grab_focus()
	$Panel2.hide()

func ON_GTAG_SUBMIT(text: String) -> void:
	print("SETTING TAG " + text)
	Profile.UserName = text
	#$Panel3/TextEditWithOnScreenKeyboard.grab_focus()
	$Panel3/TextEditWithOnScreenKeyboard.release_focus()
	CurrentPanel = 4
	InputDisabled = false
	$Panel3/AnimationPlayer.play("FadeOut")
	$Panel4/AnimationPlayer.play("FadeIn")
	$Panel4.show()
	await $Panel3/AnimationPlayer.animation_finished
	$Panel3.hide()
