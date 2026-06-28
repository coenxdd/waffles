extends Panel

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if selected == true:
		$SELECTED.show()
		$TextureRect2.hide()
	else:
		$SELECTED.hide()
		$TextureRect2.show()
