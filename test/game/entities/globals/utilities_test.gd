###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
class_name UtilitiesTest
extends GdUnitTestSuite
# Utilities test suite.

# TestSuite generated from
const __source = 'res://game/entities/globals/utilities.gd'

# Variable to store script reference.
var _script: GDScript = load(__source)
# Variable to store node reference.
var _node: Node = null


func before() -> void:
  _node = _script.new()
  pass


func after() -> void:
  _node.free()
  pass


func test_clamp_input_unidirectional() -> void:
  # Test minimum
  assert_float(_node.clamp_input_unidirectional(
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MIN - 1.0)).is_equal(
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MIN
    )
  # Test maximum
  assert_float(_node.clamp_input_unidirectional(
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MAX + 1.0)).is_equal(
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MAX
    )
  # Test valid
  var valid: float = rand_range(Constants.UNIDIRECTIONAL_INPUT_VALUE_MIN,
      Constants.UNIDIRECTIONAL_INPUT_VALUE_MAX
    )
  assert_float(_node.clamp_input_unidirectional(valid)).ie_equal(valid)
  pass


func test_clamp_input_bidirectional() -> void:
  # Test minimum
  assert_float(_node.clamp_input_bidirectional(
      Constants.BIDIRECTIONAL_INPUT_VALUE_MIN - 1.0)).is_equal(
      Constants.BIDIRECTIONAL_INPUT_VALUE_MIN
    )
  # Test maximum
  assert_float(_node.clamp_input_bidirectional(
      Constants.BIDIRECTIONAL_INPUT_VALUE_MAX + 1.0)).is_equal(
      Constants.BIDIRECTIONAL_INPUT_VALUE_MAX
    )
  # Test valid
  var valid: float = rand_range(Constants.BIDIRECTIONAL_INPUT_VALUE_MIN,
      Constants.BIDIRECTIONAL_INPUT_VALUE_MAX
    )
  assert_float(_node.clamp_input_bidirectional(valid)).ie_equal(valid)
  pass
