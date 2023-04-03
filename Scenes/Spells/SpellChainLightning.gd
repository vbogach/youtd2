extends SpellDummy

const CHAIN_DISTANCE: float = 6900.0

var _damage: float = 0.0
var _chain_count: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	super()

	print("chain!")
	print("_chain_count!", _chain_count)

	var visited_unit_list: Array[Unit] = []
	var current_position: Vector2 = _target_position

	for i in range(0, _chain_count):
		var unit_list: Array[Unit] = Utils.get_units_in_range(TargetType.new(TargetType.CREEPS), current_position, CHAIN_DISTANCE)

		for unit in visited_unit_list:
			unit_list.erase(unit)

		if unit_list.is_empty():
			break

		Utils.sort_unit_list_by_distance(unit_list, current_position)

		var hit_unit: Unit = unit_list[0]

		do_spell_damage(hit_unit, _damage)
		visited_unit_list.append(hit_unit)
		current_position = hit_unit.position


# NOTE: subclasses override this to save data that is useful
# for them
func _set_subclass_data(data: Cast.SpellData):
	_damage = data.chain_lightning.damage
	_chain_count = data.chain_lightning.chain_count