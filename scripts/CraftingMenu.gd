extends TextureRect

signal craft_pickaxe
signal craft_club
signal craft_sword

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickaxe_craft_button_pressed() -> void:
	emit_signal("craft_pickaxe")


func _on_club_craft_button_pressed() -> void:
	emit_signal("craft_club")


func _on_sword_craft_button_pressed() -> void:
	emit_signal("craft_sword")
