extends Label

var score = 0

func _on_killed():
	score += 10
	text = "Score: %s" %score
