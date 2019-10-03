
local name, OJMD_TV = ...
local LibAddonCompat = LibStub("LibAddonCompat-1.0")

local Filter = nil

OJMD_TV.Functions = {}



function OJMD_TV.Functions.UpDateXP()
  print(" -- Event XP -- ")
  DB.Twinks[UnitName("player")].XP = UnitXP("player")
  DB.Twinks[UnitName("player")].XPmax = UnitXPMax("player")
end

function OJMD_TV.Functions.UpDateGold()
  print("-- Event Money -- ")               
  DB.Twinks[UnitName("player")].Gold = GetMoney("player")   
end


--[[ Formatiere Gold String]]
function OJMD_TV.Functions.GoldString( gold )
	local str = "";
	local negative = false;

	if( gold > 0 ) then
		gold = gold -- + 101
	end

	if ( gold < 0 ) then
		str = "|cffff0000 -" .. GetCoinTextureString( ( gold * -1 ) ).. "|r";
		negative = true;
	else
		str = "|cffFFFFFF " .. GetCoinTextureString( gold ) .. "|r";
	end
	return str , negative
end


function OJMD_TV.Functions.SortTables( id )

  if currSort == id then
      if currOrder == "asc" then
          currOrder = "asc"
      else
          currOrder = "desc"
      end
  elseif id then
      currSort = translateID[ id ]
      currOrder = "desc"
  end

  print("Sort ID: " .. id .. " -> " .. translateID[id] )

  table.sort( db, function(v1,v2) 
      if currOrder == "desc" then
          return v1[currSort] > v2[currSort]
      else
          return v1[currSort] < v2[currSort]
      end
  end)
  OJMD_TableBrowser.Update()
end

function OJMD_TV.Functions.UpdateAll( Group )

  
  if Group ~= nil then

    local CharID = UnitGUID("player")
    
    local TempCharID = ""
    
    if DB.Twinks ~= nil then
      for k, member in pairs( DB.Twinks ) do
          if member.GUID == UnitGUID("player") then
            TempCharID = k
            --print('Char wurde gefunden: ' .. TempCharID)              
          end
        end
      end
      
    --print(" --> aktualisiere ALL! Gruppe: " .. Group )
    
    if TempCharID == "" then
      --print(" --> Char nicht gefunden: " )
      TempCharID = OJMD_TV.Functions.AddChar( Group )
    end    

    local Erholt = 0
    local prof1, prof2 = LibAddonCompat:GetProfessions();

    local skillLevel_1, skillLevel_2 = 0,0  
    local skillName_1, skillName_2 = "",""
    local skillFishing, skillCooking, skillFirstAid = nil, nil, nil


    for s = 1, GetNumSkillLines() do
      local skill, _, _, level, _, _, _, _, _, _, _, _, _ = GetSkillLineInfo(s)
      if skill == 'Angeln' then 
        skillFishing = level
      elseif skill == 'Kochkunst' then
        skillCooking = level
      elseif skill == 'Erste Hilfe' then
        skillFirstAid = level
      end
      --print("Profession: " .. skill .. " -> " .. level)
    end
    
    if prof1 ~= nil then
      local name1, _, skillLevel1, maxSkillLevel, _, _, _, IncreaseSkillLevel = LibAddonCompat:GetProfessionInfo(prof1)
      skillLevel_1 = skillLevel1
      name1 = string.gsub(name1, "ü", "ue")
      skillName_1 = string.gsub(name1, "ä", "ae")
    end

    if prof2 ~= nil then
      local name2, _, skillLevel2, maxSkillLevel, _, _, _, IncreaseSkillLevel = LibAddonCompat:GetProfessionInfo(prof2)
      skillLevel_2 = skillLevel2
      name2 = string.gsub(name2, "ü", "ue")
      skillName_2 = string.gsub(name2, "ä", "ae")
    end

    if GetXPExhaustion() ~= nil then Erholt = GetXPExhaustion() end
    
    DB[ Group ][ TempCharID ].Level = UnitLevel("player")   
    DB[ Group ][ TempCharID ].Gold = GetMoney("player")  
    DB[ Group ][ TempCharID ].XP = UnitXP("player")   
    DB[ Group ][ TempCharID ].XPmax = UnitXPMax("player")
    DB[ Group ][ TempCharID ].XPerh = Erholt
    DB[ Group ][ TempCharID ].Zone = GetZoneText()
    DB[ Group ][ TempCharID ].Profession1Name = skillName_1
    DB[ Group ][ TempCharID ].Profession2Name = skillName_2
    DB[ Group ][ TempCharID ].Profession1Level = skillLevel_1
    DB[ Group ][ TempCharID ].Profession2Level = skillLevel_2
    DB[ Group ][ TempCharID ].skillFishing = skillFishing
    DB[ Group ][ TempCharID ].skillCooking = skillCooking
    DB[ Group ][ TempCharID ].skillFirstAid = skillFirstAid
    DB[ Group ][ TempCharID ].Equip = {
      GetInventoryItemID("player", 1),
      GetInventoryItemID("player", 2),
      GetInventoryItemID("player", 3),
      GetInventoryItemID("player", 4),
      GetInventoryItemID("player", 5),
      GetInventoryItemID("player", 6),
      GetInventoryItemID("player", 7),
      GetInventoryItemID("player", 8),
      GetInventoryItemID("player", 9),
      GetInventoryItemID("player", 10),
      GetInventoryItemID("player", 11),
      GetInventoryItemID("player", 12),
      GetInventoryItemID("player", 13),
      GetInventoryItemID("player", 14),
      GetInventoryItemID("player", 15),
      GetInventoryItemID("player", 16),
      GetInventoryItemID("player", 17),
      GetInventoryItemID("player", 18),
      GetInventoryItemID("player", 19)        

    }

    
    --[[
            Stats = {}, 
            Equip = {}, 
            Profession = {}         
            ]]
            
          end
          

  --print("anzahl twinks: " .. table.getn( DB.Twinks ) )
  if OJMD_TV.TwinkViewerListViewItems == nil or table.getn( OJMD_TV.TwinkViewerListViewItems ) == 0 then OJMD_TV.UI.DrawTwinkViewerListview() end



  OJMD_TV.Functions.ShowTable()

end


function OJMD_TV.Functions.AddChar( Group )

  local genderTable = { "UNKNOWN", "MALE", "FEMALE" }
  local localizedClass, englishClass, classIndex = UnitClass("player")

  local CountChars =  table.getn( DB[ Group ] ) + 1

  
  if Group ~= nil then
    DB[ Group ][ CountChars ] = {
      Name = UnitName("player"),
      Realm = GetRealmName("player"),
      Faction = select(1, UnitFactionGroup("player") ) ,
      Race = UnitRace("player"),
      GUID = UnitGUID("player"),
      Class = string.upper( englishClass ),
      Gender = genderTable[ UnitSex("player") ]
    }
  end
  
  --print( "--> trage neuen Char ein!  Gruppe: " .. Group .. " Anzahl Chars: " .. CountChars )

  return CountChars
end


function OJMD_TV.Functions.ShowTable()

  if Filter == nil or Filter == "" then Filter = "Twinks" end

  if OJMD_TV.UI.MainFrame:IsShown() then
    print("Ja sichbar")
else
    print("nicht sichtbar!")
end

  --OJMD_TV.UI.RosterScrollFrame.Header:SetText("- " .. Filter .. " -")
              
  table.sort( DB[ Filter ], function(v1,v2) return v1.Level > v2.Level end)                    
  
  OJMD_TV.Functions.ClearListView()

  for i = 1, 10 do

      if DB[Filter][i] ~= nil then
        local v = DB[ Filter ][i]
        --print("i: " .. i .. " --> " .. v.Level) 
        OJMD_TV.TwinkViewerListViewItems[i]:Show()     
        OJMD_TV.TwinkViewerListViewItems[i].Level:SetText( v.Level )      
        --OJMD_TV.TwinkViewerListViewItems[i].RaceIcon.Texture:SetTexture(OJMD_TV.Data.RaceIcons[ v.Gender ][ v.Race])
        --print("Class: " .. v.Class)
        OJMD_TV.TwinkViewerListViewItems[i].ClassIcon.Texture:SetTexture(tostring("Interface/Addons/GuildHelperClassic/ClassIcons/".. v.Class))
        OJMD_TV.TwinkViewerListViewItems[i].Name:SetText( v.Name )
        OJMD_TV.TwinkViewerListViewItems[i].Name:SetTextColor(OJMD_TV.Data.ClassColours[ v.Class ].r,OJMD_TV.Data.ClassColours[ v.Class ].g,OJMD_TV.Data.ClassColours[ v.Class ].b)
        OJMD_TV.TwinkViewerListViewItems[i].Gold:SetText( OJMD_TV.Functions.GoldString( v.Gold )  )
        OJMD_TV.TwinkViewerListViewItems[i].StatusBar:SetValue((tonumber(v.XP) / tonumber(v.XPmax)) * 100.0)
        OJMD_TV.TwinkViewerListViewItems[i].StatusBar:SetStatusBarColor(0,.4, .9)        
        OJMD_TV.TwinkViewerListViewItems[i].StatusBarErholt:SetValue((tonumber(v.XP + v.XPerh) / tonumber(v.XPmax)) * 100.0)
        OJMD_TV.TwinkViewerListViewItems[i].StatusBarErholt:SetStatusBarColor(133/255, 88/255, 163/255)        
        OJMD_TV.TwinkViewerListViewItems[i].CharID = i        
        if v.Name == UnitName("player") then
          OJMD_TV.TwinkViewerListViewItems[i]:SetBackdropColor(OJMD_TV.Data.ClassColours[ v.Class ].r,OJMD_TV.Data.ClassColours[ v.Class ].g,OJMD_TV.Data.ClassColours[ v.Class ].b, .5)
        end   
        --profession 1
        if v.Profession1Name ~= nil and v.Profession1Level ~= 0 then
          OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon:Show()
          OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon.Texture:SetTexture( OJMD_TV.Data.ProfessionIcons[v.Profession1Name])
          OJMD_TV.TwinkViewerListViewItems[i].Profession1 = tostring(v.Profession1Name ..' ['..v.Profession1Level..']')
          OJMD_TV.TwinkViewerListViewItems[i].Profession1Level:SetText( v.Profession1Level )
        else
          OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon:Hide()
          OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon.Texture:SetTexture(nil)
          OJMD_TV.TwinkViewerListViewItems[i].Profession1 = ''
          OJMD_TV.TwinkViewerListViewItems[i].Profession1Level:SetText(" ")
        end
        --profession 2
        if v.Profession2Name ~= nil and v.Profession2Level ~= 0 then
          OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon:Show()
          OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon.Texture:SetTexture(OJMD_TV.Data.ProfessionIcons[v.Profession2Name])
          OJMD_TV.TwinkViewerListViewItems[i].Profession2 = tostring(v.Profession2Name..' ['..v.Profession2Level..']')
          OJMD_TV.TwinkViewerListViewItems[i].Profession2Level:SetText( v.Profession2Level )
      else
        OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon:Hide()
        OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon.Texture:SetTexture(nil)
        OJMD_TV.TwinkViewerListViewItems[i].Profession2 = ''
        OJMD_TV.TwinkViewerListViewItems[i].Profession2Level:SetText(" ")
      end

      --Cooking
      if v.skillCooking ~= nil and v.skillCooking ~= 0 then
        OJMD_TV.TwinkViewerListViewItems[i].CookingIcon:Show()
        --OJMD_TV.TwinkViewerListViewItems[i].CookingIcon.Texture:SetTexture(135805)      
        OJMD_TV.TwinkViewerListViewItems[i].CookingLevel:SetText( v.skillCooking )
    else
      OJMD_TV.TwinkViewerListViewItems[i].CookingIcon:Hide()
    end

      --Fisching
      if v.skillFishing ~= nil and v.skillFishing ~= 0 then
        OJMD_TV.TwinkViewerListViewItems[i].FishingIcon:Show()
        --OJMD_TV.TwinkViewerListViewItems[i].FishingIcon.Texture:SetTexture(136245)      
        OJMD_TV.TwinkViewerListViewItems[i].FishingLevel:SetText( v.skillFishing )
    else
      OJMD_TV.TwinkViewerListViewItems[i].FishingIcon:Hide()
    end

      --First Aid
      if v.skillFirstAid ~= nil and v.skillFirstAid ~= 0 then
        OJMD_TV.TwinkViewerListViewItems[i].FirstAidIcon:Show()
        --OJMD_TV.TwinkViewerListViewItems[i].FirstAidIcon.Texture:SetTexture('Interface\\Icons\\Spell_Holy_SealOfSacrifice')      
        OJMD_TV.TwinkViewerListViewItems[i].FirstAidLevel:SetText( v.skillFirstAid )
    else
      OJMD_TV.TwinkViewerListViewItems[i].FirstAidIcon:Hide()
    end
  --[[
      for x = 1, 18 do
        
        if v.Equip[x] ~= nil then
          OJMD_TV.TwinkViewerListViewItems[i].items[x].Texture:SetTexture(GetItemIcon( v.Equip[x] ) )
          OJMD_TV.TwinkViewerListViewItems[i].items[x].ItemID = v.Equip[x]
          local quality, ilevel, _, _, _, _, _, _, _, classId = select(3, GetItemInfo(v.Equip[x]))
          if quality then
            --print("ilevel: " .. ilevel .. " - " .. quality)
          local r, g, b, hex = GetItemQualityColor(quality)
            OJMD_TV.TwinkViewerListViewItems[i].items[x].glow:SetVertexColor(r, g, b)
          end
            OJMD_TV.TwinkViewerListViewItems[i].items[x].count:SetText( ilevel )
        else
          OJMD_TV.TwinkViewerListViewItems[i].items[x].ItemID = nil
          OJMD_TV.TwinkViewerListViewItems[i].items[x].Texture:SetTexture(nil)      
          OJMD_TV.TwinkViewerListViewItems[i].items[x].glow:SetTexture(nil)
        end  
      end 
      ]]
      end
    end
end


function OJMD_TV.Functions.ClearListView()

  for i = 1, 10 do    
    OJMD_TV.TwinkViewerListViewItems[i].Level:SetText('')      
    --OJMD_TV.TwinkViewerListViewItems[i].RaceIcon.Texture:SetTexture(nil)
    OJMD_TV.TwinkViewerListViewItems[i].ClassIcon.Texture:SetTexture(nil)
    OJMD_TV.TwinkViewerListViewItems[i].Name:SetText('')
    OJMD_TV.TwinkViewerListViewItems[i].Name:SetTextColor(nil)
    OJMD_TV.TwinkViewerListViewItems[i].Gold:SetText('')
    OJMD_TV.TwinkViewerListViewItems[i].StatusBar:SetValue(0)
    OJMD_TV.TwinkViewerListViewItems[i].StatusBar:SetStatusBarColor(nil)
    OJMD_TV.TwinkViewerListViewItems[i].FirstAidLevel:SetText('')
    OJMD_TV.TwinkViewerListViewItems[i].CookingLevel:SetText('')
    OJMD_TV.TwinkViewerListViewItems[i].FishingLevel:SetText('')
    OJMD_TV.TwinkViewerListViewItems[i]:Hide()
  end

end

function OJMD_TV.Functions.CloseFrame()
  OJMD_TV.UI.MainFrame:Hide();
end

function OJMD_TV.Functions.ShowTooltip(frame, text)
  OJMD_TV.UI.Tooltip:SetParent(frame)    
  OJMD_TV.UI.Tooltip.Text:SetText(text)
  local w = OJMD_TV.UI.Tooltip.Text:GetStringWidth()
  OJMD_TV.UI.Tooltip:SetSize(w + 24, 30)
  OJMD_TV.UI.Tooltip:SetPoint("TOPLEFT", - w * 1.25, 12)
  OJMD_TV.UI.Tooltip:Show()
end

function OJMD_TV.Functions.ToolTipp( frame , ItemID )

  
  
  if ItemID ~= nil then
    --local link = select(2, GetItemInfo( ItemID ) )--GetContainerItemLink(0,1)))
    GameTooltip:SetOwner(frame, "ANCHOR_CURSOR"); 
    GameTooltip:ClearLines(); 
    GameTooltip:SetItemByID( ItemID); 
    --GameTooltip:SetHyperlink(link)
   GameTooltip:Show()
  else
    GameTooltip:Hide()
  end
end


function OJMD_TV.Functions.ShowEquip( CharID )

  if CharID == nil then
    print( "ist  leer")
  else
    OJMD_TV.UI.MainFrame.buttonClose:Hide()
    OJMD_TV.UI.MainFrame.buttonBack:Show()
    OJMD_TV.UI.RosterScrollFrame:Hide()
    OJMD_TV.UI.DetailFrame:Show()
    
    print("CharID: " .. CharID)
  end
end

function OJMD_TV.Functions.Back() 
  OJMD_TV.UI.MainFrame.buttonClose:Show()
  OJMD_TV.UI.MainFrame.buttonBack:Hide()
  OJMD_TV.UI.RosterScrollFrame:Show()
  OJMD_TV.UI.DetailFrame:Hide()
  
end

function OJMD_TV.Functions.ScrollBarChanged(value)

  if DB[Filter]~= nil then    
    local v = math.ceil(value)
    OJMD_TV.UI.RosterScrollBar:SetMinMaxValues(1, math.ceil(#DB[Filter]/10))
    local i = 1
    OJMD_TV.Functions.ClearListView()

    --use i to access the listview item and k to access the guild db object
    for k, Chars in ipairs( DB[Filter] ) do            
        if k < ((v * 10) + 1) and k > ((v - 1) * 10) then   
          local v = DB[ Filter ][k]       
          OJMD_TV.TwinkViewerListViewItems[i]:Show()     
          OJMD_TV.TwinkViewerListViewItems[i].Level:SetText( v.Level )      
          --OJMD_TV.TwinkViewerListViewItems[i].RaceIcon.Texture:SetTexture(OJMD_TV.Data.RaceIcons[ v.Gender ][ v.Race])
          --print("Class: " .. v.Class)
          OJMD_TV.TwinkViewerListViewItems[i].ClassIcon.Texture:SetTexture(tostring("Interface/Addons/GuildHelperClassic/ClassIcons/".. v.Class))
          OJMD_TV.TwinkViewerListViewItems[i].Name:SetText( v.Name )
          OJMD_TV.TwinkViewerListViewItems[i].Name:SetTextColor(OJMD_TV.Data.ClassColours[ v.Class ].r,OJMD_TV.Data.ClassColours[ v.Class ].g,OJMD_TV.Data.ClassColours[ v.Class ].b)
          OJMD_TV.TwinkViewerListViewItems[i].Gold:SetText( OJMD_TV.Functions.GoldString( v.Gold )  )
          OJMD_TV.TwinkViewerListViewItems[i].StatusBar:SetValue((tonumber(v.XP) / tonumber(v.XPmax)) * 100.0)
          OJMD_TV.TwinkViewerListViewItems[i].StatusBar:SetStatusBarColor(0,.4, .9)        
          OJMD_TV.TwinkViewerListViewItems[i].StatusBarErholt:SetValue((tonumber(v.XP + v.XPerh) / tonumber(v.XPmax)) * 100.0)
          OJMD_TV.TwinkViewerListViewItems[i].StatusBarErholt:SetStatusBarColor(133/255, 88/255, 163/255)        
          OJMD_TV.TwinkViewerListViewItems[i].CharID = i        
          if v.Name == UnitName("player") then
            OJMD_TV.TwinkViewerListViewItems[i]:SetBackdropColor(OJMD_TV.Data.ClassColours[ v.Class ].r,OJMD_TV.Data.ClassColours[ v.Class ].g,OJMD_TV.Data.ClassColours[ v.Class ].b, .5)
          end   
          --profession 1
          if v.Profession1Name ~= nil and v.Profession1Level ~= 0 then
            OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon:Show()
            OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon.Texture:SetTexture( OJMD_TV.Data.ProfessionIcons[v.Profession1Name])
            OJMD_TV.TwinkViewerListViewItems[i].Profession1 = tostring(v.Profession1Name ..' ['..v.Profession1Level..']')
            OJMD_TV.TwinkViewerListViewItems[i].Profession1Level:SetText( v.Profession1Level )
          else
            OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon:Hide()
            OJMD_TV.TwinkViewerListViewItems[i].Profession1Icon.Texture:SetTexture(nil)
            OJMD_TV.TwinkViewerListViewItems[i].Profession1 = ''
            OJMD_TV.TwinkViewerListViewItems[i].Profession1Level:SetText(" ")
          end
          --profession 2
          if v.Profession2Name ~= nil and v.Profession2Level ~= 0 then
            OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon:Show()
            OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon.Texture:SetTexture(OJMD_TV.Data.ProfessionIcons[v.Profession2Name])
            OJMD_TV.TwinkViewerListViewItems[i].Profession2 = tostring(v.Profession2Name..' ['..v.Profession2Level..']')
            OJMD_TV.TwinkViewerListViewItems[i].Profession2Level:SetText( v.Profession2Level )
        else
          OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon:Hide()
          OJMD_TV.TwinkViewerListViewItems[i].Profession2Icon.Texture:SetTexture(nil)
          OJMD_TV.TwinkViewerListViewItems[i].Profession2 = ''
          OJMD_TV.TwinkViewerListViewItems[i].Profession2Level:SetText(" ")
        end
  
        --Cooking
        if v.skillCooking ~= nil and v.skillCooking ~= 0 then
          OJMD_TV.TwinkViewerListViewItems[i].CookingIcon:Show()  
          OJMD_TV.TwinkViewerListViewItems[i].CookingLevel:SetText( v.skillCooking )
      else
        OJMD_TV.TwinkViewerListViewItems[i].CookingIcon:Hide()
      end
  
        --Fisching
        if v.skillFishing ~= nil and v.skillFishing ~= 0 then
          OJMD_TV.TwinkViewerListViewItems[i].FishingIcon:Show()
          OJMD_TV.TwinkViewerListViewItems[i].FishingLevel:SetText( v.skillFishing )
      else
        OJMD_TV.TwinkViewerListViewItems[i].FishingIcon:Hide()
      end
  
        --First Aid
        if v.skillFirstAid ~= nil and v.skillFirstAid ~= 0 then
          OJMD_TV.TwinkViewerListViewItems[i].FirstAidIcon:Show()    
          OJMD_TV.TwinkViewerListViewItems[i].FirstAidLevel:SetText( v.skillFirstAid )
        else
          OJMD_TV.TwinkViewerListViewItems[i].FirstAidIcon:Hide()
        end

            i = i + 1
        end
    end
end

end