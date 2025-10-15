extends Card
class_name ActivityCard

func execute():
	property.add_money(10)
	property.add_mood(mood)
	property.add_time(time)
	
	for buff : Buff in buffs.get_children():
		buff.reparent_to_buff_manager()
