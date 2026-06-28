extends Control

var Recent_Selection = 1
var GameCount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GetRecentGames()
	GetGameCount()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func GetGameCount():
	var gamearray = DirAccess.get_directories_at("user://USERDATA/GAME/")
	GameCount = gamearray.size()
	print("Found " + str(GameCount) + " Games")
	$PanelBG/Header/Sub.text = str(GameCount) + " Games Installed"
	$"../HomeDash/CardController/1/2/Container/Sub".text = str(GameCount) + " Games Installed"

func GetRecentGames():
	if FileAccess.file_exists("user://USERDATA/USER/" + str(int(Profile.ProfileID)) + "/recentgame.json"):
		var loopcount = 1
		var recentfile = FileAccess.open("user://USERDATA/USER/" + str(int(Profile.ProfileID)) + "/recentgame.json", FileAccess.READ)
		var recentdict = JSON.parse_string(recentfile.get_as_text())
		for I in range(0,8):
			if not recentdict["Game" + str(loopcount)] == null:
				var thing = preload("res://Scenes/MyGames/recent-game.tscn").instantiate()
				$PanelBG/Container/VBoxContainer.add_child(thing)
				
				var file = FileAccess.open("user://USERDATA/GAME/" + str(int(recentdict["Game" + str(loopcount)])) + "/meta.txt", FileAccess.READ)
				var metadict = JSON.parse_string(file.get_as_text())
				$PanelBG/Container/VBoxContainer/GAME/Title.text = metadict.Title
				$PanelBG/Container/VBoxContainer/GAME/Developer.text = metadict.Developer
				await GetIcon(int(recentdict["Game" + str(loopcount)]))
				
				$PanelBG/Container/VBoxContainer/GAME.name = str(loopcount)
				
				var thing2 = preload("res://Scenes/MyGames/card-cover.tscn").instantiate()
				$"../HomeDash/CardController/1/2/Container/HBoxContainer".add_child(thing2)
				await GetCover(int(recentdict["Game" + str(loopcount)]))
				
				$"../HomeDash/CardController/1/2/Container/HBoxContainer/COVER".name = str(loopcount)
			loopcount += 1
		$PanelBG/Footer/Counter.text = str(Recent_Selection) + " of " + str($PanelBG/Container/VBoxContainer.get_child_count())
		get_node("PanelBG/Container/VBoxContainer/" + str(Recent_Selection)).selected = true
	else:
		print("recentgame.json Doesnt exist\n" + "PATH: " + "user://USERDATA/USER/" + str(int(Profile.ProfileID)) + "/recentgame.json")


func GetIcon(id):
	if FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/ICON.png"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/ICON.png")
		var texture=ImageTexture.create_from_image(image)
		$PanelBG/Container/VBoxContainer/GAME/Icon.texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/ICON.jpg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/ICON.jpg")
		var texture=ImageTexture.create_from_image(image)
		$PanelBG/Container/VBoxContainer/GAME/Icon.texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/ICON.webp"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/ICON.webp")
		var texture=ImageTexture.create_from_image(image)
		$PanelBG/Container/VBoxContainer/GAME/Icon.texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/ICON.jpeg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/ICON.jpeg")
		var texture=ImageTexture.create_from_image(image)
		$PanelBG/Container/VBoxContainer/GAME/Icon.texture = texture

func GetCover(id):
	if FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/COVER.png"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/COVER.png")
		var texture=ImageTexture.create_from_image(image)
		$"../HomeDash/CardController/1/2/Container/HBoxContainer/COVER/Cover".texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/COVER.jpg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/COVER.jpg")
		var texture=ImageTexture.create_from_image(image)
		$"../HomeDash/CardController/1/2/Container/HBoxContainer/COVER/Cover".texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/COVER.webp"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/COVER.webp")
		var texture=ImageTexture.create_from_image(image)
		$"../HomeDash/CardController/1/2/Container/HBoxContainer/COVER/Cover".texture = texture
	elif FileAccess.file_exists("user://USERDATA/GAME/" + str(id) + "/COVER.jpeg"):
		var image = Image.new()
		image.load("user://USERDATA/GAME/" + str(id) + "/COVER.jpeg")
		var texture=ImageTexture.create_from_image(image)
		$"../HomeDash/CardController/1/2/Container/HBoxContainer/COVER/Cover".texture = texture


func _input(_event: InputEvent) -> void:
	if $"..".CurrentMenu == "MyGames-Recent":
		if Input.is_action_just_released("down"):
			if not Recent_Selection == $PanelBG/Container/VBoxContainer.get_child_count():
				get_node("PanelBG/Container/VBoxContainer/" + str(Recent_Selection)).selected = false
				$PanelBG/Container/VBoxContainer.position.y -= 62
				Recent_Selection += 1
				get_node("PanelBG/Container/VBoxContainer/" + str(Recent_Selection)).selected = true
				$PanelBG/Footer/Counter.text = str(Recent_Selection) + " of " + str($PanelBG/Container/VBoxContainer.get_child_count())
		elif Input.is_action_just_released("up"):
			if not Recent_Selection == 1:
				get_node("PanelBG/Container/VBoxContainer/" + str(Recent_Selection)).selected = false
				Recent_Selection -= 1
				get_node("PanelBG/Container/VBoxContainer/" + str(Recent_Selection)).selected = true
				$PanelBG/Container/VBoxContainer.position.y += 62
				$PanelBG/Footer/Counter.text = str(Recent_Selection) + " of " + str($PanelBG/Container/VBoxContainer.get_child_count())
		elif Input.is_action_just_released("A"):
			pass
		elif Input.is_action_just_released("B"):
			$"..".CurrentMenu = "INPUTLOCKED"
			$AnimationPlayer.play("FadeOut")
			$"../HomeDash/AnimationPlayer".play("FadeIn")
			$"../HomeDash".show()
			await $AnimationPlayer.animation_finished
			$"..".CurrentMenu = "HomeDash"
			$".".hide()
