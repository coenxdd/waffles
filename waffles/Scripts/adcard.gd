extends Panel

var Title = "Title"
var Subtitle = "Subtitle"
var BarText = "Bar Text"
var ImageBG = Texture

var BarEnabled = false
var BarOrangeThing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func Update():
	$Container/Title.text = Title
	$Container/Sub.text = Subtitle
	$Container/Image.texture = ImageBG
	
	if BarEnabled == true:
		$Container/Bar.show()
		$Container/Bar/BarText.text = BarText
		if BarOrangeThing == true:
			$Container/Bar/OrangeThing.show()
		else:
			$Container/Bar/OrangeThing.hide()
	else:
		$Container/Bar.hide()
