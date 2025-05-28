extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_label():
	var stoneAmount = 0
	var woodAmount = 0
	var crystalAmount = 0
	
	for item in PlayerInventory.inventory:
		if PlayerInventory.inventory[item][0] == "Wood":
			woodAmount += PlayerInventory.inventory[item][1]
		if PlayerInventory.inventory[item][0] == "Stone":
			stoneAmount += PlayerInventory.inventory[item][1]
		if PlayerInventory.inventory[item][0] == "Crystal":
			crystalAmount += PlayerInventory.inventory[item][1]
	$GridContainer/ItemDisplay/Label.text = "%d/80" % woodAmount
	$GridContainer/ItemDisplay2/Label.text = "%d/12" % stoneAmount
	$GridContainer/ItemDisplay3/Label.text = "%d/24" % crystalAmount
