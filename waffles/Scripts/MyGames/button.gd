extends Panel

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if selected == true:
		$SELECTED.show()
		$NORM.hide()
		$Title.add_theme_color_override("font_color", Color("ffffffff"))
		$Developer.add_theme_color_override("font_color", Color("cecece"))
	else:
		$SELECTED.hide()
		$NORM.show()
		$Title.add_theme_color_override("font_color", Color("232323"))
		$Developer.add_theme_color_override("font_color", Color("5A5858"))
