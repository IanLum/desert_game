extends StateMachine

@onready var dash_timer: Timer = $Dash/DashTimer

var in_dialogue = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if not in_dialogue:
			for area in get_parent().get_node("NPCDialogueCollider").get_overlapping_areas():
				if area.is_in_group("npc"):
					Events.emit_signal("enter_dialogue", area)
					in_dialogue = true
		else:
			Events.emit_signal("advance_dialogue")
	elif Input.is_action_just_pressed("dash") or not dash_timer.is_stopped():
		transition_to("Dash")
	elif (
		Input.is_action_pressed("up") or
		Input.is_action_pressed("down") or
		Input.is_action_pressed("left") or
		Input.is_action_pressed("right")
	):
		transition_to("Run")
	else:
		transition_to("Idle")
		
	state.handle_physics(delta)
