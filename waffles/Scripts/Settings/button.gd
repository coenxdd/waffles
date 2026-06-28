extends Panel

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if selected == true:
		$SELECTED.show()
		$Norm.hide()
		$Icon.modulate = Color("ffffff")
		$Label.add_theme_color_override("font_color", Color("ffffffff"))
	else:
		$SELECTED.hide()
		$Norm.show()
		$Icon.modulate = Color("232323")
		$Label.add_theme_color_override("font_color", Color("232323"))
