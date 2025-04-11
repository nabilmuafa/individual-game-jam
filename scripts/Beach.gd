extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.takenID.has(4):
		if GameManager.takenID[4] == 0:
			$DialogueGate.queue_free()
	$Player.position.y = GameManager.y_pos
	$Player.position.x = GameManager.x_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_next_scene_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.y_pos = body.position.y
		GameManager.x_pos = -160.0
		GameManager.last_dir = "e"
		call_deferred("change_scene")

		
func change_scene():
	get_tree().change_scene_to_file("res://scenes/OuterForest.tscn")


func _on_is_stick_taken_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if GameManager.takenID[4] != 0:
			GameManager.show_dialogue("no_weapon_beach")
		else:
			$DialogueGate/StaticBody2D.queue_free()
