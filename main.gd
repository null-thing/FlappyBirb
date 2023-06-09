extends Node2D

var spawn_interval = 2 #second.
var obstacle_timer
var cloud_timer
var obstacle = preload("res://obstacle.tscn")
var obstacle_rock = preload("res://obstacle_rock.tscn")
var obstacle_end = preload("res://obstacle_end.tscn")
var cloud = preload("res://cloud.tscn")
var rand_cloud
var background
var score_area = preload("res://score_area.tscn")
var ob_type = 0
var num_ob_type = 2
var is_inf = 0
var end_spawned = 0
const END_NUM = 99
const SCORE_NEXT = 10

var ani
var score = 0

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	obstacle_timer = get_node("obstacle_timer")
	cloud_timer = get_node("cloud_timer")
	background = get_node("Background")
	
	cloud_spawn()
	obstacle_spawn(ob_type)
	obstacle_timer.start()
	cloud_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$celing.position.x = $player.position.x
	pass

func obstacle_spawn(ob_num):
	var obstacle_instance 
	var obstacle_instance_u 
	var score_instance 
	if end_spawned:
		return
	if ob_num == 0:
		obstacle_instance = obstacle.instantiate()
		obstacle_instance_u = obstacle.instantiate()
	
	elif ob_num == 1:
		obstacle_instance = obstacle_rock.instantiate()
		obstacle_instance_u = obstacle_rock.instantiate()
	elif ob_num == 9:
		end_spawned = 1
		obstacle_instance = obstacle_end.instantiate()
		obstacle_instance.obstacle_type = ob_num
		add_child(obstacle_instance)
		obstacle_instance.add_to_group("obstacles")
		obstacle_instance.position.x = $player.position.x + 1000
		obstacle_instance.position.y = get_viewport_rect().size.y/2
		return
	
	
	obstacle_instance.obstacle_type = ob_num
	obstacle_instance_u.obstacle_type = ob_num
	score_instance = score_area.instantiate()
	add_child(obstacle_instance)
	add_child(obstacle_instance_u)
	add_child(score_instance)
	obstacle_instance.add_to_group("obstacles")
	obstacle_instance_u.add_to_group("obstacles")
	score_instance.add_to_group("obstacles")
	obstacle_instance_u.rotation = PI
	obstacle_instance_u.position.x = $player.position.x + 1000
	obstacle_instance_u.position.y = randf_range(-300, get_viewport_rect().size.y-550)	
	obstacle_instance.position.x = $player.position.x + 1000
	obstacle_instance.position.y = obstacle_instance_u.position.y + randf_range(800,850)
	score_instance.position.x = $player.position.x + 1000
	score_instance.position.y = (obstacle_instance.position.y + obstacle_instance_u.position.y)/2

func cloud_spawn():
	var cloud_instance = cloud.instantiate()
	rand_cloud = randf_range(0.1,0.4)
	var rand_cloud_y = randf_range(-100,100)
	background.add_child(cloud_instance)
	ani = ['1', '2', '3']
	var i = randi_range(0,2)
	cloud_instance.get_node("43").play(ani[i])
	cloud_instance.set_motion_offset(Vector2($player.position.x+1000,rand_cloud_y))
	cloud_instance.set_motion_scale(Vector2(rand_cloud, rand_cloud))
	

func game_over():
	$player/die.play()
	$obstacle_timer.stop()
	$cloud_timer.stop()
	$HUD.show_game_over()	
	$player/AnimatedSprite2D.play("die")
	$player.input_enabled=0
	$HUD.end = 1
	
func new_game():
	$HUD.end = 0
	end_spawned = 0
	ob_type = 0
	$player/AnimatedSprite2D.play("player")
	$player.position = ($start_point.position)
	$player.stop = 1
	$player.show()
	$HUD/speed_label.hide()
	$HUD/score_label.hide()
	
	for instance in get_tree().get_nodes_in_group("obstacles"):
		instance.queue_free()
	score = 0
	$StartTimer.start()
	$HUD.countdown()
	await $StartTimer.timeout
	
	$player.stop = 0
	$player.input_enabled = 1
	$HUD.show_score()
	$HUD.show_speed()
	$obstacle_timer.start()
	$cloud_timer.start()
	$player.start($start_point.position)

func _on_obstacle_timer_timeout():
	obstacle_spawn(ob_type)

func _on_cloud_timer_timeout():
	cloud_spawn()	

func _on_player_hit():
	game_over()

func _on_hud_start_game():	
	new_game()

func score_increase():
	score+=1
	if score==END_NUM and is_inf==0: # end score : score_end +1
		ob_type = 9
	if score%SCORE_NEXT == 0:
		ob_type = (ob_type+1)%num_ob_type
		

func _on_player_end():
	$player/die.play()
	$obstacle_timer.stop()
	$cloud_timer.stop()
	$HUD.show_game_over()
	$HUD.show_message("Game over\n\nHuman cannot see glass,\nonly perceives its presence within frame")
	$player/AnimatedSprite2D.play("die")
	$player.input_enabled=0
	$HUD.end = 1


func _on_hud_infinite_mode():
	if is_inf:
		is_inf = 0
	else:
		is_inf = 1
