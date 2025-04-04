class_name DateTime extends Resource

@export_range(0, 59) var seconds: int = 0
@export_range(0, 59) var minutes: int = 0
@export_range(0, 23) var hours: int = 0
@export var days: int = 0

var delta_time: float = 0

func increase_by_sec(delta_seconds: float) -> void:
	delta_time += delta_seconds
	if delta_time < 1:
		return
	
	var delta_int_secs: int = int(delta_time)  # Ensure conversion to int
	delta_time -= delta_int_secs

	
	seconds += delta_int_secs
	minutes += int(seconds / 60)  
	hours += int(minutes / 60)  
	days += int(hours / 24)  

	# Ensure values wrap correctly
	seconds = seconds % 60
	minutes = minutes % 60
	hours = hours % 24

	# Debug output
	print_debug(str(days) + ":" + str(hours) + ":" + str(minutes) + "+" + str(seconds))

func diff_without_days(other_time: DateTime) -> int:
	var diff_hours = hours -other_time.hours
	var diff_minutes = minutes - other_time.minutes + diff_hours * 60
	var diff_seconds = seconds - other_time.seconds + diff_minutes * 60
	
	return diff_seconds
