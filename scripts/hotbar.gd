extends Control

const InventorySlot = preload("res://scripts/InventorySlot.gd")

@onready var hotbar = $HotbarSlots
@onready var slots = hotbar.get_children()

func _ready():
	PlayerInventory.hotbar_updated.connect(sync_hotbar)
	for i in range(slots.size()):
		PlayerInventory.active_item_updated.connect(slots[i].refresh_style)
		slots[i].slot_index = i
		slots[i].slot_type = InventorySlot.SlotType.HOTBAR
	initialize_hotbar()
	
func initialize_hotbar():
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(
				PlayerInventory.inventory[i][0],
				PlayerInventory.inventory[i][1],
				JsonData.item_data[PlayerInventory.inventory[i][0]]["ItemTexture"]
				)
				
func sync_hotbar():
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			if slots[i].item:
				slots[i].removeFromSlotNoRefresh()
			slots[i].initialize_item(
				PlayerInventory.inventory[i][0],
				PlayerInventory.inventory[i][1],
				JsonData.item_data[PlayerInventory.inventory[i][0]]["ItemTexture"]
				)
		else:
			if slots[i].item:
				slots[i].removeFromSlot()
			
