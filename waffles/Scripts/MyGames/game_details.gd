extends Control

var Selection = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GetGame(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func GetGame(id):
	get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
	$PanelBG/Container/VBoxContainer.position.y = 0
	Selection = 1
	get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
	if FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/LOGO.png"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/LOGO.png")
		var texture=ImageTexture.create_from_image(image)
		$Logo.texture = texture
	if FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/LOGO.jpg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/LOGO.jpg")
		var texture=ImageTexture.create_from_image(image)
		$Logo.texture = texture
	if FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/LOGO.jpeg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/LOGO.jpeg")
		var texture=ImageTexture.create_from_image(image)
		$Logo.texture = texture
	if FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/LOGO.webm"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/LOGO.webm")
		var texture=ImageTexture.create_from_image(image)
		$Logo.texture = texture
	
	if FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/BG1.png"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/BG1.png")
		var texture=ImageTexture.create_from_image(image)
		$Background.texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/BG1.jpg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/BG1.jpg")
		var texture=ImageTexture.create_from_image(image)
		$Background.texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/BG1.jpeg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/BG1.jpeg")
		var texture=ImageTexture.create_from_image(image)
		$Background.texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/BG1.webm"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/BG1.webm")
		var texture=ImageTexture.create_from_image(image)
		$Background.texture = texture
	
	var file = FileAccess.open("user://USERDATA/GAME/" + str(id) + "/meta.txt", FileAccess.READ)
	var metadict = JSON.parse_string(file.get_as_text())
	$"PanelBG/Container/VBoxContainer/6/Desc".text = metadict.Desc
	$PanelBG/Header/Header.text = metadict.Title

func _input(_event: InputEvent) -> void:
	if $"..".CurrentMenu == "GameDetails":
		if Input.is_action_just_released("down"):
			if not Selection == $PanelBG/Container/VBoxContainer.get_child_count():
				if not Selection == 6:
					get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				$PanelBG/Container/VBoxContainer.position.y -= 41.67
				Selection += 1
				if not Selection == 6:
					get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
		elif Input.is_action_just_released("up"):
			if not Selection == 1:
				if not Selection == 6:
					get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				Selection -= 1
				if not Selection == 6:
					get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
				$PanelBG/Container/VBoxContainer.position.y += 41.67
		elif Input.is_action_just_released("A"):
			pass
		elif Input.is_action_just_released("B"):
			$"..".CurrentMenu = "INPUTLOCKED"
			$AnimationPlayer.play("FadeOut")
			$"../MyGames/AnimationPlayer".play("FadeIn")
			$"../MyGames".show()
			await $AnimationPlayer.animation_finished
			$"..".CurrentMenu = "MyGames-Recent"
			$".".hide()
