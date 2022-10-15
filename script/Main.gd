extends Node

func _ready():
	home()
	pass

func home():
	var homeResource = preload("res://scene/Home.tscn")
	var home = homeResource.instantiate()
	add_child(home)
	$Home/Control/Start.connect("pressed", Callable(self, "startGame"))
	if (get_node_or_null("Over") != null):
		$Over.queue_free()
	whenChangeScene()
	$swoosh.play()
	pass

func startGame():
	var gameResource = preload("res://scene/Game.tscn")
	var game = gameResource.instantiate()
	add_child(game)
	
	game.end_game.connect(endGame)
	
	# 切换场景，删除Home
	$Home.queue_free()
	
	whenChangeScene()
	$swoosh.play()
	pass


func endGame(point: int):
	var overResource = preload("res://scene/Over.tscn")
	var over = overResource.instantiate()
	add_child(over)
	$Over/Control/Score.text = String.num_int64(point)
	$Over/Control/Menu.connect("pressed", Callable(self, "home"))
	$Game.queue_free()
	
	whenChangeScene()
	$die.play()
	pass

func whenChangeScene():
	$Transition/CanvasLayer.visible = true
	var animationPlayer: AnimationPlayer = $Transition/AnimationPlayer
	animationPlayer.play("fade-in")
	await animationPlayer.animation_finished
	$Transition/CanvasLayer.visible = false
	pass
