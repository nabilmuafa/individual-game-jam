extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()
		
	if Input.is_action_just_released("scroll_up"):
		PlayerInventory.active_item_scroll_up()
	elif Input.is_action_just_released("scroll_down"):
		PlayerInventory.active_item_scroll_down()
