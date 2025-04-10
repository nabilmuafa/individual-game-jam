extends CanvasLayer


func _enter_tree() -> void:
	if GameManager.game_started:
		queue_free()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_link_button_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	GameManager.game_started = true
	if anim_name == "fade_out":
		queue_free()
