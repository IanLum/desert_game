extends CanvasLayer

@export var player: CharacterBody2D

var player_max_hp: int
var player_current_hp: int

@onready var empty_hearts: TextureRect = $MarginContainer/Hearts/EmptyHearts
@onready var full_hearts: TextureRect = $MarginContainer/Hearts/FullHearts
@onready var heart_width: int = full_hearts.texture.get_size().x
@onready var screen_color_animation_player: AnimationPlayer = $ScreenColor/ScreenColorAnimationPlayer

func _ready():
	Events.player_damaged.connect(_on_player_damaged)
	initialize_health()

func initialize_health():
	player_max_hp = player.max_hp()
	player_current_hp = player_max_hp
	empty_hearts.size.x = heart_width * player_max_hp
	full_hearts.size.x = heart_width * player_max_hp
	

func _on_player_damaged(damage):
	player_current_hp -= damage
	full_hearts.size.x = heart_width * player_current_hp
	screen_color_animation_player.play("on_hit_red")
	
func hit_stop():
	const HIT_STOP_DURATION = 0.1
	# delay a bit to allow hit animations to play
	await get_tree().create_timer(0.02).timeout
	get_tree().paused = true
	await get_tree().create_timer(HIT_STOP_DURATION).timeout
	get_tree().paused = false
