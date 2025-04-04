extends Node2D

@export var item_scenes: Array[PackedScene]
@export var spawn_areas: Array[Area2D]
@export var max_items: int = 10
@export var respawn_time: float = 5.0

var current_items = []

func _ready():
	for i in range(max_items):
		spawn_item()

func spawn_item():
	if item_scenes.is_empty() or spawn_areas.is_empty():
		return
		
	var item_scene = item_scenes[randi() % item_scenes.size()]
	var item = item_scene.instantiate()
	
	var shed_area = spawn_areas[randi() % spawn_areas.size()]
	
	var shape = shed_area.get_node("CollisionShape2D").shape
	var spawn_position = get_random_position_within_area(shed_area, shape)
	
	item.global_position = spawn_position
	
	item.connect("item_collected", Callable(self, "_on_item_collected"))
	add_child(item)
	current_items.append(item)
	
func get_random_position_within_area(area: Area2D, shape: Shape2D) -> Vector2:
	var local_position: Vector2
	if shape is RectangleShape2D:
		var rect = shape as RectangleShape2D
		local_position = Vector2(randf_range(-rect.extents.x, rect.extents.x), randf_range(-rect.extents.y, rect.extents.y))
	else:
		local_position = Vector2.ZERO
		
	return area.to_global(local_position)

func _on_item_collected(item):
	current_items.erase(item)
	item.queue_free()
	await get_tree().create_timer(respawn_time).timeout
	spawn_item()
