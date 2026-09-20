// This is a typepath to just sit in baseturfs and act as a marker for other things.
/turf/baseturf_skipover
	name = "Baseturf skipover placeholder"
	desc = "这东西不该存在"

/turf/baseturf_skipover/Initialize(mapload)
	. = ..()
	stack_trace("[src]([type]) was instanced which should never happen. Changing into the next baseturf down...")
	ScrapeAway()

/turf/baseturf_skipover/shuttle
	name = "Shuttle baseturf skipover"
	desc = "充当穿梭机的底部,如果这里没有东西,穿梭机地板就会被穿透."

/turf/baseturf_bottom
	name = "Z-level baseturf placeholder"
	desc = "z轴基础地形的标记,通常解析为太空."
	baseturfs = /turf/baseturf_bottom
