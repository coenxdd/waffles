extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NetworkRequests/NetworkTest.request("https://example.com")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func GetInsider():
	$NetworkRequests/GetInsider.request("https://xbl.toonix.ink/insidexb/pull.json")

func _on_insider_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json1 = JSON.parse_string(body.get_string_from_utf8())
	var ads = int(json1["Ads"])
	print(ads)
	var loopcount = 1
	for I in range(0,ads):
		var ad = json1["ad" + str(loopcount)]
		var thing = preload("res://Scenes/adcard.tscn").instantiate()
		$"CardController/4".add_child(thing)
		await get_tree().create_timer(0.001).timeout
		
		$"CardController/4/ADCARD".Title = ad["Title"]
		$"CardController/4/ADCARD".Subtitle = ad["Subtitle"]
		$"CardController/4/ADCARD".BarEnabled = ad["BarEnabled"]
		$"CardController/4/ADCARD".BarOrangeThing = ad["BarOrangeThing"]
		$"CardController/4/ADCARD".BarText = ad["BarText"]
		
		$"NetworkRequests/GetInsider/Insider-GetAdImage".request(ad["ImageBG"])
		await $"NetworkRequests/GetInsider/Insider-GetAdImage".request_completed
		$"CardController/4/ADCARD".Update()
		$"CardController/4/ADCARD".name = str(loopcount)
		loopcount += 1

func insider_get_ad_image_rc(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var image = Image.new()
	if _headers.has("Content-Type: image/png"):
		image.load_png_from_buffer(body)
	elif _headers.has("Content-Type: image/jpeg"):
		image.load_jpg_from_buffer(body)
	var texture=ImageTexture.create_from_image(image)
	$"CardController/4/ADCARD".ImageBG = texture


func GetSpotlight():
	$NetworkRequests/GetSpotlight.request("https://xbl.toonix.ink/spotlight/pull.json")

func _on_spotlight_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json1 = JSON.parse_string(body.get_string_from_utf8())
	var ads = int(json1["Ads"])
	print(ads)
	var loopcount = 1
	for I in range(0,ads):
		var ad = json1["ad" + str(loopcount)]
		var thing = preload("res://Scenes/adcard.tscn").instantiate()
		$"CardController/8".add_child(thing)
		await get_tree().create_timer(0.001).timeout
		
		$"CardController/8/ADCARD".Title = ad["Title"]
		$"CardController/8/ADCARD".Subtitle = ad["Subtitle"]
		$"CardController/8/ADCARD".BarEnabled = ad["BarEnabled"]
		$"CardController/8/ADCARD".BarOrangeThing = ad["BarOrangeThing"]
		$"CardController/8/ADCARD".BarText = ad["BarText"]
		
		$"NetworkRequests/GetSpotlight/Spotlight-GetAdImage".request(ad["ImageBG"])
		await $"NetworkRequests/GetSpotlight/Spotlight-GetAdImage".request_completed
		$"CardController/8/ADCARD".Update()
		$"CardController/8/ADCARD".name = str(loopcount)
		loopcount += 1

func spotlight_get_ad_image_rc(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var image = Image.new()
	if _headers.has("Content-Type: image/png"):
		image.load_png_from_buffer(body)
	elif _headers.has("Content-Type: image/jpeg"):
		image.load_jpg_from_buffer(body)
	var texture=ImageTexture.create_from_image(image)
	$"CardController/8/ADCARD".ImageBG = texture


func GetEvents():
	$NetworkRequests/GetEvents.request("https://xbl.toonix.ink/event/pull.json")

func _on_event_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json1 = JSON.parse_string(body.get_string_from_utf8())
	var ads = int(json1["Ads"])
	print(ads)
	var loopcount = 1
	for I in range(0,ads):
		var ad = json1["ad" + str(loopcount)]
		var thing = preload("res://Scenes/adcard.tscn").instantiate()
		$"CardController/7".add_child(thing)
		await get_tree().create_timer(0.001).timeout
		
		$"CardController/7/ADCARD".Title = ad["Title"]
		$"CardController/7/ADCARD".Subtitle = ad["Subtitle"]
		$"CardController/7/ADCARD".BarEnabled = ad["BarEnabled"]
		$"CardController/7/ADCARD".BarOrangeThing = ad["BarOrangeThing"]
		$"CardController/7/ADCARD".BarText = ad["BarText"]
		
		$"NetworkRequests/GetEvents/Events-GetAdImage".request(ad["ImageBG"])
		await $"NetworkRequests/GetEvents/Events-GetAdImage".request_completed
		$"CardController/7/ADCARD".Update()
		$"CardController/7/ADCARD".name = str(loopcount)
		loopcount += 1

func event_get_ad_image_rc(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var image = Image.new()
	if _headers.has("Content-Type: image/png"):
		image.load_png_from_buffer(body)
	elif _headers.has("Content-Type: image/jpeg"):
		image.load_jpg_from_buffer(body)
	var texture=ImageTexture.create_from_image(image)
	$"CardController/7/ADCARD".ImageBG = texture


func GetMedia():
	$NetworkRequests/GetMedia.request("https://xbl.toonix.ink/video/pull.json")

func _on_media_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json1 = JSON.parse_string(body.get_string_from_utf8())
	var ads = int(json1["Ads"])
	print(ads)
	var loopcount = 1
	for I in range(0,ads):
		var ad = json1["ad" + str(loopcount)]
		var thing = preload("res://Scenes/adcard.tscn").instantiate()
		$"CardController/6".add_child(thing)
		await get_tree().create_timer(0.001).timeout
		
		$"CardController/6/ADCARD".Title = ad["Title"]
		$"CardController/6/ADCARD".Subtitle = ad["Subtitle"]
		$"CardController/6/ADCARD".BarEnabled = ad["BarEnabled"]
		$"CardController/6/ADCARD".BarOrangeThing = ad["BarOrangeThing"]
		$"CardController/6/ADCARD".BarText = ad["BarText"]
		
		$"NetworkRequests/GetMedia/Media-GetAdImage".request(ad["ImageBG"])
		await $"NetworkRequests/GetMedia/Media-GetAdImage".request_completed
		$"CardController/6/ADCARD".Update()
		$"CardController/6/ADCARD".name = str(loopcount)
		loopcount += 1

func media_get_ad_image_rc(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var image = Image.new()
	if _headers.has("Content-Type: image/png"):
		image.load_png_from_buffer(body)
	elif _headers.has("Content-Type: image/jpeg"):
		image.load_jpg_from_buffer(body)
	var texture=ImageTexture.create_from_image(image)
	$"CardController/6/ADCARD".ImageBG = texture


func _on_network_test_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	if _result == 0:
		$"..".HasInternet = true
		var texture = load("res://Assets/systemsettings/network_64x.png")
		$"CardController/1/5/Container/Network".texture = texture
		GetInsider()
		GetSpotlight()
		GetEvents()
		GetMedia()
	else:
		$"..".HasInternet = false
		var texture = load("res://Assets/systemsettings/connection_lost.png")
		$"CardController/1/5/Container/Network".texture = texture
