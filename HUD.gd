extends CanvasLayer
signal start_game
var spd

# Called when the node enters the scene tree for the first time.
func _ready():
	$speed_label.hide()
	$score_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spd = $"../player".velocity.x/100
	if spd > 1 :
		spd = int(spd)
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

func _on_start_button_pressed():
	$Start_button.hide()
	$Message.hide()
	start_game.emit()
