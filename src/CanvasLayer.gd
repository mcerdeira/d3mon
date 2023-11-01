extends CanvasLayer

func _process(delta):
	$game_over.visible = Global.GAME_OVER
	$game_over2.visible = $game_over.visible
	
