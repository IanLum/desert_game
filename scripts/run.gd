class_name Run
extends State

#TODO: bug that we are still it run state if both A and D or W and S are pressed so we arent moving

const RUN_SPEED = 300.0
const RUN_ACCEL = 6000.0

func enter():
	animation_tree["parameters/playback"].travel("walk")

func handle_physics(delta: float):
	var direction = Vector2(
		Input.get_axis("left", "right"), Input.get_axis("up", "down")
	).normalized()
	animation_tree["parameters/walk/blend_position"] = direction
	character.velocity = character.velocity.move_toward(direction*RUN_SPEED, RUN_ACCEL*delta)
	character.move_and_slide()
