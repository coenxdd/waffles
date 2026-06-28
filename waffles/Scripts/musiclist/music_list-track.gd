extends Control

var Selection = 1
var TrackCount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func Reset():
	$PanelBG/Container/VBoxContainer.position.y = 0
	for n in $PanelBG/Container/VBoxContainer.get_children():
		$PanelBG/Container/VBoxContainer.remove_child(n)
		n.queue_free()
	Selection = 1
	await AddTracks()
	get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
	GetCover()

func _input(_event: InputEvent) -> void:
	if $"..".CurrentMenu == "MusicList-TRACK":
		if Input.is_action_just_released("down"):
			if not Selection == $PanelBG/Container/VBoxContainer.get_child_count():
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				$PanelBG/Container/VBoxContainer.position.y -= 36
				Selection += 1
				GetCover()
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
		elif Input.is_action_just_released("up"):
			if not Selection == 1:
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				Selection -= 1
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
				GetCover()
				$PanelBG/Container/VBoxContainer.position.y += 36
		elif Input.is_action_just_released("A"):
			$"..".CurrentMenu = "MusicPlayer"
			$AnimationPlayer.play("FadeOut")
			$"../MusicPlayer/AnimationPlayer".play("FadeIn")
			$"../MusicPlayer".show()
			await $AnimationPlayer.animation_finished
			$"../MusicPlayer".PlaySong(Selection)
			$".".hide()
		elif Input.is_action_just_released("B"):
			$"..".CurrentMenu = "INPUTLOCKED"
			$AnimationPlayer.play("FadeOut")
			$"../MusicList/AnimationPlayer".play("FadeIn")
			$"../MusicList".show()
			await $AnimationPlayer.animation_finished
			$"..".CurrentMenu = "MusicList"
			$".".hide()

func AddTracks():
	var trackarray = DirAccess.get_directories_at("user://USERDATA/MUSIC/")
	TrackCount = trackarray.size()
	print("Found " + str(TrackCount) + " Tracks")
	$"../HomeDash/CardController/1/3/Container/Sub".text = str(TrackCount) + " Tracks"
	var loopcount = 1
	for I in range(0,TrackCount):
		var thing = preload("res://Scenes/musiclist/button.tscn").instantiate()
		$PanelBG/Container/VBoxContainer.add_child(thing)
		
		var file = FileAccess.open("user://USERDATA/MUSIC/" + str(loopcount) + "/meta.txt", FileAccess.READ)
		var metadict = JSON.parse_string(file.get_as_text())
		$"../MusicList-TRACK/PanelBG/Container/VBoxContainer/BUTTON/Header".text = metadict.Artist + " - " + metadict.SongName
		
		$"../MusicList-TRACK/PanelBG/Container/VBoxContainer/BUTTON".name = str(loopcount)
		loopcount += 1
	get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true

func GetCover():
	if FileAccess.file_exists("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.png"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.png")
		var texture=ImageTexture.create_from_image(image)
		$Cover.texture = texture
	elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.jpg"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.jpg")
		var texture=ImageTexture.create_from_image(image)
		$Cover.texture = texture
	elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.webp"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.webp")
		var texture=ImageTexture.create_from_image(image)
		$Cover.texture = texture
	elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.jpeg"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(Selection) + "/COVER.jpeg")
		var texture=ImageTexture.create_from_image(image)
		$Cover.texture = texture
