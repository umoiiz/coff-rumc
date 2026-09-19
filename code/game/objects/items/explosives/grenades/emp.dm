/obj/item/explosive/grenade/emp
	name = "\improper EMP手榴弹"
	desc = "一种紧凑装置,激活时释放强电磁脉冲.能够损坏或降低各种电子系统的性能.可装入任何榴弹发射器,也可用手投掷."
	icon_state = "emp"
	worn_icon_state = "emp"
	overlay_type = "blue"

/obj/item/explosive/grenade/emp/prime()
	empulse(src, 0, 2, 5)
	qdel(src)
