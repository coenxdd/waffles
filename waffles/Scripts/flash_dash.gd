extends Control

var CardNum
var HasInternet = true
var CURRENTCHANNEL
var CurrentMenu = "HomeDash"
var CHANNELNUM = 1
var NumberOfChannels = 8
var Cooldown = false

var ChannelNames = {
	"1":"Home",
	"2":"My Community",
	"3":"Friends",
	"4":"INSIDER",
	"5":"Game Marketplace",
	"6":"Media Marketplace",
	"7":"Events",
	"8":"Spotlight"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CURRENTCHANNEL = get_node("HomeDash/CardController/" + str(CHANNELNUM))
	CardNum = CURRENTCHANNEL.get_child_count()
	_LoadProfile()
	$MusicList.Reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _LoadProfile():
	$HomeDash/ProfileCard/PointContainer/Points.text = str(int(Profile.PlayerScore))
	$"HomeDash/CardController/1/1/Container/PointContainer/Points".text = str(int(Profile.PlayerScore))
	$HomeDash/ProfileCard/Username.text = Profile.UserName
	$HomeDash/ProfileCard/PFP.texture = Profile.PlayerPFP
	$"HomeDash/CardController/1/1/Container/PFP".texture = Profile.PlayerPFP
	$"HomeDash/CardController/1/1/Container/ProfileName".text = Profile.PlayerName
	$"HomeDash/CardController/1/1/Container/Quote".text = Profile.PlayerQuote

func _input(_event: InputEvent) -> void:
	if CurrentMenu == "HomeDash":
		if Input.is_action_just_released("right"):
			if not CURRENTCHANNEL.CurrentCard == CardNum:
				CURRENTCHANNEL.positionthethingisactuallysupposedtobeat -= 344
				var POSTOGO = CURRENTCHANNEL.position.x - 344
				var tween := create_tween()
				tween.set_ease(Tween.EASE_IN_OUT)
				tween.set_trans(Tween.TRANS_SINE)
				tween.tween_property(CURRENTCHANNEL, "position", Vector2(POSTOGO, CURRENTCHANNEL.position.y), 0.2)
				CURRENTCHANNEL.CurrentCard += 1
				await get_tree().create_timer(0.23).timeout
				if not CURRENTCHANNEL.position.x == CURRENTCHANNEL.positionthethingisactuallysupposedtobeat:
					CURRENTCHANNEL.position.x = CURRENTCHANNEL.positionthethingisactuallysupposedtobeat
		elif Input.is_action_just_released("left"):
			if not CURRENTCHANNEL.CurrentCard == 1:
				CURRENTCHANNEL.positionthethingisactuallysupposedtobeat += 344
				var POSTOGO = CURRENTCHANNEL.position.x + 344
				var tween := create_tween()
				tween.set_ease(Tween.EASE_IN_OUT)
				tween.set_trans(Tween.TRANS_SINE)
				tween.tween_property(CURRENTCHANNEL, "position", Vector2(POSTOGO, CURRENTCHANNEL.position.y), 0.2)
				CURRENTCHANNEL.CurrentCard -= 1
				await get_tree().create_timer(0.23).timeout
				if not CURRENTCHANNEL.position.x == CURRENTCHANNEL.positionthethingisactuallysupposedtobeat:
					CURRENTCHANNEL.position.x = CURRENTCHANNEL.positionthethingisactuallysupposedtobeat
		elif Input.is_action_just_released("up"):
			if Cooldown == false:
				if CHANNELNUM == NumberOfChannels:
					$HomeDash/CardController/AnimationPlayer.play("ChangeCard")
					await get_tree().create_timer(0.1).timeout
					CURRENTCHANNEL.hide()
					CHANNELNUM = 1
					CURRENTCHANNEL = get_node("HomeDash/CardController/" + str(CHANNELNUM))
					CardNum = CURRENTCHANNEL.get_child_count()
					CURRENTCHANNEL.show()
					UpdateChannelList()
				else:
					if CHANNELNUM == NumberOfChannels:
						pass
					else:
						$HomeDash/CardController/AnimationPlayer.play("ChangeCard")
						await get_tree().create_timer(0.1).timeout
						CURRENTCHANNEL.hide()
						CHANNELNUM += 1
						if CHANNELNUM == NumberOfChannels + 1:
							CHANNELNUM = 1
						CURRENTCHANNEL = get_node("HomeDash/CardController/" + str(CHANNELNUM))
						CardNum = CURRENTCHANNEL.get_child_count()
						CURRENTCHANNEL.show()
						UpdateChannelList()
				cooldown()
		elif Input.is_action_just_released("down"):
			if Cooldown == false:
				if CHANNELNUM == 1:
					$HomeDash/CardController/AnimationPlayer.play("ChangeCard")
					await get_tree().create_timer(0.1).timeout
					CURRENTCHANNEL.hide()
					CHANNELNUM = NumberOfChannels
					CURRENTCHANNEL = get_node("HomeDash/CardController/" + str(CHANNELNUM))
					CardNum = CURRENTCHANNEL.get_child_count()
					CURRENTCHANNEL.show()
					UpdateChannelList()
				else:
					if CHANNELNUM == 1:
						pass
					else:
						$HomeDash/CardController/AnimationPlayer.play("ChangeCard")
						await get_tree().create_timer(0.1).timeout
						CURRENTCHANNEL.hide()
						CHANNELNUM -= 1
						if CHANNELNUM == 0:
							CHANNELNUM = NumberOfChannels
						CURRENTCHANNEL = get_node("HomeDash/CardController/" + str(CHANNELNUM))
						CardNum = CURRENTCHANNEL.get_child_count()
						CURRENTCHANNEL.show()
						UpdateChannelList()
				cooldown()
		elif Input.is_action_just_released("A"):
			if CHANNELNUM == 1 and CURRENTCHANNEL.CurrentCard == 3:
				CurrentMenu = "INPUTLOCKED"
				#$MusicList.Reset()
				$HomeDash/AnimationPlayer.play("FadeOut")
				$MusicList/AnimationPlayer.play("FadeIn")
				$MusicList.show()
				await $HomeDash/AnimationPlayer.animation_finished
				CurrentMenu = "MusicList"
				$HomeDash.hide()
			elif CHANNELNUM == 1 and CURRENTCHANNEL.CurrentCard == 4:
				CurrentMenu = "INPUTLOCKED"
				$HomeDash/AnimationPlayer.play("FadeOut")
				$MyApps/AnimationPlayer.play("FadeIn")
				$MyApps.show()
				await $HomeDash/AnimationPlayer.animation_finished
				CurrentMenu = "MyApps"
				$HomeDash.hide()
			elif CHANNELNUM == 1 and CURRENTCHANNEL.CurrentCard == 2:
				CurrentMenu = "INPUTLOCKED"
				$HomeDash/AnimationPlayer.play("FadeOut")
				$MyGames/AnimationPlayer.play("FadeIn")
				$MyGames.show()
				await $HomeDash/AnimationPlayer.animation_finished
				CurrentMenu = "MyGames-Recent"
				$HomeDash.hide()
			elif CHANNELNUM == 1 and CURRENTCHANNEL.CurrentCard == 5:
				CurrentMenu = "INPUTLOCKED"
				$HomeDash/AnimationPlayer.play("FadeOut")
				$SystemSettings/AnimationPlayer.play("FadeIn")
				$SystemSettings.show()
				$SystemSettings.Reset()
				await $HomeDash/AnimationPlayer.animation_finished
				CurrentMenu = "SystemSettings"
				$HomeDash.hide()
		elif Input.is_action_just_released("B"):
			if $MusicPlayer.SongPlaying == true:
				CurrentMenu = "INPUTLOCKED"
				$HomeDash/AnimationPlayer.play("FadeOut")
				$MusicPlayer/AnimationPlayer.play("FadeIn")
				$MusicPlayer.show()
				await $HomeDash/AnimationPlayer.animation_finished
				CurrentMenu = "MusicPlayer"
				$HomeDash.hide()

func UpdateChannelList():
	$HomeDash/ChannelMenu/VBoxContainer/CURchannel.text = ChannelNames[str(CHANNELNUM)]
	if ChannelNames.has(str(CHANNELNUM + 1)):
		$HomeDash/ChannelMenu/VBoxContainer/Channel2.show()
		$HomeDash/ChannelMenu/VBoxContainer/Channel2.text = ChannelNames[str(CHANNELNUM + 1)]
	else:
		$HomeDash/ChannelMenu/VBoxContainer/Channel2.hide()
	if ChannelNames.has(str(CHANNELNUM + 2)):
		$HomeDash/ChannelMenu/VBoxContainer/Channel3.show()
		$HomeDash/ChannelMenu/VBoxContainer/Channel3.text = ChannelNames[str(CHANNELNUM + 2)]
	else:
		$HomeDash/ChannelMenu/VBoxContainer/Channel3.hide()
	if ChannelNames.has(str(CHANNELNUM + 3)):
		$HomeDash/ChannelMenu/VBoxContainer/Channel4.show()
		$HomeDash/ChannelMenu/VBoxContainer/Channel4.text = ChannelNames[str(CHANNELNUM + 3)]
	else:
		$HomeDash/ChannelMenu/VBoxContainer/Channel4.hide()
	if ChannelNames.has(str(CHANNELNUM + 4)):
		$HomeDash/ChannelMenu/VBoxContainer/Channel5.show()
		$HomeDash/ChannelMenu/VBoxContainer/Channel5.text = ChannelNames[str(CHANNELNUM + 4)]
	else:
		$HomeDash/ChannelMenu/VBoxContainer/Channel5.hide()
	if ChannelNames.has(str(CHANNELNUM + 5)):
		$HomeDash/ChannelMenu/VBoxContainer/Channel6.show()
		$HomeDash/ChannelMenu/VBoxContainer/Channel6.text = ChannelNames[str(CHANNELNUM + 5)]
	else:
		$HomeDash/ChannelMenu/VBoxContainer/Channel6.hide()
	if ChannelNames.has(str(CHANNELNUM + 6)):
		$HomeDash/ChannelMenu/VBoxContainer/Channel7.show()
		$HomeDash/ChannelMenu/VBoxContainer/Channel7.text = ChannelNames[str(CHANNELNUM + 6)]
	else:
		$HomeDash/ChannelMenu/VBoxContainer/Channel7.hide()
	if ChannelNames.has(str(CHANNELNUM + 7)):
		$HomeDash/ChannelMenu/VBoxContainer/Channel8.show()
		$HomeDash/ChannelMenu/VBoxContainer/Channel8.text = ChannelNames[str(CHANNELNUM + 7)]
	else:
		$HomeDash/ChannelMenu/VBoxContainer/Channel8.hide()

func cooldown():
	Cooldown = true
	#await get_tree().create_timer(0.1).timeout
	Cooldown = false
