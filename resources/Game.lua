local player
local soldier
local beard
local log
local camera
local arrow
local arrow2
local lichens = 0
local benchcounter = 0
local headstonecounter = 0
local barkcounter = 0
local cameracounter = 0
local unlockcounter = 0

function Start()
	Clear()
	Log(
		"I once had a dream where I was a student in the most presigious lichenology school in the world (it unfortunately does not exist). There was this really neat minigame widget embedded in the lichen identification module, and I have taken the liberty to recreate that experience for you mushroom enthusiasts out there.")
	Log("***")
	Log("ACHARIUS")
	Log("***")
	Log("Entry 1: This is my lichen journal. Please return to E. Acharius if found.")
	Log("***")
	SetBackground(0)
	PlaySound(0)
	player = FindEntity("Player")
	camera = FindEntity("Camera")
	arrow = FindEntity("Arrow")
	arrow2 = FindEntity("Arrow2")
	soldier = FindEntity("Soldier")
	log = FindEntity("Log")
	beard = FindEntity("Beard")
	unlock = FindEntity("Unlock")

	camera.visible = false
	arrow.visible = false
	arrow2.visible = false
	player.animationSpeed = 4
end

function Update()
	-- player movement vars
	speed = .3;
	vSpeed = 0;
	hSpeed = 0;

	-- input
	if UpHeld then
		vSpeed = vSpeed - speed;
	end

	if DownHeld then
		vSpeed = vSpeed + speed;
	end

	if RightHeld then
		hSpeed = hSpeed + speed;
	end

	if LeftHeld then
		hSpeed = hSpeed - speed;
	end

	-- move
	player:Move(hSpeed, vSpeed)

	-- animate
	if vSpeed > 0 then
		player:SetSprite(0)
	end

	if vSpeed < 0 then
		player:SetSprite(0)
	end

	if hSpeed > 0 then
		player:SetSprite(0)
	end

	if hSpeed < 0 then
		player:SetSprite(0)
	end

	--stop animation if there is no movement
	if hSpeed == 0 and vSpeed == 0 then
		player.animate = false
	else
		player.animate = true
	end

	if CollisionFound(hSpeed, vSpeed, player, "Bench") and benchcounter == 0 then
		Log("***")
		Log(
			"I discovered an old bench covered with a variety of crustose lichens. The only way to bring a specimen back to my laboratory would be to remove the entire bench. In short, they are here to stay.")
		Log("***")
		benchcounter = benchcounter + 1
		PlaySound(3)
		player:Move(-hSpeed, -vSpeed)
		cameracounter = cameracounter + 1
	end

	if CollisionFound(hSpeed, vSpeed, player, "Unlock") then
		unlockcounter = unlockcounter + 1
	end

	if unlockcounter > 5000 then
		unlockcounter = 0
		AddEntity(eyes, 279, 80, 30, 30, 30, 17)
		PlaySound(4)
		Log("***")
		Log("Planarian worm googly eyes unlocked!")
		Log("While it's not my forte, I thought that mound of dirt had that suspicious planarian worm look to it...")
		Log("***")
		RemoveEntity(unlock)
	end

	if CollisionFound(hSpeed, vSpeed, player, "Bench") and benchcounter == 1 and cameracounter == 5 then
		Log("***")
		Log(
			"I know not the names belonging to this multitudinous lichen colony, so diminutive are they on the park bench (save the obvious Candelariella sp.). I shall engage in careful examination of the photographs immediately upon my return. As for now, they remain a closely guarded cemetery mystery.")
		Log("***")
		PlaySound(1)
		lichens = lichens + 1
		benchcounter = benchcounter + 1
		AddEntity(benchcolony, 303, 438, 23, 23, 23, 9)
		player:Move(-hSpeed, -vSpeed)
	end

	if CollisionFound(hSpeed, vSpeed, player, "Headstone") and headstonecounter == 0 then
		Log("***")
		Log(
			"Something about cemetery headstones attracts beautiful lichen. I will not disrupt the resting places of the deceased! As enticing as it might be, there are limitations to my eccentricities.")
		Log("***")
		headstonecounter = headstonecounter + 1
		PlaySound(3)
		player:Move(-hSpeed, -vSpeed)
		cameracounter = cameracounter + 1
	end

	if CollisionFound(hSpeed, vSpeed, player, "Headstone") and headstonecounter == 1 and cameracounter == 5 then
		Log("***")
		Log(
			"I acted in haste to commit my memory of the headstone's maritime sunburst lichen (Xanthoria parietina) into a photograph with which I might consult in moments of melancholy. This foliose lichen is happiest upon rock surfaces, making this granite headstone an ideal place for warm soliloquy. It will surely outlive me.")
		Log("***")
		PlaySound(1)
		lichens = lichens + 1
		AddEntity(headstonelichen, 373, 438, 25, 25, 25, 11)
		headstonecounter = headstonecounter + 1
		player:Move(-hSpeed, -vSpeed)
	end

	if CollisionFound(hSpeed, vSpeed, player, "Bark") and barkcounter == 0 then
		Log("***")
		Log(
			"There is one tree in the cemetery which displays this brilliant smattering of a green concentrically arranged lichen. I don't have the equipment to remove a piece from its bark. It appears that I am woefully unprepared.")
		Log("***")
		barkcounter = barkcounter + 1
		PlaySound(3)
		player:Move(-hSpeed, -vSpeed)
		cameracounter = cameracounter + 1
	end

	if CollisionFound(hSpeed, vSpeed, player, "Bark") and barkcounter == 1 and cameracounter == 5 then
		Log("***")
		Log(
			"I took an exquisite photograph of a common greenshield lichen (Flavoparmelia caperata). Is not this genus the owner of the most beautiful string of words committed to the English language? The manner by which it radiates outward from its barky substrate might as well make it the thing of God's horsetail brush.")
		Log("***")
		PlaySound(1)
		lichens = lichens + 1
		AddEntity(greenshield, 443, 438, 24, 24, 24, 12)
		barkcounter = barkcounter + 1
		player:Move(-hSpeed, -vSpeed)
	end

	if CollisionFound(hSpeed, vSpeed, player, "Wall") then
		player:Move(-hSpeed, -vSpeed)
	end

	if CollisionFound(hSpeed, vSpeed, player, "Soldier") then
		RemoveEntity(soldier)
		PlaySound(2)
		player:Move(-hSpeed, -vSpeed)
		Log("***")
		Log(
			"I nearly trampled on a marching division of British soldier lichen (Cladonia cristatella). They are fruticose, meaning they boast branching structures adorned with red caps; a brilliant sight in the morning dew! I suspect that this specimen might have traveled from its original abode via a gust of wind or kindly mammalian transport.")
		Log("***")
		AddEntity(redcap, 93, 438, 27, 27, 27, 14)
		lichens = lichens + 1
	end

	if CollisionFound(hSpeed, vSpeed, player, "Beard") then
		RemoveEntity(beard)
		PlaySound(2)
		Log("***")
		Log(
			"Another common denizen of burial grounds is the old man's beard, or Usnea longissima. This pale-green fruticose lichen attaches to branches, swaying in the wind like the marvelous facial hair of a mystic dervish from the orient. Surely it is too far north to be Spanish moss (Tillandsia usneoides), however further microscopy will settle it.")
		Log("***")
		AddEntity(oldmans, 163, 438, 28, 28, 28, 15)
		lichens = lichens + 1
	end

	if CollisionFound(hSpeed, vSpeed, player, "Log") then
		RemoveEntity(log)
		PlaySound(2)
		Log("***")
		Log(
			"I stumbled upon a felled branch claimed by a colony of Platismatia glauca! This corticolous (bark-dwelling) foliose lichen was one of the species committed to writing by the Swedish botanist and my dear mentor Carl Linnaeus in 1753. Commonly referenced as the ragbag lichen, it lives up to its ragged namesake.")
		Log("***")
		AddEntity(branch, 233, 438, 29, 29, 29, 16)
		lichens = lichens + 1
	end

	if cameracounter == 3 then
		camera.visible = true
		cameracounter = cameracounter + 1
	end

	if CollisionFound(hSpeed, vSpeed, player, "Camera") and cameracounter == 4 then
		Log(
			"Somebody left their camera on this bench. This might prove useful for some of those stationary lichen specimens that remain immovable.")
		RemoveEntity(camera)
		PlaySound(2)
		cameracounter = cameracounter + 1
		player:Move(-hSpeed, -vSpeed)
	end

	if lichens == 6 then
		arrow.visible = true
		arrow2.visible = true
	end

	if CollisionFound(hSpeed, vSpeed, player, "Arrow") and lichens == 6 then
		Log(
			"Thank you for playing! This tiny world of lichens was created/curated by Tyler Wright.")
		Log("Please visit our cabinet of game curiosities at: https://outgrabe.itch.io/")
		Log(
			"Also, many thanks goes out to Gabriele Maddaloni for providing the Micro Game Engine, the one tool to adequately capture this tiny vision.")
		RemoveEntity(arrow2)
		RemoveEntity(arrow)
		AddEntity(arrow3, 23, 438, 26, 26, 26, 4)
		SetBackground(1)
	end

	if CollisionFound(hSpeed, vSpeed, player, "Arrow2") and lichens == 6 then
		Log(
			"Thank you for playing! This tiny world of lichens was created/curated by Tyler Wright.")
		Log("Please visit our cabinet of game curiosities at: https://outgrabe.itch.io/")
		Log(
			"Also, many thanks goes out to Gabriele Maddaloni for providing the Micro Game Engine, the one tool to adequately capture this tiny vision.")
		RemoveEntity(arrow)
		RemoveEntity(arrow2)
		AddEntity(arrow3, 23, 438, 26, 26, 26, 4)
		SetBackground(1)
	end
end
