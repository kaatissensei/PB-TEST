extends Sprite2D

var colors = ["Blue", "Cyan", "Green", "Orange", "Pink", "Purple", "Red", "Sky_Blue", "Yellow"]
const bob_height: float = 5.0
const bob_width: float = 3.0
const max_bob_speed: float = 2.5
var bob_speed: float = 0
var rnd
var defaultColor = "White"
var balloonColor = "White"
var popped = []
var tied : bool = true
var y_pos
var x_pos
var pos_offset #offset from initial origin
#var modulation : Color = "White"

@onready var parent_position : Vector2 = get_parent().global_position
@onready var start_position: Vector2 =  position

func _ready() -> void:
	##set_physics_process(true) #If you start this as false, it messes up starting positions
	#delayed_start()
	#print(start_position)
	rnd = randf_range(0, 1)
	bob_speed = randf_range(0, max_bob_speed) + 1
	#self.scale = Vector2(1.0,1.0)
	popped.resize(Main.max_num_teams)
	popped.fill(false)
	##await get_tree().create_timer(1).timeout
	#set_physics_process(false)
	
	y_pos 	= 0#((1+sin(time * bob_speed)) / 2) * bob_height
	global_position.y =  start_position.y - y_pos
	##TRY ADDING PARENT POSITION. IF NOT, MAKE LOCAL BALLOON TSCN
	##WHY IS PARENT POSITION SO FD ON THE RESULTS??
	x_pos = 0#((1+cos(time * bob_speed / 2)) / 2) * bob_width
	global_position.x =  start_position.x - x_pos
	

func set_default_color(color: String):
	defaultColor = color
	set_balloon_color(color)
	
func set_balloon_color(color: String):
	balloonColor = color
	var textureName = Main.textureLoc + "balloon" + balloonColor + "Sm.png"
	texture = load(textureName)

#Change texture to glow in the dark without overwriting original color
func glow():
	set_balloon_color("Pale_Green")

func no_glow():
	set_balloon_color(defaultColor)

#Draw balloon string
func _draw() -> void:
	pass

func pop(teamNum: int):
	popped[teamNum] = true

func is_popped(teamNum):
	return popped[teamNum]

func delayed_start():
	await get_tree().create_timer(2.0).timeout

func set_origin(new_position : Vector2):
	start_position = new_position + pos_offset
	
