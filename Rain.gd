extends CanvasLayer

@onready var anim = $AnimationPlayer
@onready var timer = $Timer
@onready var thunderAudio = $AudioStreamPlayerThunder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("called 1")
	var nextWaitTime = randi() % 15 + 10
	print(nextWaitTime)
	timer.set_wait_time(nextWaitTime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func _on_timer_timeout() -> void:
	thunder_strike()
	
func thunder_strike():
	var nextWaitTime = randi() % 15 + 10
	thunderAudio.play()
	anim.play("thunderStrike")
	timer.set_wait_time(nextWaitTime)
