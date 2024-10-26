extends Node

var score : int
var highscore : int

func getHighscore():
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0
	return highscore


func updateHighscore(newScore):
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_var(newScore)
	file.close()
