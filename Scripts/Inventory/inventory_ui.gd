extends Control

@onready var slots = [$HBoxContainer/Slot1, $HBoxContainer/Slot2, $HBoxContainer/Slot3, $HBoxContainer/Weapon, $HBoxContainer/Candles]

@onready var inventory = $"../../Inventory"

var item_icons = {
	"Wood": preload("res://Assets/Items/Inventory/wood/wood_filled.png"),
	"Nails": preload("res://Assets/Items/Inventory/nails/nails_filled.png"),
	"Wax": preload("res://Assets/Items/Inventory/wax/wax_filled.png"),
	"Weapon": preload("res://Assets/Items/Inventory/Board_n_Nails/board&nails_filled.png"),
	"Candle": preload("res://Assets/Items/Inventory/candle/candle_filled.png")
}

func _ready():
	inventory.inventory_updated.connect(update_inventory_ui)

func update_inventory_ui(inventory):
	var item_keys = inventory.keys().filter(func(key): return key != "Weapon" and key != "Candle")
	
	for i in range(3): 
		if i < item_keys.size(): 
			var item_name = item_keys[i]
			var icon_node = slots[i].get_node_or_null("TextureRect") 
			var count_node = slots[i].get_node_or_null("Label")
			
			if inventory[item_name]["count"] > 0:
				
				if icon_node:
					icon_node.texture = item_icons.get(item_name, null)
					
				if count_node:
					count_node.text = str(inventory[item_name]["count"])
			else:
				clear_slot(i)

	var weapon_node = slots[3].get_node_or_null("TextureRect")
	var weapon_count_node = slots[3].get_node_or_null("Label")
	if "Weapon" in inventory and inventory["Weapon"]["count"] > 0:
		if weapon_node:
			weapon_node.texture = item_icons.get("Weapon", null)
		if weapon_count_node:
			weapon_count_node.text = str(inventory["Weapon"]["count"])
	else:
		clear_slot(3)
	
	var candle_node = slots[4].get_node_or_null("TextureRect")
	var candle_count_node = slots[4].get_node_or_null("Label")
	if "Candle" in inventory and inventory["Candle"]["count"] > 0:
		if candle_node:
			candle_node.texture = item_icons.get("Candle", null)
			if candle_count_node:
				candle_count_node.text = str(inventory["Candle"]["count"])
	else:
		clear_slot(4)

func clear_slot(slot_index: int):
	var icon_node = slots[slot_index].get_node_or_null("TextureRect")
	var count_node = slots[slot_index].get_node_or_null("Label")
	
	if icon_node:
		icon_node.texture = null
		
	if count_node:
		count_node.text = ""
	

func _on_give_weapon_pressed() -> void:
	inventory.add_item("Weapon", 1)

func _on_max_items_pressed() -> void:
	while inventory.add_item("Wood", 10): pass
	while inventory.add_item("Nails", 10): pass
	while inventory.add_item("Wax", 10): pass
	while inventory.add_item("Candle", 3): pass

func _on_clear_inventory_pressed() -> void:
	inventory.clear_inventory()
