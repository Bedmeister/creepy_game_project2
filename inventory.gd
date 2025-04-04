extends Node

const MAX_SLOTS = 3
var inventory: Dictionary = {}

signal inventory_updated(inventory)

func add_item(item_name: String, max_stack: int) -> bool:
	if item_name == "Weapon":
		if "Weapon" in inventory:
			print("already have board and nails")
			return false
		else:
			inventory["Weapon"] = {"count": 1, "max": 1}
			emit_signal("inventory_updated", inventory)
			print("board and nails added")
			return true
	elif item_name == "Candle":
		if "Candle" in inventory:
			if inventory["Candle"]["count"] < 3:
				inventory["Candle"]["count"] += 1
				emit_signal("inventory_updated", inventory)
				print("added candle")
				return true
			else:
				print("max candle")
				return false
		else:
			inventory["Candle"] = {"count": 1, "max": 3}
			emit_signal("inventory_updated", inventory)
			print("candle added")
			return true
			
	elif item_name in inventory:
		if inventory[item_name]["count"] < inventory[item_name]["max"]:
			inventory[item_name]["count"] += 1  # Stack the item
			emit_signal("inventory_updated", inventory)
		else:
			#print("cannot add, stack limit reached")
			return false
	elif inventory.size() < MAX_SLOTS:
		inventory[item_name] = {"count": 1, "max": max_stack} # Add new item if a slot is available
		emit_signal("inventory_updated", inventory)
	else:
		#print("Inventory full! Can't pick up ", item_name)
		return false  # Return false if inventory is full

	emit_signal("inventory_updated", inventory)  # Update UI if needed
	#print("Picked up: ", item_name, " | Inventory: ", inventory)
	return true 
