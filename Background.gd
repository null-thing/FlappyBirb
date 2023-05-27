extends ParallaxBackground
var bg_sprite
var sun_timer
var col
var is_dawn = 0
var is_night = 0
const TWEEN_TIME = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_sprite = get_node("39")
	sun_timer = get_node("../sun_timer")
	sun_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func background_gradation(is_night, col):
	var tween =get_tree().create_tween()
	if is_night:
		tween.tween_property($"./39", "modulate", Color(0.4914, 0.3655, 0.3999, 1), TWEEN_TIME/2)
		await get_tree().create_timer(TWEEN_TIME/2).timeout
		tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property($"./39", "modulate", Color(0,0,0.1,1), TWEEN_TIME/2)
	else: 
		tween.tween_property($"./39", "modulate", Color(0.4914, 0.3655, 0.3999, 1), TWEEN_TIME/2)
		await get_tree().create_timer(TWEEN_TIME/2).timeout
		tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property($"./39", "modulate", Color(1,1,1,1), TWEEN_TIME/2)
	await get_tree().create_timer(TWEEN_TIME/2).timeout
	tween.kill()
	sun_timer.start()
		
func _on_sun_timer_timeout():
	if is_night:
		is_night = 0
	else:
		is_night = 1
	sun_timer.stop()
	background_gradation(is_night, col)
