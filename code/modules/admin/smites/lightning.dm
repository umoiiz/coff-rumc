#define LIGHTNING_BOLT_DAMAGE 75

/// Strikes the target with a lightning bolt
/datum/smite/lightning
	name = "Lightning bolt"

/datum/smite/lightning/effect(client/user, mob/living/carbon/target)
	. = ..()
	var/turf/lightning_source = get_step(get_step(target, NORTH), NORTH) //turf north of target so our lightning has something to chain from
	lightning_source.beam(target, icon_state="lightning[rand(1,12)]", time = 5)
	target.adjust_fire_loss(LIGHTNING_BOLT_DAMAGE)
	playsound(get_turf(lightning_source), 'sound/effects/lightningbolt.ogg', 50, TRUE, 10)
	if(ishuman(target)) //knockdown and make humans jitter after being struck by lightning
		var/mob/living/carbon/human/human_target = target
		human_target.Knockdown(10 SECONDS)
		human_target.jitter(150)
	to_chat(target, span_userdanger("神明因你的罪孽而惩罚你!"), confidential = TRUE)

#undef LIGHTNING_BOLT_DAMAGE
