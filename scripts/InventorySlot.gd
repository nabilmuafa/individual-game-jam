extends Panel

var default_tex = preload("res://assets/Custom Assets/HotbarSlotEmpty.png")
var occupied_tex = preload("res://assets/Custom Assets/HotbarSlotOccupied.png")

var default_style: StyleBoxTexture
var occupied_style: StyleBoxTexture

var ItemClass = preload("res://scenes/inventory/inventory_item.tscn")
var item = null
var slot_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_style = StyleBoxTexture.new()
	occupied_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	occupied_style.texture = occupied_tex
	
	refresh_style()

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	item = null
	refresh_style()
	
func putToSlot(new_item):
	item = new_item
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	item.position = Vector2(0, 0)  # Reset position to slot's top-left corner
	item.anchor_left = 0.2
	item.anchor_right = 0.2
	item.anchor_top = 0.2
	item.anchor_bottom = 0.2
	add_child(item)
	refresh_style()
	
func initialize_item(item_name, item_quantity, item_texture):
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_quantity, item_texture)
	else:
		item.set_item(item_name, item_quantity, item_texture)
	refresh_style()

func refresh_style():
	if item == null:
		set('theme_override_styles/panel', default_style)
	else:
		set('theme_override_styles/panel', occupied_style)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
