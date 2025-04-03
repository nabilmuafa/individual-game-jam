extends Control

var item_name
var item_quantity

func _ready() -> void:
	if randi() % 2 == 0:
		self.texture = load("res://assets/Ninja Adventure - Asset Pack/Items/Weapons/Stick/Sprite.png")
	else:
		self.texture = load("res://assets/Ninja Adventure - Asset Pack/Items/Weapons/Axe/Sprite.png")

func set_item(nm, qt, text):
	item_name = nm
	item_quantity = qt
	self.texture = load(text)
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)

func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)
	
func dec_item_quantity(amount_to_add):
	item_quantity -= amount_to_add
	$Label.text = String(item_quantity)
