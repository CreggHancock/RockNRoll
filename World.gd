extends Node2D

const DRAGTIME = 0.2


var up_arr = preload("res://low-res-up.tex")
var down_arr = preload("res://low-res-down.tex")
var left_arr = preload("res://low-res-left.tex")
var right_arr = preload("res://low-res-right.tex")


var drag_up = false
var drag_down = false
var drag_left = false
var drag_right = false

var counter_up = 0.0
var counter_down = 0.0
var counter_left = 0.0
var counter_right = 0.0

var set_up = false
var set_down = false
var set_left = false
var set_right = false 

var timer = 220
var timer_counter = .1

onready var trail = get_node('Particles2D')

var points = 0

onready var arrow = get_node("Arrow")
onready var button = get_node("Button")
onready var Log = get_node("Log")
onready var Rock = get_node("Rock")
onready var RockStill = get_node("RockStill")
onready var gameOver = Log.gameOver
onready var Shadow = get_node("Shadow")
var random_number = 0

onready var charging = false
onready var titleMenu = true
var load_data = load_play_data("user://play.data")



func _ready():
	arrow.hide()
	set_process_input(true)
	set_process(true)
func _input(event):
	
	if (event.type == InputEvent.SCREEN_DRAG):
		if (abs(event.relative_x) > abs(event.relative_y)):
			if (event.relative_x > 0):
				drag_right = true
			elif (event.relative_x < 0):
				drag_left = true
		elif (abs(event.relative_y) > abs(event.relative_x)):
			if (event.relative_y > 0):
				drag_down = true
			elif (event.relative_y < 0):
				drag_up = true
		self.get_tree().set_input_as_handled()
		var currentPoint = event.pos
		trail.set_pos(currentPoint)
		trail.set_emitting(true)

func _process(delta):
	gameOver = Log.gameOver
	if (titleMenu):
		charging = false
		points = 0
		button.show()
		if button.is_pressed():
			titleMenu = false
			charging = true
			button.set_pressed(false)
			button.hide()
	
	
	if(charging) and !(titleMenu):
		if (timer > 0):
			timer = timer -timer_counter 
			if (timer < 200 and !(set_up) and !(set_down) and !(set_right) and !(set_left)):
				random_number = _random()
		elif (timer <= 0):
			charging = false
			print("out of time")
		
		if (drag_up):
			counter_up += delta
		elif (drag_down):
			counter_down += delta
		elif (drag_left):
			counter_left += delta
		elif (drag_right):
			counter_right += delta
		
		
		if (counter_up > DRAGTIME):
			#RIGHT DRAG OCCURRED, DO STUFF HERE
			drag_up = false
			if (set_up):
				print("you got it")
				points = points + 1
				timer_counter = timer_counter + .1
				timer = 250
				arrow.hide()
			else:
				print("you lose")
				charging = false
			set_up = false
			set_down = false
			set_right = false
			set_left = false
			trail.set_emitting(false)
			random_number = 0
			counter_up = 0
		
		elif (counter_down > DRAGTIME):
			#DOWN DRAG OCCURRED, DO STUFF HERE
			drag_down = false
			if (set_down):
				print("you got it")
				points = points + 1
				timer_counter = timer_counter + .1
				timer = 250
				arrow.hide()
			else:
				print("you lose")
				charging = false
			set_down = false
			set_left = false
			set_right = false
			set_up = false
			trail.set_emitting(false)
			random_number = 0
			counter_down = 0

		elif (counter_left > DRAGTIME):
			#LEFT DRAG OCCURRED, DO STUFF HERE
			drag_left = false
			if (set_left):
				print("you got it")
				points = points + 1
				timer_counter = timer_counter +.1
				timer = 250
				arrow.hide()
			else:
				print("you lose")
				charging = false
			set_down = false
			set_left = false
			set_right = false
			set_up = false
			trail.set_emitting(false)
			random_number = 0
			counter_left = 0

		elif (counter_right > DRAGTIME):
			#RIGHT DRAG OCCURRED, DO STUFF HERE
			drag_right = false
			if (set_right):
				print("you got it")
				points = points + 1
				timer_counter = timer_counter +.1
				timer = 250
				arrow.hide()
			else:
				print("you lose")
				charging = false
			set_down = false
			set_left = false
			set_right = false
			set_up = false
			trail.set_emitting(false)
			random_number = 0
			counter_right = 0
	elif !(charging) and !(titleMenu):
		trail.set_emitting(false)
		arrow.hide()
		if (points > .01):
			points = points - .01
	var gameEndTimer = Log.gameEndTimer
	if gameEndTimer > 0:
		var data = load_data
		if(data>=0):
			if (gameEndTimer > 25) and (Log.yards > data):
				var save_data = Log.yards
				save_play_data("user://play.data", save_data)
func _random():
	var random_num = randi()%5+1
	if (random_num == 1):
		arrow.show()
		arrow.set_texture(right_arr)
		set_right = true
		return random_num
	elif (random_num == 2):
		arrow.show()
		arrow.set_texture(down_arr)
		set_down = true
		return random_num
	elif (random_num == 3):
		arrow.show()
		arrow.set_texture(left_arr)
		set_left = true
		return random_num
	elif (random_num == 4):
		arrow.show()
		arrow.set_texture(up_arr)
		set_up = true
		return random_num
func save_play_data(path, data):
    var f = File.new()
    f.open(path, File.WRITE)
    f.store_real(data)
    f.close()

func load_play_data(path):
    var f = File.new()
    if f.file_exists(path):
        f.open(path, File.READ)
        var data = f.get_real()
        f.close()
        return data
    return 0
