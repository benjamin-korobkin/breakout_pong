extends KinematicBody2D

export var speed: int = 700
var plyrBall
var aiBall

func _ready() -> void:
	plyrBall = get_parent().find_node("BallPlayer")
	aiBall = get_parent().find_node("BallOpponent")
	
func _physics_process(_delta: float) -> void:
	move_and_slide(Vector2(get_direction(), 0) * speed)
	
func get_direction():
	var ball
	if plyrBall.position.y < aiBall.position.y:
		ball = plyrBall
	else:
		ball = aiBall
	if abs(ball.position.x - position.x) > 20:
		if ball.position.x > position.x: return 1
		else: return -1
	else: return 0
