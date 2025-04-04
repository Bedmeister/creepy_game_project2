extends Area2D

@export var item_name: String = "default"
@export var max_stack: int = 10
#@export var quantity: int = 1

signal item_collected

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		var added = body.collect_item(item_name, max_stack)
		if added:
			emit_signal("item_collected", self)
			queue_free()
		else:
			pass
			#print("inventory full or stack limit reached")
