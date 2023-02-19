extends StaticBody2D

onready var animatedSprite = get_node("Sprite")
onready var frames = animatedSprite.frames

var health 
var points

func _ready() -> void:
	health = frames.get_frame_count("default")


func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
		

func got_hit(ball: KinematicBody2D):
	get_parent().update_score(ball, points)
	if animatedSprite.frame + 1 < frames.get_frame_count("default"):
		animatedSprite.frame += 1
	health -= 1
	

