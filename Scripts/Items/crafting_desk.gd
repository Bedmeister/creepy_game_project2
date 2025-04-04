extends StaticBody2D

@export var crafting_menu: NodePath
var player_near = false

func _ready():
	if crafting_menu:
		get_node(crafting_menu).visible = false

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		toggle_crafting_menu()

func toggle_crafting_menu():
	var menu = get_node(crafting_menu)
	menu.visible = !menu.visible

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_near = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		var menu = get_node(crafting_menu)
		player_near = false
		menu.visible = false
