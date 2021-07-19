###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
class_name CarTest
extends GdUnitTestSuite
# Car test suite.

# TestSuite generated from
const __source = 'res://game/entities/cars/car.gd'
# Variable to store script reference.
var _script: GDScript = load(__source)
# Variable to store Car reference.
var _node: Car = null

func before() -> void:
  _node = _script.new()
  pass


func after() -> void:
  _node.free()
  pass


func test_add_throttle_input() -> void:
  # Test default
  assert_float(_node.get_throttle_input()).is_equal(0.0)
  # Test input
  var input: float = 0.4
  assert_float(_node.add_throttle_input(input)).is_equal(input)
  assert_float(_node.add_throttle_input(input)).is_equal(input * 2)
  assert_float(_node.add_throttle_input(input)).is_less_equal(
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MAX
    )
  pass


func test_add_brake_input() -> void:
  # Test default
  assert_float(_node.get_brake_input()).is_equal(0.0)
  # Test input
  var input: float = 0.4
  assert_float(_node.add_brake_input(input)).is_equal(input)
  assert_float(_node.add_brake_input(input)).is_equal(input * 2)
  assert_float(_node.add_brake_input(input)).is_less_equal(
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MAX
    )
  pass


func test_add_steering_input() -> void:
  # Test default
  assert_float(_node.get_steering_input()).is_equal(0.0)
  # Test positive input
  var input: float = 0.4
  assert_float(_node.add_brake_input(input)).is_equal(input)
  assert_float(_node.add_brake_input(input)).is_equal(input * 2)
  assert_float(_node.add_brake_input(input)).is_less_equal(
      Constants.BIDIRECTIONAL_INPUT_VALUE_MAX
    )
  # Test negative input
  _node.set_steer_input(0.0)
  assert_float(_node.add_brake_input(-input)).is_equal(-input)
  assert_float(_node.add_brake_input(-input)).is_equal(-input * 2)
  assert_float(_node.add_brake_input(-input)).is_less_equal(
      Constants.BIDIRECTIONAL_INPUT_VALUE_MIN
    )
  pass


func test_throttle_input_accelerates() -> void:
  pass
