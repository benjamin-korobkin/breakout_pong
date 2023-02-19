extends Node

var playerScore = 0
var opponentScore = 0
const WINDOW_HEIGHT = 800
const WINDOW_WIDTH = 640


func _ready() -> void:
	reset_ball()

func _on_BorderTop_body_entered(body: KinematicBody2D):
	var next_level = "res://Level/Level_" + str(int(get_tree().current_scene.name) + 1)
	next_level += ".tscn"
	if get_tree().change_scene(next_level):
		# if we get an error, it means we beat the last level
		 get_tree().change_scene("res://Menu/GameWonMenu.tscn")
	
func _on_BorderBottom_body_entered(body: KinematicBody2D):
	get_tree().change_scene("res://Menu/GameOverMenu.tscn")
	
	
func _process(delta):
	$PlayerScore.text = str(playerScore)
	$OpponentScore.text = str(opponentScore)
	$CountdownLabel.text = str(ceil($CountdownTimer.time_left))

func reset_ball():
	$Player.position.x = WINDOW_WIDTH/2
	$Opponent.position.x = WINDOW_WIDTH/2
	$BallPlayer.position = Vector2(WINDOW_WIDTH/2,740)
	$BallOpponent.position = Vector2(WINDOW_WIDTH/2,145)
	get_tree().call_group('BallGroup', 'stop_ball')
	$CountdownLabel.visible = true
	$CountdownTimer.start()
	
	
func _on_CountdownTimer_timeout():
	get_tree().call_group('BallGroup', 'launch_ball')
	$CountdownLabel.visible = false

func update_score(ball, points):
	if ball.name == "BallPlayer":
		playerScore += points
	elif ball.name == "BallOpponent":
		opponentScore += points
