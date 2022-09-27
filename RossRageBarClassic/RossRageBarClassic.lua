equipmentSet = "";
ammotSlot = "";
ammoCount = "";
t = {[0] = "Mana", [1] = "Rage", [2] = "Focus", [3] = "Energy", [4] = "Happiness", [5] = "Runes", [6] = "Runic Power", [7] = "Soul Shards", [8] = "Eclipse", [9] = "Holy Power"};
function RageBar_OnLoad(self)
	self:RegisterEvent("UNIT_POWER_UPDATE");
	self:RegisterEvent("PLAYER_LOGIN");
	createBar();
end

--Handles the event fired whenever the players "power" changes.
function RageBar_OnEvent(self, event, ...)
	if (event == "UNIT_POWER_UPDATE") then
		updateBar();
	elseif (event == "PLAYER_LOGIN") then
		updateBar();
	end
end

function createBar()
	power = UnitPower("player");
	local playerClass, englishClass = UnitClass("player");
	--Only shows percentage if you are using mana, otherwise removes the % and shrinks the window slightly.
	if (UnitPowerType("player") == 0) then
		r = string.len(power);
		RossRageBarFrame:SetSize((r*7)+140, 43);
		powerText = t[UnitPowerType("player")]..": "..power.." ("..floor((power/UnitPowerMax("player"))*100).."%)";
		if (playerClass == "Hunter") then
			ammoSlot = GetInventorySlotInfo("AmmoSlot");
			ammoCount = GetInventoryItemCount("player", ammoSlot)
			ammoText = "Ammo: "..ammoCount;
			powerText = powerText.."\n"..ammoText;
		end
		RossRageBarFrameText:SetText(powerText);
	--For Runic Power
	elseif (UnitPowerType("player") == 6) then
		RossRageBarFrame:SetSize(110, 27);
		RossRageBarFrameText:SetText(t[UnitPowerType("player")]..": "..power);
	--For rage and energy
	else
		RossRageBarFrame:SetSize(90, 27);
		RossRageBarFrameText:SetText(t[UnitPowerType("player")]..": "..power);
	end
	createBackdrop();
end

--Create the backdrop for the window
--TODO: Make this a setting to turn off and on
function createBackdrop()
	RossRageBarFrame:SetBackdrop({
		bgFile = "interface/tutorialframe/tutorialframebackground.blp", 
		edgeFile = "interface/tooltips/ui-tooltip-border.blp", 
		tile = "true",
		edgeSize = 8,
		insets = { 
			left = 2,
			right = 2,
			top = 2, 
			bottom = 2 
		}
	})
end

function updateBar()
	power = UnitPower("player");
	local playerClass, englishClass = UnitClass("player");
	--Only shows percentage if you are using mana, otherwise removes the % and shrinks the window slightly.
	if (UnitPowerType("player") == 0) then
		r = string.len(power);
		powerText = t[UnitPowerType("player")]..": "..power.." ("..floor((power/UnitPowerMax("player"))*100).."%)";
		if (playerClass == "Hunter") then
			ammoSlot = GetInventorySlotInfo("AmmoSlot");
			ammoCount = GetInventoryItemCount("player", ammoSlot)
			ammoText = "Ammo: "..ammoCount;
			powerText = powerText.."\n"..ammoText;
		end
		RossRageBarFrameText:SetText(powerText);
	--For Runic Power
	elseif (UnitPowerType("player") == 6) then
		RossRageBarFrameText:SetText(t[UnitPowerType("player")]..": "..power);
	--For rage and energy
	else
		RossRageBarFrameText:SetText(t[UnitPowerType("player")]..": "..power);
	end
end

--Code to implement a tooltip.
function RageBar_ShowTooltip(self)
	GameTooltip:SetText("Shift+Click to move\nCtrl+Click to resize");
	GameTooltip:Show();
end