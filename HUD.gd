extends CanvasLayer
signal start_game
signal infinite_mode
var spd = 0
var highest_spd = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$speed_label.hide()
	$score_label.hide()
	highest_spd = spd

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if 0 :
		$speed_label.text = "Highest speed : "+str(highest_spd)
		$score_label.text = str($"..".score)
		return
	spd = $"../player".velocity.x/100
	if spd > 1 :
		spd = int(spd)
	highest_spd = max(spd, highest_spd)
	$speed_label.text = "Current speed : "+str(spd)
	$score_label.text = str($"..".score)
	
func countdown():
	for i in range(3):
		show_message(str(3-i))
		await get_tree().create_timer(0.5).timeout
	$Message.hide()

func show_speed():
	$speed_label.show()
	
func show_score():
	
	$score_label.show()
	
func show_message(text):
	$Message.text = text
	$Message.show()

func show_game_over():
	show_message("Game over")
	$Start_button.text = "restart?"
	$Start_button.show()
	$Start_inf_button.show()

func _on_start_button_pressed():
	$Start_button.hide()
	$Start_inf_button.hide()
	$Message.hide()
	start_game.emit()


func _on_start_inf_button_toggled(button_pressed):
	infinite_mode.emit()
