extends Control

@onready var slots = [$HBoxContainer/Slot1, $HBoxContainer/Slot2, $HBoxContainer/Slot3]

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
	var item_keys = inventory.keys()
	
	for i in range(3): 
		if i < item_keys.size(): 
			var item_name = item_keys[i]
			var icon_node = slots[i].get_node_or_null("TextureRect") 
			var count_node = slots[i].get_node_or_null("Label")
			
			if icon_node:
				icon_node.texture = item_icons.get(item_name, null)
				
			if count_node:
				count_node.text = str(inventory[item_name]["count"])
		else:
			var icon_node = slots[i].get_node_or_null("TextureRect")
			var count_node = slots[i].get_node_or_null("Label")
			
			if icon_node:
				icon_node.texture = null
				
			if count_node:
				count_node.text = ""
