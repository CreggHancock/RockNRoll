extends Sprite

var gameOver = false
var score = 0
var scoreUp = true
onready var yards = 0
var gameEndTimer = 0
var gameEndTimerCounting = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	
func _process(delta):
	var charging = get_owner().charging
	var points = get_owner().points
	var title = get_owner().titleMenu
	var curPos = get_pos()
	var otherPos = get_node("../Rock").get_pos()
	if !(charging) and !(title):
		if (scoreUp):
			score = score + points
			yards = int(floor((score)/200))
		elif (title):
			score = 0
			yards = 0
	
		if (curPos.x > 20) and (gameOver == false) and (points > .01):
			curPos.x = curPos.x - points * delta
			set_pos(curPos)
		elif (otherPos.y < 40) and (curPos.x <= 20) and (gameOver == false) and (points > .01):
			curPos.x = curPos.x - points * delta
			set_pos(curPos)
		elif (curPos.x < 10) and (curPos.x > -15) and (gameOver == false) and (points > .01):
			curPos.x = curPos.x - points * delta
			set_pos(curPos)
		elif (curPos.x <= -15) and (gameOver == false) and (points > .01):
			curPos.x = 65
			set_pos(curPos)
		else:
			curPos.x = 20
			gameOver = true
			scoreUp = false
			if !(gameEndTimerCounting):
				gameEndTimer = 50
				gameEndTimerCounting = true
			if (gameEndTimer > 0):
				gameEndTimer = gameEndTimer - 1
		if (gameOver) and (Input.is_action_pressed("mouse_click")) and (gameEndTimer <= 0):
			curPos.x = 65
			set_pos(curPos)
			score = 0
			yards = 0
			scoreUp = true
			gameOver = false
			charging = false
			get_tree().change_scene("res://World.tscn")