extends Node

const INVENTORY_SLOTS = 24
const InventorySlot = preload("res://scripts/InventorySlot.gd")
const ItemClass = preload("res://scripts/inventory_item.gd")

var inventory = {
}

var hotbar = {
	0: ["Stick", 1]
}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item])
				item_quantity = item_quantity - able_to_add
			
	for i in range(INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i])
			return
			
func update_slot_visual(slot_index, item_data):
	var item_name = item_data[0]
	var item_quantity = item_data[1]
	var slot = get_tree().root.get_node("/root/world/InventoryLayer/Inventory/GridContainer/Panel" + str(slot_index + 1))
	if slot.item:
		slot.item.set_item(item_name, item_quantity, JsonData.item_data[item_name]["ItemTexture"])
	else:
		slot.initialize_item(item_name, item_quantity, JsonData.item_data[item_name]["ItemTexture"])

func remove_item(slot: InventorySlot):
	inventory.erase(slot.slot_index)
			
func add_item_to_empty_slot(item: ItemClass, slot: InventorySlot):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]
	
func add_item_quantity(slot: InventorySlot, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
