// Добавляем полноценный и упрощённый языки для Древних.
#define LANGUAGE_LOCUTUS "Ancient"
#define LANGUAGE_SIMPLOCUTUS "Simplified Ancient"

// Добавляем костыль для ограничения возможности говорить на упрощённом языке Древних.
#define BP_ANCTONGUE "anctongue"

// Полноценный язык Древних.
/datum/language/locutuslanguage
	name = LANGUAGE_LOCUTUS
	desc = "A now dead language that can be found on various monoliths and in buildings from bygone eras."
	speech_verb = "pronounces"
	ask_verb = "asks"
	exclaim_verb = "states"
	colour = "selenian"
	key = "z"
	space_chance = 60
	flags = WHITELISTED
	machine_understands = 0
	syllables = list("𒀀𒀙", "𒀲𒀭", "𒀵𒁖", "𒂟𒂙", "𒂕𒂵", "𒂹𒃏", "𒆅𒆯", "𒇮𒂿", "𒌏𒆺")
	shorthand = "LT"
	has_written_form = TRUE
	hidden_from_codex = 1
	partial_understanding = list(LANGUAGE_SIMPLOCUTUS = 75)

// Упрощённый язык Древних.
/datum/language/simplocutuslanguage
	name = LANGUAGE_SIMPLOCUTUS
	desc = "A studied part of a now dead language, which can be found on various monoliths and in buildings from bygone eras."
	speech_verb = "pronounces"
	ask_verb = "asks"
	exclaim_verb = "states"
	colour = "selenian"
	key = "%"
	space_chance = 60
	flags = WHITELISTED
	machine_understands = 0
	syllables = list("𒀀𒀙", "𒀲𒀭", "𒀵𒁖", "𒂟𒂙", "𒂕𒂵", "𒂹𒃏", "𒆅𒆯", "𒇮𒂿", "𒌏𒆺")
	shorthand = "sLT"
	has_written_form = TRUE
	hidden_from_codex = 1

// Получение знаний об упрощённом языке Древних посредством обладания навыком Science на уровне Experienced.
/singleton/hierarchy/skill/research/science/update_special_effects(mob/mob, level)
	. = ..()
	mob.remove_language(LANGUAGE_SIMPLOCUTUS)
	if(level == SKILL_EXPERIENCED)
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			H.add_language(LANGUAGE_SIMPLOCUTUS)

// Орган, позволяющий говорить на упрощённом Древнем. В данном случае выступает как костыль. Не используйте его, пожалуйста.
/obj/item/organ/internal/anctongue
	name = "anctongue"
	desc = "Some kind of ancient creature's tongue."
	parent_organ = BP_HEAD
	organ_tag = BP_ANCTONGUE

// Условия, при которых моб сможет говорить на упрощённом языке Древних.
/datum/language/simplocutuslanguage/can_speak_special(mob/speaker)
	if(!ishuman(speaker))
		return FALSE
	var/mob/living/carbon/human/H = speaker
	var/obj/item/organ/internal/anctongue/tongue = H.internal_organs_by_name[BP_ANCTONGUE]
	if(!istype(tongue) || !tongue.is_usable())
		to_chat(speaker, SPAN_WARNING("You are not capable of speaking [name]!"))
		return FALSE
	return TRUE
