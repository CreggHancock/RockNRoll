extends ParallaxLayer

var gameOver = false

func _ready():
	set_process(true)
	
func _process(delta):
	var charging = get_owner().charging
	var points = get_owner().points
	var titleMenu = get_owner().titleMenu
	var gameOver = get_owner().gameOver
	var curPos = get_pos()
	print(gameOver)
	if (curPos.x > -128) and !(charging) and !(gameOver):
		curPos.x = curPos.x - points * delta
	else:
		curPos.x = 0
	set_pos(curPos)
