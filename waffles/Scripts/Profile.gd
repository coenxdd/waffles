extends Node

var UserName = "Player"
var PlayerName = "User"
var current_theme = 0
var PlayerScore = 0
var ProfileID = 1
var PlayerQuote = "Hello!"
var PlayerPFP = Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func UpdateProfile():
	var _towrite = {
		"username": UserName,
		"playername": PlayerName,
		"current_theme": current_theme,
		"playerscore": PlayerScore,
		"profileid": ProfileID,
		"playerquote": PlayerQuote,
	}
	
	var imagepfp = PlayerPFP.get_image()
	imagepfp.save_png("user://USERDATA/USER/" + str(ProfileID) + "/userpfp.png")
	
	var json = JSON.stringify(_towrite)
	var file = FileAccess.open("user://USERDATA/USER/" + str(ProfileID) + "/user.json", FileAccess.WRITE)
	if file:
		print("Writing to user " + str(ProfileID))
		file.store_string(json)

func LoadProfile(id):
	if FileAccess.file_exists("user://USERDATA/USER/" + str(id) + "/userpfp.png"):
		var image = Image.new()
		image.load("user://USERDATA/USER/" + str(id) + "/userpfp.png")
		var texture=ImageTexture.create_from_image(image)
		PlayerPFP = texture
	
	var file = FileAccess.open("user://USERDATA/USER/" + str(id) + "/user.json", FileAccess.READ)
	var metadict = JSON.parse_string(file.get_as_text())
	PlayerName = metadict.playername
	UserName = metadict.username
	current_theme = metadict.current_theme
	PlayerScore = metadict.playerscore
	ProfileID = metadict.profileid
	PlayerQuote = metadict.playerquote


func CreateProfile():
	var usercount = DirAccess.get_directories_at("user://USERDATA/USER").size()
	ProfileID = usercount + 1
	
	if not DirAccess.dir_exists_absolute("user://USERDATA/USER/" + str(ProfileID)):
		DirAccess.make_dir_absolute("user://USERDATA/USER/" + str(ProfileID))
	
	var _towrite = {
		"username": UserName,
		"playername": PlayerName,
		"current_theme": current_theme,
		"playerscore": PlayerScore,
		"profileid": ProfileID,
		"playerquote": PlayerQuote,
	}
	
	var imagepfp = PlayerPFP.get_image()
	imagepfp.save_png("user://USERDATA/USER/" + str(ProfileID) + "/userpfp.png")
	
	var json = JSON.stringify(_towrite)
	var file = FileAccess.open("user://USERDATA/USER/" + str(ProfileID) + "/user.json", FileAccess.WRITE)
	if file:
		print("Writing to user " + str(ProfileID))
		file.store_string(json)
