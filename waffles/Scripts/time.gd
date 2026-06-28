extends Node

var time = Time.get_datetime_dict_from_system()
var nameweekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
var namemonth = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var dayofweek = time["weekday"]
var day = time["day"]
var month = time["month"]
var year = time["year"]
var hour = time["hour"]
var minute= time["minute"]
var second= time["second"]
var meridian

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = Time.get_datetime_dict_from_system()
	hour = time["hour"]
	minute= time["minute"]
	second= time["second"]
	if hour - 12 < 0:
		meridian = "AM"
	else:
		meridian = "PM"
	if meridian == "PM":
		$".".text = str(month) + "/" + str(day) + " " + str(hour - 12) + ":" + str("%02d" % [minute] + " " + meridian)
	else:
		$".".text = str(month) + "/" + str(day) + " " + str(hour) + ":" + str("%02d" % [minute] + " " + meridian)
