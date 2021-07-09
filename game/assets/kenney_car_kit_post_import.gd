###############################################################################
# Copyright (C) 2021 Severi Vidnäs                                            #
# Distributed under the terms of the GNU General Public License v3.0          #
###############################################################################
tool
class_name KenneyCarKitPostImport
extends EditorScenePostImport
# Script to make Vehicles from Kenneys Car Kit
# Makes Vehicles with bodies and wheels.

# Name of the wrapper node in the tree.
const WRAPPER_NAME: String = "tmpParent"
# Name of the body mesh.
const BODY_NAME: String = "body"
# Name to use for locating the wheel meshes.
const WHEEL_NAME_PREFIX: String = "wheel"
# Prefix to append for VehicleWheel nodes.
const VEHICLE_WHEEL_PREFIX: String = "vehicle_"
# Suffix to append for collision shape.
const BODY_COLLISION_SUFFIX: String = "_collision"

# Called right after the scene is imported and gets the root node.
func post_import(scene: Object) -> Object:
  if not scene is VehicleBody:
    print("Please import with VehicleBody as RootType")
    return scene
  scene = scene as VehicleBody
  add_body_collision(scene)
  add_vehicle_wheels(scene)
  return scene
  pass


# Resolve the mesh representing the body of the car and make collision shape
# based on it.
func add_body_collision(scene: Spatial) -> void:
  var car_root: Spatial = _get_car_root(scene)
  # Use the body as collision shape
  var body: MeshInstance = car_root.get_node(BODY_NAME)
  var body_collision: CollisionShape = CollisionShape.new()
  # Name & relocate
  body_collision.name = body.name + BODY_COLLISION_SUFFIX
  body_collision.transform = body.transform
  scene.add_child(body_collision)
  body_collision.set_owner(scene)
  # TODO: Next line causes some errors on output log:
  # core/math/quick_hull.cpp:428 - Condition "!F2" is true. Continuing.
  # core/math/quick_hull.cpp:401 - Condition "O == E" is true. Continuing.
  var body_collision_shape: ConvexPolygonShape = body.mesh.create_convex_shape()
  body_collision.shape = body_collision_shape
  pass


# Add VehicleWheel to the scene tree and move the wheel mesh as child for the
# created VehicleWheel.
func add_vehicle_wheels(scene: Spatial) -> void:
  var car_root: Spatial = _get_car_root(scene)
  var car_body: Spatial = car_root.get_node(BODY_NAME)
  for c in car_root.get_children():
    c = c as MeshInstance
    if c.name.begins_with(WHEEL_NAME_PREFIX):
      var wheel: VehicleWheel = VehicleWheel.new()
      wheel.name = VEHICLE_WHEEL_PREFIX + c.name
      var aabb: AABB = c.mesh.get_aabb()
      car_root.remove_child(c)
      wheel.translation = c.translation
      wheel.rotation_degrees = car_body.rotation_degrees + Vector3(0.0, 180.0, 0.0)
      wheel.wheel_radius = aabb.size.y / 2
      scene.add_child(wheel)
      wheel.set_owner(scene)
      wheel.add_child(c)
      c.translation = Vector3.ZERO
      c.rotation_degrees.y += 180
      c.set_owner(scene)
  pass


# Utility method resolves the "root" node of the car.
func _get_car_root(scene: Spatial) -> Spatial:
  # There is wrapper parent node in the hierarchy for each car
  var tmpParent: Spatial = scene.get_node(WRAPPER_NAME)
  if tmpParent:
    # Next node in the hierarchy is named differently for each car type 
    # (i.e. "deliveryFlat" or "ambulance") so we read it by index
    return tmpParent.get_child(0) as Spatial
  return null
  pass
