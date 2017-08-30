extends Label
onready var data = 0
func _ready():
	set_process(true)

func _process(delta):
	var title = get_owner().titleMenu
	var charging = get_owner().charging
	var points = get_owner().points
	var load_data = get_owner().load_data
	var timer = get_owner().timer
	data = load_data
	var score = get_node("../Log").yards
	var gameOver = get_node("../Log").gameOver
	var cur_pos = get_pos()
	if (title):
		set_text("")
	elif (charging):
		cur_pos.x = 38
		cur_pos.y = 0
		set_pos(cur_pos)
		set_text(str(floor(timer)))
	elif (gameOver):
		cur_pos.x = 0
		cur_pos.y = 17
		set_pos(cur_pos)
		if (score > data):
			cur_pos.x = 0
			set_text("New \nHighScore:\n"+ "          "+ str(score))
		else:
			set_text("HighScore:\n"+ "          "+str(data))
	else:
		set_text("")