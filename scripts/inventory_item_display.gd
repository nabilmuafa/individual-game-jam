extends Control

@export var item_quantity: int
@export var item_name: String

func _ready() -> void:
	$TextureRect.texture = load(JsonData.item_data[item_name]["ItemTexture"])
	$Label.text = str(item_quantity)
	
