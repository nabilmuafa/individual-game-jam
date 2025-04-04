extends Control

const InventorySlot = preload("res://scripts/InventorySlot.gd")

@onready var hotbar_slots = $GridContainerHotbar
@onready var inventory_slots = $GridContainerInventory

var holding_item: Node = null

func _ready():
	var slots = hotbar_slots.get_children() + inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].mouse_filter = Control.MOUSE_FILTER_PASS
		slots[i].gui_input.connect(_on_slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
		slots[i].slot_type = InventorySlot.SlotType.INVENTORY
	initialize_inventory()

func initialize_inventory():
	var slots = hotbar_slots.get_children() + inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(
				PlayerInventory.inventory[i][0],
				PlayerInventory.inventory[i][1], 
				JsonData.item_data[PlayerInventory.inventory[i][0]]["ItemTexture"]
				)

func _on_slot_gui_input(event: InputEvent, slot: InventorySlot):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if holding_item:
			if !slot.item:
				left_click_empty_slot(slot)
			else:
				if holding_item.item_name != slot.item.item_name:
					left_click_occupied_diff_item(slot, event)
				else:
					left_click_occupied_same_item(slot)
					
		else:
			if slot.item:
				PlayerInventory.remove_item(slot)
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()

func left_click_empty_slot(slot: InventorySlot):
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	slot.putToSlot(holding_item)
	holding_item = null
	
func left_click_occupied_diff_item(slot: InventorySlot, event: InputEventMouseButton):
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putToSlot(holding_item)
	holding_item = temp_item
	
func left_click_occupied_same_item(slot: InventorySlot):
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= holding_item.item_quantity:
		PlayerInventory.add_item_quantity(slot, holding_item.item_quantity)
		slot.item.add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free()
		holding_item = null
	else:
		PlayerInventory.add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add)
		holding_item.decrease_item_quantity(able_to_add)

func _process(_delta):
	if holding_item:
		holding_item.set_global_position(get_global_mouse_position())
		holding_item.release_focus()
