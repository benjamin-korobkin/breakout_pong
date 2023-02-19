extends KinematicBody2D

export var speed: int = 400


func _physics_process(_delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	velocity = velocity.normalized() * speed
	
	move_and_slide(velocity)
