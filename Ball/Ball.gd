extends KinematicBody2D

export var ball_speed: int = 350
var speed
var velocity = Vector2.ZERO

func _ready():
	randomize()
	launch_ball()

func _physics_process(delta: float) -> void:
	var collision_object = move_and_collide(velocity * speed * delta)
	# Next, try this https://github.com/alexrintt/pong
	if collision_object:
		var collider = collision_object.get_collider()
		var normal = collision_object.normal
		#normal = fix_normal(normal)
		var normals = [-1,0,1]
		if not (normal.x in normals and normal.y in normals):
			if collider.is_in_group("Paddle"):
				velocity.x = -velocity.x
			
		var reflect = collision_object.remainder.bounce(normal)
		velocity = velocity.bounce(normal)
		move_and_collide(reflect)
		if collider.is_in_group("BrickGroup"):
			collider.got_hit(self)
		

func launch_ball():
	speed = ball_speed
	velocity.y = [-1,1][randi() % 2]
	velocity.x = [-0.7,0.7][randi() % 2]

func stop_ball():
	speed = 0

