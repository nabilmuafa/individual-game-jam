extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	$Player.position.y = GameManager.y_pos
	$Player.position.x = GameManager.x_pos
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_forest_scene_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.y_pos = body.position.y
		GameManager.x_pos = 616.0
		GameManager.last_dir = "w"
		call_deferred("change_scene_to_forest")

func change_scene_to_forest():
	get_tree().change_scene_to_file("res://scenes/OuterForest.tscn")
