local font = "Interface\\Addons\\special font\\font\\squarefont\\100p.blp"

coords = {}
coords["0"] = {0, 48/256, 0, 70/256}
coords["1"] = {58/256, 71/256, 154/256, 224/256}
coords["2"] = {0, 48/256, 154/256, 224/256}
coords["3"] = {173/256, 221/256, 77/256, 147/256}
coords["4"] = {115/256, 163/256, 77/256, 147/256}
coords["5"] = {58/256, 106/256, 77/256, 147/256}
coords["6"] = {0, 48/256, 77/256, 147/256}
coords["7"] = {173/256, 221/256, 0, 70/256}
coords["8"] = {115/256, 163/256, 0, 70/256}
coords["9"] = {58/256, 106/256, 0, 70/256}
coords["%"] = {81/256, 147/256, 154/256, 224/256}

function SpecialFont(name, string, x, y, r, g, b)
	local container, char, c, texture
	local totalWidth = 0
	if not _G["SpecialFont_"..name] then
		container = CreateFrame("Frame","SpecialFont_"..name)
		container:SetParent(UIParent)
		container:SetHeight(70)
	end
	container = _G["SpecialFont_"..name]
	container:SetPoint("BOTTOMLEFT", "UIParent", "CENTER", x, y)

	for i=1, string.len(string) do
		if not _G["SpecialFont_"..name.."_"..i] then
			CreateFrame("Frame", "SpecialFont_"..name.."_"..i, container)
		else
			_G["SpecialFont_"..name.."_"..i]:Show()
		end

		char = _G["SpecialFont_"..name.."_"..i]

		c = string.sub(string, i, i)
		local width = 48
		if c == "1" then
			width = 13
		elseif c == "%" then
			width = 66
		end
		totalWidth = totalWidth + width + 5

		char:SetWidth(width)
		char:SetHeight(70)
		if(i ~= 1) then
			char:SetPoint("LEFT", _G["SpecialFont_"..name.."_"..(i-1)], "RIGHT", 5, 0)
		else
			char:SetPoint("LEFT", container, "LEFT", 0, 0)
		end

		char:CreateTexture("SpecialFont_"..name.."_"..i.."_texture")
		texture = _G["SpecialFont_"..name.."_"..i.."_texture"]
		texture:SetAllPoints()
		texture:SetTexture(font)
		texture:SetTexCoord(coords[c][1], coords[c][2], coords[c][3], coords[c][4])
		texture:SetPoint("TOPLEFT", 0, 0)	
		texture:SetPoint("BOTTOMRIGHT", char, "TOPLEFT", width, -70)

		texture:SetVertexColor(r,g,b)
	end
	local i = 1
	while _G["SpecialFont_"..name.."_"..string.len(string)+i.."_texture"] do
		_G["SpecialFont_"..name.."_"..string.len(string)+i]:Hide()
		i=i+1
	end

	container:SetWidth(totalWidth-5)
end


function ShortNumber(cur)
	if cur < 10^3 then
		return cur
	elseif cur < 10^6 then
		return tostring(math.floor(cur/100+.5)/10).."k"
	else
		return tostring(math.floor(cur/100000+.5)/10).."m"
	end
end