extends Node

const MAX_SLOTS = 3
var inventory: Dictionary = {}

signal inventory_updated(inventory)

func add_item(item_name: String, max_stack: int) -> bool:
	if item_name == "Weapon":
		if "Weapon" in inventory:
			return false
		else:
			inventory["Weapon"] = {"count": 1, "max": 1}
			emit_signal("inventory_updated", inventory)
			return true
	elif item_name == "Candle":
		if "Candle" in inventory:
			if inventory["Candle"]["count"] < 3:
				inventory["Candle"]["count"] += 1
				emit_signal("inventory_updated", inventory)
				return true
			else:
				return false
		else:
			inventory["Candle"] = {"count": 1, "max": 3}
			emit_signal("inventory_updated", inventory)
			return true
			
	elif item_name in inventory:
		if inventory[item_name]["count"] < inventory[item_name]["max"]:
			inventory[item_name]["count"] += 1
			emit_signal("inventory_updated", inventory)
		else:
			return false
	elif inventory.size() < MAX_SLOTS:
		inventory[item_name] = {"count": 1, "max": max_stack}
		emit_signal("inventory_updated", inventory)
	else:
		return false

	emit_signal("inventory_updated", inventory)
	return true 
	
func has_item(item_name: String) -> bool:
	return item_name in inventory and inventory[item_name]["count"] > 0
