extends Label

func _ready():
	set_process(true)

func _process(delta):
	var title = get_owner().titleMenu
	var charging = get_owner().charging
	var points = get_owner().points
	var score = get_node("../Log").yards
	var gameOver = get_node("../Log").gameOver
	
	if (title):
		set_text("Rock n' Go")
	elif (charging):
		set_text("x"+str(points))
	elif (gameOver):
		set_text("Score: "+str(score))
	elif !(charging) and !(title):
		set_text(str(score))