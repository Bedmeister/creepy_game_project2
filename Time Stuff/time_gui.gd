extends Control

@onready var day_label : Label = $DayControle/days




func _on_time_system_updated(date_time: DateTime)-> void:
	day_label.text = str(date_time.days)
