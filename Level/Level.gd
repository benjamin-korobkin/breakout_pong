extends Node

var playerScore = 0
var player_lives = 5
var opponentScore = 0
var opponent_lives = 5
const WINDOW_HEIGHT = 800
const WINDOW_WIDTH = 640


func _ready() -> void:
	reset_ball()

func _on_BorderTop_body_entered(body: KinematicBody2D):
	playerScore += 50
	opponent_lives -= 1
	if opponent_lives == 0:
		player_won()
	else:
		reset_ball()
	
	
func _on_BorderBottom_body_entered(body: KinematicBody2D):
	opponentScore += 50
	player_lives -= 1
	if player_lives == 0:
		player_lost()
	else:
		reset_ball()
	
func _process(delta):
	$PlayerScore.text = "You: " + str(playerScore)
	$OpponentScore.text = "AI: " + str(opponentScore)
	$CountdownLabel.text = str(ceil($CountdownTimer.time_left))
	# End level when all bricks destroyed
	if get_tree().get_nodes_in_group("BrickGroup").empty():
		determine_winner()
		

# TODO: Change name
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
		
func determine_winner():
	if playerScore >= opponentScore:
		player_won()
	else:
		player_lost()
	
func player_won():
	var next_level = "res://Level/Level_" + str(int(get_tree().current_scene.name)+1)
	next_level += ".tscn"
	if get_tree().change_scene(next_level):
		print(next_level)
		# if change_scene returns anything besides OK (0), it means we beat the last level
		get_tree().change_scene("res://Menu/GameWonMenu.tscn")
	
func player_lost():
	get_tree().call_group('BallGroup', 'stop_ball')
	var go_screen = load("res://Menu/GameOverMenu.tscn").instance()
	get_tree().current_scene.add_child(go_screen)
