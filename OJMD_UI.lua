local name, OJMD_TV = ...

SLASH_OJMDTwinkViewer1 = '/OJMD_TV'
SlashCmdList['OJMDTwinkViewer'] = function(msg)

    if msg == 'toggle' then

        if OJMD_TV.UI.MainFrame:IsVisible() then
            --print("Ja sichbar")
            OJMD_TV.UI.MainFrame:Hide()
        else
            --print("nicht sichtbar!")
            OJMD_TV.UI.MainFrame:Show()
        end

        --OJMD_TV.UI.MainFrame:Show()
     --   //print('helping :/')
    end
    --[[    
    elseif msg == 'fix' then
        StaticPopup_Show("GHC_FixMe")

        --move this into a function
    elseif msg == 'scangb' then
        GHC.Functions.ScanGuildBank()


    end
    ]]
end


OJMD_TV.UI = {
    SmallFontSize = 8.0,
    MiddleFontSize = 11.0,
    LargeFontSize = 14.0,
    FontSizeLevel = 15.0,
    XpBarHeight = 8,
    FontSizeTooltip = 11.0,
    XpBarWidth = 215
}


--[[ MAIN Frame ]]--

OJMD_TV.UI.MainFrame = CreateFrame("FRAME", "MainFrame_TwinkViewer", UIParent, "ButtonFrameTemplate") --UIParent) CharacterFrame

OJMD_TV.UI.MainFrame:SetPoint("CENTER", UIParent, "CENTER")
OJMD_TV.UI.MainFrame:SetBackdrop({ edgeFile = "interface/dialogframe/ui-dialogbox-border", tile = true, tileSize = 16, edgeSize = 20, insets = { left = 4, right = 4, top = 4, bottom = 4 }});
OJMD_TV.UI.MainFrame:SetSize(550, 550)  --(680, 500)
OJMD_TV.UI.MainFrame.Texture = OJMD_TV.UI.MainFrame:CreateTexture('$parent_Texture', 'BACKGROUND')
OJMD_TV.UI.MainFrame.Texture:SetTexture("interface/dialogframe/ui-dialogbox-background")
OJMD_TV.UI.MainFrame.Texture:SetPoint('TOPLEFT', 4, -4)
OJMD_TV.UI.MainFrame.Texture:SetPoint('BOTTOMRIGHT', -4, 4)

OJMD_TV.UI.MainFrame:EnableMouse(true)
OJMD_TV.UI.MainFrame:SetMovable(true)
OJMD_TV.UI.MainFrame:SetClampedToScreen(true)
OJMD_TV.UI.MainFrame:RegisterForDrag("LeftButton")
OJMD_TV.UI.MainFrame:SetScript("OnDragStart", OJMD_TV.UI.MainFrame.StartMoving)
OJMD_TV.UI.MainFrame:SetScript("OnDragStop", OJMD_TV.UI.MainFrame.StopMovingOrSizing)


-- Title
OJMD_TV.UI.MainFrame.title = OJMD_TV.UI.MainFrame:CreateFontString("TwinkViewer_Title", "OVERLAY", "GameFontNormal")
OJMD_TV.UI.MainFrame.title:SetPoint("TOP", 0, -5)
OJMD_TV.UI.MainFrame.title:SetText( "TwinkViewer :: Version 0.8" )
OJMD_TV.UI.MainFrame.title:SetTextColor(1,1,1,1)
OJMD_TV.UI.MainFrame.title:SetFont("Fonts\\FRIZQT__.TTF", 12)

OJMD_TV.UI.MainFrame.icon = OJMD_TV.UI.MainFrame:CreateTexture("MainFrame_TwinkViewer_Icon", "OVERLAY")
OJMD_TV.UI.MainFrame.icon:SetSize(64, 64)
OJMD_TV.UI.MainFrame.icon:SetPoint("TOPLEFT", -9, 9)
OJMD_TV.UI.MainFrame.icon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
       
OJMD_TV.UI.MainFrame.buttonClose = CreateFrame("Button", "MainFrame_TwinkViewer_Close", OJMD_TV.UI.MainFrame , "UIPanelButtonTemplate")
OJMD_TV.UI.MainFrame.buttonClose:SetPoint("BOTTOMRIGHT", -6, 4)
OJMD_TV.UI.MainFrame.buttonClose:SetSize(110, 22)
OJMD_TV.UI.MainFrame.buttonClose:SetText( "Schließen" )
OJMD_TV.UI.MainFrame.buttonClose:SetScript("OnClick", OJMD_TV.Functions.CloseFrame )

OJMD_TV.UI.MainFrame.buttonBack = CreateFrame("Button", "MainFrame_TwinkViewer_Back", OJMD_TV.UI.MainFrame , "UIPanelButtonTemplate")
OJMD_TV.UI.MainFrame.buttonBack:SetPoint("BOTTOMRIGHT", -6, 4)
OJMD_TV.UI.MainFrame.buttonBack:SetSize(110, 22)
OJMD_TV.UI.MainFrame.buttonBack:SetText( "Zurück" )
OJMD_TV.UI.MainFrame.buttonBack:SetScript("OnClick", OJMD_TV.Functions.Back )
OJMD_TV.UI.MainFrame.buttonBack:Hide()

--[[
local buttonTwinks = CreateFrame("Button", "MainFrame_TwinkViewer_Close2", OJMD_TV.UI.MainFrame , "UIPanelButtonTemplate")
buttonTwinks:SetPoint("BOTTOMLEFT", 6, 4)
buttonTwinks:SetSize(80, 22 )
buttonTwinks:SetText( "Twinks" )
buttonTwinks:SetScript("OnClick", OJMD_TV.Functions.ShowTable ) 

local buttonGuild = CreateFrame("Button", "MainFrame_TwinkViewer_Close2", OJMD_TV.UI.MainFrame , "UIPanelButtonTemplate")
buttonGuild:SetPoint("BOTTOMLEFT", 90, 4)
buttonGuild:SetSize(80, 22)
buttonGuild:SetText( "Gilde" )
buttonGuild:SetScript("OnClick", OJMD_TV.Functions.ShowTable ) 
--buttonGuild:SetScript("OnClick", "" )
]]


--[[
SetPortraitToTexture(frame.icon, "Interface\\Icons\\INV_Misc_EngGizmos_17")
]]

--[[

local buttonFriends = CreateFrame("Button", "MainFrame_TwinkViewer_Close2", OJMD_TV.UI.MainFrame , "UIPanelButtonTemplate")
buttonFriends:SetPoint("TOPLEFT", 20, -100)
buttonFriends:SetSize(100, 30)
buttonFriends:SetText( "Freunde" )
--buttonFriends:SetScript("OnClick", "" )
]]

OJMD_TV.UI.RosterScrollFrame = CreateFrame("SCROLLFRAME", "GHC_GuildRosterScrollframe", OJMD_TV.UI.MainFrame)
OJMD_TV.UI.RosterScrollFrame:SetPoint("TOPLEFT", 0, -60)
OJMD_TV.UI.RosterScrollFrame:SetSize(520, 400)

OJMD_TV.UI.RosterScrollFrame.Header = OJMD_TV.UI.RosterScrollFrame:CreateFontString("GHC_PlayerOptionsFrame_Header", 'OVERLAY', 'GameFontNormal')
OJMD_TV.UI.RosterScrollFrame.Header:SetPoint("TOP", 0, 16)
OJMD_TV.UI.RosterScrollFrame.Header:SetText("- Twinks -")
OJMD_TV.UI.RosterScrollFrame.Header:SetTextColor(1,1,1,1)
OJMD_TV.UI.RosterScrollFrame.Header:SetFont("Fonts\\FRIZQT__.TTF", tonumber(OJMD_TV.UI.LargeFontSize))

OJMD_TV.UI.RosterScrollBar = CreateFrame("Slider", "AJ_ConsumablesListViewFrame_ScrollFrame", OJMD_TV.UI.RosterScrollFrame, "UIPanelScrollBarTemplate")
OJMD_TV.UI.RosterScrollBar:SetPoint("TOPLEFT", OJMD_TV.UI.RosterScrollFrame, "TOPRIGHT", 0, -22) 
OJMD_TV.UI.RosterScrollBar:SetPoint("BOTTOMLEFT", OJMD_TV.UI.RosterScrollFrame, "BOTTOMRIGHT", 0, 22)
OJMD_TV.UI.RosterScrollBar:SetMinMaxValues(1, 10)
OJMD_TV.UI.RosterScrollBar:SetValueStep(1.0)
OJMD_TV.UI.RosterScrollBar.scrollStep = 1
OJMD_TV.UI.RosterScrollBar:SetValue(1)
OJMD_TV.UI.RosterScrollBar:SetWidth(16)
OJMD_TV.UI.RosterScrollBar:SetScript('OnValueChanged', function(self, value) OJMD_TV.Functions.ScrollBarChanged(value) end)

OJMD_TV.TwinkViewerListViewItems = {}   

function OJMD_TV.UI.DrawTwinkViewerListview()   
    --print( "Erstelle Liste mit Menge: " .. table.getn( DB.Twinks ) ) 
    for i = 1, 10 do
        local f = CreateFrame("BUTTON", tostring("GHC_GuildRosterListViewItem"..i), OJMD_TV.UI.RosterScrollFrame)
        f:SetPoint("TOPLEFT", 12, ((44 * (i - 1)) * -1) - 4)
        f:SetSize(500, 48)
        f:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 } })
        f:SetBackdropColor(0, 0, 0, 0.1)

        f.ClassIcon = CreateFrame("FRAME", tostring("GHC_GuildRosterListViewItem"..i.."_ClassIcon"), f)
        f.ClassIcon:SetPoint("LEFT", 6, -2)
        f.ClassIcon:SetSize(45, 45)
        f.ClassIcon.Texture = f.ClassIcon:CreateTexture("$parent_Background", "BACKGROUND")
        f.ClassIcon:SetBackdropColor(0, 0, 0, 0.1)
        f.ClassIcon.Texture:SetAllPoints(f.ClassIcon)

--        f.RaceIcon = CreateFrame("FRAME", tostring("GHC_GuildRosterListViewItem"..i.."_RaceIcon"), f)
 --       f.RaceIcon:SetPoint("RIGHT", -2, -2)
 --       f.RaceIcon:SetSize(32, 32)
 --       f.RaceIcon.Texture = f.RaceIcon:CreateTexture("$parent_Background", "BACKGROUND")
 --       f.RaceIcon.Texture:SetAllPoints(f.RaceIcon)

        f.Name = f:CreateFontString(tostring("GHC_GuildRosterListViewItem"..i.."_NameText"), 'OVERLAY', 'GameFontNormal')
        f.Name:SetPoint("TOPLEFT", 78, -6)
        f.Name:SetTextColor(1,1,1,1)
        f.Name:SetFont("Fonts\\FRIZQT__.TTF", tonumber(OJMD_TV.UI.LargeFontSize))        
        
        f.Level = f.ClassIcon:CreateFontString(tostring("GHC_GuildRosterListViewItem"..i.."_LevelText"), 'OVERLAY', 'GameFontNormal')
        f.Level:SetPoint("TOPRIGHT", 21, -5)
        --f.Level:SetPoint("CENTER", -2, 0)
        f.Level:SetTextColor(1,1,1,1)
        --f.Level:SetShadow(1,1,1, .5)
        f.Level:SetShadowOffset(1,-2)
        f.Level:SetFont("Fonts\\FRIZQT__.TTF", tonumber(OJMD_TV.UI.FontSizeLevel))
        
        f.Gold = f:CreateFontString(tostring("GHC_GuildRosterListViewItem"..i.."_Gold"), 'OVERLAY', 'GameFontNormal')
        f.Gold:SetPoint("RIGHT", -233, 10)
        f.Gold:SetTextColor(1,1,1,1)
        f.Gold:SetFont("Fonts\\FRIZQT__.TTF", tonumber(OJMD_TV.UI.MiddleFontSize))      
     
        f.StatusBarErholt = CreateFrame("StatusBar", tostring("GHC_GuildSummaryClassFrame_StatusBar"..i), f)
        f.StatusBarErholt:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        f.StatusBarErholt:GetStatusBarTexture():SetHorizTile(true)
        f.StatusBarErholt:SetMinMaxValues(0, 100)
        f.StatusBarErholt:SetSize(OJMD_TV.UI.XpBarWidth, OJMD_TV.UI.XpBarHeight)
        f.StatusBarErholt:SetPoint('TOPLEFT', 52, -28)
        f.StatusBarErholt:SetStatusBarColor(0,0,0, 0)	
        
        f.StatusBar = CreateFrame("StatusBar", tostring("GHC_GuildSummaryClassFrame_StatusBar"..i), f)
        f.StatusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        f.StatusBar:GetStatusBarTexture():SetHorizTile(true)
        f.StatusBar:SetMinMaxValues(0, 100)
        f.StatusBar:SetSize(OJMD_TV.UI.XpBarWidth, OJMD_TV.UI.XpBarHeight)
        f.StatusBar:SetPoint('TOPLEFT', 52, -28)
        f.StatusBar:SetStatusBarColor(0,0,0, 0)	
        
        
        f.StatusBar.bg = f.StatusBar:CreateTexture(nil, "BACKGROUND")
        f.StatusBar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
        f.StatusBar.bg:SetAllPoints()
        f.StatusBar.bg:SetVertexColor(1, 1, 1, .1)
 
        f.Profession1Icon = CreateFrame("FRAME", tostring("GHC_GuildMemberDetailFrame_Profession1Icon"), f)
        f.Profession1Icon:SetPoint("LEFT", 290, 0)
        f.Profession1Icon:SetSize(35, 35)
        f.Profession1Icon.Texture = f.Profession1Icon:CreateTexture("$parent_Background", "BACKGROUND")
        f.Profession1Icon.Texture:SetAllPoints(f.Profession1Icon)
        f.Profession1 = nil
        --f.Profession1Icon:SetScript("OnEnter", function() OJMD_TV.Functions.ShowTooltip(f.Profession1Icon, f.Profession1) end)
        --f.Profession1Icon:SetScript("OnLeave", function() OJMD_TV.UI.Tooltip:Hide() end)

        f.Profession1Level = f.Profession1Icon:CreateFontString("$parentCount", "BORDER", "NumberFontNormal")
        f.Profession1Level:SetPoint("BOTTOMRIGHT", -5, 2)
        f.Profession1Level:SetJustifyH("RIGHT")

        f.Profession2Icon = CreateFrame("FRAME", tostring("GHC_GuildMemberDetailFrame_Profession2Icon"), f)
        f.Profession2Icon:SetPoint("LEFT", 330, 0)
        f.Profession2Icon:SetSize(35, 35)
        f.Profession2Icon.Texture = f.Profession2Icon:CreateTexture("$parent_Background", "BACKGROUND")
        f.Profession2Icon.Texture:SetAllPoints(f.Profession2Icon)
        f.Profession2 = nil
        --f.Profession2Icon:SetScript("OnEnter", function() OJMD_TV.Functions.ShowTooltip(f.Profession2Icon, f.Profession2) end)
        --f.Profession2Icon:SetScript("OnLeave", function() OJMD_TV.UI.Tooltip:Hide() end)

        f.Profession2Level = f.Profession2Icon:CreateFontString("$parentCount", "BORDER", "NumberFontNormal")
        f.Profession2Level:SetPoint("BOTTOMRIGHT", -5, 2)
        f.Profession2Level:SetJustifyH("RIGHT")

        f.CookingIcon = CreateFrame("FRAME", tostring("GHC_GuildMemberDetailFrame_Profession2Icon"), f)
        f.CookingIcon:SetPoint("LEFT", 380, 0)
        f.CookingIcon:SetSize(35, 35)
        f.CookingIcon.Texture = f.CookingIcon:CreateTexture("$parent_Background", "BACKGROUND")
        f.CookingIcon.Texture:SetTexture(135805)
        f.CookingIcon.Texture:SetAllPoints(f.CookingIcon)

        f.CookingLevel = f.CookingIcon:CreateFontString("$parentCount", "BORDER", "NumberFontNormal")
        f.CookingLevel:SetPoint("BOTTOMRIGHT", -5, 2)
        f.CookingLevel:SetJustifyH("RIGHT")
        
        f.FishingIcon = CreateFrame("FRAME", tostring("GHC_GuildMemberDetailFrame_Profession2Icon"), f)
        f.FishingIcon:SetPoint("LEFT", 420, 0)
        f.FishingIcon:SetSize(35, 35)
        f.FishingIcon.Texture = f.FishingIcon:CreateTexture("$parent_Background", "BACKGROUND")
        f.FishingIcon.Texture:SetTexture(136245)   
        f.FishingIcon.Texture:SetAllPoints(f.FishingIcon)

        f.FishingLevel = f.FishingIcon:CreateFontString("$parentCount", "BORDER", "NumberFontNormal")
        f.FishingLevel:SetPoint("BOTTOMRIGHT", -5, 2)
        f.FishingLevel:SetJustifyH("RIGHT")
        
        f.FirstAidIcon = CreateFrame("FRAME", tostring("GHC_GuildMemberDetailFrame_Profession2Icon"), f)
        f.FirstAidIcon:SetPoint("LEFT", 460, 0)
        f.FirstAidIcon:SetSize(35, 35)
        f.FirstAidIcon.Texture = f.FirstAidIcon:CreateTexture("$parent_Background", "BACKGROUND")
        f.FirstAidIcon.Texture:SetTexture('Interface\\Icons\\Spell_Holy_SealOfSacrifice') 
        f.FirstAidIcon.Texture:SetAllPoints(f.FirstAidIcon)

        f.FirstAidLevel = f.FirstAidIcon:CreateFontString("$parentCount", "BORDER", "NumberFontNormal")
        f.FirstAidLevel:SetPoint("BOTTOMRIGHT", -5, 2)
        f.FirstAidLevel:SetJustifyH("RIGHT")
        
        f.PublicNote = nil
        f.CharID = nil

        
        f:SetScript("OnClick", function(self) OJMD_TV.Functions.ShowEquip( f.CharID )  end)
        --   f:SetScript("OnClick", function(self) print(" T E S T ") end)
        f:SetScript("OnEnter", function()  f:SetBackdropColor(0, 1, 0, 0.5) end)
        f:SetScript("OnLeave", function()  f:SetBackdropColor(0, 0, 0, 0.1) end)
        
        
--[[
            f.items = {}
        for idx = 1, 18 do

            local item = CreateFrame("Button", "BagBuddy_Item" .. idx, f, "SecureActionButtonTemplate")
            item:SetSize(35, 35)
            
            item:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2")
            item:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
            item:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
            do local tex = item:GetNormalTexture()
                tex:ClearAllPoints()
                tex:SetPoint("CENTER", 0, -1)
                tex:SetSize(64, 64)
            end
            item.Texture = item:CreateTexture("$parent_Background", "BACKGROUND")
            item.Texture:SetAllPoints(item)
            
            item.icon = item:CreateTexture("$parentIconTexture", "BORDER")
            
            item.count = item:CreateFontString("$parentCount", "BORDER", "NumberFontNormal")
            item.count:SetPoint("BOTTOMRIGHT", -5, 2)
            item.count:SetJustifyH("RIGHT")
            --item.count:Hide()
            
            item.glow = item:CreateTexture("$parentGlow", "OVERLAY")
            item.glow:SetPoint("CENTER")
            item.glow:SetSize(70, 70)
            item.glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
            item.glow:SetBlendMode("ADD")
            item.glow:SetAlpha(0.6)
            
            item.ItemID = nil

            item:SetScript("OnEnter", function(self) OJMD_TV.Functions.ToolTipp( item , item.ItemID ) end)
            item:SetScript("OnLeave", function() GameTooltip:Hide() end)
            --GameTooltip:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
            --item.ToolTip:SetScript("OnEnter", function() OJMD_TV.Functions.ShowTooltip("", "TEST") end)
            
            f.items[idx] = item
            
           if idx == 1 then
                item:SetPoint("LEFT", 440, 0)
            --elseif idx == 5 then
                -- or idx == 15 or idx == 22 then
             --   item:SetPoint("TOPLEFT", f.items[idx - 7], "BOTTOMLEFT", 0, -7)

            -- item:SetPoint('CENTER', 'CharacterChestSlot', 'CENTER', 68, 68)
            
             -- :SetPoint('CENTER', CharacterChestSlot, 'CENTER', 68, 68;
           else
            item:SetPoint("TOPLEFT", f.items[idx - 1], "TOPRIGHT", 12, 0)
           end

        end
]]

        f.PublicNote = nil
        --f.RaceIcon:SetScript("OnEnter", function(self) GHC.Functions.ShowTooltip(f.RaceIcon, f.PublicNote) end)
        --f.RaceIcon:SetScript("OnLeave", function() GHC.UI.Tooltip:Hide() end)

        OJMD_TV.TwinkViewerListViewItems[i] = f
    end
end


OJMD_TV.UI.DetailFrame = CreateFrame("FRAME", "OJMD_TV_DetailFrame", MainFrame_TwinkViewer )
OJMD_TV.UI.DetailFrame:SetSize(550, 550)
OJMD_TV.UI.DetailFrame:SetPoint("TOP", 0, -5)
OJMD_TV.UI.DetailFrame:SetBackdropColor(1, 1, 0, 1)
OJMD_TV.UI.DetailFrame:Hide()

OJMD_TV.UI.DetailFrame.Name = OJMD_TV.UI.DetailFrame:CreateFontString("OJMD_TV_DetailFrame_Titel", 'OVERLAY', 'GameFontNormal')
OJMD_TV.UI.DetailFrame.Name:SetPoint("TOP", 0, -40)
OJMD_TV.UI.DetailFrame.Name:SetTextColor(1,1,1,1)
OJMD_TV.UI.DetailFrame.Name:SetText( "- Details -" )
OJMD_TV.UI.DetailFrame.Name:SetFont("Fonts\\FRIZQT__.TTF", tonumber(OJMD_TV.UI.LargeFontSize))    


--[[
-- The close button for BagBuddy.
OJMD_TV.UI.MainFrame.close = CreateFrame("Button", "MainFrame_TwinkViewer_Close", OJMD_TV.UI.MainFrame, "UIPanelCloseButton")
OJMD_TV.UI.MainFrame.close:SetPoint("TOPRIGHT", -10, -10)
]]




--used for roster listview profession icons
OJMD_TV.UI.Tooltip = CreateFrame("FRAME", "OJMD_TV_Tooltip", UIParent, "TooltipBorderedFrameTemplate")
OJMD_TV.UI.Tooltip.Text = OJMD_TV.UI.Tooltip:CreateFontString("OJMD_TV_TooltipText", "OVERLAY", "GameFontNormal")
OJMD_TV.UI.Tooltip.Text:SetPoint("CENTER", 0, 0)
OJMD_TV.UI.Tooltip.Text:SetFont("Fonts\\FRIZQT__.TTF", tonumber(OJMD_TV.UI.FontSizeTooltip))
--GHC.UI.Tooltip.Text:SetTextColor(1,1,1,1)


function OJMD_TV.OnEvent(self, event, ...)

    --standard addon loaded events, register addon chat channel prefix, after 1 second delay (allowing for GUIDs) draw and load data
    if event == "ADDON_LOADED" and select(1, ...) == "OJMD_TwinkViewer" then

        if DB == nil then 
            DB = {} 
            DB.Twinks = {}
            DB.Friends = {}
            DB.Guild = {}
        end      
        
        --OJMD_TV.UI.DrawTwinkViewerListview()       
        
    end   

    if event == "PLAYER_ENTERING_WORLD" then
        --print("--> Event Player entering World ") 
        OJMD_TV.Functions.UpdateAll( "Twinks" )
    end
    
    if ( event == "PLAYER_MONEY" ) then
        --print("--> Event Money ") 
        OJMD_TV.Functions.UpdateAll( "Twinks" )            
    end

    if ( event == "PLAYER_LEVEL_UP" ) then
        --print("--> Event Money ") 
        OJMD_TV.Functions.UpdateAll( "Twinks" )            
    end

    if ( event == "PLAYER_EQUIPMENT_CHANGED" ) then
        --print("--> Event Money ") 
        OJMD_TV.Functions.UpdateAll( "Twinks" )            
    end

end


OJMD_TV.UI.MainFrame:RegisterEvent("ADDON_LOADED")
OJMD_TV.UI.MainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
OJMD_TV.UI.MainFrame:RegisterEvent('PLAYER_LEVEL_UP')
OJMD_TV.UI.MainFrame:RegisterEvent('CHAT_MSG_SKILL')
OJMD_TV.UI.MainFrame:RegisterEvent('PLAYER_MONEY')
OJMD_TV.UI.MainFrame:RegisterEvent('PLAYER_XP_UPDATE')
OJMD_TV.UI.MainFrame:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
OJMD_TV.UI.MainFrame:SetScript("OnEvent", OJMD_TV.OnEvent)