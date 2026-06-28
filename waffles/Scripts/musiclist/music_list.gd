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
	get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
	Selection = 1
	for n in $SubViewPort/GridContainer.get_children():
		$SubViewPort/GridContainer.remove_child(n)
		n.queue_free()
	AddCovers()
	get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true

func _input(_event: InputEvent) -> void:
	if $"..".CurrentMenu == "MusicList":
		if Input.is_action_just_released("down"):
			if not Selection == $PanelBG/Container/VBoxContainer.get_child_count():
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				$PanelBG/Container/VBoxContainer.position.y -= 36
				Selection += 1
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
		elif Input.is_action_just_released("up"):
			if not Selection == 1:
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				Selection -= 1
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
				$PanelBG/Container/VBoxContainer.position.y += 36
		elif Input.is_action_just_released("A"):
			if Selection == 1:
				$"..".CurrentMenu = "MusicList-TRACK"
				$"../MusicList-TRACK".Reset()
				$AnimationPlayer.play("FadeOut")
				$"../MusicList-TRACK/AnimationPlayer".play("FadeIn")
				$"../MusicList-TRACK".show()
				await $AnimationPlayer.animation_finished
				$".".hide()
		elif Input.is_action_just_released("B"):
			$"..".CurrentMenu = "INPUTLOCKED"
			$AnimationPlayer.play("FadeOut")
			$"../HomeDash/AnimationPlayer".play("FadeIn")
			$"../HomeDash".show()
			await $AnimationPlayer.animation_finished
			$"..".CurrentMenu = "HomeDash"
			$".".hide()

func AddCovers():
	var trackarray = DirAccess.get_directories_at("user://USERDATA/MUSIC/")
	TrackCount = trackarray.size()
	print("Found " + str(TrackCount) + " Tracks")
	$"../HomeDash/CardController/1/3/Container/Sub".text = str(TrackCount) + " Tracks"
	var loopcount = 1
	for I in range(0,TrackCount):
		if loopcount <= 15:
			var thing = preload("res://Scenes/musiclist/cover.tscn").instantiate()
			$SubViewPort/GridContainer.add_child(thing)
			
			if FileAccess.file_exists("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.png"):
				var image = Image.new()
				image.load("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.png")
				var texture=ImageTexture.create_from_image(image)
				$SubViewPort/GridContainer/Cover.texture = texture
			elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.jpg"):
				var image = Image.new()
				image.load("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.jpg")
				var texture=ImageTexture.create_from_image(image)
				$SubViewPort/GridContainer/Cover.texture = texture
			elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.webp"):
				var image = Image.new()
				image.load("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.webp")
				var texture=ImageTexture.create_from_image(image)
				$SubViewPort/GridContainer/Cover.texture = texture
			elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.jpeg"):
				var image = Image.new()
				image.load("user://USERDATA/MUSIC/" + str(loopcount) + "/COVER.jpeg")
				var texture=ImageTexture.create_from_image(image)
				$SubViewPort/GridContainer/Cover.texture = texture
			
			$SubViewPort/GridContainer/Cover.name = str(loopcount)
			loopcount += 1
		else:
			return
