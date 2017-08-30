extends AnimatedSprite
var jumping = false
var startPos = get_pos()
var hangTimer = 0
const gravity = 20

func _ready():
	var hide = get_node("../RockStill").show()
	set_process(true)
	
func _process(delta):
	var charging = get_owner().charging
	var title = get_owner().titleMenu
	var points = get_owner().points
	var curPos = get_pos()
	var gameOver = get_node("../Log").gameOver
	var distance = (45 - curPos.y)
	var maxHeight = 45
	var jumpSpeed = sqrt(2.5*gravity*maxHeight)
	var speed = sqrt(2*gravity*distance)
	if !(charging) and !(title) and !(gameOver):
		var hide = get_node("../RockStill").hide()
		if (!(jumping) and (Input.is_action_pressed("mouse_click")) and (gameOver == false) and (curPos.y >= 45)):
			hangTimer = hangTimer + 1
			jumping = true
		if (jumping) and (curPos.y > 20):
			curPos.y = curPos.y-jumpSpeed*delta
			set_pos(curPos)
		elif (jumping) and (curPos.y <= 20):
			if hangTimer >= 0:
				hangTimer = hangTimer - .1
			else:
				jumping = false
		elif !(jumping) and (curPos.y < 45):
			curPos.y = curPos.y + jumpSpeed * delta
			set_pos(curPos)
		elif !(jumping) and (curPos.y >= 45):
			curPos.y = 45
			set_pos(curPos)
	else:
		curPos.y = 45
		var hide = get_node("../RockStill").show()
		set_pos(curPos)
	
