extends Node2D
var score:= 0

func _ready() -> void:
	for coin in $Collectibles/Coins.get_children():
		coin.collected.connect(_on_coin_collected)
	$player.health_changed.connect(_on_health_changed)
	
func _on_coin_collected() -> void:
	score += 1
	print("Score: ",score) 
	$UI/ScoreLabel.text = "Score: " + str(score)
	
func _on_health_changed(health):
	$UI/HealthLabel.text= "Health: " + str(health) 


func _on_finish_area_game_finished() -> void:
	$UI/EndPanel.show()
	$UI/EndPanel/CenterContainer/VBoxContainer/FinalScoreLabel.text = "Score: " + str(score)


func _on_player_player_died() -> void:
	$UI/EndPanel/CenterContainer/VBoxContainer/EndLabel.text = "Game Over"
	$UI/EndPanel/CenterContainer/VBoxContainer/FinalScoreLabel.text = "Score: " + str(score)
	$UI/EndPanel/CenterContainer/VBoxContainer/RestartButton.text="TRY AGAIN"
	$UI/EndPanel.show()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
