extends Control

var Selection = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func Reset():
	get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
	$PanelBG/Panel3/Counter.text = str(Selection) + " of " + str($PanelBG/Container/VBoxContainer.get_child_count())

func _input(_event: InputEvent) -> void:
	if $"..".CurrentMenu == "SystemSettings":
		if Input.is_action_just_released("down"):
			if not Selection == $PanelBG/Container/VBoxContainer.get_child_count():
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				$PanelBG/Container/VBoxContainer.position.y -= 43
				Selection += 1
				$PanelBG/Panel3/Counter.text = str(Selection) + " of " + str($PanelBG/Container/VBoxContainer.get_child_count())
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
		elif Input.is_action_just_released("up"):
			if not Selection == 1:
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = false
				Selection -= 1
				$PanelBG/Panel3/Counter.text = str(Selection) + " of " + str($PanelBG/Container/VBoxContainer.get_child_count())
				get_node("PanelBG/Container/VBoxContainer/" + str(Selection)).selected = true
				$PanelBG/Container/VBoxContainer.position.y += 43
		elif Input.is_action_just_released("A"):
			if Selection == 1:
				pass
		elif Input.is_action_just_released("B"):
			$"..".CurrentMenu = "INPUTLOCKED"
			$AnimationPlayer.play("FadeOut")
			$"../HomeDash/AnimationPlayer".play("FadeIn")
			$"../HomeDash".show()
			await $AnimationPlayer.animation_finished
			$"..".CurrentMenu = "HomeDash"
			$".".hide()
