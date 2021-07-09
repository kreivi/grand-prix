###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
class_name Race
extends VehicleBody
# 

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var _steer_target = 0.0
var _steer_angle = 0.0

func _physics_process(delta: float) -> void:
  var throttle_input: float = 0.0
  var brake_input: float = 0.0
  var steer_input: float = 0.0
  if Input.is_action_pressed("accelerate"):
    throttle_input += Input.get_action_strength("accelerate")
  if Input.is_action_pressed("brake"):
    brake_input += Input.get_action_strength("brake")
  if Input.is_action_pressed("steer_left"):
    steer_input += Input.get_action_strength("steer_left")
  if Input.is_action_pressed("steer_right"):
    steer_input -= Input.get_action_strength("steer_right")
  
  engine_force = throttle_input * MAX_ENGINE_FORCE
  brake = brake_input * MAX_BRAKE_FORCE
  
  _steer_target = steer_input * MAX_STEER_ANGLE
  if _steer_target < _steer_angle:
    _steer_angle -= steer_speed * delta
    if _steer_target > _steer_angle:
      _steer_angle = _steer_target
  elif _steer_target > _steer_angle:
    _steer_angle += steer_speed * delta
    if _steer_target < _steer_angle:
      _steer_angle = _steer_target
  steering = _steer_angle
  pass
