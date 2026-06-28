extends Control

var Selection = -1
var NumberOfApps = 0
var positionthethingisactuallysupposedtobeat = 193

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	if $"..".CurrentMenu == "MyApps":
		if Input.is_action_just_released("A"):
			if Selection == -1:
				GameLoader.start("/opt/VacuumTube/vacuumtube", [])
			elif Selection == 0:
				GameLoader.start("/usr/bin/flatpak", ["run", "tv.kodi.Kodi"])
		elif Input.is_action_just_released("B"):
			$"..".CurrentMenu = "INPUTLOCKED"
			$AnimationPlayer.play("FadeOut")
			$"../HomeDash/AnimationPlayer".play("FadeIn")
			$"../HomeDash".show()
			await $AnimationPlayer.animation_finished
			$"..".CurrentMenu = "HomeDash"
			$".".hide()
		if Input.is_action_just_released("right"):
			if not Selection == NumberOfApps:
				positionthethingisactuallysupposedtobeat -= 223.63
				var POSTOGO = $HBoxContainer.position.x - 223.63
				var tween := create_tween()
				tween.set_ease(Tween.EASE_IN_OUT)
				tween.set_trans(Tween.TRANS_SINE)
				tween.tween_property($HBoxContainer, "position", Vector2(POSTOGO, $HBoxContainer.position.y), 0.2)
				Selection += 1
				if Selection <= 0:
					var texture = load("res://Assets/MyApps/builtinapp/" + str(int(Selection)) + "/LOGO.png")
					$Logo.texture = texture
				await get_tree().create_timer(0.23).timeout
				if not $HBoxContainer.position.x == positionthethingisactuallysupposedtobeat:
					$HBoxContainer.position.x = positionthethingisactuallysupposedtobeat
		elif Input.is_action_just_released("left"):
			if not Selection == -1:
				positionthethingisactuallysupposedtobeat += 223.6
				var POSTOGO = $HBoxContainer.position.x + 223.63
				var tween := create_tween()
				tween.set_ease(Tween.EASE_IN_OUT)
				tween.set_trans(Tween.TRANS_SINE)
				tween.tween_property($HBoxContainer, "position", Vector2(POSTOGO, $HBoxContainer.position.y), 0.2)
				Selection -= 1
				if Selection <= 0:
					var texture = load("res://Assets/MyApps/builtinapp/" + str(int(Selection)) + "/LOGO.png")
					$Logo.texture = texture
				await get_tree().create_timer(0.23).timeout
				if not $HBoxContainer.position.x == positionthethingisactuallysupposedtobeat:
					$HBoxContainer.position.x = positionthethingisactuallysupposedtobeat
