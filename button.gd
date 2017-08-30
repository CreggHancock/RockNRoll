extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	set_process(true)
	
func _process(delta):
	var title = get_owner().titleMenu
	if is_pressed() and (title):
		title = false
		set_pressed(false)
