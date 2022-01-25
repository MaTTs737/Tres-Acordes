extends Node2D

onready var pickups = $pickups
onready var player = $player_tile
onready var rest_pos = $restPos.global_position
onready var coinCount = $HUD2/TextureRect2/coinCount
onready var tucaCount = $HUD2/TextureRect/tucaCount
onready var lifeCount = $HUD2/Control/MarginContainer/HBox1/Hbox2/lifeRect/lifeCountLabel
onready var winLose = $winLoseHandler

const COIN = preload("res://pickables/coin.tscn")
const TUCA = preload("res://pickables/tuca.tscn")
const LIFE = preload("res://levels/level_tucas/poweups/lifePowerUp.tscn")
const pausaScreen = preload("res://HUD/pausaScreen.tscn")
const flyingPlayer = preload("res://levels/level_tucas/player/flyingPlayer.tscn")

var won = false
var lost = false
var coins = 0

func _ready():
	spawn_items()
	$backgroundMusic.play()
	
func _process(delta):
	if Input.is_action_just_pressed("pausa"):
		get_tree().paused = true
		var p = pausaScreen.instance()
		add_child(p)

func spawn_items():
	for cell in pickups.get_used_cells():
		var id = pickups.get_cellv(cell)
		var pick
		var type = pickups.tile_set.tile_get_name(id)
		if type in ["coin","tuca","life"]:
			match type:
				"coin":
					pick = COIN.instance()
				"tuca":
					pick = TUCA.instance()
				"life":
					pick = LIFE.instance()
					
		pick.position = pickups.map_to_world(cell)
		self.add_child(pick)
		pickups.hide()

func add_coin():
	coins+=1
	coinCount.text = str(coins)

func tuca_picked():
	player.tucas +=1
	tucaCount.text = str(player.tucas)

func life_picked():
	player.life += 1
	player.emit_signal("life_changed",player.life)
	
func got_48(pos:Vector2,life,tuca):
	tucaCount.text = str(player.tucas)
	player.visible=false
	var p = flyingPlayer.instance()
	p.start(pos, life)
	$fumada.play()
	yield($fumada,"finished")
	player.global_position = rest_pos
	Utils._get_main_node().add_child(p)
	p.camara.current = true
	
func start_player(pos,lifes,tucas):
	player.start(pos,lifes,tucas)
	$Camera2D.current = true

func _on_player_tile_got48():
	got_48(player.global_position,player.life,player.tucas)

func _on_winArea_body_entered(body):
	winLose.win()

func _on_death_finished():
	winLose.lose()
