extends Control

var SongPlaying = false
var shuffled = true
var CurrentSongID = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(_event: InputEvent) -> void:
	if $"..".CurrentMenu == "MusicPlayer":
		if Input.is_action_just_released("B"):
			$"..".CurrentMenu = "MusicList-TRACK"
			$"../MusicList-TRACK".Reset()
			$AnimationPlayer.play("FadeOut")
			$"../MusicList-TRACK/AnimationPlayer".play("FadeIn")
			$"../MusicList-TRACK".show()
			await $AnimationPlayer.animation_finished
			$".".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if SongPlaying == true:
		$Panel/ProgressBar.max_value = $AudioStreamPlayer.stream.get_length()
		$Panel/ProgressBar.value = $AudioStreamPlayer.get_playback_position()

func PlaySong(id):
	CurrentSongID = id
	if FileAccess.file_exists("user://USERDATA/MUSIC/" + str(id) + "/COVER.png"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(id) + "/COVER.png")
		var texture=ImageTexture.create_from_image(image)
		$Panel/INFObg/Cover.texture = texture
	elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(id) + "/COVER.jpg"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(id) + "/COVER.jpg")
		var texture=ImageTexture.create_from_image(image)
		$Panel/INFObg/Cover.texture = texture
	elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(id) + "/COVER.webp"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(id) + "/COVER.webp")
		var texture=ImageTexture.create_from_image(image)
		$Panel/INFObg/Cover.texture = texture
	elif FileAccess.file_exists("user://USERDATA/MUSIC/" + str(id) + "/COVER.jpeg"):
		var image = Image.new()
		image.load("user://USERDATA/MUSIC/" + str(id) + "/COVER.jpeg")
		var texture=ImageTexture.create_from_image(image)
		$Panel/INFObg/Cover.texture = texture
	
	var file = FileAccess.open("user://USERDATA/MUSIC/" + str(id) + "/meta.txt", FileAccess.READ)
	var metadict = JSON.parse_string(file.get_as_text())
	$Panel/INFObg/SongInfo/TRACK.text = metadict.SongName
	$Panel/INFObg/SongInfo/ALBUM.text = metadict.Album
	$Panel/INFObg/SongInfo/ARTIST.text = metadict.Artist
	var songfile = FileAccess.open("user://USERDATA/MUSIC/" + str(id) + "/SONG.mp3", FileAccess.READ)
	var buffer = songfile.get_buffer(songfile.get_length())
	var audio_stream_mp3 = AudioStreamMP3.new()
	audio_stream_mp3.data = buffer
	$AudioStreamPlayer.stream = audio_stream_mp3
	$AudioStreamPlayer.play()
	SongPlaying = true

func _on_audio_stream_player_finished() -> void:
	if not $"../MusicList-TRACK".TrackCount == 0 or 1:
		var SelectedSong = randi_range(1, $"../MusicList-TRACK".TrackCount)
		if SelectedSong == CurrentSongID:
			while SelectedSong == CurrentSongID:
				SelectedSong = randi_range(1, $"../MusicList-TRACK".TrackCount)
				if not SelectedSong == CurrentSongID:
					PlaySong(SelectedSong)
					return
		else:
			PlaySong(SelectedSong)
