extends Control

@onready var craft_board_button = $VBoxContainer/HBoxContainer/WeaponButton
@onready var craft_candle_button = $VBoxContainer/HBoxContainer2/CandleButton
@onready var close_button = $VBoxContainer/Close
@onready var inventory = get_tree().get_first_node_in_group("inventory")

func _ready():

	inventory.inventory_updated.connect(update_crafting_buttons)
	update_crafting_buttons(inventory.inventory)

func update_crafting_buttons(inventory_data):
	var can_craft_board = inventory_data.get("Wood", {}).get("count", 0) >= 3 and inventory_data.get("Nails", {}).get("count", 0) >= 2
	var can_craft_candle = inventory_data.get("Wax", {}).get("count", 0) >= 3
	
	craft_board_button.disabled = not can_craft_board
	craft_candle_button.disabled = not can_craft_candle
	
	craft_board_button.modulate = Color(1, 1, 1, 0.5) if craft_board_button.disabled else Color(1, 1, 1, 1)
	craft_candle_button.modulate = Color(1, 1, 1, 0.5) if craft_candle_button.disabled else Color(1, 1, 1, 1)

func craft_board_and_nails():
	if inventory.add_item("Weapon", 1):
		inventory.inventory["Wood"]["count"] -= 3
		inventory.inventory["Nails"]["count"] -= 2
		inventory.inventory_updated.emit(inventory.inventory)

func craft_candle():
	if inventory.add_item("Candle", 3):
		inventory.inventory["Wax"]["count"] -= 3
		inventory.inventory_updated.emit(inventory.inventory)
		
func close_menu():
	visible = false

func _on_weapon_button_pressed() -> void:
	craft_board_and_nails()

func _on_candle_button_pressed() -> void:
	craft_candle()

func _on_close_pressed() -> void:
	print("close button")
	close_menu()
