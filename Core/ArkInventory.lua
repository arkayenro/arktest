﻿-- local addonName, addonTbl = ...

--License: All Rights Reserved, (c) 2006-2024


local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table




ArkInventory.Const.BindingText = {
	
	{ id = ArkInventory.ENUM.ITEM.BINDING.ACCOUNTEQUIP, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_ACCOUNTBOUND_UNTIL_EQUIP"] },
	
	{ id = ArkInventory.ENUM.ITEM.BINDING.ACCOUNT, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_ACCOUNTBOUND"] },
	{ id = ArkInventory.ENUM.ITEM.BINDING.ACCOUNT, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_BIND_TO_ACCOUNT"] },
	{ id = ArkInventory.ENUM.ITEM.BINDING.ACCOUNT, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_BIND_TO_BNETACCOUNT"] },
	{ id = ArkInventory.ENUM.ITEM.BINDING.ACCOUNT, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_BNETACCOUNTBOUND"] },
	
	{ id = ArkInventory.ENUM.ITEM.BINDING.PICKUP, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_SOULBOUND"] },
	{ id = ArkInventory.ENUM.ITEM.BINDING.PICKUP, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_BIND_ON_PICKUP"] },
	
	{ id = ArkInventory.ENUM.ITEM.BINDING.EQUIP, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_BIND_ON_EQUIP"] },
	
	{ id = ArkInventory.ENUM.ITEM.BINDING.USE, text = ArkInventory.Localise["WOW_TOOLTIP_ITEM_BIND_ON_USE"] },
	
}

ArkInventory.Const.ButtonData = {
	[ArkInventory.ENUM.BUTTONID.MainMenu] = {
		Texture = nil,
		Name = ArkInventory.Localise["MENU"],
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.MenuMainOpen( self )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["MENU"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.Close] = {
		Texture = [[Interface\RAIDFRAME\ReadyCheck-NotReady]],
		Name = ArkInventory.Localise["CLOSE"],
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				local loc_id_window = self:GetParent( ):GetParent( ):GetID( )
				ArkInventory.Frame_Main_Hide( loc_id_window )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["CLOSE"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.EditMode] = {
		Texture = [[Interface\Icons\Trade_Engineering]],
		Name = ArkInventory.Localise["MENU_ACTION_EDITMODE"],
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
				ArkInventory.ToggleEditMode( )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["MENU_ACTION_EDITMODE"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.Rules] = {
		--Texture = [[Interface\Icons\INV_Misc_Note_05]],
		--Texture = [[Interface\Icons\Interface\Icons\INV_Gizmo_02]],
		Texture = [[Interface\Icons\INV_Misc_Book_10]],
		Name = ArkInventory.Localise["RULES"],
		LDB = true,
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
				ArkInventory.Frame_Rules_Toggle( )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["RULES"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.Search] = {
		--Texture = [[Interface\Icons\INV_Misc_EngGizmos_20]],
		Texture = [[Interface\Minimap\Tracking\None]],
		Name = ArkInventory.Localise["SEARCH"],
		LDB = true,
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				if button == "RightButton" then
					ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
					local loc_id_window = self:GetParent( ):GetParent( ):GetID( )
					if ArkInventory.Global.Location[loc_id_window].canSearch then
						ArkInventory.Global.Location[loc_id_window].filter = ""
						local me = ArkInventory.Codex.GetPlayer( loc_id_window )
						me.style.search.hide = not me.style.search.hide
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
					end
				else
					ArkInventory.Search.Frame_Toggle( )
				end
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["SEARCH"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.SwitchCharacter] = {
		Texture = [[Interface\Icons\INV_Shirt_Orange_01]],
		Name = ArkInventory.Localise["MENU_CHARACTER_SWITCH"],
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
				ArkInventory.MenuSwitchCharacterOpen( self )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["MENU_CHARACTER_SWITCH"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.SwitchLocation] = {
		Texture = [[Interface\Icons\INV_Helmet_47]],
		Name = ArkInventory.Localise["LOCATIONS"],
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
				ArkInventory.MenuSwitchLocationOpen( self )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["LOCATIONS"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.Restack] = {
		Texture = [[Interface\Icons\INV_Misc_Gift_05]],
		Name = function( )
			if ArkInventory.db.option.cleanup.enable then
				return ArkInventory.Localise["CLEANUP"]
			else
				return ArkInventory.Localise["RESTACK"]
			end
		end,
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				if button == "RightButton" then
					ArkInventory.Frame_Config_Show( "general", "restack" )
				else
					local loc_id_window = self:GetParent( ):GetParent( ):GetID( )
					ArkInventory.Restack( loc_id_window )
				end
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Const.ButtonData[ArkInventory.ENUM.BUTTONID.Restack].Name( ) )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.Changer] = {
		Texture = [[Interface\Icons\INV_Misc_EngGizmos_17]],
		Name = ArkInventory.Localise["SUBFRAME_NAME_BAGCHANGER"],
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
				ArkInventory.ToggleChanger( self:GetParent( ):GetParent( ):GetID( ) )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["SUBFRAME_NAME_BAGCHANGER"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.Refresh] = {
		Texture = [[Interface\Icons\Spell_Frost_Stun]],
		Name = ArkInventory.Localise["REFRESH"],
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
				if button == "RightButton" then
					ArkInventory.MenuRefreshOpen( self )
				else
					local loc_id_window = self:GetParent( ):GetParent( ):GetID( )
					--ArkInventory.OutputWarning( "refresh action - .Recalculate" )
					ArkInventory.Global.Location[loc_id_window].retryCount = 0
					ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Recalculate )
				end
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["REFRESH"] )
			end,
		},
	},
	[ArkInventory.ENUM.BUTTONID.Actions] = {
		Texture = [[Interface\Icons\INV_Gizmo_02]],
		Name = ArkInventory.Localise["ACTIONS"],
		LDB = true,
		Scripts = {
			OnClick = function( self, button )
				if not self then return end
				ArkInventory.Frame_Main_Level( self:GetParent( ):GetParent( ) )
				ArkInventory.Frame_Actions_Toggle( )
			end,
			OnEnter = function( self )
				ArkInventory.GameTooltipSetText( self, ArkInventory.Localise["ACTIONS"] )
			end,
		},
	},
}

ArkInventory.Const.Tradeskill = {
	numPrimary = 2,
	numSecondary = 3,
	maxLearn = 5,
	ToolSlotNames = {
		[1] = { "Prof0ToolSlot", "Prof0Gear0Slot", "Prof0Gear1Slot" },
		[2] = { "Prof1ToolSlot", "Prof1Gear0Slot", "Prof1Gear1Slot" },
		[3] = { "CookingToolSlot", "CookingGear0Slot" },
		[4] = { "FishingToolSlot" },
		[5] = { },
	},
	Data = {
		-- primary crafting
		[171] = {
			id = "SKILL_ALCHEMY",
			pt = "ArkInventory.Skill.Alchemy",
			text = ArkInventory.Localise["WOW_SKILL_ALCHEMY"],
			primary = true,
		},
		[164] = {
			id = "SKILL_BLACKSMITHING",
			pt = "ArkInventory.Skill.Blacksmithing",
			text = ArkInventory.Localise["WOW_SKILL_BLACKSMITHING"],
			primary = true,
		},
		[333] = {
			id = "SKILL_ENCHANTING",
			pt = "ArkInventory.Skill.Enchanting",
			text = ArkInventory.Localise["WOW_SKILL_ENCHANTING"],
			primary = true,
		},
		[202] = {
			id = "SKILL_ENGINEERING",
			pt = "ArkInventory.Skill.Engineering",
			text = ArkInventory.Localise["WOW_SKILL_ENGINEERING"],
			primary = true,
		},
		[773] = {
			id = "SKILL_INSCRIPTION",
			pt = "ArkInventory.Skill.Inscription",
			text = ArkInventory.Localise["WOW_SKILL_INSCRIPTION"],
			primary = true,
		},
		[755] = {
			id = "SKILL_JEWELCRAFTING",
			pt = "ArkInventory.Skill.Jewelcrafting",
			text = ArkInventory.Localise["WOW_SKILL_JEWELCRAFTING"],
			primary = true,
		},
		[165] = {
			id = "SKILL_LEATHERWORKING",
			pt = "ArkInventory.Skill.Leatherworking",
			text = ArkInventory.Localise["WOW_SKILL_LEATHERWORKING"],
			primary = true,
		},
		[197] = {
			id = "SKILL_TAILORING",
			pt = "ArkInventory.Skill.Tailoring",
			text = ArkInventory.Localise["WOW_SKILL_TAILORING"],
			primary = true,
		},
		-- primary gather
		[182] = {
			id = "SKILL_HERBALISM",
			pt = "ArkInventory.Skill.Herbalism",
			text = ArkInventory.Localise["WOW_SKILL_HERBALISM"],
			primary = true,
		},
		[186] = {
			id = "SKILL_MINING",
			pt = "ArkInventory.Skill.Mining",
			text = ArkInventory.Localise["WOW_SKILL_MINING"],
			primary = true,
		},
		[393] = {
			id = "SKILL_SKINNING",
			pt = "ArkInventory.Skill.Skinning",
			text = ArkInventory.Localise["WOW_SKILL_SKINNING"],
			primary = true,
		},
		-- secondary
		[794] = {
			id = "SKILL_ARCHAEOLOGY",
			pt = "ArkInventory.Skill.Archaeology",
			text = ArkInventory.Localise["WOW_SKILL_ARCHAEOLOGY"],
		},
		[185] = {
			id = "SKILL_COOKING",
			pt = "ArkInventory.Skill.Cooking",
			text = ArkInventory.Localise["WOW_SKILL_COOKING"],
		},
		[129] = {
			id = "FIRST_AID",
			pt = "ArkInventory.Skill.First Aid",
			text = ArkInventory.Localise["WOW_SKILL_FIRSTAID"],
		},
		[356] = {
			id = "SKILL_FISHING",
			pt = "ArkInventory.Skill.Fishing",
			text = ArkInventory.Localise["WOW_SKILL_FISHING"],
		},
	},
}

ArkInventory.Const.Slot.Data = {
	[ArkInventory.Const.Slot.Type.Unknown] = {
		name = ArkInventory.Localise["UNKNOWN"],
		short = ArkInventory.Localise["UNKNOWN"],
	},
	[ArkInventory.Const.Slot.Type.Bag] = {
		name = ArkInventory.Localise["WOW_ITEM_CLASS_CONTAINER_BAG"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_BAG"],
	},
	[ArkInventory.Const.Slot.Type.Keyring] = {
		ClientCheck = ArkInventory.ClientCheck( nil, 40200 ),
		hide = true,
		name = ArkInventory.Localise["KEYRING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_KEY"],
	},
	[ArkInventory.Const.Slot.Type.Wearing] = {
		hide = true,
		name = ArkInventory.Localise["WOW_ITEM_CLASS_CONTAINER_BAG"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_WEARING"],
	},
	[ArkInventory.Const.Slot.Type.Herbalism] = {
		name = ArkInventory.Localise["WOW_SKILL_HERBALISM"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_HERBALISM"],
	},
	[ArkInventory.Const.Slot.Type.Enchanting] = {
		name = ArkInventory.Localise["WOW_SKILL_ENCHANTING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_ENCHANTING"],
	},
	[ArkInventory.Const.Slot.Type.Engineering] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.TBC ),
		name = ArkInventory.Localise["WOW_SKILL_ENGINEERING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_ENGINEERING"],
	},
	[ArkInventory.Const.Slot.Type.Inscription] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WRATH ),
		name = ArkInventory.Localise["WOW_SKILL_INSCRIPTION"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_INSCRIPTION"],
	},
	[ArkInventory.Const.Slot.Type.Jewelcrafting] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.TBC ),
		name = ArkInventory.Localise["WOW_SKILL_JEWELCRAFTING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_JEWELCRAFTING"],
	},
	[ArkInventory.Const.Slot.Type.Leatherworking] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.TBC ),
		name = ArkInventory.Localise["WOW_SKILL_LEATHERWORKING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_LEATHERWORKING"],
	},
	[ArkInventory.Const.Slot.Type.Mining] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.TBC ),
		name = ArkInventory.Localise["WOW_SKILL_MINING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_MINING"],
	},
	[ArkInventory.Const.Slot.Type.Mailbox] = {
		hide = true,
		name = ArkInventory.Localise["WOW_ITEM_CLASS_CONTAINER_BAG"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_MAILBOX"],
	},
	[ArkInventory.Const.Slot.Type.Fishing] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.CATACLYSM ),
		name = ArkInventory.Localise["WOW_SKILL_FISHING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_FISHING"],
	},
	[ArkInventory.Const.Slot.Type.Critter] = {
		hide = true,
		name = ArkInventory.Localise["PET"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_CRITTER"],
	},
	[ArkInventory.Const.Slot.Type.Mount] = {
		hide = true,
		name = ArkInventory.Localise["WOW_ITEM_CLASS_MISC_MOUNT"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_MOUNT"],
	},
	[ArkInventory.Const.Slot.Type.Toybox] = {
		hide = true,
		name = ArkInventory.Localise["TOY"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_TOY"],
	},
	[ArkInventory.Const.Slot.Type.Heirloom] = {
		hide = true,
		name = ArkInventory.Localise["HEIRLOOM"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_HEIRLOOM"],
	},
	[ArkInventory.Const.Slot.Type.Currency] = {
		hide = true,
		name = ArkInventory.Localise["CURRENCY"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_TOKEN"],
	},
	[ArkInventory.Const.Slot.Type.Auction] = {
		hide = true,
		name = ArkInventory.Localise["AUCTIONS"],
		short = ArkInventory.Localise["AUCTIONS"],
	},
	[ArkInventory.Const.Slot.Type.Void] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.CATACLYSM ),
		name = ArkInventory.Localise["VOID_STORAGE"],
		short = ArkInventory.Localise["VOID_STORAGE"],
		texture = [[Interface\AddOns\ArkInventory\Images\Slot-VoidStorage.tga]],
	},
	[ArkInventory.Const.Slot.Type.Cooking] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA ),
		name = ArkInventory.Localise["WOW_SKILL_COOKING"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_COOKING"],
	},
	[ArkInventory.Const.Slot.Type.Reagent] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAENOR ),
		name = ArkInventory.Localise["CRAFTING_REAGENT"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_REAGENT"],
		--texture = [[Interface\Paperdoll\UI-PaperDoll-Slot-Relic]],
	},
	[ArkInventory.Const.Slot.Type.Reputation] = {
		hide = true,
		name = ArkInventory.Localise["REPUTATION"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_REPUTATION"],
	},
	[ArkInventory.Const.Slot.Type.Projectile] = {
		ClientCheck = ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.WRATH ),
		name = ArkInventory.Localise["WOW_ITEM_CLASS_PROJECTILE"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_PROJECTILE"],
	},
	[ArkInventory.Const.Slot.Type.Soulshard] = {
		ClientCheck = ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.WRATH ),
		name = ArkInventory.Localise["WOW_ITEM_CLASS_CONTAINER_SOULSHARD"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_SOULSHARD"],
	},
	[ArkInventory.Const.Slot.Type.AccountBank] = {
		ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ),
		name = ArkInventory.Localise["ACCOUNTBANK"],
		short = ArkInventory.Localise["STATUS_SHORTNAME_ACCOUNTBANK"],
	},
}

ArkInventory.Global = { -- globals
	
	Enabled = false,
	--dataexport = true, -- comment out when done
	actions_enabled = false,
	
	Thread = {
		Use = true, -- !!! un-comment when done testing
		WindowState = { },
		data = { },
		Format = { -- if multiple threads are pending then they will be restarted in token name sort order
			Force = "*",
			Restack = "p01-restack",
			Transfer = "p02-transfer",
			Collection = "p03-scan-%s",
			Scan = "p04-scan-%s",
			Window = "p05-draw-%s",
			Search = "p06-search",
			LDB = "p07-ldb-%s",
			Tooltip = "p08-tooltip",
			Tradeskill = "p03-tradeskill",
			Category = "p04-category",
			ObjectData = "p03-objectdata",
			CompressedBar = "p05-compressedbar",
			ActionVendor = "p99-actionvendor",
			ActionMail = "p99-actionmail",
			ActionUse = "p99-actionuse",
			ActionScrap = "p99-actionscrap",
		},
	},
	
	Version = "", --calculated
	
	Me = { },
	
	Mode = {
		Bank = false,
		ReagentBank = false,
		Vault = false,
		Mailbox = false,
		Merchant = false,
		Auction = false,
		Void = false,
		
		Edit = false,
		Combat = false,
		World = false,
		Database = false,
		ColourBlind = ArkInventory.CrossClient.GetCVarBool( "colorblindMode" ),
		DragonRace = false,
		Scrap = false,
		Loot = false,
	},
	
	ScanAfterCombat = { }, -- [loc_id] = true
	ScanAfterDragonRace = { }, -- [loc_id] = true
	
	Tooltip = {
		Scan = nil,
		WOW = {
			GameTooltip,
			ShoppingTooltip1,
			ShoppingTooltip2,
			ItemRefTooltip,
			ItemRefShoppingTooltip1,
			ItemRefShoppingTooltip2,
		},
	},
	
	Category = { }, -- see CategoryGenerate( ) for how this gets populated
	
	Location = {
		
		-- isMapped is set elsewhere
		
		[ArkInventory.Const.Location.Bag] = {
			id = ArkInventory.Const.Location.Bag,
			Internal = "bags",
			Name = ArkInventory.Localise["BAGS"],
			Texture = [[Interface\Icons\INV_Misc_Bag_07_Green]],
			canRestack = true,
			hasChanger = true,
			canSearch = true,
			canCompress = true,
			
			isOffline = false,
			canView = true,
			canOverride = true,
			
			template = "ARKINV_TemplateButtonItem",
			
			preloaditeminfo = true,
			preloadwindow = true,
			canpreload = true,
		},
		
		[ArkInventory.Const.Location.ReagentBag] = {
			id = ArkInventory.Const.Location.ReagentBag,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ),
			Internal = "reagentbag",
			Name = ArkInventory.Localise["WOW_ITEM_CLASS_CONTAINER_REAGENT"],
			Texture = [[Interface\Icons\INV_Misc_Bag_07_Green]],
			
			canPurge = true,
			
			template = "ARKINV_TemplateButtonItem",
		},
		
		[ArkInventory.Const.Location.Keyring] = {
			id = ArkInventory.Const.Location.Keyring,
			ClientCheck = ArkInventory.ClientCheck( nil, 40200 ),
			Internal = "key",
			Name = ArkInventory.Localise["KEYRING"],
			Texture = [[Interface\ICONS\INV_Misc_Key_03]],
			canSearch = true,
			
			isOffline = false,
			canView = true,
			canOverride = true,
			
			template = "ARKINV_TemplateButtonViewOnlyItem",
		},
		
		[ArkInventory.Const.Location.Bank] = {
			id = ArkInventory.Const.Location.Bank,
			Internal = "bank",
			Name = ArkInventory.Localise["BANK"],
			Texture = [[Interface\Icons\INV_Box_02]],
			TextureReagent = [[Interface\Icons\INV_Box_03]],
			TextureAccount = [[Interface\Icons\INV_Box_04]],
			canRestack = true,
			hasChanger = true,
			canSearch = true,
			canCompress = true,
			
			isOffline = true,
			canView = true,
			canOverride = true,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonItem",
			
			preloaditeminfo = true,
			preloadwindow = true,
			canpreload = true,
			firstopen = true,
		},
		
		[ArkInventory.Const.Location.ReagentBank] = {
			id = ArkInventory.Const.Location.ReagentBank,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAENOR ),
			Internal = "reagentbank",
			Name = ArkInventory.Localise["REAGENTBANK"],
			Texture = [[Interface\Icons\INV_Box_03]],
			
--			isOffline = true,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonItem",
		},
		
		[ArkInventory.Const.Location.AccountBank] = {
			id = ArkInventory.Const.Location.AccountBank,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ),
			isAccount = true,
			Internal = "accountbank",
			Name = ArkInventory.Localise["ACCOUNTBANK"],
			Texture = [[Interface\Icons\INV_Box_04]],
			
--			isOffline = true,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonItem",
		},
		
		[ArkInventory.Const.Location.Vault] = {
			id = ArkInventory.Const.Location.Vault,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.TBC ),
			Internal = "vault",
			Name = ArkInventory.Localise["VAULT"],
			--Texture = [[Interface\Icons\INV_Misc_Coin_02]],
			Texture = [[Interface\ICONS\INV_Misc_Gem_Topaz_01]],
			--Texture = [[Interface\ICONS\INV_Trinket_80_Titan02d]],
			canRestack = true,
			hasChanger = true,
			canSearch = true,
			isVault = true,
			
			isOffline = true,
			canView = true,
			canOverride = true,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonVaultItem",
			
			preloaditeminfo = true,
			
			active_mode = "bank",
			view_load = true,
		},
		
		[ArkInventory.Const.Location.Mailbox] = {
			id = ArkInventory.Const.Location.Mailbox,
			Internal = "mailbox",
			Name = ArkInventory.Localise["MAILBOX"],
			--Texture = [[Interface\Icons\INV_Letter_01]]
			Texture = [[Interface\Minimap\Tracking\Mailbox]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = true,
			canView = true,
			canOverride = nil,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonMailboxItem",
			
			preloaditeminfo = true,
		},
		
		[ArkInventory.Const.Location.Wearing] = {
			id = ArkInventory.Const.Location.Wearing,
			Internal = "wearing",
			Name = ArkInventory.Localise["LOCATION_WEARING"],
			Texture = [[Interface\Icons\INV_Shirt_Yellow_01]],
			--Texture = [[Interface\ICONS\INV_OrderHall_ArmamentupgradeBlue]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = false,
			canView = true,
			canOverride = nil,
			
			preloaditeminfo = true,
		},
		
		[ArkInventory.Const.Location.Pet] = {
			id = ArkInventory.Const.Location.Pet,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA ),
			isAccount = true,
			Internal = "pet",
			Name = ArkInventory.Localise["PET"],
			--Texture = [[Interface\Icons\PetJournalPortrait]],
			Texture = [[Interface\ICONS\INV_Misc_FireKitty]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = false,
			canView = true,
			canOverride = nil,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonBattlepetItem",
		},
		
		[ArkInventory.Const.Location.Mount] = {
			id = ArkInventory.Const.Location.Mount,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.CATACLYSM ),
			isAccount = true,
			Internal = "mount",
			Name = ArkInventory.Localise["MOUNT"],
			Texture = [[Interface\Icons\MountJournalPortrait]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = false,
			canView = true,
			canOverride = nil,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonMountItem",
		},
		
		[ArkInventory.Const.Location.MountEquipment] = {
			id = ArkInventory.Const.Location.MountEquipment,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA ),
			Internal = "mountequipment",
			Name = ArkInventory.Localise["MOUNT"],
			Texture = [[Interface\Icons\MountJournalPortrait]],
			
			canPurge = true,
			
			template = "ARKINV_TemplateButtonMountItem",
		},
		
		[ArkInventory.Const.Location.Toybox] = {
			id = ArkInventory.Const.Location.Toybox,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.CATACLYSM ),
			isAccount = true,
			Internal = "toybox",
			Name = ArkInventory.Localise["TOYBOX"],
			--Texture = [[Interface\Icons\Trade_Archaeology_ChestofTinyGlassAnimals]],
			Texture = [[Interface\ICONS\INV_Misc_Toy_02]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = false,
			canView = true,
			canOverride = nil,
			canPurge = true,
			
			template = "ARKINV_TemplateButtonToyboxItem",
		},
		
		[ArkInventory.Const.Location.Heirloom] = {
			id = ArkInventory.Const.Location.Heirloom,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA ),
			isAccount = true,
			Internal = "heirloom",
			Name = ArkInventory.Localise["HEIRLOOM"],
			Texture = [[Interface\Icons\inv_misc_enggizmos_19]],
			--Texture = [[Interface\ICONS\Spell_Shadow_LastingAfflictions]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = false,
			canView = true,
			canOverride = nil,
			canPurge = true,
			
			--template = "ARKINV_TemplateButtonHeirloomItem",
			
			preloaditeminfo = true,
		},
		
		[ArkInventory.Const.Location.Currency] = {
			id = ArkInventory.Const.Location.Currency,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WRATH ),
			Internal = "currency",
			Name = ArkInventory.Localise["CURRENCY"],
			--Texture = [[Interface\ICONS\Spell_Holy_ChampionsBond]],
			--Texture = [[Interface\ICONS\ABILITY_Rogue_RollTheBones05]],
			--Texture = [[Interface\ICONS\inv_misc_coinbag_special]],
			Texture = [[Interface\ICONS\INV_Misc_Coin_01]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = false,
			canView = true,
			canOverride = nil,
			canPurge = true,
		},
		
		[ArkInventory.Const.Location.AccountCurrency] = {
			id = ArkInventory.Const.Location.AccountCurrency,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ),
			isAccount = true,
			Internal = "accountcurrency",
			Name = ArkInventory.Localise["CURRENCY"],
			Texture = [[Interface\ICONS\Inv_Misc_SummerFest_BrazierBlue]],
			
			canPurge = true,
		},
		
		[ArkInventory.Const.Location.Auction] = {
			id = ArkInventory.Const.Location.Auction,
			Internal = "auction",
			Name = ArkInventory.Localise["AUCTIONS"],
			Texture = [[Interface\ICONS\INV_Misc_Coin_04]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = true,
			canView = true,
			canOverride = nil,
			canPurge = true,
		},
		
		[ArkInventory.Const.Location.Void] = {
			id = ArkInventory.Const.Location.Void,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA ), -- void storage not implemented in cata beta yet so moved to pandaria temporarily
			Internal = "void",
			Name = ArkInventory.Localise["VOID_STORAGE"],
			Texture = [[Interface\Icons\Spell_Nature_AstralRecalGroup]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			isOffline = true,
			canView = true,
			canOverride = nil,
			canPurge = true,
		},
		
		[ArkInventory.Const.Location.Reputation] = {
			id = ArkInventory.Const.Location.Reputation,
			Internal = "reputation",
			Name = ArkInventory.Localise["REPUTATION"],
			Texture = [[Interface\ICONS\Inv_Misc_SummerFest_BrazierBlue]],
			--Texture = [[Interface\ICONS\INV_SummerFest_Symbol_High]],
			canRestack = nil,
			hasChanger = nil,
			canSearch = true,
			
			canView = true,
			canOverride = nil,
			canPurge = true,
		},
		
		[ArkInventory.Const.Location.AccountReputation] = {
			id = ArkInventory.Const.Location.AccountReputation,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ),
			isAccount = true,
			Internal = "accountreputation",
			Name = ArkInventory.Localise["REPUTATION"],
			Texture = [[Interface\ICONS\Inv_Misc_SummerFest_BrazierBlue]],
			
			canPurge = true,
		},
		
		[ArkInventory.Const.Location.Tradeskill] = {
			id = ArkInventory.Const.Location.Tradeskill,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.LEGION ),
			Internal = "tradeskill",
			Name = ArkInventory.Localise["TRADESKILLS"],
			Texture = nil,
			canRestack = nil,
			hasChanger = nil,
			--canSearch = true,
			excludeFromGlobalSearch = true,
			
			isOffline = true,
			canView = false,
			canOverride = nil,
			canPurge = true,
		},
		
		[ArkInventory.Const.Location.TradeskillEquipment] = {
			id = ArkInventory.Const.Location.TradeskillEquipment,
			ClientCheck = ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ),
			Internal = "tradeskillequipment",
			Name = ArkInventory.Localise["PROFESSION_TOOL"],
			Texture = nil,
			
			isOffline = true,
			canView = false,
			canOverride = nil,
			canPurge = true,
		},
		
	},
	
	Cache = {
		
		ScanState = { }, -- if a scan is being run on a blizzard_id, or if its queued
		
		ItemCountRaw = { }, -- key generated via ObjectIDCount( )
		ItemCountTooltip = { }, -- key generated via ObjectIDCount( )
		ItemSearchData = { }, -- key generated via ObjectIDCount( )
		
		ItemTransmogOwned = { }, -- key = itemID
		
		SentMail = { }, -- keeps track of any sent mail to other characters you have
		
	},
	
	Queue = {
		LBS = { },
	},
	
	Options = {
		
		Location = ArkInventory.Const.Location.Bag,
		ShowHiddenItems = false,
		
		SortKeyBagAssignmentSort = true,
		
		MoveType = nil,
		MoveLocation = nil,
		MoveSourceBar = nil,
		MoveDestination = nil,
		
		OnDragSourceFrame = nil,
		OnDragType = nil,
		OnDragLocation = nil,
		OnDragSourceBar = nil,
		OnDragSourceCategory = nil,
		
	},
	
	Rules = {
		Enabled = false, -- change this to module check
	},
	
	NewItemResetTime = nil,
	
	BagsOpenedBy = nil,
	
	ItemCrossReference = { },
	
	ItemLock = { },
	
	TimerunningSeasonID = 0,
	
	Map = {
		Blizzard = { },
		Storage = { },
		Window = { },
	},
}


ArkInventory.Config = {
	Internal = {
		type = "group",
		childGroups = "tree",
		name = ArkInventory.Const.Program.Name,
	},
	Blizzard = {
		type = "group",
		childGroups = "tree",
		name = ArkInventory.Const.Program.Name,
	},
}



-- Binding Variables
--BINDING_HEADER_ARKINV = ArkInventory.Const.Program.Name
BINDING_NAME_ARKINV_TOGGLE_BAG = ArkInventory.Global.Location[ArkInventory.Const.Location.Bag].Name
BINDING_NAME_ARKINV_TOGGLE_KEYRING = ArkInventory.Global.Location[ArkInventory.Const.Location.Keyring].Name
BINDING_NAME_ARKINV_TOGGLE_BANK = ArkInventory.Global.Location[ArkInventory.Const.Location.Bank].Name
BINDING_NAME_ARKINV_TOGGLE_VAULT = ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].Name
BINDING_NAME_ARKINV_TOGGLE_MAILBOX = ArkInventory.Global.Location[ArkInventory.Const.Location.Mailbox].Name
BINDING_NAME_ARKINV_TOGGLE_WEARING = ArkInventory.Global.Location[ArkInventory.Const.Location.Wearing].Name
BINDING_NAME_ARKINV_TOGGLE_PET = ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].Name
BINDING_NAME_ARKINV_TOGGLE_MOUNT = ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Name
BINDING_NAME_ARKINV_TOGGLE_TOYBOX = ArkInventory.Global.Location[ArkInventory.Const.Location.Toybox].Name
BINDING_NAME_ARKINV_TOGGLE_HEIRLOOM = ArkInventory.Global.Location[ArkInventory.Const.Location.Heirloom].Name
BINDING_NAME_ARKINV_TOGGLE_CURRENCY = ArkInventory.Global.Location[ArkInventory.Const.Location.Currency].Name
BINDING_NAME_ARKINV_TOGGLE_REPUTATION = ArkInventory.Global.Location[ArkInventory.Const.Location.Reputation].Name
BINDING_NAME_ARKINV_TOGGLE_VOID = ArkInventory.Global.Location[ArkInventory.Const.Location.Void].Name
BINDING_NAME_ARKINV_TOGGLE_AUCTION = ArkInventory.Global.Location[ArkInventory.Const.Location.Auction].Name
BINDING_NAME_ARKINV_TOGGLE_EDIT = ArkInventory.Localise["MENU_ACTION_EDITMODE"]
BINDING_NAME_ARKINV_TOGGLE_RULES = ArkInventory.Localise["RULES"]
BINDING_NAME_ARKINV_TOGGLE_SEARCH = ArkInventory.Localise["SEARCH"]
BINDING_NAME_ARKINV_TOGGLE_DEBUG = ArkInventory.Localise["DEBUG"]
BINDING_NAME_ARKINV_REFRESH = ArkInventory.Localise["REFRESH"]
BINDING_NAME_ARKINV_RELOAD = ArkInventory.Localise["RELOAD"]
BINDING_NAME_ARKINV_RESTACK = ArkInventory.Localise["RESTACK"]
BINDING_NAME_ARKINV_MENU = ArkInventory.Localise["MENU"]
BINDING_NAME_ARKINV_CONFIG = ArkInventory.Localise["CONFIG_DESC"]
BINDING_NAME_ARKINV_LDB_PET_SUMMON = ArkInventory.Localise["LDB_COMPANION_SUMMON"]
_G["BINDING_NAME_CLICK ARKINV_MountToggle:LeftButton"] = ArkInventory.Localise["LDB_MOUNT_SUMMON"]
BINDING_NAME_ARKINV_ACTION_MANUAL_RUN = ArkInventory.Localise["CONFIG_ACTION_MANUAL_RUN"]

--if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ) then
	-- workaround until click binding issue is resolved
	--BINDING_NAME_ARKINV_LDB_MOUNT_SUMMON = ArkInventory.Localise["LDB_MOUNT_SUMMON"] .. " (non-secure)"
--end



ArkInventory.Const.DatabaseDefaults.global = {
	["option"] = {
		["version"] = 0,
		["auto"] = {
			["open"] = {
				["*"] = 1,
				["transmog"] = 0,
			},
			["close"] = {
				["*"] = 1,
			},
			["reposition"] = true,
		},
		["design"] = { -- layout and style data
			["data"] = {
				["**"] = {
					["guid"] = false,
					["system"] = false,
					["used"] = "N", -- Y(es) | N(o) | D(eleted)
					["name"] = "",
					
					-- ** style **
					["font"] = {
						["custom"] = false,
						["face"] = ArkInventory.Const.Font.Face,
						["height"] = ArkInventory.Const.Font.Height,
					},
					["window"] = {
						["scale"] = 1,
						["width"] = 16,
						["height"] = 800,
						["border"] = {
							["style"] = ArkInventory.Const.Texture.BorderDefault,
							["size"] = nil,
							["offset"] = nil,
							["scale"] = 1,
							["colour"] = {
								["r"] = 1,
								["g"] = 1,
								["b"] = 1,
							},
						},
						["pad"] = 8,
						["background"] = {
							["style"] = ArkInventory.Const.Texture.BackgroundDefault,
							["colour"] = {
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
								["a"] = 0.75,
							},
						},
						["scrollbar"] = {
							["style"] = ArkInventory.Const.Texture.BackgroundDefault,
							["colour"] = {
								["r"] = 0,
								["g"] = 0,
								["b"] = 0,
								["a"] = 0.75,
							},
						},
						["strata"] = "MEDIUM",
						["list"] = false,
					},
					["bar"] = {
						["per"] = 5,
						["pad"] = {
							["internal"] = 8,
							["external"] = 8,
						},
						["border"] = {
							["style"] = ArkInventory.Const.Texture.BorderDefault,
							["size"] = nil,
							["offset"] = nil,
							["scale"] = 1,
							["colour"] = {
								["r"] = 0.3,
								["g"] = 0.3,
								["b"] = 0.3,
							},
						},
						["background"] = {
							["colour"] = {
								["r"] = 0,
								["g"] = 0,
								["b"] = 0.4,
								["a"] = 0.4,
							},
						},
						["showempty"] = false,
						["anchor"] = ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT,
						["compact"] = false,
						["hide"] = false,
						["name"] = {
							["show"] = false,
							["editmode"] = true,
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["colour"] = {
								["r"] = 1,
								["b"] = 1,
								["g"] = 1,
							},
							["height"] = ArkInventory.Const.Font.Height,
							["align"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["pad"] = {
								["vertical"] = 5, -- this is a minimum, otherwise it uses the slot padding value
							},
						},
						["width"] = {
							["min"] = 0,
							["max"] = 0,
						},
						["data"] = { -- ** layout **
							["*"] = {
								["sort"] = {
									["method"] = nil,
								},
								["border"] = {
									["custom"] = 1, -- 1 = default, 2 = custom
									["colour"] = {
										["r"] = 0.3,
										["g"] = 0.3,
										["b"] = 0.3,
									},
								},
								["background"] = {
									["custom"] = 1, -- 1 = default, 2 = custom, 3 = border
									["colour"] = {
										["r"] = 0,
										["g"] = 0,
										["b"] = 0.4,
										["a"] = 0.4,
									},
								},
								["name"] = {
									["text"] = "",
									["custom"] = 1, -- 1 = default, 2 = custom
									["colour"] = {
										["r"] = 1,
										["g"] = 1,
										["b"] = 1,
									},
								},
								["width"] = {
									["min"] = 0,
									["max"] = 0,
								},
							},
						},
					},
					["slot"] = {
						["scale"] = 1,
						["size"] = ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.SLOTSIZE,
						["empty"] = {
							["border"] = true,
							["first"] = 0,
							["clump"] = false,
							["position"] = true,
						},
						["data"] = { -- slot type data
							["**"] = {
								["colour"] = { r = 0.30, g = 0.30, b = 0.30 },
							},
							[ArkInventory.Const.Slot.Type.Unknown] = {
								["colour"] = { r = 1.00, g = 0.00, b = 0.00 },
							},
							[ArkInventory.Const.Slot.Type.AccountBank] = {
								["colour"] = { r = 0.86, g = 0.94, b = 0.35 },
							},
							[ArkInventory.Const.Slot.Type.Enchanting] = {
								["colour"] = { r = 0.06, g = 0.88, b = 0.93 },
							},
							[ArkInventory.Const.Slot.Type.Engineering] = {
								["colour"] = { r = 0.61, g = 0.74, b = 0.29 },
							},
							[ArkInventory.Const.Slot.Type.Fishing] = {
								["colour"] = { r = 0.12, g = 0.56, b = 0.42 },
							},
							[ArkInventory.Const.Slot.Type.Herbalism] = {
								["colour"] = { r = 0.00, g = 1.00, b = 0.00 },
							},
							[ArkInventory.Const.Slot.Type.Inscription] = {
								["colour"] = { r = 0.46, g = 0.67, b = 0.63 },
							},
							[ArkInventory.Const.Slot.Type.Jewelcrafting] = {
								["colour"] = { r = 0.63, g = 0.00, b = 0.56 },
							},
							[ArkInventory.Const.Slot.Type.Leatherworking] = {
								["colour"] = { r = 0.63, g = 0.45, b = 0.10 },
							},
							[ArkInventory.Const.Slot.Type.Mining] = {
								["colour"] = { r = 0.79, g = 0.79, b = 0.00 },
							},
							[ArkInventory.Const.Slot.Type.Projectile] = {
								["colour"] = { r = 0.80, g = 0.80, b = 0.00 },
							},
							[ArkInventory.Const.Slot.Type.Reagent] = {
								["colour"] = { r = 0.10, g = 0.30, b = 1.00 },
							},
							[ArkInventory.Const.Slot.Type.Soulshard] = {
								["colour"] = { r = 0.90, g = 0.00, b = 0.90 },
							},
						},
						["pad"] = 5,
						["background"] = {
							["icon"] = true,
							["alpha"] = 1,
							["colour"] = {
								["**"] = { r = 0.30, g = 0.30, b = 0.30 },
								[ArkInventory.Const.Slot.Type.Unknown] = { r = 1.00, g = 0.00, b = 0.00 },
								[ArkInventory.Const.Slot.Type.AccountBank] = { r = 0.86, g = 0.94, b = 0.35 },
								[ArkInventory.Const.Slot.Type.Enchanting] = { r = 0.06, g = 0.88, b = 0.93 },
								[ArkInventory.Const.Slot.Type.Engineering] = { r = 0.61, g = 0.74, b = 0.29 },
								[ArkInventory.Const.Slot.Type.Fishing] = { r = 0.12, g = 0.56, b = 0.42 },
								[ArkInventory.Const.Slot.Type.Herbalism] = { r = 0.00, g = 1.00, b = 0.00 },
								[ArkInventory.Const.Slot.Type.Inscription] = { r = 0.46, g = 0.67, b = 0.63 },
								[ArkInventory.Const.Slot.Type.Jewelcrafting] = { r = 0.63, g = 0.00, b = 0.56 },
								[ArkInventory.Const.Slot.Type.Leatherworking] = { r = 0.63, g = 0.45, b = 0.10 },
								[ArkInventory.Const.Slot.Type.Mining] = { r = 0.79, g = 0.79, b = 0.00 },
								[ArkInventory.Const.Slot.Type.Projectile] = { r = 0.80, g = 0.80, b = 0.00 },
								[ArkInventory.Const.Slot.Type.Reagent] = { r = 0.10, g = 0.30, b = 1.00 },
								[ArkInventory.Const.Slot.Type.Soulshard] = { r = 0.90, g = 0.00, b = 0.90 },
							},
						},
						["border"] = {
							["style"] = ArkInventory.Const.Texture.BorderDefault,
							["size"] = nil,
							["offset"] = nil,
							["scale"] = 1,
							["rarity"] = true,
							["raritycutoff"] = ArkInventory.ENUM.ITEM.QUALITY.POOR,
							["alpha"] = 0.6,
							["coloured"] = true,
							["colour"] = {
								["**"] = { r = 0.30, g = 0.30, b = 0.30 },
								[ArkInventory.Const.Slot.Type.Unknown] = { r = 1.00, g = 0.00, b = 0.00 },
								[ArkInventory.Const.Slot.Type.AccountBank] = { r = 0.86, g = 0.94, b = 0.35 },
								[ArkInventory.Const.Slot.Type.Enchanting] = { r = 0.06, g = 0.88, b = 0.93 },
								[ArkInventory.Const.Slot.Type.Engineering] = { r = 0.61, g = 0.74, b = 0.29 },
								[ArkInventory.Const.Slot.Type.Fishing] = { r = 0.12, g = 0.56, b = 0.42 },
								[ArkInventory.Const.Slot.Type.Herbalism] = { r = 0.00, g = 1.00, b = 0.00 },
								[ArkInventory.Const.Slot.Type.Inscription] = { r = 0.46, g = 0.67, b = 0.63 },
								[ArkInventory.Const.Slot.Type.Jewelcrafting] = { r = 0.63, g = 0.00, b = 0.56 },
								[ArkInventory.Const.Slot.Type.Leatherworking] = { r = 0.63, g = 0.45, b = 0.10 },
								[ArkInventory.Const.Slot.Type.Mining] = { r = 0.79, g = 0.79, b = 0.00 },
								[ArkInventory.Const.Slot.Type.Projectile] = { r = 0.80, g = 0.80, b = 0.00 },
								[ArkInventory.Const.Slot.Type.Reagent] = { r = 0.10, g = 0.30, b = 1.00 },
								[ArkInventory.Const.Slot.Type.Soulshard] = { r = 0.90, g = 0.00, b = 0.90 },
							},
						},
						["anchor"] = ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT,
						["age"] = {
							["show"] = false,
							["colour"] = {
								["r"] = 1,
								["g"] = 1,
								["b"] = 1,
							},
							["cutoff"] = 0,
							["font"] = {
								["height"] = ArkInventory.Const.Font.Height - 2,
							},
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
						},
						["offline"] = {
							["fade"] = true,
						},
						["unusable"] = {
							["tint"] = false,
--							["junk"] = false,
						},
						["unwearable"] = {
							["tint"] = false,
--							["junk"] = false,
						},
						["cooldown"] = {
							["show"] = true,
							["onopen"] = true,
--							["global"] = false,
							["combat"] = true,
						},
						["itemlevel"] = {
							["show"] = true,
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["quality"] = false,
							["colour"] = {
								["r"] = 1,
								["g"] = 0.82,
								["b"] = 0,
							},
							["font"] = {
								["height"] = ArkInventory.Const.Font.Height - 2,
							},
							["equip"] = {
								["show"] = true,
								["min"] = 1,
							},
							["bags"] = {
								["show"] = false,
							},
							["stock"] = {
								["show"] = false,
								["total"] = true,
							},
						},
						["itemcount"] = {
							["show"] = true,
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["colour"] = {
								["r"] = 1,
								["g"] = 1,
								["b"] = 1,
							},
							["font"] = {
								["height"] = ArkInventory.Const.Font.Height,
							},
						},
--						["new"] = {
--							["enable"] = false,
--							["cutoff"] = 2,
--						},
						["stack"] = {
							["mode"] = ArkInventory.Const.Slot.Stack.Mode.Limit,
							["limit"] = {
								["enable"] = 0,
								["identify"] = {
									["count"] = {
										["enable"] = true,
										["position"] = 1,
									},
								},
							},
							["compress"] = {
								["enable"] = false,
								["sort"] = true,
								["identify"] = {
									["count"] = {
										["enable"] = true,
										["position"] = 1,
									},
									["border"] = {
										["enable"] = false,
										["colour"] = {
											["r"] = 1.0,
											["g"] = 1.0,
											["b"] = 0.0,
											["a"] = 0.7,
										},
									},
									["desaturate"] = {
										["enable"] = false,
									},
								},
								["anchor"] = ArkInventory.ENUM.ANCHOR.BOTTOM,
								["tooltip"] = true,
								["bar"] = {
									["width"] = 10,
								},
								["include"] = {
									["empty"] = true,
									["single"] = true,
									["stack"] = true,
								},
							},
						},
--						["upgrade"] = true, -- need to remove from saved data
						["upgradeicon"] = {
							["show"] = true,
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["size"] = 20,
						},
						["junkicon"] = {
							["show"] = true,
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["merchant"] = true,
							["size"] = 20,
						},
						["transmogicon"] = {
							["show"] = true,
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["alternative"] = true,
							["size"] = 12,
						},
						["overlay"] = {
							["cosmetic"] = {
								["show"] = true,
							},
							["conduit"] = {
								["show"] = true,
							},
							["azerite"] = {
								["show"] = true,
							},
							["nzoth"] = {
								["show"] = true,
								["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
								["size"] = 12,
							},
							["professionrank"] = {
								["show"] = true,
								["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
								["size"] = 40,
								["custom"] = false,
								["number"] = false,
								["colour"] = {
									["r"] = 1,
									["g"] = 1,
									["b"] = 1,
								},
							},
						},
						["quest"] = {
							["bang"] = true,
							["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
							["border"] = true,
							["size"] = 21,
						},
						["override"] = {
							["new"] = {
								["enable"] = false,
								["cutoff"] = 2,
							},
							["partyloot"] = {
								["enable"] = false,
							},
							["refundable"] = {
								["enable"] = false,
							},
						},
					},
					["title"] = {
						["hide"] = false,
						["scale"] = 1,
						["size"] = 1,
						["colour"] = {
							["online"] = {
								["r"] = 0,
								["g"] = 1,
								["b"] = 0,
							},
							["offline"] = {
								["r"] = 1,
								["g"] = 0,
								["b"] = 0,
							},
						},
						["font"] = {
							["height"] = 20,
						},
					},
					["search"] = {
						["hide"] = false,
						["scale"] = 1,
						["label"] = {
							["colour"] = {
								["r"] = 0,
								["g"] = 1,
								["b"] = 0,
							},
						},
						["text"] = {
							["colour"] = {
								["r"] = 1,
								["g"] = 1,
								["b"] = 1,
							},
						},
						["font"] = {
							["height"] = 12,
						},
					},
					["changer"] = {
						["hide"] = false,
						["scale"] = 1,
						["highlight"] = {
							["show"] = true,
							["colour"] = {
								["r"] = 0,
								["g"] = 1,
								["b"] = 0,
							},
						},
						["freespace"] = {
							["show"] = true,
							["colour"] = {
								["r"] = 1,
								["g"] = 1,
								["b"] = 1,
							},
						},
						["font"] = {
							["height"] = 20,
						},
					},
					["status"] = {
						["hide"] = false,
						["scale"] = 1,
						["emptytext"] = {   -- slot>empty>display
							["show"] = true,
							["colour"] = false,
							["full"] = true,
							["includetype"] = true,
							["include"] = {
								["*"] = true,
							},
						},
						["font"] = {
							["height"] = 16,
						},
						["currency"] = {
							["show"] = true,
						},
						["money"] = {
							["show"] = true,
						},
					},
					["sort"] = {
						["when"] = ArkInventory.ENUM.SORTWHEN.ONOPEN,
						["method"] = 9999,  -- the default sort method for this layout
					},
					
					-- ** layout **
					["bag"] = {
						["*"] = { -- [bag_id]
							["bar"] = nil, -- bar number to put all bag slots on
						},
					},
					["category"] = {
						["*"] = nil, -- [category number] = bar number to put it on
					},
				},
				[9999] = {
					["system"] = true,
					["used"] = "Y",
					["name"] = ArkInventory.Localise["DEFAULT"],
				},
				[9998] = {
					["system"] = true,
					["used"] = "Y",
					["name"] = ArkInventory.Localise["VAULT"],
					["window"] = {
						["width"] = ArkInventory.Const.BLIZZARD.GLOBAL.GUILDBANK.WIDTH,
					},
					["sort"] = {
						["method"] = 9995,
					},
				},
				[9997] = {
					["system"] = true,
					["used"] = "Y",
					["name"] = "List",
					["window"] = {
						["list"] = true,
						["width"] = 10,
					},
					["bar"] = {
						["per"] = 1,
						["data"] = {
							[1] = {
								["width"] = {
									["max"] = 1,
								},
							},
						},
					},
					["slot"] = {
						["anchor"] = ArkInventory.ENUM.ANCHOR.BOTTOMLEFT,
					},
					["changer"] = {
						["hide"] = true,
					},
					["status"] = {
						["hide"] = true,
					},
					["sort"] = {
						["method"] = 9993,
					},
				},
				[1000] = {
					["system"] = false,
					["used"] = "Y",
					["name"] = ArkInventory.Localise["DEFAULT"],
				},
			},
			["min"] = 1000,
			["next"] = 1000,
			["max"] = 8999,
		},
		["category"] = {
			["**"] = {
				["min"] = 1000,
				["next"] = 1000,
				["max"] = 8999,
			},
			[ArkInventory.Const.Category.Type.System] = {
				["data"] = {
					["*"] = {  -- [number] = { data }
						["guid"] = false,
						["system"] = true,
						["used"] = "N", -- Y(es) | N(o) | D(eleted)
						["name"] = "",
					},
				},
			},
			[ArkInventory.Const.Category.Type.Custom] = {
				["data"] = {
					["*"] = {  -- [number] = { data }
						["guid"] = false,
						["system"] = false,
						["used"] = "N", -- Y(es) | N(o) | D(eleted)
						["name"] = "",
					},
				},
			},
			[ArkInventory.Const.Category.Type.Rule] = {
				["data"] = {
					["*"] = {  -- [number] = { data }
						["guid"] = false,
						["system"] = false,
						["used"] = "N", -- Y(es) | N(o) | D(eleted)
						["name"] = "",
						["order"] = 1000,
						["formula"] = "false",
						["damaged"] = false,
					},
				},
			},
			[ArkInventory.Const.Category.Type.Action] = {
				["data"] = {
					["*"] = {  -- [number] = { data }
						["guid"] = false,
						["system"] = false,
						["used"] = "N", -- Y(es) | N(o) | D(eleted)
						["name"] = "",
						["order"] = 1000,
						["act"] = ArkInventory.ENUM.ACTION.TYPE.IGNORE, -- action: ignore, vendor, mail, move
						["src"] = nil, -- source: bag, bank
						["dst"] = nil, -- destination: bag, bank
	--					["bag"] = nil, -- destination bag/tab
						["rec"] = nil, -- recipient
						["inp"] = nil, -- only applies to these characters
						["exp"] = nil, -- exclude these characters
					},
					[9998] = {
						["system"] = true,
						["used"] = "Y", -- Y(es) | N(o) | D(eleted)
						["name"] = "vendor",
						["order"] = 1000,
						["act"] = ArkInventory.ENUM.ACTION.TYPE.VENDOR,
					},
					[9999] = {
						["system"] = true,
						["used"] = "Y", -- Y(es) | N(o) | D(eleted)
						["name"] = "ignore",
						["order"] = 0,
						["act"] = ArkInventory.ENUM.ACTION.TYPE.IGNORE,
					},
				},
			},
		},
		["catset"] = { -- category sets
			["data"] = {
				["**"] = {
					["guid"] = false,
					["system"] = false,
					["used"] = "N", -- Y(es) | N(o) | D(eleted)
					["name"] = "",
					["ca"] = { -- category data
						["*"] = {
							["*"] = {
								["active"] = false,
								["actions"] = {
									["*"] = {
										["w"] = ArkInventory.ENUM.ACTION.WHEN.DISABLED,
									},
								},
								["action"] = {
									["t"] = ArkInventory.ENUM.ACTION.TYPE.DISABLED,
									["w"] = ArkInventory.ENUM.ACTION.WHEN.DISABLED,
								},
							},
						},
						[ArkInventory.Const.Category.Type.System] = {
							["*"] = {
								["active"] = true,
								["actions"] = {
									["*"] = {
										["w"] = ArkInventory.ENUM.ACTION.WHEN.DISABLED,
									},
								},
								["action"] = {
									["t"] = ArkInventory.ENUM.ACTION.TYPE.DISABLED,
									["w"] = ArkInventory.ENUM.ACTION.WHEN.DISABLED,
								},
							},
							[402] = {
								["active"] = true,
								["actions"] = {
									["*"] = {
										["w"] = ArkInventory.ENUM.ACTION.WHEN.DISABLED,
									},
									[9998] = {
										["w"] = ArkInventory.ENUM.ACTION.WHEN.AUTO,
									},
								},
								["action"] = {
									["t"] = ArkInventory.ENUM.ACTION.TYPE.VENDOR,
									["w"] = ArkInventory.ENUM.ACTION.WHEN.AUTO,
								},
							},
						},
					},
					["ia"] = { -- item data
						["*"] = { -- item id
							["assign"] = nil, -- cat_id to assign the item to
							["actions"] = {
								["*"] = {
									["w"] = ArkInventory.ENUM.ACTION.WHEN.DISABLED,
								},
							},
							["action"] = {
								["t"] = ArkInventory.ENUM.ACTION.TYPE.DISABLED,
								["w"] = ArkInventory.ENUM.ACTION.WHEN.DISABLED,
							},
						},
					},
				},
				[9999] = {
					["system"] = true,
					["used"] = "Y",
					["name"] = ArkInventory.Localise["DEFAULT"],
				},
				[1000] = {
					["system"] = false,
					["used"] = "Y",
					["name"] = ArkInventory.Localise["DEFAULT"],
				},
			},
			["min"] = 1000,
			["next"] = 1000,
			["max"] = 8999,
		},
		["profile"] = {
			["data"] = {
				["**"] = { -- id
					["guid"] = false,
					["system"] = false,
					["used"] = "N", -- Y(es) | N(o) | D(eleted)
					["name"] = "",
					["location"] = {
						["**"] = { -- loc_id
							["monitor"] = true,
							["save"] = true,
							["override"] = false,
							["special"] = true,
							["notify"] = false,
							["preload"] = false,
							["anchor"] = {
								["point"] = ArkInventory.ENUM.ANCHOR.TOPRIGHT,
								["locked"] = false,
								["t"] = nil,
								["b"] = nil,
								["l"] = nil,
								["r"] = nil,
							},
							["style"] = 1000,
							["layout"] = 1000,
							["catset"] = 1000,
							["container"] = {
								["width"] = 400,
								["height"] = 400,
							},
						},
						[ArkInventory.Const.Location.Bag] = {
							["notify"] = true,
							["override"] = true,
							--["preload"] = true,
						},
						[ArkInventory.Const.Location.Bank] = {
							["notify"] = true,
							["override"] = true,
							--["preload"] = true,
						},
						[ArkInventory.Const.Location.Vault] = {
							["notify"] = true,
							["override"] = true,
						},
						[ArkInventory.Const.Location.Tradeskill] = {
							["monitor"] = false,
							["loadscan"] = true,
						},
					},
				},
				[1000] = {
					["system"] = false,
					["used"] = "Y",
					["name"] = ArkInventory.Localise["DEFAULT"],
				},
				[9999] = {
					["system"] = true,
					["used"] = "Y",
					["name"] = ArkInventory.Localise["DEFAULT"],
				},
			},
			["min"] = 1000,
			["next"] = 1000,
			["max"] = 8999,
		},
		["sort"] = {
			["method"] = {
				["data"] = {
					["**"] = {
						["guid"] = false,
						["system"] = false,
						["used"] = "N", -- Y(es) | N(o) | D(eleted)
						["name"] = "",
						["order"] = { },
					},
					[9999] = {
						["system"] = true,
						["used"] = "Y",
						["name"] = ArkInventory.Localise["CONFIG_SORTING_METHOD_BAGSLOT"],
						["order"] = {
							[1] = {
								["key"] = "bagid",
								["active"] = true,
							},
							[2] = {
								["key"] = "slotid",
								["active"] = true,
							},
						},
					},
					[9998] = {
						["system"] = true,
						["used"] = "Y",
						["name"] = "Quality > Category > Location > Name",
						["order"] = {
							[1] = {
								["key"] = "quality",
								["active"] = true,
							},
							[2] = {
								["key"] = "category",
								["active"] = true,
							},
							[3] = {
								["key"] = "location",
								["active"] = true,
							},
							[4] = {
								["key"] = "name",
								["active"] = true,
							},
							[5] = {
								["key"] = "rank",
								["active"] = true,
							},
							[6] = {
								["key"] = "count",
								["active"] = true,
							},
							[7] = {
								["key"] = "bagid",
								["active"] = true,
							},
							[8] = {
								["key"] = "slotid",
								["active"] = true,
							},
						},
					},
					[9997] = {
						["system"] = true,
						["used"] = "Y",
						["name"] = "Name (Ascending)",
						["order"] = {
							[1] = {
								["key"] = "name",
								["active"] = true,
							},
							[2] = {
								["key"] = "rank",
								["active"] = true,
							},
							[3] = {
								["key"] = "count",
								["active"] = true,
							},
							[4] = {
								["key"] = "bagid",
								["active"] = true,
							},
							[5] = {
								["key"] = "slotid",
								["active"] = true,
							},
						},
					},
					[9996] = {
						["system"] = true,
						["used"] = "Y",
						["name"] = "Vendor Price",
						["order"] = {
							[1] = {
								["key"] = "vendorprice",
								["active"] = true,
							},
							[2] = {
								["key"] = "count",
								["active"] = true,
							},
							[3] = {
								["key"] = "bagid",
								["active"] = true,
							},
							[4] = {
								["key"] = "slotid",
								["active"] = true,
							},
						},
					},
					[9995] = {
						["system"] = true,
						["used"] = "Y",
						["name"] = string.format( "%s / %s", ArkInventory.Localise["VAULT"], ArkInventory.Localise["VOID_STORAGE"] ),
						["order"] = {
							[1] = {
								["key"] = "bagid",
								["active"] = true,
							},
							[2] = {
								["key"] = "slotid",
								["active"] = true,
							},
						},
					},
					[9994] = {
						["system"] = true,
						["used"] = "Y",
						["name"] = "Name (Descending)",
						["order"] = {
							[1] = {
								["key"] = "name",
								["active"] = true,
								["descending"] = true,
							},
							[2] = {
								["key"] = "rank",
								["active"] = true,
								["descending"] = true,
							},
							[3] = {
								["key"] = "count",
								["active"] = true,
							},
							[4] = {
								["key"] = "bagid",
								["active"] = true,
							},
							[5] = {
								["key"] = "slotid",
								["active"] = true,
							},
						},
					},
					[9993] = {
						["system"] = true,
						["used"] = "Y",
						["name"] = string.format( "%s (%s)", ArkInventory.Localise["CONFIG_SORTING_METHOD_BAGSLOT"], "Descending" ),
						["order"] = {
							[1] = {
								["key"] = "bagid",
								["active"] = true,
								["descending"] = true,
							},
							[2] = {
								["key"] = "slotid",
								["active"] = true,
								["descending"] = true,
							},
						},
					},
				},
				["min"] = 1000,
				["next"] = 1000,
				["max"] = 8999,
			},
		},
		["showdisabled"] = true,
		["cleanup"] = {
			["enable"] = true, -- use blizzard cleanup function
			["reverse"] = false,
			["deposit"] = { -- run deposit all items
				["*"] = false, -- loc_id_storage
			},
			["delay"] = 0.2,
		},
		["restack"] = {
			["enable"] = true,
			["refresh"] = false, -- do a refresh when the restack is finished
			["bagorder"] = {
				[1] = ArkInventory.ENUM.RESTACK.ORDER.ACCOUNT,
				[2] = ArkInventory.ENUM.RESTACK.ORDER.REAGENT,
				[3] = ArkInventory.ENUM.RESTACK.ORDER.PROFESSION,
				[4] = ArkInventory.ENUM.RESTACK.ORDER.NORMAL,
			},
			["stack"] = {
				["**"] = { -- loc_id_storage
					["enable"] = true,
					["checkbag"] = false,
				},
				[ArkInventory.Const.Location.Bank] = {
					["checkbag"] = true,
				},
				[ArkInventory.Const.Location.ReagentBank] = {
					["checkbag"] = true,
				},
			},
			["consolidate"] = {
				["**"] = { -- loc_id_storage
					["enable"] = false,
					["checkbag"] = false,
				},
				[ArkInventory.Const.Location.Bag] = {
					["enable"] = true,
				},
				[ArkInventory.Const.Location.ReagentBag] = {
					["enable"] = true,
					["checkbag"] = true,
				},
				[ArkInventory.Const.Location.Bank] = {
					["enable"] = true,
					["checkbag"] = true,
				},
				[ArkInventory.Const.Location.ReagentBank] = {
					["enable"] = true,
					["checkbag"] = true,
				},
			},
			["compact"] = {
				["*"] = { -- loc_id_storage
					["enable"] = false,
				},
			},
			["include"] = {
				["item"] = {
					["*"] = true, -- class:id
				},
			},
		},
		["bucket"] = {
			["*"] = nil,
		},
		["updatetimer"] = {
			-- warning - if you change these you need to clear them via the upgrades function
			["**"] = {
				default = 0.5,
				custom = false,
				value = nil,
			},
--			["EVENT_ARKINV_ACTIONBAR_UPDATE_USABLE_BUCKET"] = { default = 0.2 },
			["EVENT_ARKINV_AUCTION_LEAVE_BUCKET"] = { default = 0.3 },
			["EVENT_ARKINV_AUCTION_UPDATE_MASSIVE_BUCKET"] = { default = 60 },
			["EVENT_ARKINV_AUCTION_UPDATE_BUCKET"] = { default = 2 },
			["EVENT_ARKINV_AVG_ITEM_LEVEL_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_BAG_RESCAN_BUCKET"] = { default = 2 },
			["EVENT_ARKINV_BAG_UPDATE_BUCKET"] = { default = 0.2 },
			["EVENT_ARKINV_BAG_OPEN_BUCKET"] = { default = 0.2 },
			["EVENT_ARKINV_ITEM_UPDATE_BUCKET"] = { default = 0.2 },
			["EVENT_ARKINV_UPDATE_COOLDOWN_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_BANK_LEAVE_BUCKET"] = {  default = 0.3 },
			["EVENT_ARKINV_CHANGER_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_COLLECTION_HEIRLOOM_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_COLLECTION_CURRENCY_UPDATE_BUCKET"] = { default = 3 },
			["EVENT_ARKINV_COLLECTION_MOUNT_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_TRADESKILL_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_LOCATION_SCANNED_BUCKET"] = { default = 0.3 },
			["EVENT_ARKINV_LOCATION_DRAW_BUCKET"] = { default = 0.3 },
			["EVENT_ARKINV_MAIL_LEAVE_BUCKET"] = { default = 0.3 },
			["EVENT_ARKINV_MAIL_UPDATE_BUCKET"] = { default = 2 },
			["EVENT_ARKINV_MERCHANT_LEAVE_BUCKET"] = { default = 0.3 },
			["EVENT_ARKINV_TRANSMOG_LEAVE_BUCKET"] = { default = 0.3 },
			["EVENT_ARKINV_PLAYER_MONEY_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_QUEST_UPDATE_BUCKET"] = { default = 4 },
			["EVENT_ARKINV_TOOLTIP_REBUILD_QUEUE_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_VAULT_LEAVE_BUCKET"] = { default = 0.3 },
			["EVENT_ARKINV_VAULT_UPDATE_BUCKET"] = { default = 0.75 },
			["EVENT_ARKINV_VAULT_TABS_UPDATE_BUCKET"] = { },
			["EVENT_ARKINV_VOID_UPDATE_BUCKET"] = { },
			["EVENT_ARKINV_ZONE_CHANGED_BUCKET"] = { default = 0.2 },
			["EVENT_ARKINV_BACKPACK_TOKEN_UPDATE_BUCKET"] = { default = 1 },
			
			["EVENT_ARKINV_GETOBJECTINFO_QUEUE_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_UNIT_AURA_BUCKET"] = { default = 5 },
			
			["EVENT_ARKINV_LDB_CURRENCY_UPDATE_BUCKET"] = { default = 2 },
			["EVENT_ARKINV_LDB_REPUTATION_UPDATE_BUCKET"] = { default = 2 },
			["EVENT_ARKINV_LDB_ITEM_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_LDB_PET_UPDATE_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_LDB_MOUNT_UPDATE_BUCKET"] = { default = 1 },
			
			["EVENT_ARKINV_ACTION_USE_BUCKET"] = { default = 2 },
			["EVENT_ARKINV_ACTION_SCRAP_START_BUCKET"] = { default = 1 },
			["EVENT_ARKINV_SCRAP_STOP_BUCKET"] = { default = 1 },
			
			["EVENT_ARKINV_TRANSMOG_SOURCE_UPDATED_BUCKET"] = { default = 2 },
			
			["EVENT_ARKINV_EVENT_RESUME_BUCKET"] = { default = 0.5 },
		},
		["bugfix"] = {
			["framelevel"] = {
				["enable"] = true,
				["alert"] = 0,
			},
			["zerosizebag"] = {
				["enable"] = true,
				["alert"] = true,
			},
			["itemlock"] = {
				["delay"] = 0.6,
			},
--			["interaction"] = {
--				["enable"] = true,
--			},
		},
		["tooltip"] = {
			["show"] = true, -- show tooltips for items
			["scale"] = {
				["enabled"] = false,
				["amount"] = 1,
			},
			["addempty"] = false, -- add an empty line / seperator
			["highlight"] = "", -- highlight my data
			["battlepet"] = {
				["enable"] = true,
				["source"] = true,
				["description"] = true,
			},
			["reputation"] = { -- need to add this to the config at some point
				["enable"] = true,
				["description"] = true,
				["custom"] = 1, -- 1 = default, 2 = custom
				["style"] = {
					["normal"] = "",
					["count"] = "",
				},
			},
			["itemcount"] = {
				["enable"] = true,
				["justme"] = false, -- only show my data
				["account"] = true, -- only show my account
				["faction"] = true, -- only show my faction
				["realm"] = true, -- only show my realm
				["crossrealm"] = false, -- show connected realms
				["vault"] = true,
				["tabs"] = true,
				["reputation"] = true,
				["tradeskill"] = true,
				["colour"] =  {
					["class"] = false,
					["text"] = {
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.15,
					},
					["count"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["ignore"] = {
					["*"] = false,
				},
			},
			["money"] = {
				["enable"] = true,
				["justme"] = false, -- only show my data
				["account"] = true, -- only show my account
				["faction"] = true, -- only show my faction
				["realm"] = true, -- only show my realm
				["crossrealm"] = false, -- show connected realms
				["vault"] = true,
				["colour"] =  {
					["class"] = false,
					["text"] = {
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.15,
					},
					["count"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
			},
			["precalc"] = false,
			["refresh"] = true,
			["transmog"] = {
				["enable"] = true,
				["set"] = true,
				["item"] = true,
			},
		},
		["tracking"] = {
			["items"] = { }, --move these down to item.list at some point
			["item"] = {
				["showzero"] = true,
				["list"] = { },
			},
			["reputation"] = {
				["custom"] = 1, -- 1 = default, 2 = custom
				["style"] = {
					["ldb"] = "",
					["tooltip"] = "",
				},
			},
		},
		["message"] = {
			["translation"] = {
				["interim"] = true,
				["final"] = true,
			},
			["restack"] = {
				["*"] = true,
			},
			["battlepet"] = {
				["opponent"] = true,
			},
			["mount"] = {
				["warnings"] = true,
			},
			["bag"] = {
				["unknown"] = true,
			},
			["rules"] = {
				["state"] = true,
				["hooked"] = true,
				["registration"] = true,
			},
			["realm"] = {
				["loaded"] = true,
			},
			["object"] = {
				["notfound"] = false,
			},
		},
		["mount"] = {
			["correction"] = { }, -- [spell id] = mountType
		},
		["action"] = {
			["vendor"] = {
				["enable"] = false,
				["auto"] = false,
				["manual"] = true,
				["combat"] = false,
				["limit"] = true,
--				["delete"] = false,
				["notify"] = true,
				["raritycutoff"] = ArkInventory.ENUM.ITEM.QUALITY.POOR, -- max quality to sell
				["partyloot"] = false,
				["list"] = true,
				["test"] = true,
				["soulbound"] = {
					["known"] = true,
					["equipment"] = true,
					--["itemlevel"] = true,
					["ignorelevel"] = true,
				},
			},
			["mail"] = {
				["enable"] = false,
				["auto"] = false,
				["manual"] = true,
				["notify"] = true,
				["raritycutoff"] = ArkInventory.ENUM.ITEM.QUALITY.POOR, -- max quality to send
				["list"] = true,
				["test"] = true,
			},
			["use"] = {
				["enable"] = false,
				["auto"] = false,
				["manual"] = true,
				["combat"] = false,
				["list"] = true,
				["test"] = true,
				["item"] = {
					[211279] = true, -- cache of infinite treasure
					[211932] = true, -- cache of infinite treasure
					[223907] = false, -- asynchronized prismatic gem (will trigger addon block)
					[223908] = true, -- minor bronze cache
					[223909] = true, -- lesser bronze cache
					[223910] = true, -- bronze cache
					[223911] = true, -- greater bronze cache
				},
			},
			["delete"] = {
				["enable"] = false,
				["raritycutoff"] = ArkInventory.ENUM.ITEM.QUALITY.POOR, -- max quality to delete
				["partyloot"] = false,
				["list"] = true,
				["test"] = true,
			},
			["scrap"] = {
				["enable"] = false,
				["auto"] = false,
				["manual"] = true,
				["raritycutoff"] = ArkInventory.ENUM.ITEM.QUALITY.POOR, -- max quality to scrap
				["list"] = true,
				["test"] = true,
			},
		},
		["font"] = {
			["face"] = ArkInventory.Const.Font.Face,
			["height"] = ArkInventory.Const.Font.Height,
		},
		["menu"] = {
			["font"] = {
				["face"] = ArkInventory.Const.Font.Face,
				["height"] = ArkInventory.Const.Font.Height,
			},
		},
		["newitemglow"] = {
			["enable"] = true,
			["colour"] = { r = 0.7, g = 0.7, b = 0.7, a = 0.5 },
			["clearonclose"] = false,
		},
		["transmog"] = {
			["enable"] = true,
			["anchor"] = ArkInventory.ENUM.ANCHOR.DEFAULT,
			["secondary"] = false,
			["icon"] = {
				[ArkInventory.Const.Transmog.State.CanLearnMyself] = {
					["style"] = ArkInventory.Const.Transmog.StyleDefault,
					["colour"] = { r = 0.00, g = 1.00, b = 0.00, a = 1 }, -- green
				},
				[ArkInventory.Const.Transmog.State.CanLearnMyselfSecondary] = {
					["style"] = ArkInventory.Const.Transmog.StyleDefault,
					["colour"] = { r = 0.08, g = 0.76, b = 0.94, a = 1 },
				},
				[ArkInventory.Const.Transmog.State.CanLearnOther] = {
					["style"] = ArkInventory.Const.Transmog.StyleDefault,
					["colour"] = { r = 1.00, g = 1.00, b = 0.00, a = 1 },
				},
				[ArkInventory.Const.Transmog.State.CanLearnOtherSecondary] = {
					["style"] = ArkInventory.Const.Transmog.StyleDefault,
					["colour"] = { r = 1.00, g = 0.78, b = 1.00, a = 1 },
				},
			},
		},
		["conflict"] = {
			["tsm"] = {
				["mailbox"] = false,
				["merchant"] = false,
			},
		},
		["ui"] = {
			["sortalpha"] = true,
			["main"] = {
				["retry"] = 5,
			},
			["search"] = {
				["scale"] = 1,
				["background"] = {
					["style"] = ArkInventory.Const.Texture.BackgroundDefault,
					["colour"] = {
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
						["a"] = 0.75,
					},
				},
				["border"] = {
					["style"] = ArkInventory.Const.Texture.BorderDefault,
					["size"] = nil,
					["offset"] = nil,
					["scale"] = 1,
					["colour"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["font"] = {
					["height"] = ArkInventory.Const.Font.Height,
				},
				["strata"] = "MEDIUM"
			},
			["rules"] = {
				["scale"] = 1,
				["background"] = {
					["style"] = ArkInventory.Const.Texture.BackgroundDefault,
					["colour"] = {
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
						["a"] = 0.75,
					},
				},
				["border"] = {
					["style"] = ArkInventory.Const.Texture.BorderDefault,
					["size"] = nil,
					["offset"] = nil,
					["scale"] = 1,
					["colour"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["font"] = {
					["height"] = ArkInventory.Const.Font.Height,
				},
				["strata"] = "MEDIUM",
				["width"] = 600,
				["rows"] = 15,
			},
			["actions"] = {
				["scale"] = 1,
				["background"] = {
					["style"] = ArkInventory.Const.Texture.BackgroundDefault,
					["colour"] = {
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
						["a"] = 0.75,
					},
				},
				["border"] = {
					["style"] = ArkInventory.Const.Texture.BorderDefault,
					["size"] = nil,
					["offset"] = nil,
					["scale"] = 1,
					["colour"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["font"] = {
					["height"] = ArkInventory.Const.Font.Height,
				},
				["strata"] = "MEDIUM",
				["width"] = 600,
				["rows"] = 15,
			},
			["debug"] = {
				["enable"] = true,
				["lines"] = 400,
				["scale"] = 1,
				["background"] = {
					["style"] = ArkInventory.Const.Texture.BackgroundDefault,
					["colour"] = {
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
						["a"] = 0.75,
					},
				},
				["border"] = {
					["style"] = ArkInventory.Const.Texture.BorderDefault,
					["size"] = nil,
					["offset"] = nil,
					["scale"] = 1,
					["colour"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				},
				["font"] = {
					["height"] = ArkInventory.Const.Font.Height,
				},
				["strata"] = "MEDIUM"
			},
		},
		["thread"] = {
			["debug"] = false,
			["timeout"] = {
				["normal"] = 25,
				["combat"] = 25, -- 200ms appears to be the actual limit
				["tooltip"] = 25, -- tooltip generation queue
				["objectdata"] = 25, -- object data retreival queue
				
				-- actions
				["junksell"] = 75, -- this is a minimum duration timer, not a timeout, must be above 50 (will occasionally fail when that low)
				["mailsend"] = 2500, -- this is not a timer, its the number of retries
				["useitem"] = 75, -- this is a minimum duration timer, not a timeout
				["scrap"] = 75, -- this is a minimum duration timer, not a timeout
			},
		},
--		["suffix"] = {
--			["count"] = false,
--			["search"] = false,
--		},
		["bonusid"] = {
			["count"] = {
				["suffix"] = false,
			},
			["search"] = {
				["suffix"] = false,
				["corruption"] = true,
			},
		},
--		["panel"] = {
--			["bank"] = {
--				["combine"] = {
--					["all"] = false,
--					["reagent"] = true,
--					["account"] = true,
--				},
--			},
--		},
	},
	["player"] = {
		["version"] = 0,
		["data"] = {
			["*"] = { -- player or guild name
				
				["erasesilent"] = false,
				
				["ldb"] = {
					["bags"] = {
						["colour"] = false,
						["full"] = true,
						["includetype"] = true,
						["include"] = {
							["*"] = true,
						},
					},
					["pets"] = {
						["randomise"] = true,
						["useall"] = true,
						["selected"] = {
							["*"] = nil,
						},
					},
					["mounts"] = {
						["randomise"] = true,
--						["dragonriding"] = true,
						["type"] = {
							["l"] = { -- land (ground)
								["useflying"] = false,
								["usesurface"] = false,
								["useall"] = true,
								["selected"] = {
									["*"] = nil,
								},
							},
							["a"] = { -- air (flying)
								["dismount"] = false,
								["useall"] = true,
								["selected"] = {
									["*"] = nil,
								},
								["mode"] = {
									["*"] = ArkInventory.ENUM.FLIGHT.MODE.ALL,
								},
							},
							["u"] = { -- underwater
								["useall"] = true,
								["selected"] = {
									["*"] = nil,
								},
							},
							["s"] = { -- surface (water)
								["useall"] = true,
								["selected"] = {
									["*"] = nil,
								},
							},
							["x"] = { -- unknown
								["useall"] = true,
								["selected"] = {
									["*"] = nil,
								},
							},
						},
					},
					["tracking"] = {
						["currency"] = {
							["tracked"] = {
								["*"] = false, -- included in object tooltip
							},
							["expand"] = { -- list of header ids to auto expand (so its children are in-lined)
								["*"] = false,
							},
							["watched"] = { -- included in object name
								["*"] = false,
							},
						},
						["item"] = {
							["tracked"] = {
								["*"] = false,
							},
						},
						["reputation"] = {
							["tracked"] = {
								["*"] = false, -- included in object tooltip
							},
							["expand"] = { -- list of header ids to auto expand (so its children are in-lined)
								["*"] = false,
							},
							["watched"] = nil, -- included in object name (only one rep can be watched)
						},
						["bronze"] = {
							["tracked"] = 2778,  -- default to timerunning bronze
						},
					},
					["travelform"] = false,
				},
				
				["option"] = { -- mostly moved to profile
					["*"] = { -- loc_id_window
						["bag"] = {
							["*"] = { -- bag_id_window
								["display"] = true,
								["restack"] = {
									["ignore"] = false,
								},
							},
						},
					},
				},
				
				["info"] = {
					["**"] = nil,
					["account_id"] = 100,
					["money"] = 0,
					["tradeskill"] = {
						["*"] = nil, -- slot = tradeskill id
					},
				},
				
				["location"] = {
					["*"] = { -- loc_id
						["slot_count"] = 0,
						["bag"] = { -- bag_id
							["*"] = {
								["status"] = ArkInventory.Const.Bag.Status.Unknown,
								["texture"] = nil,
								["name"] = nil,
--								["h"] = nil,
--								["q"] = nil,
								["type"] = ArkInventory.Const.Slot.Type.Unknown,
								["count"] = 0,
								["empty"] = 0,
								["slot"] = { },
							},
						},
					},
				},
				
				["tradeskill"] = {
					["priority"] = 1, -- profession priority for category assignment
				},
				
				["panel"] = {
					["bank"] = {
						["combine"] = {
							["all"] = false,
							["reagent"] = true,
							["account"] = true,
						},
					},
				},
				
				["profile"] = 1000,
				
			},
		},
	},
	["account"] = {
		["version"] = 0,
		["data"] = {
			["**"] = {
				["guid"] = false,
				["system"] = false,
				["used"] = "N", -- Y(es) | N(o) | D(eleted)
				["name"] = "",
			},
			[100] = {
				["system"] = true,
				["used"] = "Y",
				["name"] = MANAGE_ACCOUNT,
			},
			[999] = {
				["system"] = true,
				["used"] = "Y",
				["name"] = ArkInventory.Localise["UNASSIGNED"],
			},
		},
		["min"] = 500,
		["next"] = 500,
		["max"] = 900,
	},
	["cache"] = {
		["version"] = 0,
		["default"] = {
			["*"] = nil, -- key generated via ObjectIDCategory( )
		},
		["rule"] = {
			["*"] = nil, -- key generated via ObjectIDRule( )
		},
		["trainerspecies"] = { -- populates as you battle them
			["*"] = false, --speciesID = { table of species + trainer pet data }
		},
		["reputation"] = {
			["*"] = nil,
		},
		["tradeskill"] = {
			["data"] = {
				["*"] = { -- skillID
					["name"] = ""
				},
			},
			["enchant"] = { 
				["*"] = {
					["s"] = 0,
					["r"] = "0",
					-- dataexport values, users should never get these.  controlled via collect.exporting
					["cat"] = 0,
					["name"] = "",
					["rank"] = 0,
					["src"] = 0,
					
				},
			},
			["result"] = {
				["*"] = { --base hyperlink
					["*"] = nil, -- enchant = skillID
				},
			},
		},
--		["category"] = {
--			["*"] = { -- cat_type
--				["*"] = nil, -- cat_num = ????
--			},
--		},
	},
	["extract"] = { },
}

ArkInventory.Const.DatabaseDefaults.profile = {
	["option"] = {
		["version"] = 0,
	},
}


function ArkInventory.TOCVersionFail( quiet )
	if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ) then
		if not quiet then
			--ArkInventory.OutputWarning( "This version is meant for The War Within, you may experience issues using it with this game client." )
			--ArkInventory.OutputWarning( "If you encounter any issues please open a issue on github." )
		end
	end
end

function ArkInventory.OnLoad( )
	
	-- called via the debug frame onload (its the first frame that gets created)
	
	ArkInventory.Const.StartupTime = time( ) - ( debugprofilestop( ) / 1000 )
	--ArkInventory.OutputDebug( "OnLoad - Start" )
	
	ArkInventory.Const.Program.Version = ArkInventory.CrossClient.GetAddOnMetadata( ArkInventory.Const.Program.Name, "Version" )
	
	local ignore, ignore, ignore, major, minor = string.find( ArkInventory.Const.Program.Version, "^((%d+)[.](%d%d))$" )
	if not major then
		ignore, ignore, major = string.find( ArkInventory.Const.Program.Version, "^(%d+)$" )
		if not major then
--			ArkInventory.OutputError( "code failure: TOC Interface value does not have the correct format 123456 or 123456.78" )
		end
	end
	ArkInventory.Global.VersionText = string.format( "v%s", major )
	
	-- this needs to be a number
	ArkInventory.Const.Program.Version = 0 + ArkInventory.Const.Program.Version
	--ArkInventory.Output( ArkInventory.Const.Program.Version )
	
	
	local releasetype = ArkInventory.CrossClient.GetAddOnMetadata( ArkInventory.Const.Program.Name, "X-ReleaseType" )
	if releasetype ~= "" then
		ArkInventory.Global.VersionText = string.format( "%s.%s", ArkInventory.Global.VersionText, releasetype )
	end
	
	if minor then
		minor = 0 + minor
		if releasetype == "" then
			ArkInventory.OutputError( "code failure: TOC Interface value appears to be a point release but X-ReleaseType is not set" )
		end
		ArkInventory.Global.VersionText = string.format( "%s.%s", ArkInventory.Global.VersionText, minor )
	end
	
	ArkInventory.Global.Version = string.format( "%s [%s]", ArkInventory.Global.VersionText, ArkInventory.Const.BLIZZARD.CLIENT.NAME )
	
	
	-- bags
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX.BACKPACK, loc_id_window = ArkInventory.Const.Location.Bag, fixed = true } )
	for x = 1, ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS_NORMAL do
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX["BAG_" .. x], loc_id_window = ArkInventory.Const.Location.Bag } )
	end
	
	-- reagent bag
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX.REAGENTBAG_1, loc_id_window = ArkInventory.Const.Location.Bag, loc_id_storage = ArkInventory.Const.Location.ReagentBag } )
	
	
	-- keyring 11101 - 40200
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX.KEYRING, loc_id_window = ArkInventory.Const.Location.Keyring } )
	
	
	-- bank
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX.BANK, loc_id_window = ArkInventory.Const.Location.Bank, fixed = true } )
	for x = 1, ArkInventory.Const.BLIZZARD.GLOBAL.BANK.NUM_BAGS do
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX["BANKBAG_" .. x], loc_id_window = ArkInventory.Const.Location.Bank } )
	end
	
	-- reagent bank
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX.REAGENTBANK, loc_id_window = ArkInventory.Const.Location.Bank, loc_id_storage = ArkInventory.Const.Location.ReagentBank, fixed = true } )
	
	-- account bank
	for x = 1, ArkInventory.Const.BLIZZARD.GLOBAL.ACCOUNTBANK.NUM_BAGS do
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX["ACCOUNTBANK_" .. x], loc_id_window = ArkInventory.Const.Location.Bank, loc_id_storage = ArkInventory.Const.Location.AccountBank, tab_id = x, fixed = true } )
	end
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX.ACCOUNTBANK, loc_id_window = ArkInventory.Const.Location.Bank, loc_id_storage = ArkInventory.Const.Location.AccountBank, fixed = true, hidden = true } )
	
	
	-- guild bank 20300
	for x = 1, ArkInventory.Const.BLIZZARD.GLOBAL.GUILDBANK.NUM_BAGS do
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Vault + x, loc_id_window = ArkInventory.Const.Location.Vault, tab_id = x, panel_id = x } )
	end
	
	
	-- mailbox
	for x = 1, 2 do
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Mailbox + x, loc_id_window = ArkInventory.Const.Location.Mailbox } )
	end
	
	
	-- wearing
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Wearing + 1, loc_id_window = ArkInventory.Const.Location.Wearing } )
	
	if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.TBC ) then
		table.insert( ArkInventory.Const.InventorySlotName, "RangedSlot" )
	end
	
	
	-- pet 30002
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Pet + 1, loc_id_window = ArkInventory.Const.Location.Pet } )
	
	
	-- mount 30002
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Mount + 1, loc_id_window = ArkInventory.Const.Location.Mount } )
	
	
	-- mount equipment 80200
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.MountEquipment + 1, loc_id_window = ArkInventory.Const.Location.MountEquipment } )
	
	
	-- toybox 60200
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Toybox + 1, loc_id_window = ArkInventory.Const.Location.Toybox } )
	
	
	-- heirloom 60100
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Heirloom + 1, loc_id_window = ArkInventory.Const.Location.Heirloom } )
	
	
	-- currency
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Currency + 1, loc_id_window = ArkInventory.Const.Location.Currency } )
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.AccountCurrency + 1, loc_id_window = ArkInventory.Const.Location.Currency, loc_id_storage = ArkInventory.Const.Location.AccountCurrency, panel_id = 2 } )
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.ENUM.BAG.INDEX.CURRENCY, loc_id_window = ArkInventory.Const.Location.Currency, hidden = true } )
	
	
	-- auctions
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Auction + 1, loc_id_window = ArkInventory.Const.Location.Auction } )
	
	-- void storage
	for x = 1, ArkInventory.Const.BLIZZARD.GLOBAL.VOIDSTORAGE.NUM_BAGS do
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Void + x, loc_id_window = ArkInventory.Const.Location.Void, tab_id = x } )
	end
	
	
	-- reputation
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Reputation + 1, loc_id_window = ArkInventory.Const.Location.Reputation } )
	ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.AccountReputation + 1, loc_id_window = ArkInventory.Const.Location.Reputation, loc_id_storage = ArkInventory.Const.Location.AccountReputation, panel_id = 1 } )
	
	
	-- tradeskill + equipment
	for x = 1, ArkInventory.Const.Tradeskill.maxLearn do
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.Tradeskill + x, loc_id_window = ArkInventory.Const.Location.Tradeskill, tab_id = x } )
		ArkInventory.Util.MapAddBag( { blizzard_id = ArkInventory.Const.Offset.TradeskillEquipment + x, loc_id_window = ArkInventory.Const.Location.TradeskillEquipment, tab_id = x } )
	end
	
	
	--ArkInventory.OutputDebug( "OnLoad - End" )
	
end

function ArkInventory.OnInitialize( )
	
	ArkInventory.OutputDebug( "OnInitialize - Start" )
	
	-- pre acedb load, the database is just a table
	ArkInventory.DatabaseUpgradePreLoad( )
	
	-- load database, use default profile as we dont need them, metatables now active
	ArkInventory.acedb = LibStub( "AceDB-3.0" ):New( "ARKINVDB", ArkInventory.Const.DatabaseDefaults, true )
	ArkInventory.db = ArkInventory.acedb.global
	ArkInventory.Global.Mode.Database = true
	
	ArkInventory.OutputDebugConfig( )
	
	ArkInventory.StartupChecks( )
	
	-- config menu (internal)
	ArkInventory.Lib.Config:RegisterOptionsTable( ArkInventory.Const.Frame.Config.Internal, ArkInventory.Config.Internal )
	ArkInventory.Lib.Dialog:SetDefaultSize( ArkInventory.Const.Frame.Config.Internal, 1250, 700 )
	
	-- config menu (blizzard)
	ArkInventory.ConfigBlizzard( )
	ArkInventory.Lib.Config:RegisterOptionsTable( ArkInventory.Const.Frame.Config.Blizzard, ArkInventory.Config.Blizzard, { "arkinventory", "arkinv", "ai" } )
	ArkInventory.Lib.Dialog:AddToBlizOptions( ArkInventory.Const.Frame.Config.Blizzard, ArkInventory.Const.Program.Name )
	
	-- tooltip
	ArkInventory.Global.Tooltip.Scan = ArkInventory.TooltipScanInit( "ARKINV_ScanTooltip" )
	
	ArkInventory.LoadConnectedRealmData( )
	
	ArkInventory.PlayerInfoSet( )
	ArkInventory.MediaRegister( )
	
	local me = ArkInventory.Codex.GetPlayer( )
	
	for loc_id_window, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			if me.profile.location[loc_id_window].special then
				local frame = ArkInventory.Frame_Main_Get( loc_id_window )
				table.insert( UISpecialFrames, frame:GetName( ) )
			end
		end
	end
	
	
	ArkInventory.Const.BLIZZARD.Events = {
--		{ "blizzard event name", "arkinventory function name", blizzard_project_id, min_toc, max_toc }
		
		{ "ACTIONBAR_UPDATE_USABLE", "EVENT_ARKINV_ACTIONBAR_UPDATE_USABLE" },
		{ "CVAR_UPDATE", "EVENT_ARKINV_CVAR_UPDATE" },
--		{ "PLAYER_CONTROL_GAINED", "EVENT_ARKINV_PLAYER_CONTROL_GAINED" },
--		{ "PLAYER_CONTROL_LOST", "EVENT_ARKINV_PLAYER_CONTROL_LOST" },
		{ "PLAYER_ENTERING_WORLD", "EVENT_ARKINV_PLAYER_ENTER" }, -- not really needed but seems to fix a bug where ace doesnt seem to init again
		{ "PLAYER_LEAVING_WORLD", "EVENT_ARKINV_PLAYER_LEAVE" }, -- when the player logs out or the UI is reloaded.
		{ "PLAYER_REGEN_DISABLED", "EVENT_ARKINV_COMBAT_ENTER" }, -- player entered combat
		{ "PLAYER_REGEN_ENABLED", "EVENT_ARKINV_COMBAT_LEAVE" }, -- player left combat
		{ "PLAYER_LEVEL_UP", "EVENT_ARKINV_PLAYER_LEVEL_UP" }, -- player levelled up
--		{ "UNIT_POWER", "EVENT_ARKINV_UNIT_POWER" },
		{ "ACTIVE_TALENT_GROUP_CHANGED", "EVENT_ARKINV_TALENT_CHANGED", ArkInventory.ENUM.EXPANSION.WRATH },
--		{ "UI_SCALE_CHANGED", "" },
		{ "ADDON_LOADED", "EVENT_ARKINV_ADDON_LOADED" },
		
		{ "AUCTION_HOUSE_SHOW", "EVENT_ARKINV_AUCTION_ENTER", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "AUCTION_HOUSE_CLOSED", "EVENT_ARKINV_AUCTION_LEAVE", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "AUCTION_OWNED_LIST_UPDATE", "EVENT_ARKINV_AUCTION_UPDATE", nil, ArkInventory.ENUM.EXPANSION.CLASSIC }, -- FIX ME
		{ "OWNED_AUCTIONS_UPDATED", "EVENT_ARKINV_AUCTION_UPDATE", ArkInventory.ENUM.EXPANSION.BFA },
--		{ "OWNED_AUCTION_EXPIRED", "EVENT_ARKINV_AUCTION_UPDATE", ArkInventory.ENUM.EXPANSION.BFA },
--		{ "OWNED_AUCTION_ADDED", "EVENT_ARKINV_AUCTION_UPDATE", ArkInventory.ENUM.EXPANSION.BFA },
		{ "AUCTION_CANCELED", "EVENT_ARKINV_AUCTION_UPDATE", ArkInventory.ENUM.EXPANSION.BFA },
		
		{ "PLAYER_EQUIPMENT_CHANGED", "EVENT_ARKINV_PLAYER_EQUIPMENT_CHANGED" },
--		{ "WEAR_EQUIPMENT_SET", "EVENT_ARKINV_PLAYER_EQUIPMENT_CHANGED", ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT },
		{ "EQUIPMENT_SETS_CHANGED", "EVENT_ARKINV_EQUIPMENT_SETS_CHANGED", ArkInventory.ENUM.EXPANSION.WRATH },
		
--		{ "BAG_NEW_ITEMS_UPDATED", "" },
--		{ "BAG_SLOT_FLAGS_UPDATED", "EVENT_ARKINV_BAG_UPDATE" },
		{ "BAG_UPDATE", "EVENT_ARKINV_BAG_UPDATE" },
		{ "BAG_UPDATE_DELAYED", "EVENT_ARKINV_BAG_UPDATE_DELAYED" }, -- used for the action open (automatic)
--		{ "ITEM_LOCKED", "EVENT_ARKINV_ITEM_LOCK_CHANGED" },
--		{ "ITEM_UNLOCKED", "EVENT_ARKINV_ITEM_LOCK_CHANGED" },
		{ "ITEM_LOCK_CHANGED", "EVENT_ARKINV_ITEM_LOCK_CHANGED" },
--		{ "PLAYER_AVG_ITEM_LEVEL_UPDATE", "EVENT_ARKINV_AVG_ITEM_LEVEL_UPDATE" },
		
		{ "BANKFRAME_CLOSED", "EVENT_ARKINV_BANK_LEAVE", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "BANKFRAME_OPENED", "EVENT_ARKINV_BANK_ENTER", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
--		{ "BANK_BAG_SLOT_FLAGS_UPDATED", "EVENT_ARKINV_BANK_UPDATE" },
		{ "PLAYERBANKSLOTS_CHANGED", "EVENT_ARKINV_BANK_UPDATE" }, -- a bag_update event for the bank (-1)
		{ "PLAYERBANKBAGSLOTS_CHANGED", "EVENT_ARKINV_BANK_SLOT" }, -- triggered when you purchase a new bank bag slot
--		{ "PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED", "EVENT_ARKINV_BANK_SLOT", ArkInventory.ENUM.EXPANSION.WARWITHIN },
		
		{ "REAGENTBANK_PURCHASED", "EVENT_ARKINV_BANK_TAB", ArkInventory.ENUM.EXPANSION.DRAENOR }, -- triggered when you purchase a bank tab (reagent bank)
		{ "REAGENTBANK_UPDATE", "EVENT_ARKINV_REAGENTBANK_UPDATE", ArkInventory.ENUM.EXPANSION.DRAENOR },
		{ "PLAYERREAGENTBANKSLOTS_CHANGED", "EVENT_ARKINV_REAGENTBANK_UPDATE", ArkInventory.ENUM.EXPANSION.DRAENOR }, -- a bag_update event for the reagent bank (-3)
		
		{ "GUILDBANKFRAME_OPENED", "EVENT_ARKINV_VAULT_ENTER", ArkInventory.ENUM.EXPANSION.TBC, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "GUILDBANKFRAME_CLOSED", "EVENT_ARKINV_VAULT_LEAVE", ArkInventory.ENUM.EXPANSION.TBC, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "GUILDBANKBAGSLOTS_CHANGED", "EVENT_ARKINV_VAULT_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) },
		{ "GUILDBANKLOG_UPDATE", "EVENT_ARKINV_VAULT_LOG", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) },
		{ "GUILDBANK_ITEM_LOCK_CHANGED", "EVENT_ARKINV_VAULT_LOCK", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) },
		{ "GUILDBANK_UPDATE_MONEY", "EVENT_ARKINV_VAULT_MONEY", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) },
		{ "GUILDBANK_UPDATE_TABS", "EVENT_ARKINV_VAULT_TABS_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) },
		{ "GUILDBANK_UPDATE_TEXT", "EVENT_ARKINV_VAULT_INFO", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) },
		
--		{ "BANK_TABS_CHANGED", "EVENT_ARKINV_", ArkInventory.ENUM.EXPANSION.WARWITHIN }, 0=CHAR, 1=GUILD, 2=ACCOUNT
--		{ "BANK_TAB_SETTINGS_UPDATED", "EVENT_ARKINV_", ArkInventory.ENUM.EXPANSION.WARWITHIN }, 0=CHAR, 1=GUILD, 2=ACCOUNT
		
		{ "HEIRLOOMS_UPDATED", "EVENT_ARKINV_COLLECTION_HEIRLOOM_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Heirloom].ClientCheck ) },
		
		{ "ITEM_DATA_LOAD_RESULT", "EVENT_ARKINV_ITEM_DATA_LOAD_RESULT" },
		{ "TRADE_SKILL_ITEM_CRAFTED_RESULT", "EVENT_ARKINV_TRADE_SKILL_ITEM_CRAFTED_RESULT", ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT },
--		{ "TRADE_SKILL_CURRENCY_REWARD_RESULT", "EVENT_ARKINV_ITEM_DATA_LOAD_RESULT" },
		
		{ "CURRENCY_DISPLAY_UPDATE", "EVENT_ARKINV_COLLECTION_CURRENCY_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Currency].ClientCheck ) },
		{ "PLAYER_TRADE_CURRENCY", "EVENT_ARKINV_COLLECTION_CURRENCY_UPDATE", ArkInventory.ENUM.EXPANSION.PANDARIA }, --FIX ME, check when this got added
		{ "ACCOUNT_CHARACTER_CURRENCY_DATA_RECEIVED", "EVENT_ARKINV_COLLECTION_CURRENCY_UPDATE", ArkInventory.ENUM.EXPANSION.WARWITHIN },
		
		{ "MAIL_SHOW", "EVENT_ARKINV_MAIL_ENTER", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "MAIL_CLOSED", "EVENT_ARKINV_MAIL_LEAVE", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "MAIL_INBOX_UPDATE", "EVENT_ARKINV_MAIL_UPDATE" },
		{ "MAIL_SEND_SUCCESS", "EVENT_ARKINV_MAIL_SEND_SUCCESS" },
		{ "MAIL_FAILED", "EVENT_ARKINV_MAIL_FAILED" },
		
		{ "MERCHANT_SHOW", "EVENT_ARKINV_MERCHANT_ENTER", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "MERCHANT_CLOSED", "EVENT_ARKINV_MERCHANT_LEAVE", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		
		{ "MOUNT_EQUIPMENT_APPLY_RESULT", "EVENT_ARKINV_COLLECTION_MOUNT_EQUIPMENT_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.MountEquipment].ClientCheck ) },
--		{ "MOUNT_JOURNAL_SEARCH_UPDATED", "" },
--		{ "MOUNT_JOURNAL_USABILITY_CHANGED", "" },
		{ "NEW_MOUNT_ADDED", "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].ClientCheck ) },
		{ "UNIT_AURA", "EVENT_ARKINV_UNIT_AURA", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].ClientCheck ) },
--		{ "PLAYER_CAN_GLIDE_CHANGED", "EVENT_ARKINV_PLAYER_CAN_GLIDE_CHANGED", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].ClientCheck ) },
		
		{ "BATTLE_PET_CURSOR_CLEAR", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "CHAT_MSG_PET_BATTLE_COMBAT_LOG", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "CHAT_MSG_PET_BATTLE_INFO", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "CHAT_MSG_PET_INFO", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "COMPANION_LEARNED", "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "COMPANION_UNLEARNED", "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "COMPANION_UPDATE", "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) }, -- do i really need this? it triggers when other people mount/dismount as well
		{ "NEW_PET_ADDED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_BATTLE_CLOSE", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_BATTLE_LEVEL_CHANGED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_BATTLE_OPENING_DONE", "EVENT_ARKINV_BATTLEPET_OPENING_DONE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "PET_BATTLE_OVER", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "PET_BATTLE_PET_CHANGED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "PET_BATTLE_PET_ROUND_RESULTS", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_BATTLE_QUEUE_STATUS", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
--		{ "PET_BATTLE_XP_CHANGED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_JOURNAL_LIST_UPDATE", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_JOURNAL_PET_DELETED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_JOURNAL_PET_RESTORED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_JOURNAL_PET_REVOKED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		{ "PET_JOURNAL_PETS_HEALED", "EVENT_ARKINV_COLLECTION_PET_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) },
		
		{ "OBLITERUM_FORGE_SHOW", "EVENT_ARKINV_OBLITERUM_ENTER", ArkInventory.ENUM.EXPANSION.LEGION, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "OBLITERUM_FORGE_CLOSE", "EVENT_ARKINV_OBLITERUM_LEAVE", ArkInventory.ENUM.EXPANSION.LEGION, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		
		{ "PLAYER_MONEY", "EVENT_ARKINV_PLAYER_MONEY" },
--		{ "ACCOUNT_MONEY", "EVENT_ARKINV_", ArkInventory.ENUM.EXPANSION.WARWITHIN },
		
		{ "SKILL_LINES_CHANGED", "EVENT_ARKINV_TRADESKILL_UPDATE" }, -- triggered when you gain or lose a skill, skillup, collapse/expand a skill header, generally annoying
		{ "TRADE_SKILL_DATA_SOURCE_CHANGED", "EVENT_ARKINV_TRADESKILL_UPDATE", ArkInventory.ENUM.EXPANSION.LEGION },
		{ "TRADE_SKILL_CLOSE", "EVENT_ARKINV_TRADESKILL_UPDATE", ArkInventory.ENUM.EXPANSION.LEGION },
		{ "NEW_RECIPE_LEARNED", "EVENT_ARKINV_TRADESKILL_UPDATE", ArkInventory.ENUM.EXPANSION.LEGION },
--		{ "LEARNED_SPELL_IN_TAB", "EVENT_ARKINV_TRADESKILL_UPDATE", ArkInventory.ENUM.EXPANSION.LEGION },
		
		{ "QUEST_ACCEPTED", "EVENT_ARKINV_QUEST_UPDATE" },
		{ "QUEST_AUTOCOMPLETE", "EVENT_ARKINV_QUEST_UPDATE" },
		{ "QUEST_FINISHED", "EVENT_ARKINV_QUEST_UPDATE" },
		{ "QUEST_REMOVED", "EVENT_ARKINV_QUEST_UPDATE" },
		{ "QUEST_TURNED_IN", "EVENT_ARKINV_QUEST_UPDATE" },
--		{ "QUEST_ITEM_UPDATED", "EVENT_ARKINV_QUEST_UPDATE", nil, ArkInventory.ENUM.EXPANSION.LEGION },
--		{ "QUEST_LOG_UPDATE", "" }, -- triggers too often to be usable
		{ "UNIT_QUEST_LOG_CHANGED", "EVENT_ARKINV_QUEST_UPDATE" },
		{ "WORLD_QUEST_COMPLETED_BY_SPELL", "EVENT_ARKINV_QUEST_UPDATE", ArkInventory.ENUM.EXPANSION.LEGION },
		
		{ "SCRAPPING_MACHINE_SHOW", "EVENT_ARKINV_SCRAP_ENTER", ArkInventory.ENUM.EXPANSION.BFA, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "SCRAPPING_MACHINE_CLOSE", "EVENT_ARKINV_SCRAP_LEAVE", ArkInventory.ENUM.EXPANSION.BFA, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "UPDATE_TRADESKILL_CAST_STOPPED", "EVENT_ARKINV_UPDATE_TRADESKILL_CAST_STOPPED", ArkInventory.ENUM.EXPANSION.BFA },
		{ "UNIT_SPELLCAST_START", "EVENT_ARKINV_UNIT_SPELLCAST_START", ArkInventory.ENUM.EXPANSION.BFA },
		{ "UNIT_SPELLCAST_INTERRUPTED", "EVENT_ARKINV_UNIT_SPELLCAST_INTERRUPTED", ArkInventory.ENUM.EXPANSION.BFA },
		{ "UNIT_SPELLCAST_SUCCEEDED", "EVENT_ARKINV_UNIT_SPELLCAST_SUCCEEDED", ArkInventory.ENUM.EXPANSION.BFA },
		
		{ "TRADE_SHOW", "EVENT_ARKINV_TRADE_ENTER", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "TRADE_CLOSED", "EVENT_ARKINV_TRADE_LEAVE", nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		
		{ "TRANSMOGRIFY_OPEN", "EVENT_ARKINV_TRANSMOG_ENTER", ArkInventory.ENUM.EXPANSION.CATACLYSM, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		{ "TRANSMOGRIFY_CLOSE", "EVENT_ARKINV_TRANSMOG_LEAVE", ArkInventory.ENUM.EXPANSION.CATACLYSM, ArkInventory.ENUM.EXPANSION.SHADOWLANDS },
		
		{ "NEW_TOY_ADDED", "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Toybox].ClientCheck ) },
		{ "TOYS_UPDATED", "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Toybox].ClientCheck ) },
		
		{ "UPDATE_FACTION", "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE" }, -- triggers off gui changes and can cause infinite loops if another mod changes the gui
		{ "CHAT_MSG_COMBAT_FACTION_CHANGE", "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE" },
		{ "LFG_BONUS_FACTION_ID_UPDATED", "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE", ArkInventory.ENUM.EXPANSION.PANDARIA, ArkInventory.ENUM.EXPANSION.BFA },
		{ "UPDATE_EXPANSION_LEVEL", "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE" },
		
		{ "VOID_STORAGE_OPEN", "EVENT_ARKINV_VOID_ENTER", ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA, ArkInventory.ENUM.EXPANSION.SHADOWLANDS ) }, -- void storage not implemented in cata beta yet so moved to pandaria temporarily
		{ "VOID_STORAGE_CLOSE", "EVENT_ARKINV_VOID_LEAVE", ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA, ArkInventory.ENUM.EXPANSION.SHADOWLANDS ) }, -- void storage not implemented in cata beta yet so moved to pandaria temporarily
		
		{ "VOID_STORAGE_UPDATE", "EVENT_ARKINV_VOID_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Void].ClientCheck ) },
		{ "VOID_STORAGE_CONTENTS_UPDATE", "EVENT_ARKINV_VOID_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Void].ClientCheck ) },
		{ "VOID_STORAGE_DEPOSIT_UPDATE", "EVENT_ARKINV_VOID_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Void].ClientCheck ) },
		{ "VOID_TRANSFER_DONE", "EVENT_ARKINV_VOID_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Void].ClientCheck ) },
--		{ "VOID_DEPOSIT_WARNING", "EVENT_ARKINV_VOID_UPDATE", ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Void].ClientCheck ) },
		
--		{ "ZONE_CHANGED", "EVENT_ARKINV_ZONE_CHANGED" },
--		{ "ZONE_CHANGED_INDOORS", "EVENT_ARKINV_ZONE_CHANGED" },
--		{ "ZONE_CHANGED_NEW_AREA", "EVENT_ARKINV_ZONE_CHANGED" },
		
--		{ "SPELL_UPDATE_COOLDOWN", "EVENT_ARKINV_UPDATE_COOLDOWN" },
--		{ "ACTIONBAR_UPDATE_COOLDOWN", "EVENT_ARKINV_UPDATE_COOLDOWN" },
--		{ "BAG_UPDATE_COOLDOWN", "EVENT_ARKINV_UPDATE_COOLDOWN" },
--		{ "PET_BAR_UPDATE_COOLDOWN", "EVENT_ARKINV_UPDATE_COOLDOWN" },
		
--		{ "UNIT_INVENTORY_CHANGED", "EVENT_ARKINV_INVENTORY_CHANGE" }, -- triggers from too much garbage to be useful, also provides no helpful args
		
		{ "LOOT_OPENED", "EVENT_ARKINV_LOOT_OPENED" },
		{ "LOOT_CLOSED", "EVENT_ARKINV_LOOT_CLOSED" },
		
		{ "TRANSMOG_COLLECTION_SOURCE_ADDED", "EVENT_ARKINV_TRANSMOG_SOURCE_ADDED", ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ) },
		{ "TRANSMOG_COLLECTION_SOURCE_REMOVED", "EVENT_ARKINV_TRANSMOG_SOURCE_REMOVED", ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ) },
		
		{ "ACCOUNT_CHARACTER_CURRENCY_DATA_RECEIVED", "EVENT_ARKINV_ACCOUNT_CHARACTER_CURRENCY_DATA_RECEIVED", ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ) },
		{ "CURRENCY_TRANSFER_LOG_UPDATE", "EVENT_ARKINV_ACCOUNT_CHARACTER_CURRENCY_DATA_RECEIVED", ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ) },
		
	}
	
	ArkInventory.OutputDebug( "OnInitialize - End" )
	
end

function ArkInventory.OnEnable( )
	
	-- Called when the addon is enabled
	
	ArkInventory.OutputDebug( "OnEnable - Start" )
	
	
	ArkInventory.Global.TimerunningSeasonID = ArkInventory.CrossClient.TimerunningSeasonID( )
	if ArkInventory.Global.TimerunningSeasonID > 0 then
		local TimerunningExpansion = ArkInventory.ENUM.TIMERUNNINGSEASON[ArkInventory.Global.TimerunningSeasonID]
		if TimerunningExpansion then
			ArkInventory.Const.BLIZZARD.CLIENT.NAME = string.format( "Timerunner - %s", _G[string.format( "EXPANSION_NAME%s", TimerunningExpansion )] )
			ArkInventory.Global.Version = string.format( "%s [%s]", ArkInventory.Global.VersionText, ArkInventory.Const.BLIZZARD.CLIENT.NAME )
		else
			ArkInventory.OutputError( "TimerunningSeasonID [", ArkInventory.Global.TimerunningSeasonID, "] is not configured.  please let the author know." )
		end
		
	end
	
	ArkInventory.Action.ConflictCheck( )
	
	if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.PANDARIA ) then
		-- global options that need to be disabled in clients before pandaria was released (if saved variables was copied from retail)
		ArkInventory.db.option.cleanup.enable = false
		ArkInventory.db.option.cleanup.reverse = false
		ArkInventory.db.option.transmog.enable = false
		ArkInventory.db.option.tooltip.battlepet.enable = false
	end
	
--[[
	-- clear locations that shouldnt have data in this client
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if not loc_data.isMapped then
			ArkInventory.EraseSavedData( nil, loc_id, true )
		end
	end
]]--
	
	if ArkInventory.TOCVersionFail( ) then return end
	
	ArkInventory.OutputDebug( "OnEnable - PlayerInfoSet" )
	ArkInventory.PlayerInfoSet( )
	
	ArkInventory.OutputDebug( "OnEnable - BlizzardAPIHook" )
	ArkInventory.BlizzardAPIHook( )
	
	ArkInventory.OutputDebug( "OnEnable - DatabaseUpgradePostLoad" )
	ArkInventory.DatabaseUpgradePostLoad( )
	
	ArkInventory.OutputDebug( "OnEnable - CategoryGenerate" )
	ArkInventory.CategoryGenerate( )
	
	-- tag all locations as changed
	ArkInventory.LocationSetValue( nil, "changed", true )
	
	-- tag all locations to be rebuilt from scratch
	--ArkInventory.OutputWarning( "OnEnable - restart window draw" )
	ArkInventory.Frame_Main_DrawStatus( nil, ArkInventory.Const.Window.Draw.Restart )
	
	-- init location player id
	ArkInventory.LocationSetValue( nil, "player_id", ArkInventory.PlayerIDSelf( ) )
	
	-- register bucket events
	for name, timer in pairs( ArkInventory.db.option.updatetimer ) do
		if ArkInventory[name] then
			local value = ( timer.custom and timer.value ) or timer.default
			ArkInventory.OutputDebug( "RegisterBucketMessage( ", name, ", ", value, " )" )
			ArkInventory:RegisterBucketMessage( name, value )
		else
			ArkInventory.OutputDebug( "RegisterBucketMessage failed as a function named ", name, " does not exist, clearing data" )
			ArkInventory.db.option.updatetimer[name] = nil
		end
	end
	
	for k, v in pairs( ArkInventory.Const.BLIZZARD.Events ) do
		--ArkInventory.Output( v )
		-- 1 = blizzard event name
		if v[1] and v[1] ~= "" then
			-- 2 = arkinventory function name
			if v[2] and v[2] ~= "" and ArkInventory[v[2]] then
				-- 3 = project id
				-- 4 = min toc required
				-- 5 = max toc required
				if ArkInventory.ClientCheck( v[3], v[4] ) then
					--ArkInventory.Output( "registering event: ", v[1], "=", v[2] )
					-- use pcall to register them as events can be removed at any time which will cause this to break otherwise
					local ok, msg = pcall( ArkInventory.RegisterEvent, ArkInventory, v[1], v[2] )
					if not ok then
						ArkInventory.OutputWarning( "skipped event: ", v[1], ": ", msg )
					end
				else
					--ArkInventory.OutputWarning( "skipped event: ", v[1], ": not meant for this client/toc" )
				end
			else
				ArkInventory.OutputWarning( "skipped event: ", v[1], ": function ", v[2], " does not exist" )
			end
		else
			ArkInventory.OutputWarning( "skipped event: name is nil or empty" )
		end
	end
	
	
	for loc_id_window, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
		
			-- initialise codex for each location
			local codex = ArkInventory.Codex.GetLocation( loc_id_window )
			
			-- and confirm its actually valid
			local f = string.format( ArkInventory.Localise["CONFIG_BLUEPRINT_VALIDATE"], ArkInventory.Global.Location[loc_id_window].Name, ArkInventory.Localise["CONFIG"], ArkInventory.Localise["GENERAL"], ArkInventory.Localise["CONFIG_PROFILE_PLURAL"], ArkInventory.Localise["CONTROLS"], ArkInventory.Localise["CONFIG_BLUEPRINT"] )
			
			local id, data, defaulted = ArkInventory.ConfigInternalDesignGet( codex.profile.location[loc_id_window].style, true )
			if defaulted then
				local s = ArkInventory.Localise["CONFIG_STYLE"]
				if codex.profile.location[loc_id_window].style == codex.profile.location[loc_id_window].layout then
					s = string.format( "%s and %s", s, ArkInventory.Localise["CONFIG_LAYOUT"] )
				end
				ArkInventory.OutputWarning( string.format( f, s, codex.profile.location[loc_id_window].style ) )
			end
			
			if codex.profile.location[loc_id_window].style ~= codex.profile.location[loc_id_window].layout then
				local id, data, defaulted = ArkInventory.ConfigInternalDesignGet( codex.profile.location[loc_id_window].layout, true )
				if defaulted then
					ArkInventory.OutputWarning( string.format( f, ArkInventory.Localise["CONFIG_LAYOUT"], codex.profile.location[loc_id_window].layout ) )
				end
			end
			
			local id, data, defaulted = ArkInventory.ConfigInternalCategorysetGet( codex.profile.location[loc_id_window].catset, true )
			if defaulted then
				ArkInventory.OutputWarning( string.format( f, ArkInventory.Localise["CONFIG_CATEGORY_SET"], codex.profile.location[loc_id_window].catset ) )
			end
			
			
			-- preload the item info to make the first load faster
			if loc_data.preloaditeminfo and not InCombatLockdown( ) and codex.profile.location[loc_id_window].preload then
				
				local c = 0
				
				for loc_id_storage in pairs( ArkInventory.Util.MapGetChildren( loc_id_window ) ) do
					local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
					for bag_id_storage, bag_data in pairs( storage.data.location[loc_id_storage].bag ) do
						for slot_id, i in pairs( bag_data.slot ) do
							c = c + 1
							ArkInventory.GetObjectInfo( i.h, i )
						end
					end
				end
				ArkInventory.OutputDebug( "pre-loading info for ", c, " ", loc_data.Name, " item(s)" )
				loc_data.preloaditeminfo = nil
			end
			
		end
		
	end
	
	
	if ContainerFrame1 and not ARKINV_ButtonOverrideBag1 then
		local obj = CreateFrame( "Button", "ARKINV_ButtonOverrideBag1", ContainerFrame1, "ARKINV_TemplateLocationOverride" )
		obj:SetID( ArkInventory.Const.Location.Bag )
		if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.CLASSIC ) then
			obj:SetPoint( "TOPRIGHT", -30, -8 )
		elseif ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.WRATH ) then
			obj:SetPoint( "TOPRIGHT", -28, -8 )
		end
	end
	
	if ContainerFrameCombinedBags and not ARKINV_ButtonOverrideBag2 then
		local obj = CreateFrame( "Button", "ARKINV_ButtonOverrideBag2", ContainerFrameCombinedBags, "ARKINV_TemplateLocationOverride" )
		obj:SetID( ArkInventory.Const.Location.Bag )
	end
	
	if BankFrame and not ARKINV_ButtonOverrideBank then
		local obj = CreateFrame( "Button", "ARKINV_ButtonOverrideBank", BankFrame, "ARKINV_TemplateLocationOverride" )
		obj:SetID( ArkInventory.Const.Location.Bank )
		if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.CLASSIC ) then
			obj:SetPoint( "TOPRIGHT", -63, -15 )
		elseif ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.WRATH ) then
			obj:SetPoint( "TOPRIGHT", -12, -15 )
		end
	end
	
	if GuildBankFrame and not ARKINV_ButtonOverrideVault then
		local obj = CreateFrame( "Button", "ARKINV_ButtonOverrideVault", GuildBankFrame, "ARKINV_TemplateLocationOverride" )
		obj:SetID( ArkInventory.Const.Location.Vault )
		if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.WRATH ) then
			obj:SetPoint( "TOPRIGHT", -26, -14 )
		end
	end
	
	
	ArkInventory.Tradeskill.ScanHeaders( )
	ArkInventory.ScanLocationWindow( )
	ArkInventory.ScanAuctionExpire( )
	
	ArkInventory.Output( ArkInventory.Global.Version, " ", ArkInventory.Localise["ENABLED"] )
	
	ArkInventory.MediaMenuFontSet( ArkInventory.db.option.font.face, ArkInventory.db.option.menu.font.height )
	
	if not ArkInventory.Global.Thread.Use then
		-- should be set to true by default so if its not then i forgot to put it back
		ArkInventory.OutputWarning( "Thread.Use is disabled (this may be deliberate if this is an Alpha/Beta version)" )
	end
	
	ArkInventory.Collection.Reputation.ImportCrossRefTable( )
	ArkInventory.Collection.Currency.ImportCrossRefTable( )
	ArkInventory.Collection.Pet.ImportCrossRefTable( )
	ArkInventory.Collection.Mount.ImportCrossRefTable( )
	
	ArkInventory.ItemCacheClear( )
	
	ArkInventory.CrossClient.SetSortBagsRightToLeft( ArkInventory.db.option.cleanup.reverse )
	
	ArkInventory.LDB.Update( )
	
	-- FIX ME   profile / blueprint checks to warn (once) about missing entries
	
	ArkInventory.GenerateMailRecipients( )
	
	if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.SHADOWLANDS ) then
		-- acknowledge reagent bag tutorial so it doesnt keep popping up
		SetCVarBitfield( "closedInfoFrames", LE_FRAME_TUTORIAL_EQUIP_REAGENT_BAG, true )
	end
	
	
	ArkInventory.Tools.GlobalSearch( )
	
	ArkInventory.ExtractData( )
	
	ArkInventory.OutputDebug( "OnEnable - End" )
	
end

function ArkInventory.OnDisable( )
	
	--ArkInventory.Frame_Main_Hide( )
	
	if ArkInventory.TOCVersionFail( true ) then return end
	
	ArkInventory.BlizzardAPIHook( true )
	
	ArkInventory.Output( ArkInventory.Global.Version, " ", ArkInventory.Localise["DISABLED"] )
	
end

function ArkInventory.ItemSortKeyClear( loc_id )
	
	-- clear sort keys
	
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	if not codex.workpad.bar then return end
	
	for _, bar in pairs( codex.workpad.bar ) do
		for j, item in ipairs( bar.item ) do
			item.sortkey = nil
		end
	end
	
end

function ArkInventory.ItemSortKeyGenerate( i, bar_id, codex )
	
	-- put each option into a table - numbered indicies so they can be programatically sorted
	
	if not i then return nil end
	
	local codex = codex or ArkInventory.Codex.GetLocation( i.loc_id )
	
	local sid = codex.style.sort.method
	
	if bar_id then
		sid = codex.layout.bar.data[bar_id].sort.method or sid
	end
	
	local sorting = ArkInventory.ConfigInternalSortMethodGet( sid )
	
	local map = ArkInventory.Util.MapGetWindow( i.loc_id, i.bag_id )
	local blizzard_id = map.blizzard_id
	
	local s = { }
	
	-- FIX ME - include loc_id_storage and swap to bag_id_storage
	
	-- bag id
	s.bagid = i.bag_id
	
	-- slot id
	if sid == 9995 then
		-- vault layout / void storage layout
		s.slotid = i.did or i.slot_id or 0
	else
		-- all other bag/slot
		s.slotid = i.slot_id or 0
	end
	
	if sorting.used then
		
		local info = ArkInventory.GetObjectInfo( i.h, i )
		
		-- slot type
		s.slottype = ArkInventory.BagType( blizzard_id )
		
		-- item count (system)
		s.count = i.count or 1
		
		-- item name
		if i.h then
			
			local t = info.name
			if t and type( i.cn ) == "string" and i.cn ~= "" then
				t = string.format( "%s %s", t, i.cn )
			end
			t = t or ""
			
			local p, c, v = ArkInventory.ConfigInternalSortMethodGetPosition( sorting, "name" )
			if p and v and v.order and v.order[p] and v.order[p].reversed then
				t = ArkInventory.ReverseName( t )
			end
			
			s.name = t
			
		else
			
			if codex.style.slot.empty.position then
				-- first alphabetically (default)
				s.name = "!"
			else
				-- last alphabetically
				s.name = "_"
			end
			
		end
		
		-- item quality
		s.quality = info.q or ArkInventory.ENUM.ITEM.QUALITY.POOR
		
		-- profession rank/quality
		s.rank = 0
		if i.h then
			s.rank = info.rank or 0
		end
		
		-- equip location
		if i.h and info.class == "item" then
			if info.equiploc ~= "" and _G[info.equiploc] then
				s.location = ArkInventory.Const.Slot.INVTYPE_SortOrder[info.equiploc]
			end
		end
		s.location = s.location or 0
		
		-- item type / subtype
		s.itemtype = string.format( "%05i:%05i", info.itemtypeid or 0, info.itemsubtypeid or 0 )
		
		-- item (use) level
		s.itemuselevel = info.uselevel or 0
		
		-- item (stat) level
		s.itemstatlevel = info.ilvl or 0
		
		-- item age
		s.itemage = i.age or 0
		
		-- vendor price
		s.vendorprice = ( info.vendorprice or 0 ) * ( i.count or 1 )
		
		-- expansion
		s.expansion = info.expansion or 0

		-- category id and name
		local cat_id, cat = ArkInventory.ItemCategoryGet( i )
		local cat_type, cat_num = ArkInventory.CategoryIdSplit( cat_id )
		local cat = ArkInventory.db.option.category[cat_type].data[cat_num]
		s.category = string.format( "%02i:%04i:%04i", cat_type or 0, cat and cat.order or 0, cat_num or 0 )
		s.catname = cat and cat.name ~= "" and cat.name or s.category
		
		-- id
		s.id = string.format( "%s:%010i:%02i", info.class or "error", info.id or 0, info.sb or ArkInventory.ENUM.ITEM.BINDING.NEVER )
		
	end
	
	s.descending = { }
	
	local p = 0
	for k, v in ipairs( sorting.order ) do
		if v.active then
			p = p + 1
			s[p] = s[v.key]
			s.descending[p] = v.descending
		end
	end
	
	return s
	
end

function ArkInventory.ItemSortKeySort( a, b )
	
	if not a or not a.sortkey or not b or not b.sortkey then
		return false
	end
	
	local v2
	
	for k1, v1 in ipairs( a.sortkey ) do
		
		v2 = b.sortkey[k1]
		
		if not v1 then 
			ArkInventory.Output( "a[", k1, "] is nil - ", a.sortkey )
			ArkInventory.Output( b.sortkey )
			
			--return false
		end
		
		if not v2 then
			ArkInventory.Output( "b[", k1, "] is nil - ", b.sortkey )
			ArkInventory.Output( a.sortkey )
			--return false
		end
		
		if a.sortkey.descending[k1] then
			if v1 > v2 then return false end
			if v1 < v2 then return true end
		else
			if v1 > v2 then return true end
			if v1 < v2 then return false end
		end
		
	end
	
end

function ArkInventory.LocationSetValue( l, k, v )
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if l == nil or l == loc_id then
			loc_data[k] = v
		end
	end
end

-- old category functions were here

function ArkInventory.ReverseName( n )
	
	if n and type( n ) == "string" then
		
		local s = { }
		
		for w in string.gmatch( n, "%S+" ) do
			table.insert( s, 1, w )
		end
		
		return table.concat( s, " " )
		
	end
	
end

function ArkInventory.ItemCacheClear( h )
	
	if not h then
		
		ArkInventory.Table.Clean( ArkInventory.db.cache.rule )
		ArkInventory.Table.Clean( ArkInventory.db.cache.default )
		
	else
		
		--ArkInventory.Output( "ItemCacheClear( ", h, " )" )
		
		local cid
		local i = { h = h }
		
		for loc_id_window in pairs( ArkInventory.Util.MapGetWindow( ) ) do
			
			i.loc_id = loc_id_window
			
			for bag_id_window in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
				
				i.bag_id = bag_id_window
				
				for k, v in pairs( ArkInventory.ENUM.ITEM.BINDING ) do
					
					i.sb = v
					
					cid = ArkInventory.ObjectIDRule( i )
					ArkInventory.db.cache.rule[cid] = nil
					
					cid = ArkInventory.ObjectIDCategory( i )
					ArkInventory.db.cache.default[cid] = nil
					
				end
				
			end
			
		end
		
	end
	
	ArkInventory.CategoryGenerate( )
	
end

function ArkInventory.Frame_Main_DrawStatus( location, level )
	
	local level = level or ArkInventory.Const.Window.Draw.None
	
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			if not location or loc_id == location then
				--ArkInventory.OutputDebug( "set draw status for ", loc_id, " to [", level, "], it is currently [", ArkInventory.Global.Location[loc_id].drawState, "]" )
				if level < loc_data.drawState then
					loc_data.drawState = level
					ArkInventory.OutputDebug( "set draw status for ", loc_id, " to [", loc_data.drawState, "] (SET)" )
				end
			end
		end
	end
	
end

function ArkInventory.Frame_Main_Generate( location, drawstatus )
	
	--if drawstatus and drawstatus < 4 then
		ArkInventory.OutputDebug( "Frame_Main_Generate( ", location, ", ", drawstatus, " )" )
	--end
	
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			if not location or loc_id == location then
				ArkInventory.Frame_Main_DrawStatus( loc_id, drawstatus )
				ArkInventory.Frame_Main_DrawLocation( loc_id )
			end
		end
	end
	
end

function ArkInventory.Frame_Main_DrawLocation( loc_id )
	local frame = ArkInventory.Frame_Main_Get( loc_id )
	ArkInventory.Frame_Main_Draw( frame )
end

function ArkInventory.SetItemButtonStock( frame, count, status )
	
	-- used to show the number of empty slots on bags in the changer window
	
	if not frame then
		return
	end
	
	local obj = _G[string.format( "%s%s", frame:GetName( ), "Stock" )]
	if not obj then
		return
	end
	
	local count = count or 0
	
	local loc_id = frame.ARK_Data.loc_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	if codex.style.changer.freespace.show then
		
		if status then
			
			if status == ArkInventory.Const.Bag.Status.Purchase then
				obj:SetText( ArkInventory.Localise["STATUS_PURCHASE"] )
			elseif status == ArkInventory.Const.Bag.Status.Unknown then
				obj:SetText( ArkInventory.Localise["UNKNOWN"] )
			elseif status == ArkInventory.Const.Bag.Status.NoAccess then
				obj:SetText( ArkInventory.Localise["VAULT_TAB_ACCESS_NONE"] )
			else
				obj:SetText( "" )
			end
			
		else
			
			if count > 0 then
				obj:SetText( count )
				obj.numInStock = count
			else
				obj:SetText( ArkInventory.Localise["FULL"] )
				obj.numInStock = 0
			end
			
		end
		
		local colour = codex.style.changer.freespace.colour
		obj:SetTextColor( colour.r, colour.g, colour.b )
		
		obj:Show( )
		
	else
		
		obj:SetText( "" )
		obj.numInStock = 0
		obj:Hide( )
		
	end
	
end

function ArkInventory.ValidFrame( frame, visible, db )
	
	if frame and frame.ARK_Data and frame.ARK_Data.loc_id then
		return true
	end
	
--[[
	if frame and frame.ARK_Data and frame.ARK_Data.loc_id then
		
		local r1 = true
		if db then
			local i = ArkInventory.Frame_Item_GetDB( frame )
			if i == nil then
				r1 = false
			end
		end
		
		local r2 = true
		if visible and not frame:IsVisible( ) then
			r2 = false
		end

		return r1 and r2
		
	end
	
	return false
]]--
	
end

function ArkInventory.Frame_Main_Get( loc_id )
	
	local framename = string.format( "%s%s", ArkInventory.Const.Frame.Main.Name, loc_id )
	local frame = _G[framename]
	ArkInventory.Util.Assert( frame, "xml element [", framename, "] could not be found" )
	
	return frame
	
end
	
function ArkInventory.Frame_Main_Scale( loc_id )
	
	local frame = ArkInventory.Frame_Main_Get( loc_id )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	local old_scale = frame:GetScale( )
	local new_scale = codex.style.window.scale or 1
	
	if old_scale ~= new_scale then
		frame:SetScale( new_scale )
	end
	
	if ArkInventory.Global.Location[loc_id].drawState <= ArkInventory.Const.Window.Draw.Init then
		
		old_scale = nil
		
		if ArkInventory.db.option.auto.reposition then
			ArkInventory.Frame_Main_Reposition( loc_id )
		end
		
	end
	
	ArkInventory.Frame_Main_Anchor_Set( loc_id, old_scale )
	
end
	
function ArkInventory.Frame_Main_Scale_All( )
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			ArkInventory.Frame_Main_Scale( loc_id )
		end
	end
end

function ArkInventory.Frame_Main_Reposition( loc_id )
	
	local frame = ArkInventory.Frame_Main_Get( loc_id )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	if not frame.ARK_Data.loaded then
		--ArkInventory.Output( "cant reposition ", frame:GetName( ), " until its been built, the frame has no size" )
		--return
	end
	
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	local f_scale = frame:GetScale( )
	local a, x
	
	a = codex.profile.location[loc_id].anchor.t
	x = UIParent:GetTop( ) / f_scale
	if not a or a > x then
		--ArkInventory.Output( loc_id, " top = ", a, " / ", x )
		codex.profile.location[loc_id].anchor.t = x
		codex.profile.location[loc_id].anchor.b = x - frame:GetHeight( )
	end
	
	a = codex.profile.location[loc_id].anchor.b
	x = UIParent:GetBottom( ) / f_scale
	if not a or a < x then
		--ArkInventory.Output( loc_id, " bottom = ", a, " / ", x )
		codex.profile.location[loc_id].anchor.b = x
		codex.profile.location[loc_id].anchor.t = x + frame:GetHeight( )
	end
	
	a = codex.profile.location[loc_id].anchor.r
	x = UIParent:GetRight( ) / f_scale
	if not a or a > x then
		--ArkInventory.Output( loc_id, " right = ", a, " / ", x )
		codex.profile.location[loc_id].anchor.r = x
		codex.profile.location[loc_id].anchor.l = x - frame:GetWidth( )
	end
	
	a = codex.profile.location[loc_id].anchor.l
	x = UIParent:GetLeft( ) / f_scale
	if not a or a < x then
		--ArkInventory.Output( loc_id, " left = ", a, " / ", x )
		codex.profile.location[loc_id].anchor.l = x
		codex.profile.location[loc_id].anchor.r = x + frame:GetWidth( )
	end
	
	ArkInventory.Frame_Main_Anchor_Set( loc_id )
	
end

function ArkInventory.Frame_Main_Reposition_All( )
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			ArkInventory.Frame_Main_Reposition( loc_id )
		end
	end
end


function ArkInventory.Frame_Main_Offline( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	local me = ArkInventory.Codex.GetPlayer( )
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	--ArkInventory.Output( "loc_playerid=[", ArkInventory.Global.Location[loc_id].player_id, "] player_id=[", codex.player.data.info.player_id, "] guild_id=[", codex.player.data.info.guild_id, "]" )
	
	
	if ArkInventory.Global.Location[loc_id].isAccount then
		
		if codex.player.data.info.account_id ~= me.player.data.info.account_id then
			ArkInventory.Global.Location[loc_id].isOffline = true
		else
			ArkInventory.Global.Location[loc_id].isOffline = false
		end
		
	elseif codex.player.current == me.player.data.info.player_id or codex.player.current == me.player.data.info.guild_id then
		
		ArkInventory.Global.Location[loc_id].isOffline = false
		
		if loc_id == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.Bank == false then
			ArkInventory.Global.Location[loc_id].isOffline = true
		end
		
		if loc_id == ArkInventory.Const.Location.Vault and ArkInventory.Global.Mode.Vault == false then
			ArkInventory.Global.Location[loc_id].isOffline = true
		end
		
		if loc_id == ArkInventory.Const.Location.Mailbox and ArkInventory.Global.Mode.Mailbox == false then
			ArkInventory.Global.Location[loc_id].isOffline = true
		end
		
		if loc_id == ArkInventory.Const.Location.Void and ArkInventory.Global.Mode.Void == false then
			ArkInventory.Global.Location[loc_id].isOffline = true
		end
		
	else
		
		ArkInventory.Global.Location[loc_id].isOffline = true
		
	end
	
end

function ArkInventory.Frame_Main_Anchor_Save( frame )
	
	if not ArkInventory.ValidFrame( frame, true ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	codex.profile.location[loc_id].anchor.t = frame:GetTop( )
	codex.profile.location[loc_id].anchor.b = frame:GetBottom( )
	codex.profile.location[loc_id].anchor.l = frame:GetLeft( )
	codex.profile.location[loc_id].anchor.r = frame:GetRight( )
	
end

function ArkInventory.Frame_Main_Anchor_Set( loc_id, old_scale )
	
	local frame = ArkInventory.Frame_Main_Get( loc_id )
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	local anchor = codex.profile.location[loc_id].anchor.point
	
	local f_scale = frame:GetScale( )
	local p_scale = UIParent:GetScale( )
	
	local t = codex.profile.location[loc_id].anchor.t
	if not t then
		t = UIParent:GetTop( ) / f_scale
	elseif old_scale then
		t = t / f_scale * old_scale
	end
	
	local b = codex.profile.location[loc_id].anchor.b
	if not b then
		b = UIParent:GetBottom( ) / f_scale
	elseif old_scale then
		b = b / f_scale * old_scale
	end
	
	local l = codex.profile.location[loc_id].anchor.l
	if not l then
		l = UIParent:GetLeft( ) / f_scale
	elseif old_scale then
		l = l / f_scale * old_scale
	end
	
	local r = codex.profile.location[loc_id].anchor.r
	if not r then
		r = UIParent:GetRight( ) / f_scale
	elseif old_scale then
		r = r / f_scale * old_scale
	end
	
	local h = l + ( ( r - l ) / 2 )
	local v = b + ( ( t - b ) / 2 )
	
	frame:ClearAllPoints( )
	if anchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
		frame:SetPoint( "BOTTOMRIGHT", nil, "BOTTOMLEFT", r, b )
	elseif anchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
		frame:SetPoint( "BOTTOMLEFT", nil, "BOTTOMLEFT", l, b )
	elseif anchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
		frame:SetPoint( "TOPLEFT", nil, "BOTTOMLEFT", l, t )
	elseif anchor == ArkInventory.ENUM.ANCHOR.TOP then
		frame:SetPoint( "TOP", nil, "BOTTOMLEFT", h, t )
	elseif anchor == ArkInventory.ENUM.ANCHOR.BOTTOM then
		frame:SetPoint( "BOTTOM", nil, "BOTTOMLEFT", h, b )
	elseif anchor == ArkInventory.ENUM.ANCHOR.LEFT then
		frame:SetPoint( "LEFT", nil, "BOTTOMLEFT", l, v )
	elseif anchor == ArkInventory.ENUM.ANCHOR.RIGHT then
		frame:SetPoint( "RIGHT", nil, "BOTTOMLEFT", r, v )
	else
		frame:SetPoint( "TOPRIGHT", nil, "BOTTOMLEFT", r, t )
	end
	
	if codex.profile.location[loc_id].anchor.locked then
		frame:RegisterForDrag( )
	else
		frame:RegisterForDrag( "LeftButton" )
	end
	
	ArkInventory.Frame_Main_Anchor_Save( frame )
	
end

function ArkInventory.Frame_Main_Paint_All( )
	
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			local frame = ArkInventory.Frame_Main_Get( loc_id )
			ArkInventory.Frame_Main_Paint( frame )
		end
	end
	
end

function ArkInventory.Frame_Main_Paint( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	
	-- scroll bar
	local obj = frame.scroll.scrollBar.trackBG
	local background = codex.style.window.scrollbar.style or ArkInventory.Const.Texture.BackgroundDefault
	if background == ArkInventory.Const.Texture.BackgroundDefault then
		local colour = codex.style.window.scrollbar.colour
		ArkInventory.SetTexture( obj, true, colour.r, colour.g, colour.b, colour.a )
	else
		local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND, background )
		ArkInventory.SetTexture( obj, file )
	end
	
	
	for _, z in pairs( { frame:GetChildren( ) } ) do
		
		local framename = z:GetName( )
		if framename then -- only process objects with a name (other addons can add frames without names, we don't want to deal with them)
			
			-- background
			local obj = _G[string.format( "%s%s", framename, "Background" )]
			if obj then
				local background = codex.style.window.background.style or ArkInventory.Const.Texture.BackgroundDefault
				if background == ArkInventory.Const.Texture.BackgroundDefault then
					local colour = codex.style.window.background.colour
					ArkInventory.SetTexture( obj, true, colour.r, colour.g, colour.b, colour.a )
				else
					local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND, background )
					ArkInventory.SetTexture( obj, file )
				end
			end
			
			-- border
			local obj = z.ArkBorder
			if obj then
				
				if codex.style.window.border.style == ArkInventory.Const.Texture.BorderNone then
					
					obj:Hide( )
					
				else
					
					local border = codex.style.window.border.style or ArkInventory.Const.Texture.BorderDefault
					local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BORDER, border )
					local size = codex.style.window.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size
					local offset = codex.style.window.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offsetdefault.window
					local scale = codex.style.window.border.scale or 1
					local colour = codex.style.window.border.colour
					ArkInventory.Frame_Border_Paint( obj, file, size, offset, scale, colour.r, colour.g, colour.b, 1 )
					
					obj:Show( )
					
				end
				
			end
			
		end
		
	end
	
end

function ArkInventory.Frame_Border_Paint( obj, file, size, offset, scale, r, g, b, a )
	
	if not obj then return end
	
	local edgeSize = ( size or 16 ) * ( scale or 1 )
	local offset = ( offset or 0 ) * ( scale or 1 )
	
	local info = obj:GetBackdrop( )
	if not info or info.edgeFile ~= file or info.edgeSize ~= edgeSize then
		obj:SetBackdrop( { edgeFile = file, edgeSize = edgeSize } )
	end
	obj:SetBackdropBorderColor( r or 1, g or 1, b or 1, a or 1 )
	
	local parent = obj:GetParent( )
	obj:ClearAllPoints( )
	obj:SetPoint( "TOPLEFT", parent, 0 - offset, offset )
	obj:SetPoint( "BOTTOMRIGHT", parent, offset, 0 - offset )
	
end

function ArkInventory.Frame_Main_Resize( frame )
	
	--ArkInventory.Output( "Frame_Main_Resize" )
	
	if not ArkInventory.ValidFrame( frame, true ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	local width = codex.profile.location[loc_id].container.width
	local height = codex.profile.location[loc_id].container.height
	
	local f1 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Title.Name )]
	if not codex.style.title.hide then
		height = height + f1:GetHeight( ) * ( codex.style.title.scale or 1 )
	end
	
	local f2 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Search.Name )]
	if not codex.style.search.hide then
		height = height + f2:GetHeight( ) * ( codex.style.search.scale or 1 )
	end
	
	local f5 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Status.Name )]
	if not codex.style.status.hide then
		height = height + f5:GetHeight( ) * ( codex.style.status.scale or 1 )
	end
	
	local f4 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Changer.Name )]
	if loc_id == ArkInventory.Const.Location.Vault or not codex.style.changer.hide then
		height = height + f4:GetHeight( ) * ( codex.style.changer.scale or 1 )
	end
	
--	local f3 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Scroll.Name )]
	
	
	-- set the size of the window
	frame:SetWidth( width )
	frame:SetHeight( height )
	
	--ArkInventory.Output( string.format( "set window %i size %i x %i", loc_id, width, height ) )
	
	ArkInventory.Frame_Main_Scale( loc_id )
	
end

function ArkInventory.Frame_Main_Draw( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	
	local thread_id = string.format( ArkInventory.Global.Thread.Format.Window, loc_id )
	
	local thread_func = function( )
		local tz = debugprofilestop( )
--		ArkInventory.OutputDebug( "draw location ", loc_id, " started" )
		ArkInventory.Frame_Main_Draw_Threaded( frame, thread_id )
		tz = debugprofilestop( ) - tz
--		ArkInventory.OutputDebug( "draw location ", loc_id, " complete ", string.format( "%s took %0.0fms", thread_id, tz ) )
		ArkInventory.Global.Location[loc_id].preloadwindow = nil
	end
	
	if ArkInventory.Global.Thread.Use then
		
		if ArkInventory.ThreadRunning( thread_id ) then
			
			-- already in progress, find highest drawstate and start again
			
			if ArkInventory.Global.Thread.WindowState[loc_id] > ArkInventory.Const.Window.Draw.Init then
				-- only replace non init threads
				if ArkInventory.Global.Thread.WindowState[loc_id] >= ArkInventory.Global.Location[loc_id].drawState then
					-- drawstate is same or higher to current thread, so replace thread with a new one
					ArkInventory.OutputDebug( "draw restarting [", loc_id, "] existing thread, old=", ArkInventory.Global.Thread.WindowState[loc_id], ", new=", ArkInventory.Global.Location[loc_id].drawState )
					ArkInventory.Global.Thread.WindowState[loc_id] = ArkInventory.Global.Location[loc_id].drawState
					ArkInventory.ThreadStart( thread_id, thread_func )
				end
			else
				ArkInventory.OutputDebug( "draw ignored [", loc_id, "] existing init thread" )
			end
			
		else
			-- nothing in progress so just kick it off
			ArkInventory.OutputDebug( "draw starting [", loc_id, "] new thread, state=", ArkInventory.Global.Location[loc_id].drawState )
			ArkInventory.Global.Thread.WindowState[loc_id] = ArkInventory.Global.Location[loc_id].drawState
			ArkInventory.ThreadStart( thread_id, thread_func )
		end
		
	else
		
		ArkInventory.ThreadStart( thread_id, thread_func )
		
	end
	
end

function ArkInventory.Frame_Main_Draw_Threaded( frame, thread_id )
	
	local loc_id = frame.ARK_Data.loc_id
--	ArkInventory.Output( "Frame_Main_Draw_Threaded( ", frame:GetName( ), " ) drawstate[", ArkInventory.Global.Location[loc_id].drawState, "]" ) --, framelevel[", frame:GetFrameLevel( ), "]" )
	
	if not ArkInventory.Global.Location[loc_id].canView then
		-- not a controllable window (for scanning only)
		-- shouldnt ever get here, but just in case
		frame:Hide( )
		return
	end
	
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	--ArkInventory.Output( "draw = ", loc_id, " / ", codex.player.data.info.player_id )
	
	if not frame:IsVisible( ) then
		if not ( ArkInventory.Global.Location[loc_id].preloadwindow and codex.profile.location[loc_id].preload and not InCombatLockdown( ) ) then
			ArkInventory.OutputThread( thread_id, " aborting, not visible / preload not enabled / incombat" )
			return
		end
		ArkInventory.OutputDebug( loc_id, " - pre loading window" )
	end
	
	ArkInventory.ThreadYield_Window( loc_id )
	
	-- calculate if the window is online or offline
	ArkInventory.Frame_Main_Offline( frame )
	
	
	if loc_id == ArkInventory.Const.Location.Vault then
		
		-- force vault back to item display when offline
		if ArkInventory.Global.Location[loc_id].isOffline then
			ArkInventory.Global.Location[loc_id].active_mode = "bank"
		end
		
		obj = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Container.Name )]
		obj:Hide( )
		
		obj = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Info.Name )]
		obj:Hide( )
		
		obj = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Log.Name )]
		obj:Hide( )
		
		if ArkInventory.Global.Location[loc_id].active_mode == "log" or ArkInventory.Global.Location[loc_id].active_mode == "moneylog" then
			obj = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Log.Name )]
			obj:Show( )
		elseif ArkInventory.Global.Location[loc_id].active_mode == "tabinfo" then
			obj = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Info.Name )]
			obj:Show( )
		elseif ArkInventory.Global.Location[loc_id].active_mode == "bank" then
			obj = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Container.Name )]
			obj:Show( )
		end
		
	end
	
	
	-- edit mode
	if ArkInventory.Global.Mode.Edit then
		ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	end
	
	
	-- do we still need to draw the window?
	if ArkInventory.Global.Location[loc_id].drawState < ArkInventory.Const.Window.Draw.None then
		
		obj = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Container.Name )]
		
		ArkInventory.ThreadYield_Window( loc_id )
		ArkInventory.OutputThread( loc_id, " Frame_Container_Draw - start" )
		ArkInventory.Frame_Container_Draw( obj )
		ArkInventory.OutputThread( loc_id, " Frame_Container_Draw - end" )
		
	end
	
	if ArkInventory.Global.Location[loc_id].drawState <= ArkInventory.Const.Window.Draw.Restart then
		
		ArkInventory.ThreadYield_Window( loc_id )
		ArkInventory.OutputThread( loc_id, " MediaFrameDefaultFontSet - start" )
		ArkInventory.MediaFrameDefaultFontSet( frame, loc_id, threadid )
		ArkInventory.OutputThread( loc_id, " MediaFrameDefaultFontSet - end" )
		
		ArkInventory.ThreadYield_Window( loc_id )
		ArkInventory.OutputThread( loc_id, " Frame_Main_Paint - start" )
		ArkInventory.Frame_Main_Paint( frame )
		ArkInventory.OutputThread( loc_id, " Frame_Main_Paint - end" )
		
	end
	
	if ArkInventory.Global.Location[loc_id].drawState <= ArkInventory.Const.Window.Draw.Refresh then
		
		-- title frame
		
		-- hide the title window if it's not needed
		local subframe1 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Title.Name )]
		local obj = subframe1
		if codex.style.title.hide then
			
			-- show mini action buttons
			for k, v in pairs( ArkInventory.Const.ButtonData ) do
				local obj = _G[string.format( "%s%s%s%s", frame:GetName( ), ArkInventory.Const.Frame.Scroll.Name, "ActionButton", k )]
				if obj then
					obj:Show( )
				end
			end
			
			obj:Hide( )
			obj:SetHeight( 1 )
			
		else
			
			-- hide mini action buttons
			for k, v in pairs( ArkInventory.Const.ButtonData ) do
				local obj = _G[string.format( "%s%s%s%s", frame:GetName( ), ArkInventory.Const.Frame.Scroll.Name, "ActionButton", k )]
				if obj then
					obj:Hide( )
				end
			end
			
			local height = codex.style.title.font.height
			ArkInventory.MediaFrameFontSet( obj, nil, height )
			
			-- window title text
			local who = _G[string.format( "%s%s%s", frame:GetName( ), ArkInventory.Const.Frame.Title.Name, "Who" )]
			local t = ""
			
			if codex.style.title.size == ArkInventory.Const.Window.Title.SizeThin then
				
				-- thin size
				t = ArkInventory.DisplayName5( codex.player.data.info )
				
				-- one line of action buttons
--				z = _G[string.format( "%s%s", obj:GetName( ), "ActionButton21" )]
--				z:ClearAllPoints( )
--				z:SetPoint( "RIGHT", _G[string.format( "%s%s", obj:GetName( ), "ActionButton14" )], "LEFT", -3, 0 )
				
				who:SetMaxLines( 1 )
				
			else
				
				-- normal size
				t = ArkInventory.DisplayName1( codex.player.data.info )
				height = height * 2
				
				-- two lines of action buttons
--				z = _G[string.format( "%s%s", obj:GetName( ), "ActionButton21" )]
--				z:ClearAllPoints( )
--				z:SetPoint( "TOP", _G[string.format( "%s%s", obj:GetName( ), "ActionButton11" )], "BOTTOM", 0, -2 )
				
				who:SetMaxLines( 2 )
				
			end
			
			-- online/offline colouring
			if ArkInventory.Global.Location[loc_id].isOffline then
				local colour = codex.style.title.colour.offline
				who:SetTextColor( colour.r, colour.g, colour.b )
				t = string.format( "%s [%s]", t, PLAYER_OFFLINE )
			else
				local colour = codex.style.title.colour.online
				who:SetTextColor( colour.r, colour.g, colour.b )
			end
			
			if height < ArkInventory.Const.Frame.Title.MinHeight then
				height = ArkInventory.Const.Frame.Title.MinHeight
			end
			
			-- set icon to match height
			local z = _G[string.format( "%s%s", obj:GetName( ), "ActionButton0" )]
			z:SetWidth( height )
			z:SetHeight( height )
			
			who:SetHeight( height )
			who:SetText( t )
			
			height = height + ArkInventory.Const.Frame.Title.Height
			obj:SetHeight( height )
			obj:SetScale( codex.style.title.scale or 1 )
			
			obj:Show( )
			
			ArkInventory.ThreadYield_Window( loc_id )
			
		end
		
		ArkInventory.ThreadYield_Window( loc_id )
		
		-- hide the search window if it's not needed
		local subframe2 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Search.Name )]
		local obj = subframe2
		if codex.style.search.hide then
			
			obj:Hide( )
			obj:SetHeight( 1 )
			
			obj:SetPoint( "TOPLEFT", subframe1, "BOTTOMLEFT", 0, 1 )
			
			obj.filterText:SetText( "" )
			
		else
			
			local height = codex.style.search.font.height
			ArkInventory.MediaFrameFontSet( obj, nil, height )
			
			local obj2 = _G[string.format( "%s%s", obj:GetName( ), "FilterLabel" )]
			local colour = codex.style.search.label.colour
			obj2:SetTextColor( colour.r, colour.g, colour.b )
			local width = obj2:GetStringWidth( )
			
			local colour = codex.style.search.text.colour
			obj.filterText:SetTextColor( colour.r, colour.g, colour.b )
			obj.filterText:SetPoint( "LEFT", obj, "LEFT", width + 20, 0 )
			
			if height < ArkInventory.Const.Frame.Search.MinHeight then
				height = ArkInventory.Const.Frame.Search.MinHeight
			end
			
			obj:SetHeight( height + ArkInventory.Const.Frame.Search.Height )
			obj:SetScale( codex.style.search.scale or 1 )
			obj:Show( )
			
			obj:SetPoint( "TOPLEFT", subframe1, "BOTTOMLEFT" )
			
		end
		
		ArkInventory.ThreadYield_Window( loc_id )
		
		-- hide the changer frame if it can't be used
		local subframe5 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Status.Name )]
		local subframe4 = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Changer.Name )]
		local obj = subframe4
		
		if loc_id ~= ArkInventory.Const.Location.Vault and ( codex.style.changer.hide or not ArkInventory.Global.Location[loc_id].hasChanger ) then
			
			obj:SetHeight( 1 )
			obj:Hide( )
			obj:SetPoint( "BOTTOMLEFT", subframe5, "TOPLEFT", 0, -1 )
			
		else
			
			obj:SetHeight( ArkInventory.Const.Frame.Changer.Height )
			obj:SetScale( codex.style.changer.scale or 1 )
			obj:Show( )
			obj:SetPoint( "BOTTOMLEFT", subframe5, "TOPLEFT" )
			
			ArkInventory.Frame_Changer_Update( loc_id )
			
			ArkInventory.ThreadYield_Window( loc_id )
			
		end
		
		ArkInventory.Frame_Status_Update( frame )
		
		ArkInventory.Frame_Main_Resize( frame )
		
		ArkInventory.ThreadYield_Window( loc_id )
		
	end
	
	
	if not codex.workpad.ready then
		--ArkInventory.Output( "codex.workpad is not ready - redraw" )
		--ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
		if ( ArkInventory.Global.Location[loc_id].retryCount or 0 ) <= ArkInventory.db.option.ui.main.retry then
			--ArkInventory.Output( "redraw ", loc_id, " attempt ", ArkInventory.Global.Location[loc_id].retryCount )
			ArkInventory:SendMessage( "EVENT_ARKINV_LOCATION_DRAW_BUCKET", loc_id )
		end
		ArkInventory.Global.Location[loc_id].retryCount = ( ArkInventory.Global.Location[loc_id].retryCount or 0 ) + 1
	else
		ArkInventory.Global.Location[loc_id].drawState = ArkInventory.Const.Window.Draw.None
	end
	
end

function ArkInventory.FrameLevelReset( frame, level )
	
	if not ArkInventory.db.option.bugfix.framelevel.enable then return end
	
	if type( frame ) == "string" then
		frame = _G[frame]
	end
	
	if frame == nil then
		return
	end
	
	if frame:GetFrameLevel( ) ~= level then
		frame:SetFrameLevel( level )
	end
	
	for _, z in pairs( { frame:GetChildren( ) } ) do
		ArkInventory.FrameLevelReset( z, level + 1 )
	end
	
end

local function FrameLevelGetMaxRecurse( frame, level )
	
	if frame:GetFrameLevel( ) > level then
		level = frame:GetFrameLevel( )
	end
	
	for _, z in pairs( { frame:GetChildren( ) } ) do
		level = FrameLevelGetMaxRecurse( z, level )
	end
	
	return level
	
end

function ArkInventory.FrameLevelGetMax( frame )
	
	local level = frame:GetFrameLevel( )
	
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			
			local f2 = ArkInventory.Frame_Main_Get( loc_id )
			
			if f2 and f2:IsVisible( ) and frame ~= f2 then
				level = FrameLevelGetMaxRecurse( f2, level )
			end
			
		end
	end
	
	return level
	
end

function ArkInventory.Frame_Main_Level( frame )
	
	ArkInventory.FrameLevelReset( frame, 1 )
	
	--[[
	local level = ArkInventory.FrameLevelGetMax( frame )
	--ArkInventory.Output( frame:GetName( ), " before: ", frame:GetFrameLevel( ), ":", level )
	
	if frame:GetFrameLevel( ) < level then
		ArkInventory.FrameLevelReset( frame, level + 10 )
		
		--level = ArkInventory.FrameLevelGetMax( frame )
		--ArkInventory.Output( frame:GetName( ), " after: ", frame:GetFrameLevel( ), ":", level )
	end
	]]--
end

function ArkInventory.Frame_Main_Toggle( loc_id )
	
	ArkInventory.Util.Assert( loc_id, "loc_id is nil" )
	
	if not ArkInventory.ClientCheck( ArkInventory.Global.Location[loc_id].ClientCheck ) then
		ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_LOCATION_NOT_SUPPORTED"], ArkInventory.Global.Location[loc_id].Name ) )
		return
	end
	
	local frame = ArkInventory.Frame_Main_Get( loc_id )
	
	if frame then
		if frame:IsVisible( ) then
			ArkInventory.Frame_Main_Hide( loc_id )
		else
			--ArkInventory.Output( "Frame_Main_Toggle( ", loc_id, " )" )
			ArkInventory.Frame_Main_Show( loc_id )
		end
	end
	
end


function ArkInventory.Frame_Main_Show( loc_id, player_id )
	
	--ArkInventory.Output( "Frame_Main_Show( ", loc_id, ", ", player_id, " )" )
	
	ArkInventory.Util.Assert( loc_id, "loc_id is nil" )
	
	ArkInventory.Global.Location[loc_id].retryCount = 0
	
	if not ArkInventory.ClientCheck( ArkInventory.Global.Location[loc_id].ClientCheck ) then
		ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_LOCATION_NOT_SUPPORTED"], ArkInventory.Global.Location[loc_id].Name ) )
		return
	end
	
	local frame = ArkInventory.Frame_Main_Get( loc_id )
	
	if loc_id == ArkInventory.Const.Location.Bank or loc_id == ArkInventory.Const.Location.Vault then
		if frame:IsVisible( ) then
			-- covers shifting from offline to online
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
		end
	end
	
	--ArkInventory.Output( "show: ", loc_id, ", ", player_id )
	local codex = ArkInventory.Codex.SetWindow( loc_id, player_id )
	--ArkInventory.Output( "player=", codex.player.data.info.player_id )
	--ArkInventory.Output( "layout=", codex.layout_id, ", style=", codex.style_id, ", catset=", codex.catset_id )
	
	if codex.style.sort.when == ArkInventory.ENUM.SORTWHEN.ONOPEN or codex.style.sort.when == ArkInventory.ENUM.SORTWHEN.ALWAYS then
		--ArkInventory.OutputWarning( "Frame_Main_Show - .Recalculate" )
		ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	end
	
	-- on open refresh so that cooldowns are updated if enabled
	if codex.style.slot.cooldown.onopen then
		ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
	end
	
	if loc_id == ArkInventory.Const.Location.Bank then
		
		ArkInventory.Util.setBankPanelLayout( )
		
	end
	
	frame:Show( )
	
--	ArkInventory.Global.Location[loc_id].show = true
	
	ArkInventory.Frame_Main_Generate( loc_id )
	
	if loc_id == ArkInventory.Const.Location.Bank then
		ArkInventory.Frame_Main_Offline( frame )
		ArkInventory.Util.syncBlizzardBankUI( )
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
	end
	
end

function ArkInventory.Frame_Main_OnShow( frame )
	
--	ArkInventory.Output( "Frame_Main_OnShow" )
	
	--ArkInventory.Lib.Dewdrop:Close( )
	
	local loc_id = frame.ARK_Data.loc_id
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	if ArkInventory.Global.Location[loc_id].drawState <= ArkInventory.Const.Window.Draw.Init then
		ArkInventory.Frame_Main_Resize( frame )
	end
	
	-- frame strata
	if frame:GetFrameStrata( ) ~= codex.style.window.strata then
		frame:SetFrameStrata( codex.style.window.strata )
	end
	
	ArkInventory.Frame_Main_Level( frame )
	
	if ArkInventory.db.option.auto.reposition then
		ArkInventory.Frame_Main_Reposition( loc_id )
	end

	if loc_id == ArkInventory.Const.Location.Bag then
		PlaySound( SOUNDKIT.IG_BACKPACK_OPEN )
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
	elseif loc_id == ArkInventory.Const.Location.Keyring then
		PlaySound( SOUNDKIT.KEY_RING_OPEN )
	elseif loc_id == ArkInventory.Const.Location.Bank then
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_OPEN )
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
	elseif loc_id == ArkInventory.Const.Location.Vault then
		PlaySound( SOUNDKIT.GUILD_VAULT_OPEN )
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
	elseif loc_id == ArkInventory.Const.Location.Wearing then
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_OPEN )
	elseif loc_id == ArkInventory.Const.Location.Auction then
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_OPEN )
	elseif loc_id == ArkInventory.Const.Location.Void then
		PlaySound( SOUNDKIT.UI_ETHEREAL_WINDOW_OPEN )
	elseif loc_id == ArkInventory.Const.Location.Currency then
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_OPEN )
	elseif loc_id == ArkInventory.Const.Location.Reputation then
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_OPEN )
	else
		PlaySound( SOUNDKIT.IG_SPELLBOOK_OPEN )
	end
	
end

function ArkInventory.Frame_Main_SearchFilterUpdate( frame )
	
	local loc_id_window = frame.ARK_Data.loc_id
	
	local filter = _G[string.format( "%s%s", frame:GetName( ), "SearchFilter" )]
	if not filter then
		ArkInventory.OutputError( "code failure: searchfilter object not found" )
		return
	end
	
	filter = filter:GetText( )
	local cf = ArkInventory.Global.Location[loc_id_window].filter or ""
	
	if cf ~= filter then
		--ArkInventory.Output( "search [", loc_id_window, "] [", cf, "] [", filter, "]" )
		ArkInventory.Global.Location[loc_id_window].filter = filter
		ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Refresh )
		--ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
	end
	
end

function ArkInventory.Frame_Main_Hide( loc_id )
	
	for loc_id_window, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			if not loc_id or loc_id == loc_id_window then
				local frame = ArkInventory.Frame_Main_Get( loc_id_window )
				frame:Hide( )
			end
		end
	end
	
end

function ArkInventory.Frame_Main_OnHide( frame )
	
	ArkInventory.Lib.Dewdrop:Close( )
	
	local loc_id = frame.ARK_Data.loc_id
	
	if loc_id == ArkInventory.Const.Location.Bag then
		
		PlaySound( SOUNDKIT.IG_BACKPACK_CLOSE )
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
		ArkInventory.Frame_Main_ClearNewItemGlow( loc_id )
		
	elseif loc_id == ArkInventory.Const.Location.Keyring then
		
		PlaySound( SOUNDKIT.KEY_RING_CLOSE )
		
	elseif loc_id == ArkInventory.Const.Location.Bank then
		
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_CLOSE )
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
		
		if ArkInventory.Global.Mode.Bank and ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then
			
			-- close blizzards bank frame if we're hiding blizzard frames, we're at the bank, and the bank window was closed
			
			StaticPopup_Hide( "CONFIRM_BUY_REAGENTBANK_TAB" )
			StaticPopup_Hide( "CONFIRM_BUY_BANK_TAB" )
			StaticPopup_Hide( "BANK_MONEY_WITHDRAW" )
			StaticPopup_Hide( "BANK_MONEY_DEPOSIT" )
			
			ArkInventory.CrossClient.CloseBankFrame( )
			
		end
		
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
		
	elseif loc_id == ArkInventory.Const.Location.Vault then
		
		PlaySound( SOUNDKIT.GUILD_VAULT_CLOSE )
		ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
		
		if ArkInventory.Global.Mode.Vault and ArkInventory.isLocationControlled( ArkInventory.Const.Location.Vault ) then
			
			-- close blizzards vault frame if we're hiding blizzard frames, we're at the vault, and the vault window was closed
			
			GuildBankPopupFrame:Hide( )
			StaticPopup_Hide( "GUILDBANK_WITHDRAW" )
			StaticPopup_Hide( "GUILDBANK_DEPOSIT" )
			StaticPopup_Hide( "CONFIRM_BUY_GUILDBANK_TAB" )
			
			CloseGuildBankFrame( )
			
		end
		
	elseif loc_id == ArkInventory.Const.Location.Wearing then
		
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_CLOSE )
		
	elseif loc_id == ArkInventory.Const.Location.Auction then
		
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_CLOSE )
		
	elseif loc_id == ArkInventory.Const.Location.Void then
		
		PlaySound( SOUNDKIT.UI_ETHEREAL_WINDOW_CLOSE )
		
	elseif loc_id == ArkInventory.Const.Location.Currency then
		
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_CLOSE )
		
	elseif loc_id == ArkInventory.Const.Location.Reputation then
		
		PlaySound( SOUNDKIT.IG_CHARACTER_INFO_CLOSE )
		
	else
		
		PlaySound( SOUNDKIT.IG_SPELLBOOK_CLOSE )
		
	end
	
	if ArkInventory.Global.Mode.Edit then
		-- if the edit mode is active then disable edit mode and flag for rebuild when next opened
		ArkInventory.Global.Mode.Edit = false
		--ArkInventory.OutputWarning( "Frame_Main_OnHide - .Recalculate" )
		ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
	end
	
	ArkInventory.FrameLevelReset( frame, 1 )
	
end

function ArkInventory.Frame_Main_OnLoad( frame )
	
	ArkInventory.Util.Assert( frame, "frame is nil" )
	
	local framename = frame:GetName( )
	local loc_id = string.match( framename, "^.-(%d+)" )
	
	ArkInventory.Util.Assert( loc_id, "xml element [", framename, "] is not an ", framename, ArkInventory.Const.Program.Name, " frame" )
	
	loc_id = tonumber( loc_id )
	
	frame.ARK_Data = {
		loc_id = loc_id,
	}
	
	if not ArkInventory.Global.Location[loc_id].isMapped then
		--ArkInventory.Output( "aborting Frame_Main_OnLoad for ", ArkInventory.Global.Location[loc_id].Name )
		return
	end
	
	ArkInventory.Frame_AddBorder( frame )
	
	frame:SetDontSavePosition( true )
	frame:SetUserPlaced( false )
	
	local tex
	
	-- setup title frame action buttons
	for k, v in pairs( ArkInventory.Const.ButtonData ) do
		
		local obj = _G[string.format( "%s%s%s%s", frame:GetName( ), ArkInventory.Const.Frame.Title.Name, "ActionButton", k )]
		
		if obj then
			
			tex = obj:GetNormalTexture( )
			ArkInventory.SetTexture( tex, v.Texture or ArkInventory.Global.Location[loc_id].Texture )
			tex:SetTexCoord( 0.075, 0.925, 0.075, 0.925 )
			
			tex = obj:GetPushedTexture( )
			ArkInventory.SetTexture( tex, v.Texture or ArkInventory.Global.Location[loc_id].Texture )
			tex:SetTexCoord( 0.075, 0.925, 0.075, 0.925 )
			
			tex = obj:GetHighlightTexture( )
			ArkInventory.SetTexture( tex, v.Texture or ArkInventory.Global.Location[loc_id].Texture )
			tex:SetTexCoord( 0.075, 0.925, 0.075, 0.925 )
			
			for s, f in pairs( v.Scripts ) do
				obj:SetScript( s, f )
			end
			
		end
		
	end
	
	-- setup main frame mini action buttons
	for k, v in pairs( ArkInventory.Const.ButtonData ) do
		
		local obj = _G[string.format( "%s%s%s%s", frame:GetName( ), ArkInventory.Const.Frame.Scroll.Name, "ActionButton", k )]
		
		if obj then
			
			tex = obj:GetNormalTexture( )
			ArkInventory.SetTexture( tex, v.Texture or ArkInventory.Global.Location[loc_id].Texture )
			tex:SetTexCoord( 0.075, 0.925, 0.075, 0.925 )
			
			tex = obj:GetPushedTexture( )
			ArkInventory.SetTexture( tex, v.Texture or ArkInventory.Global.Location[loc_id].Texture )
			tex:SetTexCoord( 0.075, 0.925, 0.075, 0.925 )
			
			tex = obj:GetHighlightTexture( )
			ArkInventory.SetTexture( tex, v.Texture or ArkInventory.Global.Location[loc_id].Texture )
			tex:SetTexCoord( 0.075, 0.925, 0.075, 0.925 )
			
			for s, f in pairs( v.Scripts ) do
				obj:SetScript( s, f )
			end
			
		end
		
	end
	
end

function ArkInventory.Frame_Main_OnMouseUp( frame )
	
	ArkInventory.Frame_Main_Level( frame )
	
	ArkInventory.Lib.Dewdrop:Close( )
	--ArkInventory.OutputDebug( "mouse up" )
	
end

function ArkInventory.Frame_Main_OnDragStart( frame )
	
	--ArkInventory.Output( "START: ", frame:GetName( ), " / level = ", frame:GetFrameLevel( ), " / strata = ", frame:GetFrameStrata( ) )
	
	frame.ARK_Data.Level = frame:GetFrameLevel( )
	
	frame:StartMoving( )
	
end

function ArkInventory.Frame_Main_OnDragStop( frame )
	
	frame:StopMovingOrSizing( )
	
	--ArkInventory.Output( "STOP: ", frame:GetName( ), " / level = ", frame:GetFrameLevel( ), " / strata = ", frame:GetFrameStrata( ) )
	
	ArkInventory.Frame_Main_Anchor_Save( frame )
	
	frame:SetUserPlaced( false )
	
	ArkInventory.Frame_Main_Level( frame )
	
end

function ArkInventory.Frame_Main_OnReceiveDrag( frame )
	
	ArkInventory.EditModeOnDragSet( )
	ArkInventory.SetCursor( )
	
end

function ArkInventory.ClearNewItemGlow( loc_id_window )
	
	if ArkInventory.db.option.newitemglow.enable and loc_id_window == ArkInventory.Const.Location.Bag and not ArkInventory.Global.Location[loc_id_window].isOffline then
		
		for bag_id_window, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
			
			local blizzard_id = map.blizzard_id
			
			for slot_id = 1, ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] or 0 do
				
				if ArkInventory.CrossClient.IsNewItem( blizzard_id, slot_id ) then
					
					C_NewItems.RemoveNewItem( blizzard_id, slot_id )
					
					local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id )
					if obj.ARK_Data.isCompressed then
						objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
					end
					
					ArkInventory.Frame_Item_Update_New( obj, nil, true )
					
				end
				
			end
			
		end
		
	end
	
end

function ArkInventory.Frame_Main_ClearNewItemGlow( loc_id )
	if ArkInventory.db.option.newitemglow.clearonclose then
		ArkInventory.ClearNewItemGlow( loc_id )
	end
end


function ArkInventory.Frame_Container_Calculate( frame )
	
	local tz = debugprofilestop( )
	ArkInventory.OutputThread( "Frame_Container_Calculate: ", frame:GetName( ) )
	
	local loc_id = frame.ARK_Data.loc_id
	
	--local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	--ArkInventory.Table.Clean( codex.workpad, nil, true )
	
	-- break the inventory up into it's respective bars
	ArkInventory.Frame_Container_CalculateBars( frame )
	
	-- calculate what the container should look like with those bars
	ArkInventory.Frame_Container_CalculateContainer( frame )
	
	tz = debugprofilestop( ) - tz
	ArkInventory.OutputThread( "Frame_Container_Calculate: ", frame:GetName( ), " ", string.format("%0.0fms", tz ) )
	
end

function ArkInventory.Frame_Container_CalculateBars( frame )
	
	-- loads the inventory into their respective bars
	
	local loc_id_window = frame.ARK_Data.loc_id
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local player_id = codex.player.data.info.player_id
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	local firstempty = codex.style.slot.empty.first or 0
--	ArkInventory.Output( "show ", firstempty, " empty slots" )
	local firstemptyshown = { }
	
	local tz = debugprofilestop( )
	ArkInventory.OutputDebug( "CalculateBars( ", frame:GetName( ), " ) for [", player_id, "] start" )
	
	ArkInventory.Table.Clean( codex.workpad, nil, true )
	
	codex.workpad.bar = { }
	--codex.workpad.bar = codex.workpad.bar or { }
	--ArkInventory.Table.Wipe( codex.workpad.bar )
	codex.workpad.bar_count = 1
	
	codex.workpad.stack_limit = { }
	--codex.workpad.stack_limit = codex.workpad.stack_limit or { }
	--ArkInventory.Table.Wipe( codex.workpad.stack_limit )
	
	codex.workpad.compress = { }
	--codex.workpad.compress = codex.workpad.compress or { }
	--ArkInventory.Table.Wipe( codex.workpad.compress )
	
	codex.workpad.ready = true
	
	
	
	local bag
	local cat_id
	local bar_id, bar_def
	local ignore = false
	local hidden = false
	local show_all = false
	local stack_id = nil
	
	if ArkInventory.Global.Mode.Edit or ArkInventory.Global.Options.ShowHiddenItems or codex.style.window.list then
		-- show everything if in edit mode or the user wants us to ignore the hidden flag
		show_all = true
	end
	
	local checkNew = codex.style.slot.override.new.enable
	local checkNewCutoff = ArkInventory.TimeAsMinutes( ) - codex.style.slot.override.new.cutoff
	local checkNewReset = ArkInventory.Global.NewItemResetTime or checkNewCutoff
	
	local checkPartyLoot = codex.style.slot.override.partyloot.enable
	
	local checkRefundable = codex.style.slot.override.refundable.enable
	
	
	
	local active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
	
	if loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.AccountBank and active_map.loc_id_storage ~= ArkInventory.Const.Location.AccountBank and not ArkInventory.Global.Location[loc_id_window].isOffline then
		-- account banker access - make sure bank is set to an account bank tab, reset to tab 1 if its not.  ignore if offline
		ArkInventory.Util.setWindowActiveMap( loc_id_window, ArkInventory.Util.MapGetStorage( ArkInventory.Const.Location.AccountBank, 1 ) )
		active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
	end
	
	
	-- the basics, just stick the items into their appropriate bars (cpu intensive)
	for loc_id_storage in pairs( ArkInventory.Util.MapGetChildren( loc_id_window ) ) do
		
		local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
		
		for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
			
			local bag_id_window = map.bag_id_window
			
			--ArkInventory.Output( "window [", loc_id_window, "].[", bag_id_window, "]" )
			--ArkInventory.Output( "storage [", loc_id_storage, "].[", bag_id_storage, "]" )
			
			bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
			
			ignore = false
			
			
			-- panel or bag/tab isolation
			-- note doing this here instead of at the slot level means items from other panels wont show up in edit mode so it acts more like its own window
			if ( not ignore ) and ( map.panel_id ~= active_map.panel_id ) then
				ignore = true
			end
			
			if ( not ignore ) and ( map.hidden ) then
				ignore = true
			end
			
			if ( not ignore ) and ( loc_id_window == ArkInventory.Const.Location.Vault ) then
				if not ArkInventory.Global.Location[loc_id_window].isOffline then
					local canView = select( 3, GetGuildBankTabInfo( bag_id_storage ) )
					if not canView then
						ignore = true
					end
				end
			end
			
--	if loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.AccountBank and active_map.loc_id_storage ~= ArkInventory.Const.Location.AccountBank and not ArkInventory.Global.Location[loc_id_window].isOffline then
--		-- warbank distance inhibitor active, ignore clicks for any bank/reagent bank tabs
--		ArkInventory.Output( "slot is not available through account banker" )
--		return
--	end
			
			
			if not ignore then
				
				for slot_id = 1, bag.count do
					
					hidden = false
					
					if not codex.player.data.option[loc_id_window].bag[bag_id_window].display then
						hidden = true
					end
					
					local i = bag.slot[slot_id]
					
					
					stack_id = nil
					
					if i then
						
						if codex.style.window.list then
							
							cat_id = ArkInventory.CategoryGetSystemID( "SYSTEM_DEFAULT" )
							
						else
							
							local info = ArkInventory.GetObjectInfo( i.h, i )
							codex.workpad.ready = codex.workpad.ready and info.ready
							
							local isPartyLoot = false
							local isRefundable = false
							
							if i.h and loc_id_window == ArkInventory.Const.Location.Bag and not ArkInventory.Global.Location[loc_id_window].isOffline then
								
								if checkPartyLoot then
									local tooltipInfo = ArkInventory.TooltipSetFromStorageItem( ArkInventory.Global.Tooltip.Scan, loc_id_storage, bag_id_storage, slot_id, i.h, i )
									if ArkInventory.TooltipContains( ArkInventory.Global.Tooltip.Scan, nil, ArkInventory.Localise["WOW_TOOLTIP_BIND_PARTYLOOT"], false, true, true, 0 ) then
										isPartyLoot = true
										--ArkInventory.OutputDebug( "party loot = ", i.h )
									end
								end
								
								if checkRefundable and not isPartyLoot then
									local tooltipInfo = ArkInventory.TooltipSetFromStorageItem( ArkInventory.Global.Tooltip.Scan, loc_id_storage, bag_id_storage, slot_id, i.h, i )
									if ArkInventory.TooltipContains( ArkInventory.Global.Tooltip.Scan, nil, ArkInventory.Localise["WOW_TOOLTIP_BIND_REFUNDABLE"], false, true, true, 0 ) then
										isRefundable = true
										--ArkInventory.OutputDebug( "refundable = ", i.h )
									end
								end
								
							end
							
							if isPartyLoot then
								cat_id = ArkInventory.CategoryGetSystemID( "SYSTEM_ITEM_BINDING_PARTYLOOT" )
							elseif isRefundable then
								cat_id = ArkInventory.CategoryGetSystemID( "SYSTEM_ITEM_BINDING_REFUNDABLE" )
							elseif i.h and checkNew and i.age and i.age > checkNewReset and i.age > checkNewCutoff then
								cat_id = ArkInventory.CategoryGetSystemID( "SYSTEM_NEW" )
							else
								cat_id = ArkInventory.ItemCategoryGet( i )
							end
							
						end
						
						bar_id, bar_def = ArkInventory.CategoryLocationGet( loc_id_window, cat_id )
						if bar_def then
							bar_id = codex.layout.bag[bag_id_window].bar or bar_id
						end
						--ArkInventory.Output( "loc=[", loc_id, "], bag=[", bag_id, "], slot=[", slot_id, "], cat=[", cat_id, "], bar_id=[", bar_id, "]" )
						
						if not show_all and bar_id > 0 then
							
							-- no point doing this if show all is enabled
							
							if hidden then
								
								-- if a bag is hidden then we dont want to process any of its items, just hide them via a negative bar number
								
								bar_id = 0 - bar_id
								
							elseif codex.style.slot.stack.mode == ArkInventory.Const.Slot.Stack.Mode.Limit then
								
								-- stack limit
								
								if i.h then
									
									if codex.style.slot.stack.limit.enable > 0 then
										
										local info = ArkInventory.GetObjectInfo( i.h, i )
										
										if info.stacksize > 1 then
											
											-- check if the number of stacks displayed so far is less than the limit, if its not then hide it
											
											stack_id = ArkInventory.ObjectIDStack( bar_id, i )
											
											if not codex.workpad.stack_limit[stack_id] then
												codex.workpad.stack_limit[stack_id] = { ["count"] = 0, ["total"] = 0 }
											end
											
											codex.workpad.stack_limit[stack_id].count = codex.workpad.stack_limit[stack_id].count + 1
											--codex.workpad.stack_limit[stack_id].total = codex.workpad.stack_limit[stack_id].total + i.count
											
											if codex.workpad.stack_limit[stack_id].count > codex.style.slot.stack.limit.enable then
												-- over stack limit so hide this stack
												bar_id = 0 - bar_id
											end
											
										end
										
									end
									
								else
									
									if firstempty > 0 then
										
										if not firstemptyshown[bag.type] then
											firstemptyshown[bag.type] = 0
										end
										
										if firstemptyshown[bag.type] < firstempty then
											firstemptyshown[bag.type] = firstemptyshown[bag.type] + 1
										else
											bar_id = 0 - bar_id
										end
										
									end
									
								end
								
							elseif codex.style.slot.stack.mode == ArkInventory.Const.Slot.Stack.Mode.Compress then
								
								-- stack compression
								
								if codex.style.slot.stack.compress.enable then
									
									if ArkInventory.Global.Location[loc_id_window].canCompress then
										
										local ok = true
										local info = ArkInventory.GetObjectInfo( i.h, i )
										
										if info.osd.class == "empty" then
											if not codex.style.slot.stack.compress.include.empty then
												ok = false
											end
										else
											if info.stacksize == 1 then
												if not codex.style.slot.stack.compress.include.single then
													ok = false
												end
											else
												if not codex.style.slot.stack.compress.include.stack then
													ok = false
												end
											end
										end
										
										stack_id = ArkInventory.ObjectIDStack( bar_id, i )
										
										if not codex.workpad.compress[stack_id] then
											codex.workpad.compress[stack_id] = { ["count"] = 0, ["total"] = 0, ["bar_id"] = 0, ["index"] = nil, ["item"] = { }, ["width"] = 0, ["height"] = 0, ["isGhost"] = false }
										end
										
										codex.workpad.compress[stack_id].count = codex.workpad.compress[stack_id].count + 1 -- stack count
										codex.workpad.compress[stack_id].width = codex.workpad.compress[stack_id].width + 1
										
										codex.workpad.compress[stack_id].total = codex.workpad.compress[stack_id].total + i.count -- total item count
										
										-- this table gets cleaned so do not directly map other tables into itnto it
										table.insert( codex.workpad.compress[stack_id].item, { ["loc_id_window"] = loc_id_window, ["bag_id_window"] = bag_id_window, ["loc_id_storage"] = loc_id_storage, ["bag_id_storage"] = bag_id_storage, ["slot_id"] = slot_id } )
										
										local count = codex.workpad.compress[stack_id].count
										if ok and count > 1 then
											
											if count == 2 then
												
												local index = codex.workpad.compress[stack_id].index
												ArkInventory.Util.Assert( index, "index of first stacked item is missing" )
												
												codex.workpad.bar[bar_id].item[index].isCompressed = true
												codex.workpad.bar[bar_id].item[index].stack_id = stack_id
												
												--ArkInventory.Output( "compressed [", bar_id, "] [", bag_id, "] [", slot_id, "] / [", stack_id, "] [", codex.workpad.compress[stack_id].count, "]" )
												
											end
											
											-- hide this stack
											bar_id = 0 - bar_id
											
										end
										
									end
									
								end
								
							end
							
						end
						
						
						
						if bar_id < 0 then
							-- hidden items/categories (reside on negative bar numbers) do not get shown
							hidden = true
						end
						
						if show_all or not hidden then
							
							bar_id = abs( bar_id )
							
							-- create the bar
							if not codex.workpad.bar[bar_id] then
								codex.workpad.bar[bar_id] = { ["bar_id"] = bar_id, ["item"] = { }, ["count"] = 0, ["width"] = 0, ["height"] = 0, ["isGhost"] = false }
							end
							
							-- add the item to the bar
							-- this table gets cleaned so do not directly map other tables into it
							table.insert( codex.workpad.bar[bar_id].item, { ["loc_id_window"] = loc_id_window, ["bag_id_window"] = bag_id_window, ["loc_id_storage"] = loc_id_storage, ["bag_id_storage"] = bag_id_storage, ["slot_id"] = slot_id, ["isCompressed"] = false } )
							
							if codex.style.slot.stack.mode == ArkInventory.Const.Slot.Stack.Mode.Compress and stack_id and not codex.workpad.compress[stack_id].index then
								codex.workpad.compress[stack_id].bar_id = bar_id
								codex.workpad.compress[stack_id].index = #codex.workpad.bar[bar_id].item 
							end
							
							-- increment the bars item count
							codex.workpad.bar[bar_id].count = codex.workpad.bar[bar_id].count + 1
							
							-- keep track of the last bar used
							if bar_id > codex.workpad.bar_count then
								codex.workpad.bar_count = bar_id
							end
							
							--ArkInventory.Output( "bag[", bag_id, "], slot[", slot_id, "], cat[", cat_id, "], bar[", bar_id, "], id=[", codex.workpad.bar[bar_id].id, "]" )
							
						end
						
					end
					
					ArkInventory.ThreadYield_Window( loc_id_window )
					
				end
				
				--ArkInventory.Output( "bag = ", bag_id, ", count = ", bag.count, " / ", ArkInventory.Table.Elements( bag.slot ) )
				
			end
			
		end
		
	end
	
	-- get highest used bar
	local cats = codex.layout.category
	for _, bar_id in pairs( cats ) do
		if bar_id > codex.workpad.bar_count then
			codex.workpad.bar_count = bar_id
		end
	end
	
	-- round up to a full number of bars per row
	local bpr = codex.style.window.list and 1 or codex.style.bar.per or 1
	codex.workpad.bar_count = math.ceil( codex.workpad.bar_count / bpr ) * bpr
	
	if ArkInventory.Global.Mode.Edit then
		-- and add an entire extra row for easy bar/category movement when in edit mode
		codex.workpad.bar_count = codex.workpad.bar_count + bpr
	end
	
	-- update the maximum number of bar frames used so far
	if codex.workpad.bar_count > ArkInventory.Global.Location[loc_id_window].maxBar then
		ArkInventory.Global.Location[loc_id_window].maxBar = codex.workpad.bar_count
	end
	
	-- if we're in edit mode then create all missing bars and add a ghost item to every bar
	-- ghost items allow for the bar menu icon
	if ArkInventory.Global.Mode.Edit or codex.style.bar.showempty then
		
		--ArkInventory.Output( "edit mode - adding ghost bars" )
		for bar_id = 1, codex.workpad.bar_count do
			
			if not codex.workpad.bar[bar_id] then
				
				-- create a ghost bar
				codex.workpad.bar[bar_id] = { ["id"] = bar_id, ["item"] = { }, ["count"] = 1, ["width"] = 0, ["height"] = 0, ["isGhost"] = true, ["frame"] = 0 }
				
			else
				
				-- add a ghost item to the bar by incrementing the bars item count
				codex.workpad.bar[bar_id].count = codex.workpad.bar[bar_id].count + 1
				
			end
			
		end
		
	end
	
	tz = debugprofilestop( ) - tz
	ArkInventory.OutputDebug( "CalculateBars( ", frame:GetName( ), " ) end: ", string.format( "%0.0fms", tz ) )
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
end

function ArkInventory.Frame_Container_CalculateContainer( frame )
	
	-- calculate what the bars look like in the conatiner
	
	local tz = debugprofilestop( )
	ArkInventory.OutputDebug( "CalculateContainer( ", frame:GetName( ), " ) start" )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	codex.workpad.container = { row = { } }
	
	local bpr = codex.style.window.list and 1 or codex.style.bar.per or 1
	local rownum = 0
	local bf = 1 -- bar frame, allocated to each bar as it's calculated (uses less frames this way)
	
	--ArkInventory.Output( "container ", loc_id_window, " has ", codex.workpad.bar_count, " bars" )
	--ArkInventory.Output( "container ", loc_id_window, " set for ", bpr, " bars per row" )
	
	
	if ArkInventory.Global.Mode.Edit == false and codex.style.bar.compact then
		
		--ArkInventory.Output( "compact bars enabled" )
		
		local bc = 0  -- number of bars currently in this row
		local vr = { }  -- virtual row - holds a list of bars for this row
		
		for j = 1, codex.workpad.bar_count do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			--ArkInventory.Output( "bar [", j, "]" )
			
			if codex.workpad.bar[j] then
				if codex.workpad.bar[j].count > 0 then
					--ArkInventory.Output( "assignment: bar [", j, "] to frame [", bf, "]" )
					codex.workpad.bar[j].frame = bf
					bf = bf + 1
					bc = bc + 1
					vr[bc] = j
				else
					--ArkInventory.Output( "bar [", j, "] has no items" )
				end
			else
				--ArkInventory.Output( "bar [", j, "] has no items (does not exist)" )
			end
			
			if bc > 0 and ( bc == bpr or j == codex.workpad.bar_count ) then
				
				rownum = rownum + 1
				if not codex.workpad.container.row[rownum] then
					codex.workpad.container.row[rownum] = { }
				end
				
				--ArkInventory.Output( "row [", rownum, "] allocated [", bc, "] bars" )
				
				codex.workpad.container.row[rownum].bar = vr
				
				--ArkInventory.Output( "row [", rownum, "] created" )
				
				bc = 0
				vr = { }
				
			end
			
		end
		
	else
		
		for j = 1, codex.workpad.bar_count, bpr do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			local bc = 0  -- number of bars currently in this row
			local vr = { }  -- virtual row - holds a list of bars for this row
			
			for b = 1, bpr do
				if codex.workpad.bar[j + b - 1] then
					if codex.workpad.bar[j + b - 1].count > 0 then
						--ArkInventory.Output( "assignment: bar [", j + b - 1, "] to frame [", bf, "]" )
						codex.workpad.bar[j + b - 1]["frame"] = bf
						bf = bf + 1
						bc = bc + 1
						vr[bc] = j + b -1
					else
						--ArkInventory.Output( "bar [", j + b - 1, "] has no items" )
					end
				else
					--ArkInventory.Output( "bar [", j + b - 1, "] has no items (does not exist)" )
				end
			end
			
			if bc > 0 then
				
				rownum = rownum + 1
				if not codex.workpad.container.row[rownum] then
					codex.workpad.container.row[rownum] = { }
				end
				
				--ArkInventory.Output( "row [", rownum, "] allocated [", bc, "] bars" )
				
				codex.workpad.container.row[rownum].bar = vr
				
			end
			
		end
		
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	-- fit the bars into the row
	
	local rmw = codex.style.window.width -- row max width
	local rcw = 0 -- row current width
	local rch = 1 -- row current height
	local rmh = 0 -- row max height
	local igb = ArkInventory.Global.Mode.Edit and not codex.style.bar.showempty -- ignore ghost bars for row width purposes (makes the window get wider in edit mode)
	local rmb = 0 -- row max (height) bar - bar id of tallest bar
	local mwb = 0 -- number of minimum width bars in the row
	
	local bar = codex.workpad.bar
	
	--ArkInventory.Output( "bars per row=[", bpr, "], max columns=[", rmw, "], columns per bar=[", math.floor( rmw / bpr ), "]" )
	
	for rownum, row in ipairs( codex.workpad.container.row ) do
		
		rcw = 0
		mwb = 0
		
		for k, bar_id in ipairs( row.bar ) do
			
			-- initial setup for each bar
			bar[bar_id].minwidth = codex.layout.bar.data[bar_id].width.min
			if bar[bar_id].minwidth == 0 then
				bar[bar_id].minwidth = codex.style.bar.width.min
			end
			
			if bar[bar_id].minwidth == 0 then
				bar[bar_id].minwidth = nil
			end
			
			if codex.style.window.list then
				bar[bar_id].maxwidth = 1
			else
				bar[bar_id].maxwidth = codex.layout.bar.data[bar_id].width.max
				if bar[bar_id].maxwidth == 0 then
					bar[bar_id].maxwidth = codex.style.bar.width.max
				end
			end
			
			if bar[bar_id].maxwidth == 0 then
				bar[bar_id].maxwidth = nil
			end
			
			bar[bar_id].width = bar[bar_id].minwidth or 1
			bar[bar_id].height = bar[bar_id].count
			
			if bar[bar_id].minwidth then
				bar[bar_id].height = math.ceil( bar[bar_id].count / bar[bar_id].minwidth )
				mwb = mwb + 1
			end
			
			if bar[bar_id].height > rmh then
				rmh = bar[bar_id].height
			end
			
			
			rcw = rcw + ( igb and bar[bar_id].isGhost and 0 or bar[bar_id].width )
			
			--ArkInventory.Output( "row=[", rownum, "], index=[", k, "], bar=[", bar_id, "], width=[", bar[bar_id].width, "], height=[", bar[bar_id].height, "], mwb=[", mwb, "]" )
			
		end
		
		if rmh > 1 then
			
			local first = true
			if #row.bar == mwb then
				-- if all the bars in the row have min width then allow them to be adjusted
				if rcw < rmw then
					-- but only if the total width is less than the window width
					first = false
					-- otherwise it will change the width of the tallest bar before passing through which we dont want
				end
			end
			
			
			repeat
				
				ArkInventory.ThreadYield_Window( loc_id_window )
				
				rmh = 1
				rmb = 0
				
				-- find the bar with tallest height (ignore bars at max width, and bars at minwidth on the first pass)
				for _, bar_id in ipairs( row.bar ) do
					--if ( bar[bar_id].height > rmh ) and not ( bar[bar_id].maxwidth and bar[bar_id].width >= bar[bar_id].maxwidth ) and not ( first and bar[bar_id].minwidth and bar[bar_id].width >= bar[bar_id].minwidth ) then
					if ( bar[bar_id].height > rmh ) and not ( bar[bar_id].maxwidth and bar[bar_id].width >= bar[bar_id].maxwidth ) and not ( first and bar[bar_id].minwidth and bar[bar_id].width >= bar[bar_id].minwidth ) then
						rmb = bar_id
						rmh = bar[bar_id].height
					end
				end
				
				if rmb > 0 and rmh > 1 then
					
					-- increase the tallest bars width by one
					bar[rmb].width = bar[rmb].width + 1
					
					-- recalcualte it's new height
					bar[rmb].height = math.ceil( bar[rmb].count / bar[rmb].width )
					
				end
				
				-- check if all fits
				rcw = 0
				rmh = 0
				for _, bar_id in ipairs( row.bar ) do
					rcw = rcw + ( igb and bar[bar_id].isGhost and 0 or bar[bar_id].width )
					if bar[bar_id].height > rmh then
						rmh = bar[bar_id].height
					end
				end
				
				first = false
				
				-- exit if the width fits (or is over), or the max height is 1, no bar heights were changed on the second or higher pass
			until rcw >= rmw or rmh == 1 or (rmb == 0 and not first)
			
		end
		
		--ArkInventory.Output( "maximum height for row [", rownum, "] was [", rmh, "]" )
		
		for k, bar_id in ipairs( row.bar ) do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			--ArkInventory.Output( "setting max height for row [", rownum, "] bar [", bar_id, "] to [", rmh, "]" )
			
			-- set height of all bars in the row to the maximum height used (looks better)
			bar[bar_id].height = rmh
			
			if bar[bar_id].isGhost or ArkInventory.Global.Mode.Edit or codex.style.bar.showempty then
				-- remove the ghost item from the count (it was only needed to calculate properly)
				bar[bar_id].count = bar[bar_id].count - 1
			end
			
		end
		
		ArkInventory.ThreadYield_Window( loc_id_window )
		
	end
	
	tz = debugprofilestop( ) - tz
	ArkInventory.OutputDebug( "CalculateContainer( ", frame:GetName( ), " ) end: ", string.format("%0.0fms", tz ) )
	
end

function ArkInventory.Frame_Container_Draw( frame )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local player_id = codex.player.data.info.player_id
	
	local slotScale = codex.style.slot.scale or 1
	local slotSize = ( codex.style.slot.size or ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.SLOTSIZE ) * slotScale
	
	--ArkInventory.Output( "draw frame=", frame:GetName( ), ", loc=", loc_id_window, ", state=", ArkInventory.Global.Location[loc_id_window].drawState )
	
	if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Recalculate then
		
		ArkInventory.Frame_Bar_Popup_Hide( )
		
		-- calculate what the container should look like
		ArkInventory.Frame_Container_Calculate( frame )
		
		-- create (if required) the normal bar frames
		for bar_id = 1, ArkInventory.Global.Location[loc_id_window].maxBar do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			
			local barframename, barframe = ArkInventory.ContainerBarNameGet( loc_id_window, bar_id )
			if not barframe then
				barframe = CreateFrame( "Frame", barframename, frame, "ARKINV_TemplateFrameBar" )
			end
			
			barframe.ARK_Data.IsDisplayed = nil
			
		end
		
		-- create (if required) the normal bags and their item buttons
		
		for bag_id_window, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			local bagframename, bagframe = ArkInventory.ContainerBagNameGet( loc_id_window, bag_id_window )
			if not bagframe then
				local template = string.format( "%s%s", "ARKINV_TemplateFrameBag", ArkInventory.Const.ItemFrameType.Normal )
				bagframe = CreateFrame( "Frame", bagframename, frame, template )
			end
			--bagframe:SetAllPoints( frame )
			
			local blizzard_id = map.blizzard_id
			local loc_id_storage = map.loc_id_storage
			local bag_id_storage = map.bag_id_storage
			
			local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
			local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
			
			-- remember the maximum number of slots used for each bag
			ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] = ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] or 0
			
			if bag.count > ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] then
				ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] = bag.count
			end
			
			
			-- create the item frames for the normal bag
			for slot_id = 1, ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] do
				
				ArkInventory.ThreadYield_Window( loc_id_window )
				
				local itemframename, itemframe = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id )
				
				if itemframe and itemframe.ARK_Data.isTainted and not InCombatLockdown( ) then
					
					-- a tainted itemframe exists and you are no longer in combat so "delete" it.  a standard itemframe will get created further down to replace it
					
					itemframe:Hide( )
					itemframe:SetParent( nil )
					
					_G[itemframename] = nil
					
					itemframe = nil
					itemframename = nil
					
				end
				
				
				if not itemframe then
					
					local template = string.format( "%s%s", ArkInventory.Global.Location[loc_id_window].template or "ARKINV_TemplateButtonViewOnlyItem", ArkInventory.CrossClient.TemplateVersion )
					
					if InCombatLockdown( ) then
						
						-- in combat, create a tainted frame that is viable
						
						template = string.format( "%s%s", template, ArkInventory.Const.ItemFrameType.Tainted )
						itemframe = CreateFrame( ArkInventory.CrossClient.GetCreateFrameItemType( ), itemframename, bagframe, template )
						--ArkInventory.Output( "tainted ", tainteditemframename )
						
						itemframe.isTainted = true
						
					else
						
						template = string.format( "%s%s", template, ArkInventory.Const.ItemFrameType.Normal )
						itemframe = CreateFrame( ArkInventory.CrossClient.GetCreateFrameItemType( ), itemframename, bagframe, template )
						--ArkInventory.Output( "secure ", itemframename )
						
					end
					
				end
				
				if itemframe.ARK_Data.init then
					-- covers stuff we cant do in the onload because the database isnt ready there
					ArkInventory.MediaFrameDefaultFontSet( itemframe )
					itemframe:SetScale( slotScale )
					itemframe.ARK_Data.init = false
				end
				
				itemframe.ARK_Data.IsDisplayed = nil
				--itemframe.ARK_Data.bar_id = nil
				
			end
			
		end
		
		
		-- create (if required) the popup bag and its item buttons
		if ArkInventory.Global.Location[loc_id_window].canCompress then
			if codex.style.slot.stack.mode == ArkInventory.Const.Slot.Stack.Mode.Compress then
				if codex.style.slot.stack.compress.enable then
					
					local framename, frame = ArkInventory.FrameBarPopupNameGet( )
					
					for bag_id_window, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
						
						ArkInventory.ThreadYield_Window( loc_id_window )
						
						local bagframename, bagframe = ArkInventory.ContainerBagNameGet( loc_id_window, bag_id_window, ArkInventory.Const.ItemFrameType.Popup )
						if not bagframe then
							local template = string.format( "%s%s", "ARKINV_TemplateFrameBag", ArkInventory.Const.ItemFrameType.Popup )
							bagframe = CreateFrame( "Frame", bagframename, frame, template )
							--ArkInventory.Output( "created ", bagframename, " parent ", framename )
						end
						
						
						-- create the popup item frames for the bag
						for slot_id = 1, ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] do
							
							--ArkInventory.ThreadYield_Window( loc_id_window )
							
							local itemframename, itemframe = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
							
							if itemframe and itemframe.ARK_Data.isTainted and not InCombatLockdown( ) then
								
								-- a tainted compressed itemframe exists and you are no longer in combat so "delete" it.  a normal itemframe will get created further down to replace it
								
								itemframe:Hide( )
								itemframe:SetParent( nil )
								
								_G[itemframename] = nil
								
								itemframe = nil
								itemframename = nil
								
							end
							
							if not itemframe then
								
								local template = string.format( "%s%s", ArkInventory.Global.Location[loc_id_window].template or "ARKINV_TemplateButtonViewOnlyItem", ArkInventory.CrossClient.TemplateVersion )
								
								if InCombatLockdown( ) then
									
									-- in combat, create a tainted frame that is viable
									
									template = string.format( "%s%s", template, ArkInventory.Const.ItemFrameType.Tainted )
									itemframe = CreateFrame( ArkInventory.CrossClient.GetCreateFrameItemType( ), itemframename, bagframe, template )
									--ArkInventory.Output( "tainted ", tainteditemframename )
									
									itemframe.isTainted = true
									
								else
									
									template = string.format( "%s%s", template, ArkInventory.Const.ItemFrameType.Popup )
									itemframe = CreateFrame( ArkInventory.CrossClient.GetCreateFrameItemType( ), itemframename, bagframe, template )
									--ArkInventory.Output( "secure ", itemframename )
									
								end
								
							end
							
							if itemframe.ARK_Data.init then
								-- covers stuff we cant do in the onload because the database isnt ready there
								ArkInventory.MediaFrameDefaultFontSet( itemframe )
								itemframe:SetScale( slotScale )
								itemframe.ARK_Data.init = false
							end
							
							itemframe.ARK_Data.IsDisplayed = nil
							
						end
						
					end
					
				end
			end
		end
		
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	-- position the bar frames
	local name = frame:GetName( )
	
	local bpr = codex.style.window.list and 1 or codex.style.bar.per or 1
	local padSlot = codex.style.slot.pad * slotScale
	local padBarInternal = codex.style.bar.pad.internal * slotScale
	local padBarExternal = codex.style.bar.pad.external
	local padWindow = codex.style.window.pad
	local padLabel = ArkInventory.Frame_Bar_Label_GetPaddingValue( codex )
	local padActionButtons = codex.style.title.hide and ArkInventory.Const.Frame.Main.MiniActionButtonSize or 0
	local anchor = codex.style.bar.anchor
	
	local padList = 0
	if codex.style.window.list then
		padList = ( codex.style.window.width - 1 ) * ( slotSize + padSlot )
	end
	
	local barOffsetX, barOffsetY, barWidth, barHeight
	
	for rownum, row in ipairs( codex.workpad.container.row ) do
		
		row.width = padWindow * 2 - padBarExternal
		
		for bar_index, bar_id in ipairs( row.bar ) do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			local bar = codex.workpad.bar[bar_id]
			local objframename, obj = ArkInventory.ContainerBarNameGet( loc_id_window, bar_id )
			ArkInventory.Util.Assert( obj, "xml element [", objframename, "] could not be found" )
			
			-- assign the bar number used to the bar frame and set it to display
			obj.ARK_Data.IsDisplayed = true
			obj.ARK_Data.bar_id = bar_id
			
			if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Recalculate then
				
				obj:ClearAllPoints( )
				
				local obj_width = ( bar.width * slotSize ) + ( ( bar.width - 1 ) * padSlot ) + ( padBarInternal * 2 ) + padList
				obj:SetWidth( obj_width )
				
				row.width = row.width + obj_width + padBarExternal
				
				row.height = ( bar.height * slotSize ) + ( ( bar.height - 1 ) * padSlot ) + ( padBarInternal * 2 ) + padLabel
				obj:SetHeight( row.height )
				
				if bar_index == 1 then
					
					--ArkInventory.Output( "r[", rownum, "] h[", row.height, "] o[", barHeight, "]" )
					
					-- first bar in a new row, set X offset
					barOffsetX = padWindow
					barWidth = 0
					
					if bar.frame == 1 then
						
						-- first row, first bar, set Y offset
						barOffsetY = padWindow
						
						-- increment Y offset if mini action items are visible, theyre always at the top
						if codex.style.title.hide then
							if anchor == ArkInventory.ENUM.ANCHOR.TOPLEFT or anchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
								barOffsetY = barOffsetY + ArkInventory.Const.Frame.Main.MiniActionButtonSize or 0
							end
						end
						
					else
						
						-- next row, first bar, increment Y offset
						barOffsetY = barOffsetY + ( barHeight or 0 ) + padBarExternal
						
					end
					
					barHeight = row.height
					
				else
					
					-- same row, subsequent bars, increment X offset
					barOffsetX = barOffsetX + ( barWidth or 0 ) + padBarExternal
					
				end
				
				barWidth = obj_width
				
				--ArkInventory.Output( "r[", rownum, "] b[", bar_index, "] f[", bar.frame, "] x[", barOffsetX, "] y[", barOffsetY, "]" )
				
				if anchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
					obj:SetPoint( "BOTTOMLEFT", frame, barOffsetX, barOffsetY )
				elseif anchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
					obj:SetPoint( "TOPLEFT", frame, barOffsetX, 0 - barOffsetY )
				elseif anchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
					obj:SetPoint( "TOPRIGHT", frame, 0 - barOffsetX, 0 - barOffsetY )
				else
					obj:SetPoint( "BOTTOMRIGHT", frame, 0 - barOffsetX, barOffsetY )
				end
				
				ArkInventory.Frame_Bar_Paint( obj )
				
			end
			
			if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Refresh then
				ArkInventory.Frame_Bar_DrawItems( obj )
			end
			
		end
		
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Refresh then
		
		-- display/hide the appropriate items - mostly used for search matching (thus the refresh level)
		
		for bag_id_window, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			if ArkInventory.Global.Mode.Edit or codex.player.data.option[loc_id_window].bag[bag_id_window].display then
				
				-- this bag and its items should be visible
				
				for slot_id = 1, ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] do
					
					--ArkInventory.OutputThread( "here 1 - ", bag_id_window, " - ", slot_id )
					
					local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id )
					ArkInventory.Util.Assert( obj, "xml element [", objname, "] could not be found" )
					
					if obj.ARK_Data.IsDisplayed then
						
						ArkInventory.Frame_Item_Update_Clickable( obj )
						
						if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Restart then
							obj:SetScale( slotScale )
						end
						
						obj:Show( )
						
					else
						
						obj:Hide( )
						
					end
					
				end
				
			end
			
		end
		
		ArkInventory.ThreadYield_Window( loc_id_window )
		
		-- display/hide the appropriate bags (code separated for better reload visual impact)
		for bag_id_window, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			local bagframename = string.format( "%sBag%s", frame:GetName( ), bag_id_window )
			local bagframe = _G[bagframename]
			ArkInventory.Util.Assert( bagframe, "xml element [", bagframename, "] could not be found" )
			
			if ArkInventory.Global.Mode.Edit or codex.player.data.option[loc_id_window].bag[bag_id_window].display then
				bagframe:Show( )
			else
				bagframe:Hide( )
			end
			
		end
		
		-- display/hide the appropriate bars
		for bar_id = 1, ArkInventory.Global.Location[loc_id_window].maxBar do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			local barframename, barframe = ArkInventory.ContainerBarNameGet( loc_id_window, bar_id )
			ArkInventory.Util.Assert( barframe, "xml element [", barframename, "] could not be found" )
			
			if barframe.ARK_Data.IsDisplayed then
				barframe:Show( )
			else
				barframe:Hide( )
			end
			
		end
		
		ArkInventory.ThreadYield_Window( loc_id_window )
		
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Recalculate then
		
		ArkInventory.ThreadYield_Window( loc_id_window )
		
		-- set container height and width
		
		local c = codex.workpad.container
		
		c.width = ArkInventory.Const.Window.Min.Width
		
		c.height = padWindow * 2 + padActionButtons - padBarExternal
		
		for row_index, row in ipairs( c.row ) do
		
			if row.width > c.width then
				c.width = row.width
			end
			
			c.height = c.height + row.height + padBarExternal
			
		end
		
		-- set the container frame dimensions
		frame:SetWidth( c.width )
		frame:SetHeight( c.height )
		
		-- set scrollframe/slider
		local h = codex.style.window.height
		if c.height < h then
			h = c.height
		end
		
		local sf = frame:GetParent( )
		
		sf.range = c.height
		sf.stepSize = ArkInventory.Const.Frame.Scroll.stepSize
		
		if c.height > h then
			sf.scrollBar:SetMinMaxValues( 0, c.height - h )
			sf.scrollBar:Show( )
		else
			sf:SetVerticalScroll( 0 )
			sf.scrollBar:Hide( )
		end
		
		codex.profile.location[loc_id_window].container.width = c.width
		codex.profile.location[loc_id_window].container.height = h
--		codex.profile.location[loc_id_window].container.heightmax = c.height
		
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
end

function ArkInventory.Frame_Container_OnLoad( frame )
	
	-- not in combat yet so theres no taint here
	
	local framename = frame:GetName( )
	local loc_id_window = string.match( framename, "^.-Frame(%d+)ScrollContainer" )
	
	ArkInventory.Util.Assert( loc_id_window, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	
	loc_id_window = tonumber( loc_id_window )
	
	frame.ARK_Data = {
		loc_id = loc_id_window,
	}
	
	-- pre-build a set amount of non tainted usable bag slots for the backpack to cater for entering the world when in combat
	if loc_id_window == ArkInventory.Const.Location.Bag then
		for bag_id = 1, ( ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + 1 ) do
			local bagframename = string.format( "%sBag%s", frame:GetName( ), bag_id )
			local bagframe = CreateFrame( "Frame", bagframename, frame, "ARKINV_TemplateFrameBag" )
		end
	end
	
end


function ArkInventory.Frame_Scroll_OnLoad( frame )
	
	ArkInventory.Util.Assert( frame, "frame is nil" )
	
	ArkInventory.Frame_AddBorder( frame )
	
	local framename = frame:GetName( )
	
	local loc_id_window = string.match( framename, "^.-(%d+)Scroll" )
	ArkInventory.Util.Assert( loc_id_window, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	
	loc_id_window = tonumber( loc_id_window )
	
	frame.ARK_Data = {
		loc_id = loc_id_window,
	}
	
	frame.stepSize = ArkInventory.Const.Frame.Scroll.stepSize
	
end


function ArkInventory.Frame_Bar_OnLoad( frame )
	
	ArkInventory.Frame_AddBorder( frame )
	
	local framename = frame:GetName( )
	local loc_id, bar_id = string.match( framename, "^.-Frame(%d+)ScrollContainerBar(%d+)" )
	
	ArkInventory.Util.Assert( loc_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	ArkInventory.Util.Assert( bar_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	
	loc_id = tonumber( loc_id )
	bar_id = tonumber( bar_id )
	
	frame.ARK_Data = {
		loc_id = loc_id,
		bar_id = bar_id,
	}
	
	-- add edit button
	frame.ArkEdit = CreateFrame( ArkInventory.CrossClient.GetCreateFrameItemType( ), string.format( "%sEdit", framename ), frame, string.format( "ARKINV_TemplateButtonBarEdit%s", ArkInventory.CrossClient.TemplateVersion ) )
	
	ArkInventory.MediaFrameDefaultFontSet( frame )
	
	frame:Hide( )
	
end

function ArkInventory.Frame_Bar_Paint_All( )

	--ArkInventory.Output( "Frame_Bar_Paint_All( )" )

	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			
			c = _G[string.format( "%s%s%s", ArkInventory.Const.Frame.Main.Name, loc_id, ArkInventory.Const.Frame.Container.Name )]
			
			if c then
				
				for bar_id = 1, loc_data.maxBar do
					
					obj = _G[string.format( "%s%s%s", c:GetName( ), "Bar", bar_id )]
					
					if obj then
						ArkInventory.Frame_Bar_Paint( obj )
					end
					
				end
				
			end
			
		end
	end

end

function ArkInventory.Frame_Bar_Paint( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	--ArkInventory.Output( "paint ", frame:GetName( ) )
	
	local loc_id = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	-- border
	local obj = frame.ArkBorder
	if obj then
		
		if codex.style.bar.border.style ~= ArkInventory.Const.Texture.BorderNone then
			
			local border = codex.style.bar.border.style or ArkInventory.Const.Texture.BorderDefault
			local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BORDER, border )
			local size = codex.style.bar.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size
			local offset = codex.style.bar.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offsetdefault.bar
			local scale = codex.style.bar.border.scale or 1
			
			local colour = nil
			if codex.layout.bar.data[bar_id].border.custom == 2 then
				colour = codex.layout.bar.data[bar_id].border.colour
			else
				colour = codex.style.bar.border.colour
			end
			
			ArkInventory.Frame_Border_Paint( obj, file, size, offset, scale, colour.r, colour.g, colour.b, 1 )
			
			obj:Show( )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
	
	-- background colour
	local obj = frame.ArkBackground
	if obj then
		
		local colour = codex.style.bar.background.colour
		
		if codex.layout.bar.data[bar_id].background.custom == 3 then
			
			-- use border colour
			if codex.layout.bar.data[bar_id].border.custom == 2 then
				-- use custom border colour
				colour = codex.layout.bar.data[bar_id].border.colour
			else
				-- use default border colour
				colour = codex.style.bar.border.colour
			end
			
		elseif codex.layout.bar.data[bar_id].background.custom == 2 then
			
			-- use custom background colour
			colour = codex.layout.bar.data[bar_id].background.colour
			
		end
		
		--frame:SetBackdropBorderColor( colour.r, colour.g, colour.b, colour.a )
		ArkInventory.SetTexture( obj, true, colour.r, colour.g, colour.b, colour.a )
		
	end
	
	
	-- edit mode bar number
	local obj = frame.ArkEdit
	if obj then
		
		if ArkInventory.Global.Mode.Edit then
			
			local padSlot = codex.style.slot.pad
			local padBarInternal = codex.style.bar.pad.internal
			local padLabel = ArkInventory.Frame_Bar_Label_GetPaddingValue( codex )
			local slotAnchor = codex.style.slot.anchor
			
			obj:ClearAllPoints( )
			
			-- anchor to the opposite corner that items are
			if slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
				
				if codex.style.bar.name.anchor == ArkInventory.ENUM.ANCHOR.BOTTOM then
					padLabel = 0
				end
				
				obj:SetPoint( "TOPRIGHT", 0 - padBarInternal, 0 - padBarInternal - padLabel )
				
			elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
				
				if codex.style.bar.name.anchor == ArkInventory.ENUM.ANCHOR.TOP then
					padLabel = 0
				end
				
				obj:SetPoint( "BOTTOMRIGHT", 0 - padBarInternal, padBarInternal + padLabel )
				
			elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
				
				if codex.style.bar.name.anchor == ArkInventory.ENUM.ANCHOR.TOP then
					padLabel = 0
				end

				obj:SetPoint( "BOTTOMLEFT", padBarInternal, padBarInternal + padLabel )
				
			else -- Default / BottomRight
				
				if codex.style.bar.name.anchor == ArkInventory.ENUM.ANCHOR.BOTTOM then
					padLabel = 0
				end
				
				obj:SetPoint( "TOPLEFT", padBarInternal, 0 - padBarInternal - padLabel )
				
			end
			
			obj:Show( )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
	-- label
	ArkInventory.Frame_Bar_Label( frame )
	
end

function ArkInventory.Frame_Bar_Label( frame )
	
	local oframe = frame.Header
	if not oframe then
		ArkInventory.OutputWarning( "code issue: ", frame:GetName( ), " missing xml element Header" )
	else
		local obj = oframe.Label
		if not obj then
			ArkInventory.OutputWarning( "code issue: ", oframe:GetName( ), " missing xml element Header.Label" )
		else
			
			local loc_id = frame.ARK_Data.loc_id
			local codex = ArkInventory.Codex.GetLocation( loc_id )
			
			local bar_id = frame.ARK_Data.bar_id
			local txt = codex.layout.bar.data[bar_id].name.text
			
			if ( codex.style.bar.name.show or ( ArkInventory.Global.Mode.Edit and codex.style.bar.name.editmode ) ) and ( not codex.style.window.list ) and txt and txt ~= "" then
				
				local padBarInternal = codex.style.bar.pad.internal
				
				local anchor = codex.style.bar.name.anchor
				if anchor == ArkInventory.ENUM.ANCHOR.DEFAULT then
					-- automatically switch based on slot anchor point
					anchor = codex.style.slot.anchor
					if anchor == ArkInventory.ENUM.ANCHOR.TOPLEFT or anchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
						anchor = ArkInventory.ENUM.ANCHOR.BOTTOM
					else
						anchor = ArkInventory.ENUM.ANCHOR.TOP
					end
				end
				
				oframe:ClearAllPoints( )
				
				if anchor == ArkInventory.ENUM.ANCHOR.TOP then
					oframe:SetPoint( "TOPLEFT", frame, padBarInternal, 0 - padBarInternal )
				else
					oframe:SetPoint( "BOTTOMLEFT", frame, padBarInternal, padBarInternal )
				end
				
				oframe:SetPoint( "RIGHT", frame, 0 - padBarInternal, 0 )
				oframe:SetHeight( codex.style.bar.name.height )
				
				obj:SetText( "\10" ) -- alignment changes wont render unless the text changes as well
				
				local align = codex.style.bar.name.align
				if align == ArkInventory.ENUM.ANCHOR.RIGHT then
					obj:SetJustifyH( "RIGHT" )
				elseif align == ArkInventory.ENUM.ANCHOR.CENTER then
					obj:SetJustifyH( "CENTER" )
				else
					obj:SetJustifyH( "LEFT" )
				end
				
				obj:SetHeight( codex.style.bar.name.height )
				
				obj:SetText( txt )
				
				local colour = codex.style.bar.name.colour
				if codex.layout.bar.data[bar_id].name.custom == 2 then
					-- use custom colour
					colour = codex.layout.bar.data[bar_id].name.colour
				end
				obj:SetTextColor( colour.r, colour.g, colour.b )
				
				ArkInventory.MediaObjectFontSet( obj, nil, codex.style.bar.name.height )
				
				oframe:Show( )
				
			else
				
				oframe:Hide( )
				
			end
			
		end
	end
end

function ArkInventory.Frame_Bar_Label_GetPaddingValue( codex )
	
	local padLabel = 0
	
	if ( codex.style.bar.name.show or ( ArkInventory.Global.Mode.Edit and codex.style.bar.name.editmode ) ) and ( not codex.style.window.list ) then
		
		local slotScale = codex.style.slot.scale or 1
		local padMin = codex.style.bar.name.pad.vertical
		
		local padSlot = codex.style.slot.pad * slotScale
		if padSlot < padMin then
			padSlot = padMin
		end
		
		padLabel = codex.style.bar.name.height + padSlot
		
	end
	
	return padLabel
	
end

function ArkInventory.Frame_Bar_Label_OnLoad( frame )
	-- required to handle cursor change on drop receive
	frame:RegisterForDrag( "LeftButton" )
end

function ArkInventory.Frame_Bar_Label_OnEnter( frame )
	
	local loc_id = frame:GetParent( ).ARK_Data.loc_id
	local bar_id = frame:GetParent( ).ARK_Data.bar_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	local txt = codex.layout.bar.data[bar_id].name.text
	
	-- show tooltip for frame names that dont fit
	if txt and txt ~= "" and frame.Label:GetStringHeight( ) > codex.style.bar.name.height + 1 then
		ArkInventory.GameTooltipSetText( frame, txt )
	end
	
end

function ArkInventory.Frame_Bar_Label_OnLeave( frame )
	
	local loc_id = frame:GetParent( ).ARK_Data.loc_id
	local bar_id = frame:GetParent( ).ARK_Data.bar_id
	
	ArkInventory.GameTooltipHide( )
	
end

function ArkInventory.Frame_Bar_Label_OnClick( frame, button )
	
	local loc_id = frame:GetParent( ).ARK_Data.loc_id
	local bar_id = frame:GetParent( ).ARK_Data.bar_id
	
	if ArkInventory.Global.Mode.Edit then
		ArkInventory.Lib.Dewdrop:Close( )
	end
	
	if button == "RightButton" then
		ArkInventory.MenuBarLabelOpen( frame )
	end
	
end

function ArkInventory.Frame_Bar_Label_OnDragStart( frame )
	local loc_id = frame:GetParent( ).ARK_Data.loc_id
	local parent = ArkInventory.Frame_Main_Get( loc_id )
	ArkInventory.Frame_Main_OnDragStart( parent )
end

function ArkInventory.Frame_Bar_Label_OnDragStop( frame )
	
		local loc_id = frame:GetParent( ).ARK_Data.loc_id
		
		local parent = ArkInventory.Frame_Main_Get( loc_id )
		ArkInventory.Frame_Main_OnDragStop( parent )
end

function ArkInventory.Frame_Bar_Label_OnReceiveDrag( frame )
	
	if ArkInventory.EditModeIsDragging( ) then
		
		ArkInventory.GameTooltipHide( )
		
		ArkInventory.EditModeOnDragSet( )
		ArkInventory.SetCursor( )
		
	end
	
end


function ArkInventory.Frame_Bar_DrawItems( frame )
	
--	local tz = debugprofilestop( )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	
	--ArkInventory.Output( "Frame_Bar_DrawItems [", frame:GetName( ), "] [", loc_id_window, "] [", bar_id, "]" )
	
	if ArkInventory.Global.Location[loc_id_window].drawState > ArkInventory.Const.Window.Draw.Refresh then
		return
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local player_id = codex.player.data.info.player_id
	
	local bar = codex.workpad.bar[bar_id]
	ArkInventory.Util.Assert( bar, "workpad data for bar [", bar_id, "] does not exist" )
	
--	ArkInventory.Output( "drawing ", codex.player.data.info.name, " - bar ", bar_id, ", count = ", bar.count, ", start = ", time( ) )
	
	if bar.count == 0 or bar.isGhost then
		return
	end
	
	
--	local tz = debugprofilestop( )
	
	if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Resort then
		
		--ArkInventory.Output( "resorting loc[", loc_id_window, "] state[", ArkInventory.Global.Location[loc_id_window].drawState, "] bar[", bar_id, "] @ ", time( ) )
		
		-- sort the items in the bar (cpu intensive)
		for j, item in ipairs( bar.item ) do
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			local loc_id_storage = item.loc_id_storage
			local bag_id_storage = item.bag_id_storage
			local slot_id = item.slot_id
			
			local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
			local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
			
			local i = bag.slot[slot_id]
			item.sortkey = item.sortkey or ArkInventory.ItemSortKeyGenerate( i, bar_id, codex )
			
		end
		
		
		local sid_def = codex.style.sort.method or 9999
		local sid = codex.layout.bar.data[bar_id].sort.method or sid_def
		
		if ArkInventory.db.option.sort.method.data[sid].used ~= "Y" then
			--ArkInventory.OutputWarning( "bar ", bar_id, " in location ", loc_id_window, " is using an invalid sort method.  resetting it to default" )
			codex.layout.bar.data[bar_id].sort.method = nil
			sid = sid_def
		end
		
		table.sort( bar.item, ArkInventory.ItemSortKeySort )
		
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	
	-- DO NOT SCALE THESE VALUES
	local slotSize = codex.style.slot.size or ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.SLOTSIZE
	local slotAnchor = codex.style.slot.anchor
	
	if codex.style.window.list then
		if slotAnchor == ArkInventory.ENUM.ANCHOR.TOPLEFT or slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
			slotAnchor = ArkInventory.ENUM.ANCHOR.TOPLEFT
		else
			slotAnchor = ArkInventory.ENUM.ANCHOR.TOPRIGHT
		end
	end
	
	local padSlot = codex.style.slot.pad
	local padBarInternal = codex.style.bar.pad.internal
	local padLabel = ArkInventory.Frame_Bar_Label_GetPaddingValue( codex )
	
	local padList = 0
	if codex.style.window.list then
		padList = ( codex.style.window.width - 1 ) * slotSize + ( codex.style.window.width - 2 ) * padSlot
	end
	
	local col = bar.width
	
	-- cycle through the items in the bar
	
	--ArkInventory.Output( "bar = ", bar_id, ", count = ", bar.count, " ,width=", bar.width )
	
	local itemOffsetX, itemOffsetY
	
	for j, item in ipairs( bar.item ) do
		
		ArkInventory.ThreadYield_Window( loc_id_window )
		
		--ArkInventory.Output( item )
		
		local bag_id_window = item.bag_id_window
		local slot_id = item.slot_id
		
		local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id )
		ArkInventory.Util.Assert( obj, "xml element [", objname, "] could not be found" )
		
		obj.ARK_Data.bar_id = bar_id
		
		obj.ARK_Data.isCompressed = item.isCompressed
		obj.ARK_Data.stack_id = item.stack_id
		
		local matches = true
		local matches = ArkInventory.Frame_Item_Update_SearchResult( obj )
		if matches then
			obj.ARK_Data.IsDisplayed = true
		else
			obj.ARK_Data.IsDisplayed = nil
		end
		
		
		ArkInventory.ThreadYield_Window( loc_id_window )
		
		if ( ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Resort ) or ( codex.style.window.list and ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Refresh ) then
			
			obj:ClearAllPoints( )
			obj:SetSize( slotSize, slotSize )
			--obj:Show( )
			
			if ( j - 1 ) % col == 0 then
				
				-- first item in a new row, set X offset
				itemOffsetX = padBarInternal
				
				if j == 1 then
					
					-- first row, first item, set Y offset
					itemOffsetY = padBarInternal
					
					-- increment Y offset if bar names are enabled and they are in the way
					if ( codex.style.bar.name.show or ( ArkInventory.Global.Mode.Edit and codex.style.bar.name.editmode ) ) and ( not codex.style.window.list ) then
						
						local nameAnchor = codex.style.bar.name.anchor
						if nameAnchor ~= ArkInventory.ENUM.ANCHOR.DEFAULT then
							
							local tempAnchor = ArkInventory.ENUM.ANCHOR.TOP
							if slotAnchor == ArkInventory.ENUM.ANCHOR.DEFAULT or slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT or slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
								tempAnchor = ArkInventory.ENUM.ANCHOR.BOTTOM
							end
							
							if nameAnchor == tempAnchor then
								itemOffsetY = itemOffsetY + padLabel
							end
							
						end
						
					end
					
					if codex.style.window.list and not matches then
						-- cater for first entry in list view being hidden
						itemOffsetY = itemOffsetY - slotSize - padSlot
					end
					
				else
					
					-- next row, first item, increment Y offset
					if not ( codex.style.window.list and not matches ) then
						-- non matching items are hidden
						-- in list view that leaves gaps so dont increment the Y offset if this is list view and the item does not match
						itemOffsetY = itemOffsetY + slotSize + padSlot
					end
					
				end
				
			else
				
				-- same row, subsequent items, increment X offset
				-- list view only has a single item per row so wont get here
				
				itemOffsetX = itemOffsetX + slotSize + padSlot
				
			end
			
			--ArkInventory.Output( "item ", j, ", x=", itemOffsetX, ", y=", itemOffsetY )
			
			if slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
				obj:SetPoint( "BOTTOMLEFT", frame, itemOffsetX, itemOffsetY )
			elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
				obj:SetPoint( "TOPLEFT", frame, itemOffsetX, 0 - itemOffsetY )
			elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
				obj:SetPoint( "TOPRIGHT", frame, 0 - itemOffsetX, 0 - itemOffsetY )
			else -- slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
				obj:SetPoint( "BOTTOMRIGHT", frame, 0 - itemOffsetX, itemOffsetY )
			end
			
			local listobj = obj.ArkListEntry
			if listobj then
				
				if codex.style.window.list then
					
					listobj:ClearAllPoints( )
					
					listobj:SetPoint( "TOP", obj )
					listobj:SetPoint( "BOTTOM", obj )
					
					if slotAnchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
						listobj:SetPoint( "LEFT", obj, "RIGHT", padSlot, 0 )
					else
						listobj:SetPoint( "RIGHT", obj, "LEFT", 0 - padSlot, 0 )
					end
					
					listobj:SetWidth( padList )
					listobj:Show( )
					
				else
					
					listobj:Hide( )
					
				end
				
			end
			
		end
		
		ArkInventory.ThreadYield_Window( loc_id_window )
		
		if ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Refresh then
			
			ArkInventory.ThreadYield_Window( loc_id_window )
			
			ArkInventory.Frame_Item_Update_Instant( loc_id_window, bag_id_window, slot_id )
			
		end
		
	end
	
	ArkInventory.ThreadYield_Window( loc_id_window )
	
	if codex.style.window.list and ArkInventory.Global.Location[loc_id_window].drawState <= ArkInventory.Const.Window.Draw.Refresh then
		frame:GetParent( ):GetParent( ):SetVerticalScroll( 1 )
		frame:GetParent( ):GetParent( ):UpdateScrollChildRect( )
	end
	
	
--	tz = debugprofilestop( ) - tz
--	ArkInventory.OutputThread( "draw bar [", loc_id_window, "] [", bar_id, "] [", string.format( "%0.02fms", tz ), "] " )
	
end

function ArkInventory.Frame_Bar_Insert( loc_id_window, bar_id )
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local t = codex.layout.bar.data
	table.insert( t, bar_id, ArkInventory.Table.Copy( t[0] ) )
	
	
	-- move category data (bar numbers can be negative)
	for cat, bar in pairs( codex.layout.category ) do
		if abs( bar ) >= bar_id then
			if bar > 0 then
				ArkInventory.CategoryLocationSet( loc_id_window, cat, bar + 1 )
			else
				ArkInventory.CategoryLocationSet( loc_id_window, cat, bar - 1 )
			end
		end
	end
	
	
	-- move bag assignment
	for bag_id_window in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		local z = codex.layout.bag[bag_id_window].bar
		if z and z >= bar_id then
			codex.layout.bag[bag_id_window].bar = z + 1
		end
	end
	
end

function ArkInventory.Frame_Bar_Remove( loc_id_window, bar_id )
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local t = codex.layout.bar.data
	table.remove( t, bar_id )
	
	
	-- move category data (bar numbers can be negative)
	local cat_def = ArkInventory.CategoryGetSystemID( "SYSTEM_DEFAULT" )
	
	for cat, bar in pairs( codex.layout.category ) do
		if abs( bar ) > bar_id then
			if bar > 0 then
				ArkInventory.CategoryLocationSet( loc_id_window, cat, bar - 1 )
			else
				ArkInventory.CategoryLocationSet( loc_id_window, cat, bar + 1 )
			end
		elseif abs( bar ) == bar_id then
			if cat == cat_def then
				-- if the DEFAULT category was on the bar then move it to bar 1
				ArkInventory.CategoryLocationSet( loc_id_window, cat, 1 )
			else
				-- erase the location, setting it back to the same as DEFAULT
				ArkInventory.CategoryLocationSet( loc_id_window, cat, nil )
			end
		end
		
	end
	
	
	-- move bag assignment
	for bag_id_window in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		local z = codex.layout.bag[bag_id_window].bar
		if not z then
			-- do nothing
		elseif z > bar_id then
			codex.layout.bag[bag_id_window].bar = z - 1
		elseif z == bar_id then
			codex.layout.bag[bag_id_window].bar = nil
		end
	end
	
end

function ArkInventory.Frame_Bar_Move( loc_id_window, bar1, bar2 )
	
	--ArkInventory.Output( "loc [", loc_id_window, "], bar1 [", bar1, "], bar2 [", bar2, "]" )
	
	if not bar1 or not bar2 or bar1 == bar2 or bar1 < 1 or bar2 < 1 then return end
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local t = codex.layout.bar.data
	
	local step = 1
	if bar2 < bar1 then
		step = -1
		table.insert( t, bar2, ArkInventory.Table.Copy( t[bar1] ) )
		table.remove( t, bar1 + 1 )
	else
		table.insert( t, bar2 + 1, ArkInventory.Table.Copy( t[bar1] ) )
		table.remove( t, bar1 )
	end
	
	
	-- move category data (bar numbers can be negative)
	for cat, bar in pairs( codex.layout.category ) do
		local z = abs( bar )
		if z == bar1 then
			ArkInventory.CategoryLocationSet( loc_id_window, cat, bar2 )
		elseif ( ( step == 1 ) and ( z > bar1 and z <= bar2 ) ) or ( ( step == -1 ) and ( z >= bar2 and z < bar1 ) ) then
			if bar > 0 then
				ArkInventory.CategoryLocationSet( loc_id_window, cat, bar - step )
			else
				ArkInventory.CategoryLocationSet( loc_id_window, cat, bar + step )
			end
		end
	end
	
	-- move bag assignment
	for bag_id_window in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		local z = codex.layout.bag[bag_id_window].bar
		if not z then
			-- do nothing
		elseif z == bar1 then
			codex.layout.bag[bag_id_window].bar = bar2
		elseif ( ( step == 1 ) and ( z > bar1 and z <= bar2 ) ) or ( ( step == -1 ) and ( z >= bar2 and z < bar1 ) ) then
			codex.layout.bag[bag_id_window].bar = z - step
		end
	end
	
end

function ArkInventory.Frame_Bar_Clear( loc_id_window, bar_id )
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	-- clear bar data
	codex.layout.bar.data[bar_id] = ArkInventory.Table.Copy( codex.layout.bar.data[0] )
	
	-- clear category
	for k, v in pairs( codex.layout.category ) do
		if v == bar_id then
			local cat_def = ArkInventory.CategoryGetSystemID( "SYSTEM_DEFAULT" )
			if k ~= cat_def then
				-- erase the location, setting it back to the same as DEFAULT
				ArkInventory.CategoryLocationSet( loc_id_window, k, nil )
			end
		end
	end
	
	-- clear bag assignment
	for bag_id_window in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		if codex.layout.bag[bag_id_window].bar == bar_id then
			codex.layout.bag[bag_id_window].bar = nil
		end
	end
	
end


function ArkInventory.Frame_Bar_Edit_OnLoad( frame )
	
	ArkInventory.Util.Assert( frame, "frame is nil" )
	
	local framename = frame:GetName( )
	local loc_id, bar_id = string.match( framename, "^.-Frame(%d+)ScrollContainerBar(%d+)" )
	
	ArkInventory.Util.Assert( loc_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	ArkInventory.Util.Assert( bar_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	
	loc_id = tonumber( loc_id )
	bar_id = tonumber( bar_id )
	
	frame.ARK_Data = {
		loc_id = loc_id,
		bar_id = bar_id,
	}
	
	frame:SetID( bar_id )
	
	-- <START> because blizzard sometimes forgets to turn things off by default
	
	if frame.NewItemTexture then
		frame.NewItemTexture:Hide( )
	end
	
	if frame.BattlepayItemTexture then
		frame.BattlepayItemTexture:Hide( )
	end
	
	-- <END> because blizzard sometimes forgets to turn things off by default
	
	ArkInventory.MediaFrameDefaultFontSet( frame )
	
	ArkInventory.SetItemButtonTexture( frame, [[Interface\Buttons\WHITE8X8]] )
	SetItemButtonTextureVertexColor( frame, 0.5, 0.1, 0.1, 0.3 )
	
	frame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" )
	frame:RegisterForDrag( "LeftButton" )
	
end

function ArkInventory.Frame_Bar_Edit_OnClick( frame, button )
	
	--ArkInventory.Output( "OnClick( ", frame:GetName( ), ", ", button, " )" )
	
	local loc_id = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	
	if button then
		ArkInventory.MenuBarOpen( frame )
	end
	
end

local function helper_DragState( loc_id, bar_id, drag_type )
	if loc_id and bar_id and ArkInventory.Global.Options.OnDragType == drag_type and ArkInventory.Global.Options.OnDragLocation and ArkInventory.Global.Options.OnDragSourceBar then
		if drag_type == ArkInventory.Const.Move.Bar or ( drag_type == ArkInventory.Const.Move.Category and ArkInventory.Global.Options.OnDragSourceCategory ) then
			if ArkInventory.Global.Options.OnDragLocation == loc_id and ArkInventory.Global.Options.OnDragSourceBar ~= bar_id then
				return 1
			else
				if ArkInventory.Global.Options.OnDragLocation == loc_id then
					return 2
				else
					return 3
				end
			end
		end
	end
end

function ArkInventory.Frame_Bar_Edit_OnDragStart( frame )
	
--	local loc_id = frame.ARK_Data.loc_id
--	local bar_id = frame.ARK_Data.bar_id
--	ArkInventory.Output( "bar - on drag start: ", loc_id, ".", bar_id )
	
	ArkInventory.EditModeOnDragSet( ArkInventory.Const.Move.Bar, frame )
	
	ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
	
end

function ArkInventory.Frame_Bar_Edit_OnReceiveDrag( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	
	-- drop bar here?
	local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Bar )
	if IsAltKeyDown( ) then
		
		-- alt: move all categories on bar (OnDragSourceBar) to this bar (bar_id)
		if state == 1 then
			
			local cat_tbl = ArkInventory.CategoryBarGetAssigned( loc_id, ArkInventory.Global.Options.OnDragSourceBar )
			if cat_tbl then
				
				for cat_id in pairs( cat_tbl ) do
					ArkInventory.CategoryLocationSet( loc_id, cat_id, bar_id )
				end
				
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
				
			end
			
		else
			--ArkInventory.OutputWarning( "category assignment aborted, its already on this bar" )
		end
		
	else
		
		-- normal: move dragged bar (OnDragSourceBar) in front of this one (bar_id)
		if state == 1 then
			ArkInventory.Frame_Bar_Move( loc_id, ArkInventory.Global.Options.OnDragSourceBar, bar_id )
			ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
			--ArkInventory.OutputDebug( "dropped bar ", bar_id, " here" )
		elseif state == 2 then
			--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_SAME"], ArkInventory.Localise["MENU_BAR"] ) )
		elseif state == 3 then
			--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_OUTSIDE"], ArkInventory.Localise["MENU_BAR"] ) )
		end
		
	end
	
	
	-- drop category here?
	local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Category )
	if state == 1 then
		ArkInventory.CategoryLocationSet( loc_id, ArkInventory.Global.Options.OnDragSourceCategory, bar_id )
		ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
	elseif state == 2 then
		--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_SAME"], ArkInventory.Localise["CATEGORY"] ) )
	elseif state == 3 then
		--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_OUTSIDE"], ArkInventory.Localise["CATEGORY"] ) )
	end
	
	ArkInventory.EditModeOnDragSet( )
	
	ArkInventory.SetCursor( )
	
	ArkInventory.Frame_Bar_Edit_OnEnter( frame )
	
end

function ArkInventory.Frame_Bar_Edit_OnEnter( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	
	ArkInventory.GameTooltipSetText( frame, string.format( ArkInventory.Localise["MENU_BAR_TITLE"], bar_id ) )
	GameTooltip:Show( )
	
	if IsMouseButtonDown( "LeftButton" ) and not GetCursorInfo( ) then
	
		-- is a bar is being dragged?
		local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Bar )
		if state == 1 then
			
			GameTooltip:AddLine( string.format( ArkInventory.Localise["FRAME_ONENTER_DRAG_BAR"], ArkInventory.Global.Options.OnDragSourceBar, bar_id ), nil, nil, nil, true )
			
			-- alt: move all categories on bar (OnDragSourceBar) to this bar
			GameTooltip:AddLine( string.format( ArkInventory.Localise["FRAME_ONENTER_DRAG_BAR_ALT"], ArkInventory.Global.Options.OnDragSourceBar, bar_id ), nil, nil, nil, true )
			
			GameTooltip:Show( )
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
			
		elseif state then
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.UnableDrag )
			
		end
		
		-- is a category is being dragged
		local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Category )
		if state == 1 then
			
			local cat = ArkInventory.Global.Category[ArkInventory.Global.Options.OnDragSourceCategory]
			GameTooltip:AddLine( string.format( ArkInventory.Localise["FRAME_ONENTER_DRAG_CATEGORY"], cat.fullname, bar_id ), nil, nil, nil, true )
			GameTooltip:Show( )
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
			
		elseif state then
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.UnableDrag )
			
		end
		
	end
	
end

function ArkInventory.Frame_Bar_Edit_OnLeave( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	
	ArkInventory.GameTooltipHide( )
	
	if IsMouseButtonDown( "LeftButton" ) and not GetCursorInfo( ) then
		
		-- is a bar is being dragged?
		local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Bar )
		if state then
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
		end
		
		-- is a category is being dragged?
		local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Category )
		if state then
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
		end
		
	end
	
end


function ArkInventory.Frame_Bag_OnLoad( frame, ItemFrameType )
	
	local framename = frame:GetName( )
	
	local loc_id_window, bag_id_window = string.match( framename, "^.-Frame(%d+)ScrollContainerBag(%d+)" )
	ArkInventory.Util.Assert( loc_id_window, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	ArkInventory.Util.Assert( bag_id_window, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	
	loc_id_window = tonumber( loc_id_window )
	bag_id_window = tonumber( bag_id_window )
		
	frame.ARK_Data = {
		ItemFrameType = ItemFrameType or ArkInventory.Const.ItemFrameType.Normal,
		loc_id = loc_id_window,
		bag_id = bag_id_window,
		blizzard_id = ArkInventory.Util.getBlizzardBagIdFromWindowId( loc_id_window, bag_id_window ),
	}
	
	frame:SetID( frame.ARK_Data.blizzard_id )
	
	ArkInventory.MediaFrameDefaultFontSet( frame )
	
	frame:Hide( )
	
	if ItemFrameType ~= ArkInventory.Const.ItemFrameType.Popup then
		
		-- pre-build a set amount of non tainted usable item slots for the backpack to cater for entering the world when in combat
		if loc_id_window == ArkInventory.Const.Location.Bag then
			ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] = ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_SLOT_MAX
			for slot_id = 1, ArkInventory.Global.Location[loc_id_window].maxSlot[bag_id_window] do
				local itemframename = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id )
				local template = string.format( "%s%s", ArkInventory.Global.Location[loc_id_window].template or "ARKINV_TemplateButtonViewOnlyItem", ArkInventory.CrossClient.TemplateVersion )
				CreateFrame( ArkInventory.CrossClient.GetCreateFrameItemType( ), itemframename, frame, template )
			end
		end
	end
	
end


function ArkInventory.SetTexture( obj, texture, r, g, b, a, c )
	
	if not obj then
		return
	end
	
	if texture then
		obj:Show( )
	else
		obj:Hide( )
		return
	end
	
	if texture == true then
		-- solid colour
		obj:SetColorTexture( r or 0, g or 0, b or 0, a or 1 )
	else
		if c then
			SetPortraitToTexture( obj, texture or ArkInventory.Const.Texture.Missing )
		else
			obj:SetTexture( texture or ArkInventory.Const.Texture.Missing )
			if r and g and b then
				obj:SetVertexColor( r, g, b )
			end
		end
	end
	
end

function ArkInventory.SetItemButtonTexture( frame, texture, r, g, b, a, c )
	
	if not frame then
		return
	end
	
	local obj = frame.icon
	
	if not obj then
		return
	end
	
	ArkInventory.SetTexture( obj, texture, r, g, b, a, c )
	
	--obj:SetTexCoord( 0.075, 0.935, 0.075, 0.935 )
	obj:SetTexCoord( 0.075, 0.925, 0.075, 0.925 )
	
end

function ArkInventory.SetItemButtonDesaturate( frame, desaturate, r, g, b )

	if not frame then
		return
	end
	
	local obj = frame.icon
	
	if not obj then
		return
	end
	
	local shaderSupported = obj:SetDesaturated( desaturate )
	
	if desaturate then
	
		if shaderSupported then
			return
		end
		
		if not r or not g or not b then
			r = 0.5
			g = 0.5
			b = 0.5
		end
		
	else

		if not r or not g or not b then
			r = 1.0
			g = 1.0
			b = 1.0
		end
		
	end
	
	obj:SetVertexColor( r, g, b )
	
end


function ArkInventory.Frame_Item_GetDB( frame )
	
	ArkInventory.Util.Assert( frame.ARK_Data, "frame.ARK_Data is nil" )
	
	--ArkInventory.Output( "frame=[", frame:GetName( ), "]" )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	local slot_id = frame.ARK_Data.slot_id
	local bar_id = frame.ARK_Data.bar_id
	
	if loc_id_window and not bag_id_window and not slot_id and bar_id then
		-- its a bar number, ignore
		return
	end
	
	
	--ArkInventory.Output( loc_id_window, ".", bag_id_window, ".", slot_id, " on ", bar_id )
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
	local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
	
	local i
	if not slot_id then
		i = bag
	else
		i = bag.slot[slot_id]
	end
	
	--ArkInventory.Output( storage.data.info.player_id, " loc=[", loc_id_storage, "], bag=[", bag_id_storage, "], slot=[", slot_id, "] ", i )
	
	return i
	
end

function ArkInventory.Frame_Item_OnLoad( frame, ItemFrameType )
	
	--ArkInventory.Output( frame:GetName( ), " / level = ", frame:GetFrameLevel( ) )
	
	ArkInventory.Frame_AddBorder( frame )
	
	local framename = frame:GetName( )
	local loc_id_window, bag_id_window, slot_id = string.match( framename, "^.-Frame(%d+)ScrollContainerBag(%d+)Item(%d+)" )
	
	ArkInventory.Util.Assert( loc_id_window, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	ArkInventory.Util.Assert( bag_id_window, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	ArkInventory.Util.Assert( slot_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	
	loc_id_window = tonumber( loc_id_window )
	bag_id_window = tonumber( bag_id_window )
	slot_id = tonumber( slot_id )
	
	frame:SetID( slot_id )
	
	frame.ARK_Data = {
		ItemFrameType = ItemFrameType or ArkInventory.Const.ItemFrameType.Normal,
		loc_id = loc_id_window,
		bag_id = bag_id_window,
		blizzard_id = ArkInventory.Util.getBlizzardBagIdFromWindowId( loc_id_window, bag_id_window ),
		slot_id = slot_id,
		init = true,
	}
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	
	-- because blizzard sometimes forgets to turn things off by default
	if frame.BattlepayItemTexture then
		frame.BattlepayItemTexture:Hide( )
	end
	
	if frame.NewItemTexture then
		frame.NewItemTexture:Hide( )
	end
	
	if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ) then
		ContainerFrameItemButtonMixin.OnLoad( frame )
	else
		if frame.ARK_Data.ItemFrameType == ArkInventory.Const.ItemFrameType.Normal then
			if loc_id_storage == ArkInventory.Const.Location.Bank and bag_id_storage == 1 then
				BankFrameItemButton_OnLoad( frame )
			elseif loc_id_storage == ArkInventory.Const.Location.ReagentBank then
				ReagentBankFrameItemButton_OnLoad( frame )
			elseif loc_id_storage == ArkInventory.Const.Location.AccountBank then
				ContainerFrameItemButton_OnLoad( frame ) -- FIX ME - does account bank have an onload?
			else
				ContainerFrameItemButton_OnLoad( frame )
			end
		else
			ContainerFrameItemButton_OnLoad( frame )
		end
	end
	
	frame.UpdateTooltip = ArkInventory.Frame_Item_UpdateTooltip
	frame.GetItemContextMatchResult = ArkInventory.Frame_Item_Update_ContextMatchResult
	
	frame.locked = not ( frame.ARK_Data.ItemFrameType == ArkInventory.Const.ItemFrameType.Normal )
	
	if loc_id_window == ArkInventory.Const.Location.Vault then
		
		-- replace the split function for vault items
		frame.SplitStack = function( button, amount )
			ArkInventory.CrossClient.SplitGuildBankItem( frame.ARK_Data.bag_id, frame.ARK_Data.slot_id, amount )
		end
		
	end
	
	
	-- adjust any fixed size blizzard subframes so they scale properly
	-- fairly sure these are whats been contributing to the framelevel issue as they extend well past the item border and cause a massive amount of overlap
	
	local obj = _G[string.format( "%s%s", frame:GetName( ), "IconQuestTexture" )]
	if obj then
		obj:ClearAllPoints( )
		obj:SetPoint( "TOPLEFT", frame )
		obj:SetPoint( "BOTTOMRIGHT", frame )
	end
	
	local obj = frame.NewItemTexture
	if obj then
		obj:ClearAllPoints( )
		obj:SetPoint( "TOPLEFT", frame )
		obj:SetPoint( "BOTTOMRIGHT", frame )
	end
	
	local obj = frame.flash
	if obj then
		obj:ClearAllPoints( )
		obj:SetPoint( "TOPLEFT", frame )
		obj:SetPoint( "BOTTOMRIGHT", frame )
	end
	
	frame:Hide( )
	
	ArkInventory.API.ItemFrameLoaded( frame, loc_id_window, bag_id_window, slot_id  )
	
	frame:RegisterForDrag( "LeftButton" )
	
end

function ArkInventory.Frame_Item_OnLoad_ListEntry( frame )
	
	--ArkInventory.Output( frame:GetName( ), " / level = ", frame:GetFrameLevel( ) )
	
	local framename = frame:GetName( )
	
	local loc_id, bag_id = string.match( framename, "^.-Frame(%d+)ScrollContainerBar(%d+)" )
	if loc_id then return end
	
	local loc_id, bag_id, slot_id = string.match( framename, "^.-Frame(%d+)ScrollContainerBag(%d+)Item(%d+)" )
	
	ArkInventory.Util.Assert( loc_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	ArkInventory.Util.Assert( bag_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	ArkInventory.Util.Assert( slot_id, "xml element [", framename, "] is not an ", ArkInventory.Const.Program.Name, " frame" )
	
	loc_id = tonumber( loc_id )
	bag_id = tonumber( bag_id )
	slot_id = tonumber( slot_id )
	
	frame:SetID( slot_id )
	
	frame.ARK_Data = {
		loc_id = loc_id,
		bag_id = bag_id,
		blizzard_id = ArkInventory.Util.getBlizzardBagIdFromWindowId( loc_id, bag_id ),
		slot_id = slot_id,
	}
	
	frame:Hide( )
	
end


function ArkInventory.Frame_Item_Update_Texture( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id_window = frame.ARK_Data.loc_id
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	
	if i and i.h then
		
		-- frame has an item
		frame.hasItem = 1
		
		-- item is readable?
		if loc_id_window == ArkInventory.Const.Location.Bag or loc_id_window == ArkInventory.Const.Location.Bank then
			if not ArkInventory.Global.Location[loc_id_window].isOffline then
				local blizzard_id = ArkInventory.Util.getBlizzardBagIdFromWindowId( i.loc_id, i.bag_id )
				frame.readable = ArkInventory.CrossClient.GetContainerItemInfo( blizzard_id, i.slot_id ).isReadable
			end
		else
			frame.readable = nil
		end
		
		-- item texture
		local t = i.texture or ArkInventory.ObjectInfoTexture( i.h )
		ArkInventory.SetItemButtonTexture( frame, t )
		
	else
		
		frame.hasItem = nil
		frame.readable = nil
		
		ArkInventory.Frame_Item_Update_Empty( frame )
		
	end
	
	ArkInventory.Frame_Item_Update_New( frame, codex )
	
end

function ArkInventory.SetAnchorPoint( obj, frame, anchor, default, offsetX, offsetY )
	
	local point
	local x = offsetX or 0
	local y = offsetY or x
	
	if ( not anchor ) or ( anchor == ArkInventory.ENUM.ANCHOR.DEFAULT ) then
		anchor = default
	end
	
	if anchor == ArkInventory.ENUM.ANCHOR.CENTER then
		point = "CENTER"
		x = 0
		y = 0
	elseif anchor == ArkInventory.ENUM.ANCHOR.TOP then
		point = "TOP"
		x = 0
		y = y * -1
	elseif anchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
		point = "TOPRIGHT"
		x = x * -1
		y = y * -1
	elseif anchor == ArkInventory.ENUM.ANCHOR.RIGHT then
		point = "RIGHT"
		x = x * -1
		y = 0
	elseif anchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
		point = "BOTTOMRIGHT"
		x = x * -1
		y = y
	elseif anchor == ArkInventory.ENUM.ANCHOR.BOTTOM then
		point = "BOTTOM"
		x = 0
		y = y
	elseif anchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
		point = "BOTTOMLEFT"
		x = x
		y = y
	elseif anchor == ArkInventory.ENUM.ANCHOR.LEFT then
		point = "LEFT"
		x = x
		y = 0
	elseif anchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
		point = "TOPLEFT"
		x = x
		y = y * -1
	else
		ArkInventory.OutputError( "code failure - unknown anchor point id=[", anchor, "]" )
		return
	end
	
	obj:ClearAllPoints( )
	obj:SetPoint( point, frame, point, x, y )
	
end

function ArkInventory.Frame_Item_Update_StatusIconQuest( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj1 = frame.IconQuestTexture or _G[frame:GetName( ) .. "IconQuestTexture"]
	if not obj1 then return end
	
	local obj2 = frame.ArkIconQuestBang or _G[frame:GetName( ) .. "ArkIconQuestBang"]
	if not obj2 then return end
	
	if frame.ARK_Data.isCompressed then
		
		--ArkInventory.SetTexture( obj1, TEXTURE_ITEM_QUEST_BORDER )
		--obj1:Show( )
		
	else
		
		local loc_id = frame.ARK_Data.loc_id
		if ( loc_id == ArkInventory.Const.Location.Bag or loc_id == ArkInventory.Const.Location.Bank ) and not ArkInventory.Global.Location[loc_id].isOffline then
			
			local i = ArkInventory.Frame_Item_GetDB( frame )
			
			if i and i.h then
				
				local itemInfo = ArkInventory.CrossClient.GetContainerItemQuestInfo( i, frame.ARK_Data.blizzard_id, frame.ARK_Data.slot_id )
				--itemInfo.isQuestItem = true
				--itemInfo.questID = 1
				--itemInfo.isActive = false
				
				if itemInfo.questID or itemInfo.isQuestItem then
					
					local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
					
					if codex.style.slot.quest.border then
						ArkInventory.SetTexture( obj1, TEXTURE_ITEM_QUEST_BORDER )
					else
						obj1:Hide( )
					end
					
					if itemInfo.questID then
						
						if not itemInfo.isActive then
							
							if codex.style.slot.quest.bang then
								
								obj2:SetWidth( codex.style.slot.quest.size / 3 )
								obj2:SetHeight( codex.style.slot.quest.size )
								
								ArkInventory.SetAnchorPoint( obj2, frame, codex.style.slot.quest.anchor, ArkInventory.ENUM.ANCHOR.BOTTOMLEFT, 3 )
								ArkInventory.SetTexture( obj2, [[Interface\AddOns\ArkInventory\Images\Overlay-QuestBang.tga]] )
								
								return
								
							end
							
						end
						
					end
					
					obj2:Hide( )
					
					return
					
				end
				
			end
			
		end
		
		obj1:Hide( )
		obj2:Hide( )
		
	end
	
end

function ArkInventory.Frame_Item_Update_StatusIconUpgrade( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.UpgradeIcon
	if not obj then return end
	
	local loc_id = frame.ARK_Data.loc_id
	if ( loc_id == ArkInventory.Const.Location.Bag or loc_id == ArkInventory.Const.Location.Bank ) and not ArkInventory.Global.Location[loc_id].isOffline then
		
		local i = ArkInventory.Frame_Item_GetDB( frame )
		if i and i.h then
			
			local info = ArkInventory.GetObjectInfo( i.h, i )
			if info.equiploc ~= "" then
				
				local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
				if codex.style.slot.upgradeicon.show then
					
					local itemIsUpgrade = false
					
					if not itemIsUpgrade and PawnShouldItemLinkHaveUpgradeArrowUnbudgeted then
						itemIsUpgrade = PawnShouldItemLinkHaveUpgradeArrowUnbudgeted( i.h, true )
					end
						
					if ContainerFrameItemButton_UpdateItemUpgradeIcon then -- legion to shadowlands
						itemIsUpgrade = true
						ContainerFrameItemButton_UpdateItemUpgradeIcon( frame )
					end
					
					if not itemIsUpgrade and IsContainerItemAnUpgrade then -- was in dragonflight for a while then got removed
						itemIsUpgrade = IsContainerItemAnUpgrade( frame:GetBagID( ), frame:GetID( ) )
						if frame.isExtended then
							itemIsUpgrade = false
						end
					end
					
					
					if itemIsUpgrade then
						
						--ArkInventory.Output( "item upgrade - ", i.h )
						
						obj:SetWidth( codex.style.slot.upgradeicon.size )
						obj:SetHeight( codex.style.slot.upgradeicon.size )
						
						ArkInventory.SetAnchorPoint( obj, frame, codex.style.slot.upgradeicon.anchor, ArkInventory.ENUM.ANCHOR.BOTTOMLEFT, -3 )
						
						obj:Show( )
						
						return
						
					else
						
						--ArkInventory.Output( "item not an upgrade - ", i.h )
						
					end
					
				end
				
			end
			
		end
		
	end
	
	obj:Hide( )
	
end

function ArkInventory.Frame_Item_Update_StatusIconJunk( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.JunkIcon
	if not obj then return end
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	local slot_id = frame.ARK_Data.slot_id
	
	if ( loc_id_window == ArkInventory.Const.Location.Bag or loc_id_window == ArkInventory.Const.Location.Bank ) and not ArkInventory.Global.Location[loc_id_window].isOffline then
		
		local i = ArkInventory.Frame_Item_GetDB( frame )
		if i and i.h then
			
			local codex = codex or ArkInventory.Codex.GetLocation( loc_id_window )
			
			if codex.style.slot.junkicon.show then
				
				local blizzard_id = ArkInventory.Util.getBlizzardBagIdFromWindowId( loc_id_window, bag_id_window )
				local isJunk = ArkInventory.Action.Vendor.Check( codex, blizzard_id, slot_id, true )
				
				if isJunk then
					
					obj:SetHeight( codex.style.slot.junkicon.size )
					obj:SetWidth( codex.style.slot.junkicon.size )
					
					ArkInventory.SetAnchorPoint( obj, frame, codex.style.slot.junkicon.anchor, ArkInventory.ENUM.ANCHOR.BOTTOMLEFT, -3 )
					
					obj:Show( )
					
					return
					
				end
				
			end
			
		end
		
	end
	
	obj:Hide( )
	
end

function ArkInventory.Frame_Item_Update_StatusIconCorrupted( frame, codex )
	
	if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.BFA ) then return end
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.ArkIconCorrupted
	if not obj then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	if i and i.h then
		
		local loc_id = frame.ARK_Data.loc_id
		local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
		
		if codex.style.slot.overlay.nzoth.show and ArkInventory.CrossClient.IsItemCorrupted( i.h ) then
			
			obj:SetWidth( codex.style.slot.overlay.nzoth.size )
			obj:SetHeight( codex.style.slot.overlay.nzoth.size )
			
			ArkInventory.SetAnchorPoint( obj, frame, codex.style.slot.overlay.nzoth.anchor, ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT, 1 )
			
			ArkInventory.SetTexture( obj, [[Interface\AddOns\ArkInventory\Images\Overlay-Corrupted.tga]] )
			
			return
		end
		
	end
	
	obj:Hide( )
	
end

function ArkInventory.Frame_Item_Update_StatusIconProfessionRank( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	if not ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ) then return end
	
	local obj1 = frame.ArkIconProfessionRank
	if not obj1 then return end
	
	local obj2 = frame.ArkIconProfessionRankText
	if not obj2 then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	if i and i.h then
		
		local loc_id = frame.ARK_Data.loc_id
		local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
		local info = ArkInventory.GetObjectInfo( i.h, i )
		
		if codex.style.slot.overlay.professionrank.show then
			
			local quality = info.rank
			--quality = random( 5 )
			if quality then
				
				local colour = ArkInventory.Const.BLIZZARD.GLOBAL.PROFESSIONRANK.COLOR[quality]
				
				if codex.style.slot.overlay.professionrank.custom then
					colour = codex.style.slot.overlay.professionrank.colour or ArkInventory.Const.BLIZZARD.GLOBAL.PROFESSIONRANK.COLOR[0]
				end
				
				if codex.style.slot.overlay.professionrank.number then
					
					obj2:SetText( quality )
					obj2:SetTextColor( colour.r, colour.g, colour.b, colour.a )
					
					ArkInventory.MediaObjectFontSet( obj2, nil, codex.style.slot.overlay.professionrank.size )
					
					ArkInventory.SetAnchorPoint( obj2, frame, codex.style.slot.overlay.professionrank.anchor, ArkInventory.ENUM.ANCHOR.TOPLEFT, 1 )
					
					obj2:Show( )
					
					obj1:Hide( )
					
				else
					
					local atlas = C_Texture.GetAtlasInfo( string.format( "Professions-Icon-Quality-Tier%d-Inv", quality ) )
					ArkInventory.SetTexture( obj1, atlas.file )
					obj1:SetTexCoord( atlas.leftTexCoord, atlas.rightTexCoord, atlas.topTexCoord, atlas.bottomTexCoord )
					
					if codex.style.slot.overlay.professionrank.custom then
						obj1:SetDesaturated( 1 )
						obj1:SetVertexColor( colour.r, colour.g, colour.b, colour.a )
					else
						obj1:SetDesaturated( nil )
						obj1:SetVertexColor( 1, 1, 1, 1 )
					end
					
					obj1:SetWidth( codex.style.slot.overlay.professionrank.size )
					obj1:SetHeight( codex.style.slot.overlay.professionrank.size / atlas.width * atlas.height )
					
					local offset = ArkInventory.Const.BLIZZARD.GLOBAL.PROFESSIONRANK.OFFSET[quality]
					ArkInventory.SetAnchorPoint( obj1, frame, codex.style.slot.overlay.professionrank.anchor, ArkInventory.ENUM.ANCHOR.TOPLEFT, offset.x, offset.y )
					
					obj1:Show( )
					
					obj2:Hide( )
					
				end
				
				return
				
			end
			
		end
		
	end
	
	obj1:Hide( )
	obj2:Hide( )
	
end

function ArkInventory.Frame_Item_Update_Overlays( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	-- azerite
	-- nzoth
	-- cosmetic
	-- conduit
	-- profession rank
	
	ArkInventory.CrossClient.ClearItemOverlays( frame )
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	if i and i.h then
		
		local loc_id = frame.ARK_Data.loc_id
		local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
		
		local button = frame
		local itemIDOrLink = i.h
		local info = ArkInventory.GetObjectInfo( i.h, i )
		local quality = info.q
		
		if button.IconOverlay then
			
			-- sourced from: \Interface\FrameXML\ItemButtonTemplate.lua
			
			if codex.style.slot.overlay.azerite.show and ArkInventory.CrossClient.IsItemAzeriteEmpowered( itemIDOrLink ) then
				
				button.IconOverlay:SetAtlas( "AzeriteIconFrame" )
				button.IconOverlay:Show( )
				
			elseif ArkInventory.CrossClient.IsItemCorrupted( itemIDOrLink ) then
				
				-- changed this to a status icon so it can be moved around
				
				--button.IconOverlay:SetAtlas( "Nzoth-inventory-icon" )
				--button.IconOverlay:Show( )
				
			elseif codex.style.slot.overlay.cosmetic.show and ArkInventory.CrossClient.IsItemCosmetic( itemIDOrLink ) and not ArkInventory.CrossClient.PlayerHasTransmogByItemInfo( itemIDOrLink ) then
				
				button.IconOverlay:SetAtlas( "CosmeticIconFrame" )
				button.IconOverlay:Show( )
				
			elseif codex.style.slot.overlay.conduit.show and ArkInventory.CrossClient.IsItemConduit( itemIDOrLink ) then
				
				if not quality or not BAG_ITEM_QUALITY_COLORS[quality] then
					quality = ArkInventory.ENUM.ITEM.QUALITY.STANDARD
				end
				
				local c = BAG_ITEM_QUALITY_COLORS[quality]
				button.IconOverlay:SetVertexColor( c.r, c.g, c.b )
				button.IconOverlay:SetAtlas( "ConduitIconFrame" )
				button.IconOverlay:Show( )
				
				-- If this is missing, the texture will make it apparant instead of error.
				if button.IconOverlay2 then
					button.IconOverlay2:SetAtlas( "ConduitIconFrame-Corners" )
					button.IconOverlay2:Show( )
				end
				
			else
				
				-- changed this to a status icon so it can be moved around
--[[
				if not button.ProfessionQualityOverlay then
					button.ProfessionQualityOverlay = button:CreateTexture( nil, "OVERLAY" )
					button.ProfessionQualityOverlay:SetPoint( "TOPLEFT", 0, 2 )
					button.ProfessionQualityOverlay:SetDrawLayer( "OVERLAY", 7 )
				end
				
				local obj = button.ProfessionQualityOverlay
				local quality = info.rank
				if quality then
					obj.isProfessionItem = true
					ArkInventory.OutputDebug( "profession rank ", quality )
					local atlas = ( "Professions-Icon-Quality-Tier%d-Inv" ):format( quality )
					obj:SetAtlas( atlas, TextureKitConstants.UseAtlasSize )
					obj:Show( )
					
					--ArkInventory.Frame_Item_Update_StatusIconProfessionRank( button )
					--EventRegistry:RegisterCallback("ItemButton.UpdateCraftedProfessionQualityShown", ArkInventory.Frame_Item_Update_StatusIconProfessionRank, button )
				else
					obj.isProfessionItem = false
				end
]]--
			end
			
		end
		
	end
	
end

function ArkInventory.ItemTransmogStateCharacter( h, sb, loc_id, rule_primary, rule_secondary )
	
--	if h and sb == ArkInventory.ENUM.ITEM.BINDING.PICKUP and not ArkInventory.Global.Location[loc_id].isOffline then
--		return random( 4 )
--	end
	
	if ArkInventory.db.option.transmog.enable or rule_primary then
		
		if h and sb == ArkInventory.ENUM.ITEM.BINDING.EQUIP and not ArkInventory.Global.Location[loc_id].isOffline then
			
			local visualID, sourceID = ArkInventory.CrossClient.TransmogCollection_GetItemInfo( h )
			if visualID and sourceID then
				
				--ArkInventory.Output( h, " ", visualID, " / ", sourceID )
				
				-- this item has an appearance
				
	--			local codex = ArkInventory.Codex.GetLocation( loc_id )
	--			if codex.style.slot.transmogicon.show or rule_primary then
				
				
				local sourceMe = { } -- sources i can collect
				local sourceOther = { } -- sources i cannot collect
				
				local itemInfo = { ArkInventory.CrossClient.GetItemInfoInstant( h ) }
				local itemSubType = itemInfo[7] or -2
				local invType = itemInfo[4] or -2
				
				local source = C_TransmogCollection.GetAllAppearanceSources( visualID )
				for _, id in pairs( source ) do
					
					local isInfoReady, canCollect = C_TransmogCollection.PlayerCanCollectSource( id )
					if isInfoReady then
						
						local info = C_TransmogCollection.GetSourceInfo( id )
						
						if canCollect then
							
							sourceMe[id] = info
							
						else
							
							local itemInfo = { ArkInventory.CrossClient.GetItemInfoInstant( info.itemID ) }
							
							if itemSubType == itemInfo[7] then
								-- only add sources that match the sub type of the item
								sourceOther[id] = info
							end
							
						end
						
					end
					
				end
				
				
				local collectedMe = false
				local collectedMeFromThisItem = false
				
				if sourceMe[sourceID] then
					
					-- this character can collect this appearance
					-- check if the appearance hasn't been collected
					
					for id, info in pairs( sourceMe ) do
						if info.isCollected then
							collectedMe = true
							if id == sourceID then
								collectedMeFromThisItem = true
							end
						end
					end
					
					if not collectedMe then
						
						--ArkInventory.Output( h, " unknown, learn it" )
						
						-- can be learnt by this character
						return ArkInventory.Const.Transmog.State.CanLearnMyself
						
					end
					
				end
				
				
				local collectedOther = false
				local collectedOtherFromThisItem = false
				
				if sourceOther[sourceID] then
					
					-- cant be learnt by this character, another character may be able to collect it
					
					for id, info in pairs( sourceOther ) do
						if info.isCollected then
							collectedOther = true
							if id == sourceID then
								collectedOtherFromThisItem = true
							end
						end
					end
					
					if not collectedOther then
						
						--ArkInventory.Output( h, " unknown, send to another character" )
						
						-- can be learnt by another character
						return ArkInventory.Const.Transmog.State.CanLearnOther
						
					end
					
				end
				
				--if codex.style.slot.transmogicon.alternative or rule_secondary then
				if ArkInventory.db.option.transmog.secondary or rule_secondary then
					
					if collectedMe and not collectedMeFromThisItem then
						
						--ArkInventory.Output( h, " learnt, from another item" )
						
						-- already known on this character but from another item, learn this one as well?
						return ArkInventory.Const.Transmog.State.CanLearnMyselfSecondary
						
					end
					
					
					if collectedOther and not collectedOtherFromThisItem then
						
						--ArkInventory.Output( h, " learnt, from another item, send to another character" )
						
						-- already known on another character but from another item, learn this one as well?
						return ArkInventory.Const.Transmog.State.CanLearnOtherSecondary
						
					end
					
				end
				
			end
			
		end
		
	end
	
	return false
	
end

function ArkInventory.ItemTransmogStateAccount( itemID )
	
	-- /dump ArkInventory.ItemTransmogStateAccount( 215252 )
	
	if not itemID then return end
	
	if not C_Item or not C_TransmogSets or not C_TransmogCollection then return end
	
	local obj = ArkInventory.Global.Cache.ItemTransmogOwned[itemID]
	if obj == nil then
		
		local setID = C_Item.GetItemLearnTransmogSet( itemID )
		local appearanceAll = nil
		
		if setID then
			
			-- its a transmog set (ensemble)
			
			appearanceAll = C_TransmogSets.GetAllSourceIDs( setID )
			
			local appearancePrimary = C_TransmogSets.GetSetPrimaryAppearances( setID )
			if appearancePrimary then
				
				local isCollected
				local total = ArkInventory.Table.Elements( appearancePrimary )
				local count = 0
				
				-- does the account know all the slot appearances for the set
				for k, v in pairs( appearancePrimary ) do
					isCollected = select( 5, C_TransmogCollection.GetAppearanceSourceInfo( v.appearanceID ) )
					if isCollected then
						count = count + 1
					end
				end
				
				ArkInventory.Global.Cache.ItemTransmogOwned[itemID] = { setTotal = total, setCount = count }
				obj = ArkInventory.Global.Cache.ItemTransmogOwned[itemID]
				
				if count == total then
					obj.isCollected = true
				end
				
			end
			
		else
			
			-- its not a transmog set, check if it has an appearance
			
			local isCollected
			local appearanceID, sourceID = C_TransmogCollection.GetItemInfo( itemID )
			if appearanceID and sourceID then
				
				appearanceAll = C_TransmogCollection.GetAllAppearanceSources( appearanceID )
				
				isCollected = select( 5, C_TransmogCollection.GetAppearanceSourceInfo( sourceID ) )
				
				ArkInventory.Global.Cache.ItemTransmogOwned[itemID] = { isCollected = isCollected, itemKnown = isCollected }
				obj = ArkInventory.Global.Cache.ItemTransmogOwned[itemID]
				
			else
				
				ArkInventory.Global.Cache.ItemTransmogOwned[itemID] = false
				
			end
			
		end
		
		
		if obj then
			
			if appearanceAll then
				
				local total = ArkInventory.Table.Elements( appearanceAll )
				local count = 0
				
				for k, v in pairs( appearanceAll ) do
					local isCollected = select( 5, C_TransmogCollection.GetAppearanceSourceInfo( v ) )
					if isCollected then
						
						count = count + 1
						
						if not setID and not obj.isCollected then
							obj.isCollected = true
						end
						
					end
				end
				
				obj.itemTotal = total
				obj.itemCount = count
				
			end
			
			
			obj.text1 = ArkInventory.Localise["NOT_COLLECTED"]
			obj.colour1 = RED_FONT_COLOR_CODE
			obj.colour2 = RED_FONT_COLOR_CODE
			
			if obj.isCollected then
				
				obj.text1 = ArkInventory.Localise["COLLECTED"]
				
				if obj.setTotal then
					if obj.setTotal == obj.setCount then
						obj.colour1 = GREEN_FONT_COLOR_CODE
					end
				else
					if obj.itemKnown then
						obj.colour1 = GREEN_FONT_COLOR_CODE
						obj.text2 = ArkInventory.Localise["CONFIG_GENERAL_TOOLTIP_TRANSMOG_FROM_THIS_ITEM"]
					else
						obj.colour1 = ORANGE_FONT_COLOR_CODE
						obj.text2 = ArkInventory.Localise["CONFIG_GENERAL_TOOLTIP_TRANSMOG_FROM_THIS_ITEM_NOT"]
					end
				end
				
				if obj.itemTotal == obj.itemCount then
					obj.colour2 = GREEN_FONT_COLOR_CODE
				else
					obj.colour2 = ORANGE_FONT_COLOR_CODE
				end
				
				if obj.text2 then
					obj.text1 = string.format( "%s (%s)", obj.text1, obj.text2 )
				end
				
			end
			
		end
		
	end
	
	
	return ArkInventory.Global.Cache.ItemTransmogOwned[itemID]
	
end

function ArkInventory.Frame_Item_Update_StatusIconTransmog( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.ArkIconTransmog or _G[frame:GetName( ).."ArkIconTransmog"]
	if not obj then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if i and i.h then
		
		local state	= ArkInventory.ItemTransmogStateCharacter( i.h, i.sb, i.loc_id )
		if state then
			
			--ArkInventory.Output( i.h, " state [", state, "]" )
			
			local info = ArkInventory.db.option.transmog.icon[state]
			local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Const.SharedMedia.Type.Transmog, info.style )
			ArkInventory.SetTexture( obj, file, info.colour.r, info.colour.g, info.colour.b, info.colour.a )
			
			ArkInventory.SetAnchorPoint( obj, frame, ArkInventory.db.option.transmog.anchor, ArkInventory.ENUM.ANCHOR.BOTTOMLEFT, 1 )
			
			return
			
		end
		
	end
	
	obj:Hide( )
	
end

function ArkInventory.Frame_Item_Update_Count( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.Count or _G[frame:GetName( ) .. "Count"]
	if not obj then
		--ArkInventory.OutputError( frame:GetName( ), " does not have a Count object" )
		return
	end
	
	--local codex = codex or ArkInventory.Codex.GetLocation( i.loc_id )
	if codex.style.slot.itemcount.show then
		
		frame.count = 0
		
		local i = ArkInventory.Frame_Item_GetDB( frame )
		
		if frame.ARK_Data.isCompressed then
			
			if i then
				
				local stack_id = frame.ARK_Data.stack_id
				local stack = codex.workpad.compress[stack_id]
				if not stack then
					-- this will happen when a non-compressed item ends up in a compressesed empty item slot
					-- transferring between locations, or looting.
					-- just exit out of here and let the full redraw will fix it, otherwise the count flips between the two and looks weird
					return
				end
				
				local count = stack.total
				frame.count = count
				
	--			if count > ( frame.maxDisplayCount or 9999 ) then
	--				count = "***"
	--			end
				
				if codex.style.slot.stack.compress.identify.count.enable then
					if codex.style.slot.stack.compress.identify.count.position == 1 then
						count = "+" .. count
					else
						count = count .. "+"
					end
				end
				
				obj:SetText( count )
				
				local colour = codex.style.slot.itemcount.colour
				obj:SetTextColor( colour.r, colour.g, colour.b )
				
				ArkInventory.MediaObjectFontSet( obj, nil, codex.style.slot.itemcount.font.height )
				
				ArkInventory.SetAnchorPoint( obj, frame, codex.style.slot.itemcount.anchor, ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT, -2, 0 )
				
				obj:Show( )
				
				return
				
			end
			
		else
			
			if i and i.h then
				
				if not codex.style.window.list then
					
					local osd = ArkInventory.ObjectStringDecode( i.h )
					local count = i.count or 0
					frame.count = count
					
					if osd.class == "battlepet" then
						count = osd.level
					end
					
					local more = false
					if codex.style.slot.stack.mode == ArkInventory.Const.Slot.Stack.Mode.Limit then
						if codex.style.slot.stack.limit.enable > 0 and not ArkInventory.Global.Options.ShowHiddenItems then
							local info = ArkInventory.GetObjectInfo( i.h )
							if info.stacksize > 1 then
								local stack_id = frame.ARK_Data.stack_id
								if codex.workpad.stack_limit and codex.workpad.stack_limit[stack_id] and codex.workpad.stack_limit[stack_id].count > codex.style.slot.stack.limit.enable then
									more = true
								end
							end
						end
					end
					
					if osd.class == "battlepet" or count > 1 or more or ( frame.isBag and count > 0 ) then
						
	--					if count > ( frame.maxDisplayCount or 9999 ) then
	--						count = "***"
	--					end
						
						if more and codex.style.slot.stack.limit.identify.count.enable then
							if codex.style.slot.stack.limit.identify.count.position == 1 then
								count = "+" .. count
							else
								count = count .. "+"
							end
						end
						
						obj:SetText( count )
						
						local colour = codex.style.slot.itemcount.colour
						obj:SetTextColor( colour.r, colour.g, colour.b )
						
						ArkInventory.MediaObjectFontSet( obj, nil, codex.style.slot.itemcount.font.height )
						
						ArkInventory.SetAnchorPoint( obj, frame, codex.style.slot.itemcount.anchor, ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT, -2, 0 )
						
						obj:Show( )
						
						return
						
					end
					
				end
				
			end
			
		end
		
	end
	
	obj:Hide( )
	
end

function ArkInventory.Frame_Item_Update_Level( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.ArkLevel
	if not obj then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if i and i.h then
		
		local stock = 0
		local codex = codex or ArkInventory.Codex.GetLocation( i.loc_id )
		
		if codex.style.slot.itemlevel.show then
			
			local info = ArkInventory.GetObjectInfo( i.h, i )
			
			if info.class == "item" then
				
				if frame.ARK_Data.isCompressed then
					
					if codex.style.slot.itemlevel.stock.show and info.equiploc == "" and info.stock > 0 then
						if codex.style.slot.itemlevel.stock.total then
							
							local stack_id = frame.ARK_Data.stack_id
							local stack = codex.workpad.compress[stack_id]
							stock = info.stock * stack.total
						else
							stock = info.stock
						end
					end
					
				else
					
					if codex.style.slot.itemlevel.show then
						
						if ArkInventory.PT_ItemInSets( info.id, "ArkInventory.Internal.ItemsWithCharges" ) then
							
							local pattern = ArkInventory.Localise["WOW_TOOLTIP_ITEM_CHARGES"]
							ArkInventory.TooltipSetFromWindowItem( ArkInventory.Global.Tooltip.Scan, frame.ARK_Data.loc_id, frame.ARK_Data.bag_id, frame.ARK_Data.slot_id )
							stock = ArkInventory.TooltipMatch( ArkInventory.Global.Tooltip.Scan, nil, pattern, false, true, false, 0, ArkInventory.Const.Tooltip.Search.Short )
							stock = ArkInventory.TooltipTextToNumber( stock )
							
						elseif info.equiploc == "" and info.stock > 0 then
							
							if codex.style.slot.itemlevel.stock.total then
								stock = info.stock * i.count
							else
								stock = info.stock
							end
							
							if info.itemtypeid == ArkInventory.ENUM.ITEM.TYPE.CONTAINER.PARENT and not codex.style.slot.itemlevel.bags.show then
								stock = 0
							end
							
						elseif info.equiploc ~= "" then
							
							if codex.style.slot.itemlevel.equip.show and info.ilvl >= codex.style.slot.itemlevel.equip.min then
								stock = info.ilvl
							end
						
						end
						
					end
					
				end
				
			elseif info.class == "keystone" then
				
				stock = info.ilvl
				
			end
			
			if ( stock or 0 ) > 0 then
				
				if stock > ( frame.maxDisplayCount or 9999 ) then
					
					if stock >= 1000000000000 then
						stock = string.format( "%.0f%s", stock / 1000000000000, ArkInventory.Localise["WOW_ITEM_TOOLTIP_10P12S"] )
					elseif stock >= 1000000000 then
						stock = string.format( "%.0f%s", stock / 1000000000, ArkInventory.Localise["WOW_ITEM_TOOLTIP_10P9S"] )
					elseif stock >= 1000000 then
						stock = string.format( "%.0f%s", stock / 1000000, ArkInventory.Localise["WOW_ITEM_TOOLTIP_10P6S"] )
					elseif stock > 9999 then
						stock = string.format( "%.0f%s", stock / 1000, ArkInventory.Localise["WOW_ITEM_TOOLTIP_10P3S"] )
					else
						stock = string.format( "%.0f", stock )
					end
					
				else
					
					stock = string.format( "%.0f", stock )
					
				end
				
				obj:SetText( stock )
				
				if codex.style.slot.itemlevel.quality then
					local colour = { ArkInventory.GetItemQualityColor( info.q ) }
					obj:SetTextColor( colour[1], colour[2], colour[3] )
				else
					local colour = codex.style.slot.itemlevel.colour
					obj:SetTextColor( colour.r, colour.g, colour.b )
				end
				
				ArkInventory.MediaObjectFontSet( obj, nil, codex.style.slot.itemlevel.font.height )
				
				ArkInventory.SetAnchorPoint( obj, frame, codex.style.slot.itemlevel.anchor, ArkInventory.ENUM.ANCHOR.TOPLEFT, 1 )
				
				obj:Show( )
				
				return
				
			end
			
		end
		
	end
	
	obj:Hide( )
	
end

function ArkInventory.Frame_Item_Update_Fade( frame, codex, changer )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	local codex = codex or ArkInventory.Codex.GetLocation( loc_id_window )
	local alpha = 1
	
	local fade = 0.4
	
	if ArkInventory.Global.Location[loc_id_window].isOffline then
		if codex.style.slot.offline.fade then
			alpha = fade
		end
	end
	
--	if not frame.ARK_Data.IsDisplayed then
--		alpha = 0.2
--	end
	
	if changer then
		
		local active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
		if map.panel_id ~= active_map.panel_id then
			alpha = fade
		end
		
		-- when online, the first vault tab wont fade when we have no access unless we specifically fade it here
		if loc_id_window == ArkInventory.Const.Location.Vault then
			if not ArkInventory.Global.Location[loc_id_window].isOffline then
				local canView = select( 3, GetGuildBankTabInfo( bag_id_storage ) )
				if not canView then
					alpha = fade
				end
			end
		end
		
	end
	
	frame:SetAlpha( alpha )
	
end

function ArkInventory.Frame_Item_Update_Border( frame, codex, changer )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	--ArkInventory.Output( frame.ARK_Data.loc_id, ".", frame.ARK_Data.bag_id, ".", frame.ARK_Data.slot_id )
	
	local obj = frame.ArkBorder or _G[frame:GetName( ).."ArkBorder"]
	if obj then
		
		local loc_id_window = frame.ARK_Data.loc_id
		local bag_id_window = frame.ARK_Data.bag_id
		
		--local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
		
		local codex = codex or ArkInventory.Codex.GetLocation( loc_id_window )
		
		if codex.style.slot.border.style ~= ArkInventory.Const.Texture.BorderNone then
			
			local border = codex.style.slot.border.style or ArkInventory.Const.Texture.BorderDefault
			local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BORDER, border )
			local size = codex.style.slot.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size
			local offset = codex.style.slot.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offsetdefault.slot
			local scale = codex.style.slot.border.scale or 1
			local r, g, b, alpha = 1, 1, 1, codex.style.slot.border.alpha or 1
			
			local i = ArkInventory.Frame_Item_GetDB( frame )
			
			
			if codex.style.slot.border.coloured then
				
				local c = codex.style.slot.border.colour[ArkInventory.Const.Slot.Type.Bag]
				r, g, b = c.r, c.g, c.b
				
				if i and i.h then
					
					if codex.style.slot.border.rarity then
						local info = ArkInventory.GetObjectInfo( i.h, i )
						if ( info.q or ArkInventory.ENUM.ITEM.QUALITY.POOR ) >= ( codex.style.slot.border.raritycutoff or ArkInventory.ENUM.ITEM.QUALITY.POOR ) then
							r, g, b = ArkInventory.GetItemQualityColor( info.q or ArkInventory.ENUM.ITEM.QUALITY.POOR )
						end
					end
					
					if frame.locked and not changer then
						alpha = alpha - 0.4
						if alpha < 0 then
							alpha = 0
						end
					end
					
				else
					
					if changer then
						
						r, g, b = ArkInventory.GetItemQualityColor( ArkInventory.ENUM.ITEM.QUALITY.ARTIFACT )
						
					else
						
						local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
						
						local loc_id_storage = map.loc_id_storage
						local bag_id_storage = map.bag_id_storage
						
						local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
						local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
						
						local colour = codex.style.slot.border.colour[bag.type]
						r, g, b = colour.r, colour.g, colour.b
						
					end
					
				end
				
			end
			
			if frame.ARK_Data.isCompressed and codex.style.slot.stack.compress.identify.border.enable then
				r = codex.style.slot.stack.compress.identify.border.colour.r
				g = codex.style.slot.stack.compress.identify.border.colour.g
				b = codex.style.slot.stack.compress.identify.border.colour.b
				alpha = codex.style.slot.stack.compress.identify.border.colour.a
			end
			
			ArkInventory.Frame_Border_Paint( obj, file, size, offset, scale, r, g, b, alpha )
			obj:Show( )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
end

function ArkInventory.Frame_Item_Update_List( frame, show )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.ArkListEntry
	if obj then
		
		if show then
			
			ArkInventory.Frame_Item_Update_Border( obj )
			ArkInventory.Frame_Item_Update_List_Text( obj )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
end

function ArkInventory.Frame_Item_Update_List_Text( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if frame.Text1 and frame.Text2 then
		
		local txt1 = ""
		local txt2 = ""
		local txt3 = ""
		
		if i then
			
			local loc_id = frame.ARK_Data.loc_id
			local osd = ArkInventory.ObjectStringDecode( i.h )
			
			if osd.class == "currency" then
				
				local info = ArkInventory.Collection.Currency.GetByID( osd.id )
				if not info then
					
					txt1 = string.format( "no currency data found for [%s]", osd.id or "nil" )
					
				else
					
					txt1 = info.name
					
					if info.maxQuantity > 0 then
						txt2 = string.format( CURRENCY_TOTAL_CAP, "", FormatLargeNumber( info.quantity ), FormatLargeNumber( info.maxQuantity ) )
					else
						txt2 = string.format( CURRENCY_TOTAL, "", FormatLargeNumber( info.quantity ) )
					end
					
					if info.maxWeeklyQuantity > 0 then
						local weekly = string.format( CURRENCY_WEEKLY_CAP, "", FormatLargeNumber( info.quantityEarnedThisWeek ), FormatLargeNumber( info.maxWeeklyQuantity ) )
						txt2 = string.format( "%s\n%s", weekly, txt2 )
					end
					
				end
				
			elseif osd.class == "reputation" then
				
				local info = ArkInventory.Collection.Reputation.GetByID( osd.id )
				if not info then
					txt1 = string.format( "no reputation data found for [%s]", osd.id or "nil" )
				else
					txt1 = info.name
					txt2 = ArkInventory.Collection.Reputation.LevelText( osd.id, ArkInventory.Const.Reputation.Style.TwoLines )
				end
				
			else
				
				txt1 = ArkInventory.ObjectInfoName( i.h )
				
			end
			
		end
		
		if txt1 == "" then
			frame.Text1:SetText( txt1 )
			frame.Text1:Hide( )
		else
			frame.Text1:SetText( txt1 )
			frame.Text1:Show( )
		end
			
		if txt2 == "" then
			frame.Text2:SetText( txt1 )
			frame.Text2:Hide( )
		else
			frame.Text2:SetText( txt2 )
			frame.Text2:SetTextColor( 1, 1, 1 )
			frame.Text2:Show( )
		end
		
	end
	
end

function ArkInventory.Frame_Item_Update_New( frame, codex, clear )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	
	local bag_id = frame.ARK_Data.bag_id
	local blizzard_id = frame.ARK_Data.blizzard_id
	local slot_id = frame.ARK_Data.slot_id
	
	local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	local isNewItem = false
	local isBattlePayItem = false
	if i and i.h and loc_id == ArkInventory.Const.Location.Bag and not ArkInventory.Global.Location[loc_id].isOffline and not clear then
		isNewItem = ArkInventory.CrossClient.IsNewItem( blizzard_id, slot_id )
		isBattlePayItem = ArkInventory.CrossClient.IsBattlePayItem( blizzard_id, slot_id )
	end
	
	local BattlepayItemTexture = frame.BattlepayItemTexture
	local NewItemTexture = frame.NewItemTexture
	local flashAnim = frame.flashAnim
	local newitemglowAnim = frame.newitemglowAnim
	
	local obj = frame.ArkItemAge
	if obj then
		
		if i and i.h then
			
			if codex.style.slot.age.show then
				
				local cutoff = codex.style.slot.age.cutoff
				local age, age_text = ArkInventory.ItemAgeGet( i.age )
				
				if age and ( cutoff == 0 or age <= cutoff ) then
					
					ArkInventory.SetAnchorPoint( obj, frame, codex.style.slot.age.anchor, ArkInventory.ENUM.ANCHOR.CENTER, 1 )
					
					local colour = codex.style.slot.age.colour
					
					obj:SetText( age_text )
					obj:SetTextColor( colour.r, colour.g, colour.b )
					ArkInventory.MediaObjectFontSet( obj, nil, codex.style.slot.age.font.height )
					obj:Show( )
					
				else
					
					obj:Hide( )
					
					if isNewItem then
						C_NewItems.RemoveNewItem( blizzard_id, slot_id )
					end
					
				end
				
			else
				
				obj:Hide( )
				
			end
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
	if isNewItem then
		
		if isBattlePayItem then
			
			NewItemTexture:Hide( )
			BattlepayItemTexture:Show( )
			
		else
			
			BattlepayItemTexture:Hide( )
			
			if ArkInventory.db.option.newitemglow.enable then
				local c = ArkInventory.db.option.newitemglow.colour
				ArkInventory.SetTexture( frame.NewItemTexture, true, c.r, c.g, c.b, c.a )
				NewItemTexture:Show( )
			else
				NewItemTexture:Hide( )
			end
			
		end
		
		if ArkInventory.db.option.newitemglow.enable and not flashAnim:IsPlaying( ) and not newitemglowAnim:IsPlaying( ) then
			flashAnim:Play( )
			newitemglowAnim:Play( )
		end
		
	else
		
		if flashAnim:IsPlaying( ) or newitemglowAnim:IsPlaying( ) then
			flashAnim:Stop( )
			newitemglowAnim:Stop( )
		end
		
		BattlepayItemTexture:Hide( )
		NewItemTexture:Hide( )
		
	end
	
end


function ArkInventory.Frame_Item_Update_Empty( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if i and not i.h then
		
		local codex = ArkInventory.Codex.GetLocation( loc_id_window )
		local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
		
		local loc_id_storage = map.loc_id_storage
		local bag_id_storage = map.bag_id_storage
		
		if codex.style.slot.background.icon == true then -- FIX ME  move to upgrades 31033.08
			codex.style.slot.background.icon = ArkInventory.Const.SharedMedia.Default.EmptySlot
		end
		
		
		local style = codex.style.slot.background.icon or ArkInventory.Const.SharedMedia.Default.EmptySlot
		
		--ArkInventory.Output( texture )
		if style == ArkInventory.Const.SharedMedia.Name.None then
			
			ArkInventory.SetItemButtonTexture( frame, false )
			
		elseif style == ArkInventory.Const.SharedMedia.Name.Solid then
			
			local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
			local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
			
			local colour = codex.style.slot.background.colour[bag.type]
			colour.a = codex.style.slot.background.alpha
			
			ArkInventory.SetItemButtonTexture( frame, true, colour.r, colour.g, colour.b, colour.a )
			
		else
			
			local texture = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Const.SharedMedia.Type.EmptySlot, style )
			
			if loc_id_window == ArkInventory.Const.Location.Wearing then
				-- use paper doll empty slot icons
				local a, b = GetInventorySlotInfo( ArkInventory.Const.InventorySlotName[i.slot_id] )
				--ArkInventory.Output( "id=[", i.slot_id, "], name=[", ArkInventory.Const.InventorySlotName[i.slot_id], "], texture=[", b, "]" )
				texture = b or texture
			end
			
			ArkInventory.SetItemButtonTexture( frame, texture )
			
		end
		
	end
	
end
	
function ArkInventory.Frame_Item_Empty_Paint_All( )
	
	for loc_id_window in pairs( ArkInventory.Util.MapGetWindow( ) ) do
		for bag_id_window, map in pairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
			
			local loc_id_storage = map.loc_id_storage
			local bag_id_storage = map.bag_id_storage
			
			local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
			local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
			
			for slot_id = 1, bag.count do
				local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id )
				ArkInventory.Frame_Item_Update_Empty( obj )
				ArkInventory.Frame_Item_Update_Border( obj )
			end
			
		end
	end
	
end

function ArkInventory.Frame_Item_UpdateTooltip( frame )
	
	if frame.ARK_Data.isTainted then
		
		if not ArkInventory.db.option.tooltip.show then return end
		
		ArkInventory.GameTooltipSetText( frame, ArkInventory.Localise["BUGFIX_TAINTED_ALERT_MOUSEOVER_DESC"], 1.0, 0.1, 0.1 )
		
		return
		
	elseif frame.ARK_Data.isCompressed then
		
		if not ArkInventory.db.option.tooltip.show then return end
		
		local loc_id_window = frame.ARK_Data.loc_id
		local codex = ArkInventory.Codex.GetLocation( loc_id_window )
		
		if codex.style.slot.stack.compress.tooltip then
			local i = ArkInventory.Frame_Item_GetDB( frame )
			local id = ArkInventory.ObjectIDCount( i.h, i )
			ArkInventory.GameTooltipSetHyperlink( frame, id )
		end
		
		return
		
	end
	
	
	local blizzard_id = frame.ARK_Data.blizzard_id
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	local slot_id = frame.ARK_Data.slot_id
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	
	-- edit mode tooltip
	if ArkInventory.Global.Mode.Edit and IsMouseButtonDown( "LeftButton" ) and not GetCursorInfo( ) then
		
		local processed = false
		local cat_id = ArkInventory.ItemCategoryGet( i )
		local bar_id = ArkInventory.CategoryLocationGet( loc_id_window, cat_id )
		
		ArkInventory.GameTooltipSetText( frame, string.format( ArkInventory.Localise["MENU_BAR_TITLE"], bar_id ) )
		GameTooltip:Show( )
		
		-- is a bar is being dragged
		local state = helper_DragState( loc_id_window, bar_id, ArkInventory.Const.Move.Bar )
		if state == 1 then
			
			GameTooltip:AddLine( string.format( ArkInventory.Localise["FRAME_ONENTER_DRAG_BAR"], ArkInventory.Global.Options.OnDragSourceBar, bar_id ), nil, nil, nil, true )
			
			-- alt: move all categories on bar (OnDragSourceBar) to this bar
			GameTooltip:AddLine( string.format( ArkInventory.Localise["FRAME_ONENTER_DRAG_BAR_ALT"], ArkInventory.Global.Options.OnDragSourceBar, bar_id ), nil, nil, nil, true )
			
			GameTooltip:Show( )
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
			processed = true
			
		elseif state then
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.UnableDrag )
			processed = true
			
		end
		
		-- is a category is being dragged?
		local state = helper_DragState( loc_id_window, bar_id, ArkInventory.Const.Move.Category )
		if state == 1 then
			
			local cat = ArkInventory.Global.Category[ArkInventory.Global.Options.OnDragSourceCategory]
			GameTooltip:AddLine( string.format( ArkInventory.Localise["FRAME_ONENTER_DRAG_CATEGORY"], cat.fullname, bar_id ) )
			
			-- alt: assign the category from this item (look it up) to the item being dropped here (di)
			local i = ArkInventory.Frame_Item_GetDB( frame )
			local cat_id = ArkInventory.ItemCategoryGet( i )
			local cat_type, cat_num = ArkInventory.CategoryIdSplit( cat_id )
			if cat_type ~= ArkInventory.Const.Category.Type.Rule then
				local cat = ArkInventory.Global.Category[cat_id]
				local di = ArkInventory.Frame_Item_GetDB( ArkInventory.Global.Options.OnDragSourceFrame )
				GameTooltip:AddLine( string.format( ArkInventory.Localise["FRAME_ONENTER_DRAG_CATEGORY_ALT"], cat.fullname, di.h ), nil, nil, nil, true )
			end
			
			GameTooltip:Show( )
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
			processed = true
			
		elseif state then
			
			ArkInventory.SetCursor( ArkInventory.Const.Cursor.UnableDrag )
			processed = true
			
		end
		
		if processed == true then return end
		
	end
	
	
	
	if not ArkInventory.db.option.tooltip.show then return end
	
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	
	-- normal item tooltip
	local reset = true
	
	if i and i.h then
		
		ArkInventory.GameTooltipSetPosition( frame )
		
		if ArkInventory.Global.Location[loc_id_window].isOffline then
			
			ArkInventory.GameTooltipSetHyperlink( frame, i.h )
			
		elseif loc_id_window == ArkInventory.Const.Location.Pet then
			
			ArkInventory.TooltipCustomBattlepetShow( GameTooltip, i.h, i )
			CursorUpdate( frame )
			return
			
		elseif loc_id_window == ArkInventory.Const.Location.Toybox then
			
			GameTooltip:SetToyByItemID( i.item )
			CursorUpdate( frame )
			return
			
		elseif loc_id_window == ArkInventory.Const.Location.Heirloom then
			
			GameTooltip:SetHeirloomByItemID( i.item )
			
		elseif loc_id_window == ArkInventory.Const.Location.Currency then
			
			--GameTooltip:SetCurrencyByID( i.id )
			ArkInventory.CrossClient.TooltipSetCurrencyByID( GameTooltip, i.id )
			CursorUpdate( frame )
			return
			
		elseif loc_id_window == ArkInventory.Const.Location.Bag or loc_id_window == ArkInventory.Const.Location.Bank then
			
			local tooltipInfo = ArkInventory.TooltipSetFromStorageItem( GameTooltip, loc_id_storage, bag_id_storage, slot_id, i.h, i )
			
			-- adapted from Interface\FrameXML\ContainerFrame.lua - ContainerFrameItemButton_OnEnter
			
			C_NewItems.RemoveNewItem( blizzard_id, slot_id )
			ArkInventory.Frame_Item_Update_New( frame, nil, true )
			
			local showSell = nil
			
			if tooltipInfo.type == Enum.TooltipDataType.BattlePet then
--			if( tooltipInfo.battlePetSpeciesID and tooltipInfo.battlePetSpeciesID > 0 ) then
				ContainerFrameItemButton_CalculateItemTooltipAnchors( frame, GameTooltip ) -- Battle pet tooltip uses the GameTooltip's anchor
				return BattlePetToolTip_ShowLink( i.h )
--				return BattlePetToolTip_Show( tooltipInfo.battlePetSpeciesID, tooltipInfo.battlePetLevel, tooltipInfo.battlePetBreedQuality, tooltipInfo.battlePetMaxHealth, tooltipInfo.battlePetPower, tooltipInfo.battlePetSpeed, tooltipInfo.battlePetName )
			else
				if BattlePetTooltip then
					BattlePetTooltip:Hide( )
				end
			end
			
			if IsModifiedClick("COMPAREITEMS") or ArkInventory.CrossClient.GetCVarBool( "alwaysCompareItems" ) then
				GameTooltip_ShowCompareItem( GameTooltip )
			end
			
			if InRepairMode( ) and ( tooltipInfo.repairCost and tooltipInfo.repairCost > 0 ) then
				GameTooltip:AddLine( REPAIR_COST, nil, nil, nil, true )
				SetTooltipMoney( GameTooltip, tooltipInfo.repairCost )
				GameTooltip:Show( )
			elseif MerchantFrame:IsShown( ) and MerchantFrame.selectedTab == 1 then
				showSell = 1
			end
			
			if IsModifiedClick( "DRESSUP" ) then
				ShowInspectCursor( )
			elseif ( showSell ) then
				ArkInventory.CrossClient.ShowContainerSellCursor( blizzard_id, slot_id )
			elseif ( frame.readable ) then
				ShowInspectCursor( )
			else
				ResetCursor( )
			end
			
			if ArtifactFrame then
				ArtifactFrame:OnInventoryItemMouseEnter( blizzard_id, slot_id )
			end
			
			reset = false
			
		elseif loc_id_window == ArkInventory.Const.Location.Keyring then
			
			-- adapted from Interface\FrameXML\ContainerFrame.lua - ContainerFrameItemButton_OnEnter
			
			local inv_id = ArkInventory.CrossClient.KeyRingButtonIDToInvSlotID( slot_id )
			GameTooltip:SetInventoryItem( "player", inv_id )
			CursorUpdate( frame )
			
			return
			
		else
			
			ArkInventory.GameTooltipSetHyperlink( frame, i.h )
			
		end
		
		if ArkInventory.Global.Mode.Edit then
			
			ResetCursor( )
			
		elseif IsModifiedClick( "DRESSUP" ) then
			
			ShowInspectCursor( )
			
		elseif IsModifiedClick( "COMPAREITEMS" ) or ArkInventory.CrossClient.GetCVarBool( "alwaysCompareItems" ) then
			
			GameTooltip_ShowCompareItem( )
			
		elseif reset then
			
			ArkInventory.SetCursor( )
			
		end
		
	else
		
		GameTooltip:Hide( )
		ArkInventory.SetCursor( )
		
	end
	
	
end

function ArkInventory.Frame_Item_Update_ContextMatchResult( frame )
	
	-- process ItemButtonUtil.Event.ItemContextChanged here
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	
	if ArkInventory.Global.Location[loc_id_window].isOffline then
		return ItemButtonUtil.ItemContextMatchResult.DoesNotApply
	end
	
	local blizzard_id = frame.ARK_Data.blizzard_id
	local slot_id = frame.ARK_Data.slot_id
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local result
	
	
	if loc_id_window == ArkInventory.Const.Location.Bag then
		
		local itemLocation = ItemLocation:CreateFromBagAndSlot( blizzard_id, slot_id )
		if C_Item.DoesItemExist( itemLocation ) then
			
			result = ItemButtonUtil.GetItemContextMatchResultForItem( itemLocation )
			if result ~= ItemButtonUtil.ItemContextMatchResult.Match then
				
				if ArkInventory.Global.Mode.Bank then
					
					local active_map = ArkInventory.Util.getWindowActiveMap( ArkInventory.Const.Location.Bank )
					
					if active_map.loc_id_storage == ArkInventory.Const.Location.AccountBank then
						
						if not C_Bank.IsItemAllowedInBankType( ArkInventory.ENUM.BANKTYPE.ACCOUNT, itemLocation ) then
							result = ItemButtonUtil.ItemContextMatchResult.Mismatch
						end
						
					elseif active_map.loc_id_storage == ArkInventory.Const.Location.ReagentBank then
						
						local i = ArkInventory.Frame_Item_GetDB( frame )
						local info = ArkInventory.GetObjectInfo( i.h, i )
						if not ArkInventory.CrossClient.IsReagentBankUnlocked( ) or not info.craft then
							result = ItemButtonUtil.ItemContextMatchResult.Mismatch
						end
						
					end
					
				elseif ArkInventory.Global.Mode.Vault and ArkInventory.isLocationControlled( ArkInventory.Const.Location.Vault ) then
					
--					if not C_Bank.IsItemAllowedInBankType( ArkInventory.ENUM.BANKTYPE.GUILD, itemLocation ) then
--						result = ItemButtonUtil.ItemContextMatchResult.Mismatch
--					end
					
				end
			
			end
		
		end
		
	end
	
	if loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.AccountBank then
		
		local active_map = ArkInventory.Util.getWindowActiveMap( ArkInventory.Const.Location.Bank )
		
		if active_map.loc_id_storage ~= ArkInventory.Const.Location.AccountBank then
			result = ItemButtonUtil.ItemContextMatchResult.Mismatch
		end
		
	end
	
	
--[[
	-- add location search filter context result
	if result ~= ItemButtonUtil.ItemContextMatchResult.Match then
		
		local f = ArkInventory.Search.CleanText( string.trim( string.lower( ArkInventory.Global.Location[loc_id_window].filter or "" ) ) )
		if f ~= "" then
			
			local i = ArkInventory.Frame_Item_GetDB( frame )
			if i then
				
				if i.h then
					local txt = ArkInventory.Search.GetContent( i.h )
					if not string.find( txt, f, nil, true ) then
						result = ItemButtonUtil.ItemContextMatchResult.Mismatch
					end
				else
					--result = ItemButtonUtil.ItemContextMatchResult.Mismatch
				end
				
			end
			
		end
		
	end
]]--
	
	
	
	return result or ItemButtonUtil.ItemContextMatchResult.Match --DoesNotApply
	
end

function ArkInventory.Frame_Item_OnEnter( frame )
	
	ArkInventory.Frame_Item_UpdateTooltip( frame )
	
--	local loc_id = frame.ARK_Data.loc_id
--	local bag_id = frame.ARK_Data.bag_id
--	local slot_id = frame.ARK_Data.slot_id
	
	--ArkInventory.Output( "on enter [", loc_id, "] [", bag_id, "] [", slot_id, "] ", frame:GetName( ) )
	
	if frame.ARK_Data.isTainted then
		
		-- do nothing
		
	elseif frame.ARK_Data.ItemFrameType == ArkInventory.Const.ItemFrameType.Popup then
		
		ArkInventory.Frame_Bar_Popup_SetTimer( )
		
	else
		
		if frame.ARK_Data.isCompressed then
			
			ArkInventory.Frame_Bar_Popup_Show( frame )
			
		else
			
			ArkInventory.Frame_Bar_Popup_SetTimer( nil, true )
			
		end
		
	end
	
end

function ArkInventory.Frame_Item_OnLeave( frame )
	
	local loc_id = frame.ARK_Data.loc_id
--	local bag_id = frame.ARK_Data.bag_id
--	local slot_id = frame.ARK_Data.slot_id
	
	GameTooltip:Hide( )
	
	if BattlePetTooltip then
		BattlePetTooltip:Hide( )
	end
	
	--ArkInventory.Output( "on leave [", loc_id, "] [", bag_id, "] [", slot_id, "] ", frame:GetName( ) )
	
	if frame.ARK_Data.isCompressed then
		
		ArkInventory.Frame_Bar_Popup_SetTimer( nil, true )
		return
		
	else
		
		if ArkInventory.Global.Mode.Edit and IsMouseButtonDown( "LeftButton" ) and not GetCursorInfo( ) then
			
			local i = ArkInventory.Frame_Item_GetDB( frame )
			local cat_id = ArkInventory.ItemCategoryGet( i )
			local bar_id = ArkInventory.CategoryLocationGet( loc_id, cat_id )
			
			-- is a bar is being dragged
			local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Bar )
			if state then
				ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
			end
			
			-- is a category is being dragged?
			local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Category )
			if state  then
				ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
			end
			
		else
			
			ResetCursor( )
			
		end
		
	end
	
end

function ArkInventory.Frame_Item_PreClick( frame, button, down )
	
	-- note - the only way to abort blizzard handling the item is to move it yourself so if that fails for any reason then blizzard will process it no matter what
	
	-- FIX ME - do something with the down click to make sure were abiding by the cvar
	
	if InCombatLockdown( ) then return end
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	local blizzard_id = frame.ARK_Data.blizzard_id
	local slot_id = frame.ARK_Data.slot_id
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	
	
	if not ArkInventory.Global.Mode.Edit then
		
		if button == "LeftButton" then
			local i = ArkInventory.Frame_Item_GetDB( frame )
			if i.h then
				-- DressUpLink( i.h )
				
								
				--ArkInventory.Output( "[", DressUpItemLink( i.h ), "]" )
				--ArkInventory.Output( "[", C_Item.IsDressableItemByID( i.h ), "]" )
				--ArkInventory.Output( "[", C_Item.GetItemLearnTransmogSet( i.h ), "]" )
			end
		end
		
		
		if button == "RightButton" then
			
			if loc_id_window == ArkInventory.Const.Location.Bag then
				
				-- only doing pre-click for items in your bags
				
				--ArkInventory.Output( "PreClick: start" )
				
				local i = ArkInventory.Frame_Item_GetDB( frame )
				if i.h then
					
					if not IsModifiedClick( ) then
					
						if ArkInventory.Global.Mode.Bank then
							
							local active_map = ArkInventory.Util.getWindowActiveMap( ArkInventory.Const.Location.Bank )
							
							if active_map.loc_id_storage == ArkInventory.Const.Location.AccountBank then
								-- account bank is selected, send it to the active tab
								
								if ArkInventory.CrossClient.GetContainerNumFreeSlots( active_map.blizzard_id ) > 0 then
									
									local itemLocation = ItemLocation:CreateFromBagAndSlot( blizzard_id, slot_id )
									if C_Item.DoesItemExist( itemLocation ) then
										
										local ok = C_Bank.IsItemAllowedInBankType( ArkInventory.ENUM.BANKTYPE.ACCOUNT, itemLocation )
										
										if ok then
											--ArkInventory.Output( "PreClick: atempting to move item to account bank tab ", active_map.bag_id_storage )
											ArkInventory.CrossClient.PickupContainerItem( blizzard_id, slot_id )
											ArkInventory.CrossClient.PutItemInAccountBank( active_map.blizzard_id )
										end
										
									else
										
										return
										
									end
									
								end
								
								return
								
							end
							
							
							if active_map.loc_id_storage == ArkInventory.Const.Location.Bank and codex.player.data.panel.bank.combine.reagent and ArkInventory.CrossClient.IsReagentBankUnlocked( ) and ArkInventory.CrossClient.GetContainerNumFreeSlots( ArkInventory.ENUM.BAG.INDEX.REAGENTBANK ) > 0 then
								-- bank is selected, panel is combined reagent bank, reagent bank is unlocked, reagent bank has a free slot, send it to the reagent bank if its a crafting mat
								
								local info = ArkInventory.GetObjectInfo( i.h, i )
								if info.craft then
									
									--ArkInventory.Output( "PreClick: atempting to move item to reagent bank" )
									ArkInventory.CrossClient.PutItemInReagentBank( blizzard_id, slot_id )
									
									return
									
								end
								
							end
							
							
							
						end
						
						if ArkInventory.Global.Mode.Vault then
							
							--ArkInventory.Output( "PreClick: atempting to move item to guild bank" )
							--ArkInventory.CrossClient.PickupContainerItem( blizzard_id, slot_id )
							--ArkInventory.CrossClient.PutItemInGuildBank( )
							
							--return
							
						end
						
					end
					
					-- delete item
					if IsShiftKeyDown( ) or ( ArkInventory.Global.Mode.Merchant and not IsModifiedClick( ) ) then
						
						if not ArkInventory.Action.Delete.data.conflict and ArkInventory.db.option.action.delete.enable then
							
							if ArkInventory.Action.Delete.Check( frame.ARK_Data.blizzard_id, frame.ARK_Data.slot_id, codex ) then
								
								--ArkInventory.Output( "PreClick-Control: deleting item ", i.h )
								
								if not ArkInventory.db.option.action.delete.test then
									ArkInventory.CrossClient.PickupContainerItem( frame.ARK_Data.blizzard_id, frame.ARK_Data.slot_id )
									DeleteCursorItem( )
								end
								
								local test = ""
								if ArkInventory.db.option.action.delete.test then
									test = string.format( "(%s)", ArkInventory.Localise["CONFIG_ACTION_TESTING"] )
								end
								
								if ArkInventory.db.option.action.delete.list then
									local itemInfo = ArkInventory.CrossClient.GetContainerItemInfo( frame.ARK_Data.blizzard_id, frame.ARK_Data.slot_id )
									--ArkInventory.Output( "itemInfo = ", itemInfo )
									ArkInventory.Output( string.format( ArkInventory.Localise["CONFIG_ACTION_DELETE_LIST"], test, i.h, itemInfo.stackCount ) )
								end
								
								return
								
							end
							
						end
						
					end
					
				end
				
				--ArkInventory.Output( "PreClick: ignored item ", i.h )
				
			end
			
		end
	end
	
end

function ArkInventory.Frame_Item_PostClick( frame, button, down )
	
	if true then return end
	
	
	if InCombatLockdown( ) then return end
	
	if not ArkInventory.Global.Mode.Edit then
		
		if frame.ARK_Data.loc_id == ArkInventory.Const.Location.Bag then
			
			if button == "RightButton" and IsControlKeyDown( ) then
				
				-- these only work when there is an item, it is in the backpack, and its an unmodified right click
				
				--ArkInventory.Output( "PreClick: start" )
				
				local i = ArkInventory.Frame_Item_GetDB( frame )
				if i.h then
					
					local info = ArkInventory.GetObjectInfo( i.h, i )
					
					
					
					if ItemSocketingFrame and ItemSocketingFrame:IsShown( ) then
						
						-- is this a socketable gem
						-- is there an open socket
						-- pick up the item
						-- insert it into the socket
						
						--ArkInventory.Output( "PostClick: moving ", i.h, " to open socket" )
						
					end
					
					
					--ArkInventory.Output( "PostClick: ignored item ", i.h )
					
				end
			end
		end
	end
	
end

function ArkInventory.Frame_Item_OnMouseUp( frame, button )
	
	if ArkInventory.Global.Mode.Edit then
		ArkInventory.MenuItemOpen( frame )
		return
	end
	
	--ArkInventory.Output( frame:GetName( ), " on mouse up [", frame.ARK_Data, "]" )
	
	if frame.ARK_Data.ItemFrameType ~= ArkInventory.Const.ItemFrameType.Popup then
		
		if frame.ARK_Data.isCompressed then
			--ArkInventory.Output( "on mouse up - frameitem" )
			ArkInventory.Frame_Bar_Popup_Toggle( frame )
		else
			ArkInventory.Frame_Bar_Popup_Hide( )
		end
		
	end
	
	local loc_id = frame.ARK_Data.loc_id
	local bag_id = frame.ARK_Data.bag_id
	local slot_id = frame.ARK_Data.slot_id
	
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if not i then return end
	
	if ArkInventory.Global.Location[loc_id].isOffline or frame.ARK_Data.isTainted then
		
		if HandleModifiedItemClick( i.h ) then return end
		
		-- must be online or untainted to continue
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Bag then
		
		-- already handled in onclick
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Keyring then
		return ContainerFrameItemButton_OnClick( frame, button )
	end
	
	
	if loc_id == ArkInventory.Const.Location.Bank then
		
		-- already handled in onclick
		return
		
	end
	
	
	if HandleModifiedItemClick( i.h ) then return end
	
	
	if loc_id == ArkInventory.Const.Location.Vault then
		
		if not ArkInventory.Global.Mode.Vault then
			-- must be at the vault to continue
			return
		end
		
		local tab_id = frame.ARK_Data.bag_id
		local slot_id = frame.ARK_Data.slot_id
		
		if IsModifiedClick( "SPLITSTACK" ) then
			
			if not CursorHasItem( ) then
				if i.count > 1 and not frame.locked then
					if StackSplitFrame.OpenStackSplitFrame then
						-- Retail
						StackSplitFrame:OpenStackSplitFrame( i.count, frame, "BOTTOMLEFT", "TOPLEFT" )
					else
						-- TBC
						OpenStackSplitFrame( i.count, frame, "BOTTOMLEFT", "TOPLEFT" )
					end
				end
			end
			
			return
			
		end
		
		local infoType, info1, info2 = GetCursorInfo( )
		if infoType == "money" then
			DepositGuildBankMoney( info1 )
			ClearCursor( )
		elseif infoType == "guildbankmoney" then
			DropCursorMoney( )
			ClearCursor( )
		else
			if button == "RightButton" then
				AutoStoreGuildBankItem( tab_id, slot_id )
			else
				ArkInventory.CrossClient.PickupGuildBankItem( tab_id, slot_id )
			end
		end
		
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Mailbox then
		
		if not ArkInventory.Global.Mode.Mailbox then
			-- must be at the mailbox to continue
			return
		end
		
		if button == "RightButton" then
			if i.msg_id and i.money then
				TakeInboxMoney( i.msg_id )
			elseif i.msg_id and i.att_id then
				TakeInboxItem( i.msg_id, i.att_id )
			end
		end
		
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Wearing then
		
		-- nothing to do
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Pet then
		
		if i.guid then
			
			if button == "LeftButton" then
				
				ArkInventory.Collection.Pet.Summon( i.guid )
				
			elseif button == "RightButton" then
				
				ArkInventory.MenuItemPetJournal( frame, i.guid )
				
			end
			
		end
		
		ClearCursor( )
		
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Mount then
		
		if i.index then
			
			if button == "LeftButton" then
				
				local md = ArkInventory.Collection.Mount.GetMount( i.index )
				
				if md.active then
					ArkInventory.Collection.Mount.Dismiss( )
				elseif ArkInventory.Collection.Mount.isUsable( md.index ) then
					ArkInventory.Collection.Mount.Summon( i.index )
				end
				
			elseif button == "RightButton" then
				
				ArkInventory.MenuItemMountJournal( frame, i.index )
				
			end
			
		end
		
		ClearCursor( )
		
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Currency then
		
		if button == "RightButton" then
			return ArkInventory.MenuCurrencyItemOpen( frame )
		end
		
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Auction then
		
		-- nothing to do
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Toybox then
		
		if button == "LeftButton" then
			
			--ArkInventory.Collection.Toybox.Summon( i.index )
			ArkInventory.OutputWarning( "Toys can no longer be summoned by addon code. Please drag the ", i.h, " toy to your action bar to use" )
			
		elseif button == "RightButton" then
			
			--ArkInventory.MenuItemToybox( frame, i.index ) !!! to be done
			
		end
		
		ClearCursor( )
		
		return
		
	end
	
	
	if loc_id == ArkInventory.Const.Location.Heirloom then
		
		if button == "LeftButton" then
			
			--C_Heirloom.CreateHeirloom( i.item ) -- secure action, cant be done
			
		elseif button == "RightButton" then
			
			--ArkInventory.MenuItemHeirloom( frame, i.index ) !!! to be done
			
		end
		
		ClearCursor( )
		
		return
		
	end
	
	
	--ArkInventory.Output( button, " click not handled" )
	
end

function ArkInventory.Frame_Item_OnDragStart( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	local usedmycode = false
	
	if ArkInventory.Global.Mode.Edit then
		
		usedmycode = true
		
--		local i = ArkInventory.Frame_Item_GetDB( frame )
--		local cat_id = ArkInventory.ItemCategoryGet( i )
--		local bar_id = ArkInventory.CategoryLocationGet( loc_id, cat_id )
		
		ArkInventory.EditModeOnDragSet( ArkInventory.Const.Move.Category, frame )
		
		ArkInventory.SetCursor( ArkInventory.Const.Cursor.Drag )
		
	elseif SpellIsTargeting( ) or ArkInventory.Global.Location[loc_id].isOffline then
		
		usedmycode = true
		-- do not drag / drag disabled
		
		ArkInventory.SetCursor( )
		
	end
	
	if not usedmycode then
		ContainerFrameItemButton_OnClick( frame, "LeftButton" )
	end
	
end

function ArkInventory.Frame_Item_OnReceiveDrag( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	local usedmycode = false
	
	if ArkInventory.Global.Mode.Edit then
		
		if ArkInventory.EditModeIsDragging( ) then
			
			usedmycode = true
			
			local i = ArkInventory.Frame_Item_GetDB( frame )
			local cat_id = ArkInventory.ItemCategoryGet( i )
			local bar_id = math.abs( ArkInventory.CategoryLocationGet( loc_id, cat_id ) )
			
			-- drop bar here?
			local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Bar )
			if IsAltKeyDown( ) then
				
				-- alt: move all categories on bar (OnDragSourceBar) to this bar (bar_id)
				if state == 1 then
					
					local cat_tbl = ArkInventory.CategoryBarGetAssigned( loc_id, ArkInventory.Global.Options.OnDragSourceBar )
					if cat_tbl then
						
						for cat_id in pairs( cat_tbl ) do
							ArkInventory.CategoryLocationSet( loc_id, cat_id, bar_id )
						end
						
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						
					end
					
				else
					--ArkInventory.OutputWarning( "category assignment aborted, its already on this bar" )
				end
				
			else
				
				-- normal: move dragged bar (OnDragSourceBar) in front of this one (bar_id)
				if state == 1 then
					ArkInventory.Frame_Bar_Move( loc_id, ArkInventory.Global.Options.OnDragSourceBar, bar_id )
					ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
					--ArkInventory.OutputDebug( "dropped bar ", bar_id, " here" )
				elseif state == 2 then
					--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_SAME"], ArkInventory.Localise["MENU_BAR"] ) )
				elseif state == 3 then
					--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_OUTSIDE"], ArkInventory.Localise["MENU_BAR"] ) )
				end
				
			end
			
			
			-- drop category here?
			local state = helper_DragState( loc_id, bar_id, ArkInventory.Const.Move.Category )
			if IsAltKeyDown( ) then
				
				-- alt: assign the category from this item (look it up) to the item being dropped here (di)
				if state == 1 then
					-- check destination category is not a RULE
					local cat_type, cat_num = ArkInventory.CategoryIdSplit( cat_id )
						if cat_type ~= ArkInventory.Const.Category.Type.Rule then
						local di = ArkInventory.Frame_Item_GetDB( ArkInventory.Global.Options.OnDragSourceFrame )
						ArkInventory.ItemCategorySet( di, cat_id )
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						--ArkInventory.OutputDebug( "assigned ", cat_id, " to ", di.h )
					else
						--ArkInventory.OutputWarning( "category assignment aborted, destination is not a custom category" )
					end
					
				else
					--ArkInventory.OutputWarning( "category assignment aborted, its already on this bar" )
				end
				
			else
				
				-- normal: drop category (OnDragSourceCategory) from bar (OnDragSourceBar) to here (bar_id)?
				if state == 1 then
					ArkInventory.CategoryLocationSet( loc_id, ArkInventory.Global.Options.OnDragSourceCategory, bar_id )
					ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
					--ArkInventory.OutputDebug( "dropped category ", ArkInventory.Global.Options.OnDragSourceCategory, " here" )
				elseif state == 2 then
					--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_SAME"], ArkInventory.Localise["CATEGORY"] ) )
				elseif state == 3 then
					--ArkInventory.OutputWarning( string.format( ArkInventory.Localise["MENU_MOVE_FAIL_OUTSIDE"], ArkInventory.Localise["CATEGORY"] ) )
				end
				
			end
			
			ArkInventory.EditModeOnDragSet( )
			ArkInventory.SetCursor( )
			ArkInventory.Frame_Item_OnEnter( frame )
			
		end
		
	elseif SpellIsTargeting( ) or ArkInventory.Global.Location[loc_id].isOffline then
		
		-- do not drag / drag disabled
		usedmycode = true
		
		ArkInventory.SetCursor( )
		
	end
	
	if not usedmycode then
		ContainerFrameItemButton_OnClick( frame, "LeftButton" )
	end
	
end

function ArkInventory.Frame_Item_Update_Cooldown( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.Cooldown or _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Cooldown.Name )]
	if not obj then return end
	
	local blizzard_id = frame.ARK_Data.blizzard_id
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	local slot_id = frame.ARK_Data.slot_id
	
	if ArkInventory.Global.Location[loc_id_window].isOffline then
		obj:Hide( )
		return
	end
	
	local codex = codex or ArkInventory.Codex.GetLocation( loc_id_window )
	if not codex.style.slot.cooldown.show then
		obj:Hide( )
		return
	end
	
	-- do not use cached data here, more than likely the scan will lag behind
	
	-- source: Interface\FrameXML\Cooldown.lua CooldownFrame_Set
	local enable, start, duration
	
	if loc_id_window == ArkInventory.Const.Location.Toybox then
		local i = ArkInventory.Frame_Item_GetDB( frame )
		if i and i.item then
			start, duration, enable = ArkInventory.CrossClient.GetItemCooldown( i.item )
			--ArkInventory.Output( "toybox cooldown: ", obj:GetName( ) )
		end
	elseif loc_id_window == ArkInventory.Const.Location.Wearing then
		local inv_id = ArkInventory.Util.getInventoryIDFromWindow( loc_id_window, bag_id_window, slot_id )
		start, duration, enable = GetInventoryItemCooldown( "player", inv_id )
	else
		start, duration, enable = ArkInventory.CrossClient.GetContainerItemCooldown( blizzard_id, slot_id )
	end
	
	enable = enable or 0
	start = start or 0
	duration = duration or 0
	
	if enable ~= 0 and start > 0 and duration > 0 then
		--ArkInventory.Output( "loc [", loc_id_window, "]  bag [", bag_id_window, "]  slot [", slot_id, "]  enable [", enable, "]  start [", start, "]  duration [", duration, "]" )
		obj:SetDrawEdge( codex.style.slot.cooldown.edge )
		obj:SetCooldown( start, duration )
	else
		obj:Hide( )
	end
	
end

function ArkInventory.Frame_Item_Update_Lock( frame, codex, changer )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	local bag_id = frame.ARK_Data.bag_id
	local locked = false
	
	if frame.ARK_Data.isCompressed then
		
		local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
		if codex.style.slot.stack.compress.identify.desaturate.enable then
			locked = true
		end
		
	else
		
		if ArkInventory.Global.Mode.Edit or ArkInventory.Global.Location[loc_id].isOffline then
			
		else
			
			local i = ArkInventory.Frame_Item_GetDB( frame )
			
			if i and i.h then
				
				local map = ArkInventory.Util.MapGetWindow( loc_id, bag_id )
				--local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
				
				if loc_id == ArkInventory.Const.Location.Vault then
					local itemInfo = ArkInventory.CrossClient.GetGuildBankItemInfo( frame.ARK_Data.bag_id, frame.ARK_Data.slot_id )
					locked = itemInfo.isLocked
				elseif changer then
					if map.inv_id then
						locked = IsInventoryItemLocked( map.inv_id )
					end
					--ArkInventory.Output( "locked [", frame.ARK_Data.inv_id, "] = ", locked )
				else
					local info = ArkInventory.CrossClient.GetContainerItemInfo( map.blizzard_id, frame.ARK_Data.slot_id )
					locked = info.isLocked
					--ArkInventory.Output( "locked [", loc_id, "] [", i.bag_id, "] [", i.slot_id, "] = ", info )
				end
				
			end
			
		end
		
	end
	
	ArkInventory.SetItemButtonDesaturate( frame, locked )
	
	frame.locked = locked
	
end

function ArkInventory.Frame_Item_Update_Tint( frame, codex )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local obj = frame.ArkTint or _G[frame:GetName( ).."ArkTint"]
	if not obj then return end
	
	local loc_id = frame.ARK_Data.loc_id
	if ArkInventory.Global.Mode.Edit or ArkInventory.Global.Location[loc_id].isOffline then
		obj:Hide( )
		return
	end
	
	local tinted = false
	local codex = codex or ArkInventory.Codex.GetLocation( loc_id )
	
	if codex.style.slot.unusable.tint then
		local i = ArkInventory.Frame_Item_GetDB( frame )
		tinted = ArkInventory.GetItemTinted( i, codex )
	end
	
	if tinted then
		obj:Show( )
	else
		obj:Hide( )
	end
	
end

function ArkInventory.Frame_Item_Update_PetJournal( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if frame.favorite then
		
		if i and i.guid then
			
			frame.active:SetShown( i.guid == ArkInventory.Collection.Pet.GetCurrent( ) )
			frame.slotted:SetShown( ArkInventory.Collection.Pet.IsSlotted( i.guid ) )
			frame.dead:SetShown( ( ArkInventory.Collection.Pet.GetStats( i.guid ) or 1 ) <= 0 )
			frame.favorite:SetShown( i.fav )
			
		else
			
			frame.active:Hide( )
			frame.slotted:Hide( )
			frame.dead:Hide( )
			frame.favorite:Hide( )
			
		end
		
	end
	
end

function ArkInventory.Frame_Item_Update_MountJournal( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if frame.favorite then
		if i then
			frame.favorite:SetShown( i.fav )
		else
			frame.favorite:Hide( )
		end
	end
	
end

function ArkInventory.Frame_Item_Update_Toybox( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if frame.favorite then
		if i then
			frame.favorite:SetShown( i.fav )
		else
			frame.favorite:Hide( )
		end
	end
	
end

function ArkInventory.Frame_Item_Update_Heirloom( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if i then
		
		
		
	else
		
		
		
	end
	
end

function ArkInventory.Frame_Item_Update_Clickable( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	local click = true
	
	if ArkInventory.Global.Mode.Edit or ArkInventory.Global.Location[loc_id].isOffline then
		
		click = false
		
	elseif frame.ARK_Data.isCompressed then
		
		click = false
		
	else
		
		if loc_id == ArkInventory.Const.Location.Vault then
			
			local bag_id = frame.ARK_Data.bag_id
			local _, _, _, canDeposit, numWithdrawals = GetGuildBankTabInfo( bag_id )
			if ( not canDeposit ) and ( numWithdrawals == 0 ) then
				click = false
			end
			
		end
		
	end
	
	
	if click then
		frame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" )
		--frame:RegisterForDrag( "LeftButton" )
	else
		-- disable clicks/drag when in edit mode or offline
		frame:RegisterForClicks( )
		--frame:RegisterForDrag( )
	end
	
end

function ArkInventory.Frame_Item_OnDragStart_PetJournal( frame )
	
	if ArkInventory.Global.Mode.Edit then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if i and i.guid then
		
		ArkInventory.Collection.Pet.PickupPet( i.guid, true )
		
		if PetJournal:IsVisible( ) then
			PetJournal_UpdatePetLoadOut( )
		end

	end
	
end

function ArkInventory.Frame_Item_OnDragStart_Toybox( frame )
	
	if ArkInventory.Global.Mode.Edit then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if i and i.item then
		
		C_ToyBox.PickupToyBoxItem( i.item )
		
	end
	
end

function ArkInventory.Frame_Item_OnDragStart_Heirloom( frame )
	
	if ArkInventory.Global.Mode.Edit then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	
	if i and i.h then
		
		
		
	end
	
end

function ArkInventory.Frame_Item_OnDragStart_MountJournal( frame )
	
	if ArkInventory.Global.Mode.Edit then return end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	if i and i.slot_id then
		PickupCompanion( "MOUNT", i.slot_id )
	end
	
end

function ArkInventory.Frame_Item_Update( loc_id, bag_id, slot_id, lockevent )
	local id = ArkInventory.LocationEncode( loc_id, bag_id, slot_id )
	--ArkInventory.Output( "add: ", loc_id, "-", bag_id, "-", slot_id )
	ArkInventory:SendMessage( "EVENT_ARKINV_ITEM_UPDATE_BUCKET", id )
end

function ArkInventory.Frame_Item_Update_Instant( loc_id, bag_id, slot_id, ItemFrameType, lockevent )
	
--	if ItemFrameType == ArkInventory.Const.ItemFrameType.Popup then
--		ArkInventory.Output( "Frame_Item_Update_Instant [", loc_id, "] [", bag_id, "] [", slot_id, "] [", ItemFrameType, "] [", lockevent, "]" )
--	end
	
	local framename, frame = ArkInventory.ContainerItemNameGet( loc_id, bag_id, slot_id, ItemFrameType )
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	ArkInventory.Frame_Item_Update_Lock( frame, codex, false )
	
	ArkInventory.Frame_Item_Update_Border( frame, codex )
	
	ArkInventory.Frame_Item_Update_Texture( frame, codex )
	
	ArkInventory.Frame_Item_Update_Overlays( frame, codex )
	
	ArkInventory.Frame_Item_Update_Count( frame, codex )
	ArkInventory.Frame_Item_Update_Level( frame, codex )
	
	ArkInventory.Frame_Item_Update_StatusIconQuest( frame, codex )
	ArkInventory.Frame_Item_Update_StatusIconUpgrade( frame, codex )
	ArkInventory.Frame_Item_Update_StatusIconJunk( frame, codex )
	ArkInventory.Frame_Item_Update_StatusIconCorrupted( frame, codex )
	ArkInventory.Frame_Item_Update_StatusIconProfessionRank( frame, codex )
	ArkInventory.Frame_Item_Update_StatusIconTransmog( frame )
	
	ArkInventory.Frame_Item_Update_Tint( frame, codex )
	
	ArkInventory.Frame_Item_Update_Fade( frame, codex, false )
	
	
	if loc_id == ArkInventory.Const.Location.Pet then
		ArkInventory.Frame_Item_Update_PetJournal( frame )
	end
	
	if loc_id == ArkInventory.Const.Location.Toybox then
		ArkInventory.Frame_Item_Update_Toybox( frame )
	end
	
	if loc_id == ArkInventory.Const.Location.Heirloom then
		ArkInventory.Frame_Item_Update_Heirloom( frame )
	end
	
	ArkInventory.Frame_Item_Update_List( frame, codex.style.window.list )
	
	ArkInventory.Frame_Item_Update_Cooldown( frame, codex )
	
	if frame == GameTooltip:GetOwner( ) then
		if frame.UpdateTooltip then
			frame.UpdateTooltip( frame )
		end
	end
	
	
	
	ArkInventory.API.ItemFrameUpdated( frame, loc_id, bag_id, slot_id )
	
--[[
	if lockevent then
		C_Timer.After(
			ArkInventory.db.option.bugfix.itemlock.delay,
			function( )
				--ArkInventory.Frame_Item_Update_Instant( loc_id, bag_id, slot_id )
				--local id = ArkInventory.LocationEncode( loc_id, bag_id, slot_id )
				--ArkInventory.Output( "lockdelay: ", loc_id, "-", bag_id, "-", slot_id )
				--ArkInventory:SendMessage( "EVENT_ARKINV_ITEM_UPDATE_BUCKET", id )
			end
		)
	end
]]--
	
end

function ArkInventory.Frame_Item_Update_InstantLock( loc_id_window, bag_id_window, slot_id, ItemFrameType )
	
	local framename, frame = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ItemFrameType )
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	ArkInventory.Frame_Item_Update_Lock( frame )
	
	ArkInventory.API.ItemFrameUpdated( frame, loc_id_window, bag_id_window, slot_id )
	
end

function ArkInventory.Frame_Item_Update_SearchResult( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	
	local f = string.trim( string.lower( ArkInventory.Global.Location[loc_id].filter or "" ) )
	
	f = ArkInventory.Search.CleanText( f )
	
	if f == "" then
		return true
	end
	
	local i = ArkInventory.Frame_Item_GetDB( frame )
	if not i or not i.h then
		return false
	end
	
	local txt = ArkInventory.Search.GetContent( i.h )
	
	if string.find( txt, f, nil, true ) then
		return true
	end
	
end


function ArkInventory.Frame_Bar_Popup_Paint( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	--ArkInventory.Output( "paint ", frame:GetName( ) )
	
	local loc_id = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	-- border
	local obj = frame.ArkBorder
	if obj then
		
		if codex.style.bar.border.style ~= ArkInventory.Const.Texture.BorderNone then
			
			local border = codex.style.bar.border.style or ArkInventory.Const.Texture.BorderDefault
			local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BORDER, border )
			local size = codex.style.bar.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size
			local offset = codex.style.bar.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offsetdefault.bar
			local scale = codex.style.bar.border.scale or 1
			
			local colour = nil
			if codex.layout.bar.data[bar_id].border.custom == 2 then
				colour = codex.layout.bar.data[bar_id].border.colour
			else
				colour = codex.style.bar.border.colour
			end
			
			ArkInventory.Frame_Border_Paint( obj, file, size, offset, scale, colour.r, colour.g, colour.b, 1 )
			
			obj:Show( )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
	
	-- background colour
	local obj = frame.ArkBackground
	if obj then
		
		local colour = codex.style.bar.background.colour
		
		if codex.layout.bar.data[bar_id].background.custom == 3 then
			
			-- use border colour
			if codex.layout.bar.data[bar_id].border.custom == 2 then
				-- use custom border colour
				colour = codex.layout.bar.data[bar_id].border.colour
			else
				-- use default border colour
				colour = codex.style.bar.border.colour
			end
			
		elseif codex.layout.bar.data[bar_id].background.custom == 2 then
			
			-- use custom background colour
			colour = codex.layout.bar.data[bar_id].background.colour
			
		end
		
		--ArkInventory.SetTexture( obj, true, colour.r, colour.g, colour.b, colour.a )
		ArkInventory.SetTexture( obj, true, 0, 0, 0, 1 )
		
	end
	
	-- label
	--ArkInventory.Frame_Bar_Label( frame )
	
end

function ArkInventory.Frame_Bar_Popup_Draw( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	local thread_id = ArkInventory.Global.Thread.Format.CompressedBar
	
	local thread_func = function( )
		local tz = debugprofilestop( )
		ArkInventory.OutputDebug( "draw compressed bar started" )
		ArkInventory.Frame_Bar_Popup_Draw_Threaded( frame, thread_id )
		tz = debugprofilestop( ) - tz
		ArkInventory.OutputDebug( "draw compressed bar complete ", string.format( "%s took %0.0fms", thread_id, tz ) )
	end
	
	ArkInventory.ThreadStart( thread_id, thread_func )
	
end

function ArkInventory.Frame_Bar_Popup_Draw_Threaded( frame, thread_id )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	local slotScale = codex.style.slot.scale or 1
	local slotSize = ( codex.style.slot.size or ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.SLOTSIZE ) * slotScale
	
	--ArkInventory.Output( "draw compressed bar frame=", frame:GetName( ), ", loc=", loc_id_window, ", state=", ArkInventory.Global.Location[loc_id_window].drawState )
	
	-- position the bar frame
	local name = frame:GetName( )
	
	local bpr = 1
	local padSlot = codex.style.slot.pad * slotScale
	local padBarInternal = codex.style.bar.pad.internal * slotScale
	local padLabel = 0
	
	local padList = 0
	
	ArkInventory.ThreadYield( thread_id )
	
	local bar = codex.workpad.compress[stack_id]
	if not bar then
		--assert( bar, string.format( "workpad data for stack [%s] does not exist", stack_id ) )
		return
	end
	
	
	bar.width = codex.style.slot.stack.compress.bar.width
	if bar.count < bar.width then
		bar.width = bar.count
	end
	
	bar.height = math.ceil( bar.count / bar.width )
	
	--ArkInventory.Output( "width [", bar.width, "], height [", bar.height, "]" )
	
	
	local barWidth = ( bar.width * slotSize ) + ( ( bar.width - 1 ) * padSlot ) + ( padBarInternal * 2 ) + padList
	local barHeight = ( bar.height * slotSize ) + ( ( bar.height - 1 ) * padSlot ) + ( padBarInternal * 2 ) + padLabel
	
	frame:SetWidth( barWidth )
	frame:SetHeight( barHeight )
	
	
	ArkInventory.Frame_Bar_Popup_Paint( frame )
	ArkInventory.Frame_Bar_Popup_Draw_Items( frame, thread_id )
	
	ArkInventory.ThreadYield( thread_id )
	
	
	-- display/hide the appropriate items
	for j, item in ipairs( bar.item ) do
		
		local bag_id_window = item.bag_id_window
		local slot_id = item.slot_id
		
		local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
		ArkInventory.Util.Assert( obj, "xml element [", objname, "] was not found" )
		
		ArkInventory.Frame_Item_Update_Clickable( obj )
		
		if obj.ARK_Data.IsDisplayed then
			
			obj:SetScale( slotScale )
			obj:Show( )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
	
	-- display/hide the appropriate bags (if the bags arent shown the items inside them wont be either)
	for bag_id_window, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		
		local bagframename, bagframe = ArkInventory.ContainerBagNameGet( loc_id_window, bag_id_window, ArkInventory.Const.ItemFrameType.Popup )
		ArkInventory.Util.Assert( bagframe, "xml element [", bagframename, "] was not found" )
		
		if codex.player.data.option[loc_id_window].bag[bag_id_window].display then
			bagframe:Show( )
		else
			bagframe:Hide( )
		end
		
	end
	
	
	ArkInventory.ThreadYield( thread_id )
	
end

function ArkInventory.Frame_Bar_Popup_Draw_Items( frame, thread_id )
	
	--ArkInventory.Output( "Frame_Bar_Popup_Draw_Items( ", frame:GetName( ), " )" )
--	local tz = debugprofilestop( )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local player_id = codex.player.data.info.player_id
	
	--ArkInventory.Output( frame:GetName( ), " [", loc_id_window, "] [", bar_id, "] [", stack_id, "]" )
	
	
	ArkInventory.ThreadYield( thread_id )
	
	local bar = codex.workpad.compress[stack_id]
	if not bar then
		--ArkInventory.Util.Assert( bar, "workpad data for stack [", stack_id, "] does not exist" ) )
		return
	end
	
	
	
--	local tz = debugprofilestop( )
	
	
	
	--ArkInventory.Output( "resorting loc[", loc_id_window, "] state[", ArkInventory.Global.Location[loc_id_window].drawState, "] bar[", bar_id, "] @ ", time( ) )
	
	-- sort the items in the bar (cpu intensive)
	for j, item in ipairs( bar.item ) do
		
		ArkInventory.ThreadYield( thread_id )
		
		local loc_id_storage = item.loc_id_storage
		local bag_id_storage = item.bag_id_storage
		local slot_id = item.slot_id
		
		local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
		local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
		
		local i = bag.slot[slot_id]
		item.sortkey = item.sortkey or ArkInventory.ItemSortKeyGenerate( i, bar_id, codex )
		
	end
	
	local sid_def = codex.style.sort.method or 9999
	local sid = codex.layout.bar.data[bar_id].sort.method or sid_def
	
	if ArkInventory.db.option.sort.method.data[sid].used ~= "Y" then
		sid = sid_def
	end
	
	table.sort( bar.item, ArkInventory.ItemSortKeySort )
	
	-- clear out the sortkey, we dont need it here once its been sorted
	for j, item in ipairs( bar.item ) do
		item.sortkey = nil
	end
	
	
	ArkInventory.ThreadYield( thread_id )
	
	
	-- DO NOT SCALE THESE VALUES
	local slotSize = codex.style.slot.size or ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.SLOTSIZE
	local slotAnchor = codex.style.slot.anchor
	
	local barWidth = codex.style.slot.stack.compress.bar.width
	
	local padSlot = codex.style.slot.pad
	local padBarInternal = codex.style.bar.pad.internal

	local padLabel = ArkInventory.Frame_Bar_Label_GetPaddingValue( codex )
	
	local padList = 0
	
	local itemOffsetX, itemOffsetY
	
	-- cycle through the items in the bar
	for j, item in ipairs( bar.item ) do
		
		ArkInventory.ThreadYield( thread_id )
		
		local bag_id_window = item.bag_id_window
		local slot_id = item.slot_id
		
		local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
		ArkInventory.Util.Assert( obj, "xml element [", objname, "] is missing" )
		
		--ArkInventory.Output( j, " / ", objname )
		
		local matches = true
		local matches = ArkInventory.Frame_Item_Update_SearchResult( obj )
		if matches then
			obj.ARK_Data.IsDisplayed = true
		else
			obj.ARK_Data.IsDisplayed = nil
		end
		
		--ArkInventory.Output( j, " / ", obj.ARK_Data.IsDisplayed )
		
		ArkInventory.ThreadYield( thread_id )
		
		obj:SetSize( slotSize, slotSize )
		
		if ( j - 1 ) % bar.width == 0 then
			
			-- first item in a new row, set X offset
			itemOffsetX = padBarInternal
			
			if j == 1 then
				
				-- first row, first item, set Y offset
				itemOffsetY = padBarInternal
				
				-- increment Y offset if bar names are enabled and they are in the way
				if ( codex.style.bar.name.show or ( ArkInventory.Global.Mode.Edit and codex.style.bar.name.editmode ) ) and ( not codex.style.window.list ) then
					
					local nameAnchor = codex.style.bar.name.anchor
					if nameAnchor ~= ArkInventory.ENUM.ANCHOR.DEFAULT then
						
						local tempAnchor = ArkInventory.ENUM.ANCHOR.TOP
						if slotAnchor == ArkInventory.ENUM.ANCHOR.DEFAULT or slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT or slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
							tempAnchor = ArkInventory.ENUM.ANCHOR.BOTTOM
						end
						
						if nameAnchor == tempAnchor then
							itemOffsetY = itemOffsetY + padLabel
						end
						
					end
					
				end
				
			else
				
				itemOffsetY = itemOffsetY + slotSize + padSlot
				
			end
			
		else
			
			-- same row, subsequent items, increment X offset
			itemOffsetX = itemOffsetX + slotSize + padSlot
			
		end
		
		
		if slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
			obj:SetPoint( "BOTTOMLEFT", frame, itemOffsetX, itemOffsetY )
		elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
			obj:SetPoint( "TOPLEFT", frame, itemOffsetX, 0 - itemOffsetY )
		elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
			obj:SetPoint( "TOPRIGHT", frame, 0 - itemOffsetX, 0 - itemOffsetY )
		else -- slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
			obj:SetPoint( "BOTTOMRIGHT", frame, 0 - itemOffsetX, itemOffsetY )
		end
		
		--local parent = obj:GetParent( )
		--ArkInventory.Output( "parent ", parent:GetName( ), " [", parent:GetID( ), "]" )
		
		--ArkInventory.Output( "item ", j, ", x=", itemOffsetX, ", y=", itemOffsetY, " a=", slotAnchor )
		
		--ArkInventory.Output( "bar = ", bar )
		
		ArkInventory.ThreadYield( thread_id )
		
		ArkInventory.Frame_Item_Update_Instant( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
		
	end
	
	ArkInventory.ThreadYield( thread_id )
	
	
--	tz = debugprofilestop( ) - tz
--	ArkInventory.OutputThread( "draw compressed bar [", loc_id_window, "] [", bar_id, "] [", stack_id, "] [", string.format( "%0.02fms", tz ), "] " )
	
end

function ArkInventory.Frame_Bar_Popup_Toggle( frame )
	
	local _, obj = ArkInventory.FrameBarPopupNameGet( )
	
	if obj:IsVisible( ) then
		ArkInventory.Frame_Bar_Popup_Hide( )
	else
		ArkInventory.Frame_Bar_Popup_Show( frame )
	end
	
end

function ArkInventory.Frame_Bar_Popup_Show( frame )
	
	-- frame is the item frame, presuambly a compressed one, not the bar frame
	
	if not frame.ARK_Data.isCompressed then
		ArkInventory.OutputError( "code issue: Frame_Bar_Popup_Show called by a non compressed item [", frame:GetName( ), "]" )
		return
	end
	
	--ArkInventory.Output( "Frame_Bar_Popup_Show" )
	
	ArkInventory.Frame_Bar_Popup_SetTimer( )
	
	
	-- assign new values to popup frame from compressed item frame
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	--local bar = codex.workpad.compress[stack_id]
	--ArkInventory.Util.Assert( bar, "workpad data for stack [", stack_id, "] does not exist" )
	
	ArkInventory.Frame_Bar_Popup_Reset( loc_id_window, bar_id, stack_id )
	
	local _, obj = ArkInventory.FrameBarPopupNameGet( )
	
	obj:ClearAllPoints( )
	
	if codex.style.slot.stack.compress.anchor == ArkInventory.ENUM.ANCHOR.BOTTOM then
		obj:SetPoint( "TOP", frame, "BOTTOM", 0, 0 )
	else
		obj:SetPoint( "BOTTOM", frame, "TOP", 0, 0 )
	end
	
	
	ArkInventory.Frame_Bar_Popup_Draw( obj )
	
	obj:Show( )
	
	--ArkInventory.Output( "Frame_Bar_Popup_Show" )
	
end

function ArkInventory.Frame_Bar_Popup_Reset( new_loc_id, new_bar_id, new_stack_id )
	
	local _, frame = ArkInventory.FrameBarPopupNameGet( )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	if stack_id then
		
		local codex = ArkInventory.Codex.GetLocation( loc_id_window )
		
		-- reset all popup item frames
		for _, stack in pairs( codex.workpad.compress or { } ) do
			for _, item in pairs( stack.item ) do
				
				local slot_id = item.slot_id
				
				local bag_id_window = item.bag_id_window
				
				local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
				ArkInventory.Util.Assert( obj, "xml element [", objname, "] is missing" )
				
				obj.ARK_Data.IsDisplayed = nil
				obj:ClearAllPoints( )
				obj:Hide( )
				
			end
		end
		
	end
	
	if new_stack_id then
		frame.ARK_Data.loc_id = new_loc_id
		frame.ARK_Data.bar_id = new_bar_id
		frame.ARK_Data.stack_id = new_stack_id
	end
	
end

function ArkInventory.Frame_Bar_Popup_Hide( )
	
	local _, frame = ArkInventory.FrameBarPopupNameGet( )
	frame:Hide( )
	
	ArkInventory.Frame_Bar_Popup_Reset( )
	
end

function ArkInventory.Frame_Bar_Popup_OnLoad( frame )
	
	table.insert( UISpecialFrames, frame:GetName( ) )
	
	ArkInventory.Frame_AddBorder( frame )
	
	frame.ARK_Data = {
		loc_id = 0,
		bar_id = 0,
		stack_id = nil,
	}
	
	frame:SetID( 1 )
	
	ArkInventory.MediaFrameDefaultFontSet( frame )
	
	frame:Hide( )
	
end

function ArkInventory.Frame_Bar_Popup_OnUpdate( frame, elapsed )
	
	if frame.timer_run then
		frame.timer_value = ( frame.timer_value or 0 ) + elapsed
		if frame.timer_value > 0.1 then
			frame.timer_value = nil
			--ArkInventory.Output( "auto closing popup item bar" )
			ArkInventory.Frame_Bar_Popup_Hide( )
		end
	end
	
end

function ArkInventory.Frame_Bar_Popup_SetTimer( frame, run )
	
	if not frame then
		local _
		_, frame = ArkInventory.FrameBarPopupNameGet( )
	end
	
	--ArkInventory.Output( "set timer [", not not run, "]" )
	frame.timer_run = run
	frame.timer_value = 0
	
end

function ArkInventory.Frame_Bar_Popup_OnEnter( frame )
	--ArkInventory.Output( "on enter - popup bar" )
	ArkInventory.Frame_Bar_Popup_SetTimer( frame )
end

function ArkInventory.Frame_Bar_Popup_OnLeave( frame )
	--ArkInventory.Output( "on leave - popup bar" )
	ArkInventory.Frame_Bar_Popup_SetTimer( frame, true )
end

function ArkInventory.Frame_Bar_Popup_OnShow( frame )
	--ArkInventory.Output( "on show - popup bar" )
	ArkInventory.Frame_Bar_Popup_SetTimer( frame )
end

function ArkInventory.Frame_Bar_Popup_OnHide( frame )
	--ArkInventory.Output( "on hide - popup bar" )
	ArkInventory.Frame_Bar_Popup_Hide( )
end

function ArkInventory.FrameBarPopupNameGet( )
	return ArkInventory.Const.Frame.BarPopup.Name, _G[ArkInventory.Const.Frame.BarPopup.Name]
end


function ArkInventory.Frame_Action_Popup_Paint( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	--ArkInventory.Output( "paint ", frame:GetName( ) )
	
	local loc_id = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	
	-- border
	local obj = frame.ArkBorder
	if obj then
		
		if codex.style.bar.border.style ~= ArkInventory.Const.Texture.BorderNone then
			
			local border = codex.style.bar.border.style or ArkInventory.Const.Texture.BorderDefault
			local file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BORDER, border )
			local size = codex.style.bar.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size
			local offset = codex.style.bar.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offsetdefault.bar
			local scale = codex.style.bar.border.scale or 1
			
			local colour = nil
			if codex.layout.bar.data[bar_id].border.custom == 2 then
				colour = codex.layout.bar.data[bar_id].border.colour
			else
				colour = codex.style.bar.border.colour
			end
			
			ArkInventory.Frame_Border_Paint( obj, file, size, offset, scale, colour.r, colour.g, colour.b, 1 )
			
			obj:Show( )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
	
	-- background colour
	local obj = frame.ArkBackground
	if obj then
		
		local colour = codex.style.bar.background.colour
		
		if codex.layout.bar.data[bar_id].background.custom == 3 then
			
			-- use border colour
			if codex.layout.bar.data[bar_id].border.custom == 2 then
				-- use custom border colour
				colour = codex.layout.bar.data[bar_id].border.colour
			else
				-- use default border colour
				colour = codex.style.bar.border.colour
			end
			
		elseif codex.layout.bar.data[bar_id].background.custom == 2 then
			
			-- use custom background colour
			colour = codex.layout.bar.data[bar_id].background.colour
			
		end
		
		--ArkInventory.SetTexture( obj, true, colour.r, colour.g, colour.b, colour.a )
		ArkInventory.SetTexture( obj, true, 0, 0, 0, 1 )
		
	end
	
end

function ArkInventory.Frame_Action_Popup_Draw( frame )
	
	local loc_id = frame.ARK_Data.loc_id
	local thread_id = ArkInventory.Global.Thread.Format.CompressedBar
	
	local thread_func = function( )
		local tz = debugprofilestop( )
		ArkInventory.OutputDebug( "draw compressed bar started" )
		ArkInventory.Frame_Action_Popup_Draw_Threaded( frame, thread_id )
		tz = debugprofilestop( ) - tz
		ArkInventory.OutputDebug( "draw compressed bar complete ", string.format( "%s took %0.0fms", thread_id, tz ) )
	end
	
	ArkInventory.ThreadStart( thread_id, thread_func )
	
end

function ArkInventory.Frame_Action_Popup_Draw_Threaded( frame, thread_id )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	local slotScale = codex.style.slot.scale or 1
	local slotSize = ( codex.style.slot.size or ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.SLOTSIZE ) * slotScale
	
	--ArkInventory.Output( "draw compressed bar frame=", frame:GetName( ), ", loc=", loc_id_window, ", state=", ArkInventory.Global.Location[loc_id_window].drawState )
	
	-- position the bar frame
	local name = frame:GetName( )
	
	local bpr = 1
	local padSlot = codex.style.slot.pad * slotScale
	local padBarInternal = codex.style.bar.pad.internal * slotScale
	local padLabel = 0
	
	local padList = 0
	
	ArkInventory.ThreadYield( thread_id )
	
	local bar = codex.workpad.compress[stack_id]
	if not bar then
		--assert( bar, string.format( "workpad data for stack [%s] does not exist", stack_id ) )
		return
	end
	
	
	bar.width = codex.style.slot.stack.compress.bar.width
	if bar.count < bar.width then
		bar.width = bar.count
	end
	
	bar.height = math.ceil( bar.count / bar.width )
	
	--ArkInventory.Output( "width [", bar.width, "], height [", bar.height, "]" )
	
	
	local barWidth = ( bar.width * slotSize ) + ( ( bar.width - 1 ) * padSlot ) + ( padBarInternal * 2 ) + padList
	local barHeight = ( bar.height * slotSize ) + ( ( bar.height - 1 ) * padSlot ) + ( padBarInternal * 2 ) + padLabel
	
	frame:SetWidth( barWidth )
	frame:SetHeight( barHeight )
	
	
	ArkInventory.Frame_Action_Popup_Paint( frame )
	ArkInventory.Frame_Action_Popup_Draw_Items( frame, thread_id )
	
	ArkInventory.ThreadYield( thread_id )
	
	
	-- display/hide the appropriate items
	for j, item in ipairs( bar.item ) do
		
		local bag_id_window = item.bag_id_window
		local slot_id = item.slot_id
		
		local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
		ArkInventory.Util.Assert( obj, "xml element [", objname, "] was not found" )
		
		ArkInventory.Frame_Item_Update_Clickable( obj )
		
		if obj.ARK_Data.IsDisplayed then
			
			obj:SetScale( slotScale )
			obj:Show( )
			
		else
			
			obj:Hide( )
			
		end
		
	end
	
	
	-- display/hide the appropriate bags (if the bags arent shown the items inside them wont be either)
	for bag_id_window, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		
		local bagframename, bagframe = ArkInventory.ContainerBagNameGet( loc_id_window, bag_id_window, ArkInventory.Const.ItemFrameType.Popup )
		ArkInventory.Util.Assert( bagframe, "xml element [", bagframename, "] was not found" )
		
		if codex.player.data.option[loc_id_window].bag[bag_id_window].display then
			bagframe:Show( )
		else
			bagframe:Hide( )
		end
		
	end
	
	
	ArkInventory.ThreadYield( thread_id )
	
end

function ArkInventory.Frame_Action_Popup_Draw_Items( frame, thread_id )
	
	--ArkInventory.Output( "Frame_Action_Popup_Draw_Items( ", frame:GetName( ), " )" )
--	local tz = debugprofilestop( )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local player_id = codex.player.data.info.player_id
	
	--ArkInventory.Output( frame:GetName( ), " [", loc_id_window, "] [", bar_id, "] [", stack_id, "]" )
	
	
	ArkInventory.ThreadYield( thread_id )
	
	local bar = codex.workpad.compress[stack_id]
	if not bar then
		--ArkInventory.Util.Assert( bar, "workpad data for stack [", stack_id, "] does not exist" ) )
		return
	end
	
	
	
--	local tz = debugprofilestop( )
	
	
	
	--ArkInventory.Output( "resorting loc[", loc_id_window, "] state[", ArkInventory.Global.Location[loc_id_window].drawState, "] bar[", bar_id, "] @ ", time( ) )
	
	-- sort the items in the bar (cpu intensive)
	for j, item in ipairs( bar.item ) do
		
		ArkInventory.ThreadYield( thread_id )
		
		local loc_id_storage = item.loc_id_storage
		local bag_id_storage = item.bag_id_storage
		local slot_id = item.slot_id
		
		local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
		local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
		
		local i = bag.slot[slot_id]
		item.sortkey = item.sortkey or ArkInventory.ItemSortKeyGenerate( i, bar_id, codex )
		
	end
	
	local sid_def = codex.style.sort.method or 9999
	local sid = codex.layout.bar.data[bar_id].sort.method or sid_def
	
	if ArkInventory.db.option.sort.method.data[sid].used ~= "Y" then
		sid = sid_def
	end
	
	table.sort( bar.item, ArkInventory.ItemSortKeySort )
	
	-- clear out the sortkey, we dont need it here once its been sorted
	for j, item in ipairs( bar.item ) do
		item.sortkey = nil
	end
	
	
	ArkInventory.ThreadYield( thread_id )
	
	
	-- DO NOT SCALE THESE VALUES
	local slotSize = codex.style.slot.size or ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.SLOTSIZE
	local slotAnchor = codex.style.slot.anchor
	
	local barWidth = codex.style.slot.stack.compress.bar.width
	
	local padSlot = codex.style.slot.pad
	local padBarInternal = codex.style.bar.pad.internal

	local padLabel = ArkInventory.Frame_Bar_Label_GetPaddingValue( codex )
	
	local padList = 0
	
	local itemOffsetX, itemOffsetY
	
	-- cycle through the items in the bar
	for j, item in ipairs( bar.item ) do
		
		ArkInventory.ThreadYield( thread_id )
		
		local bag_id_window = item.bag_id_window
		local slot_id = item.slot_id
		
		local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
		ArkInventory.Util.Assert( obj, "xml element [", objname, "] is missing" )
		
		--ArkInventory.Output( j, " / ", objname )
		
		local matches = true
		local matches = ArkInventory.Frame_Item_Update_SearchResult( obj )
		if matches then
			obj.ARK_Data.IsDisplayed = true
		else
			obj.ARK_Data.IsDisplayed = nil
		end
		
		--ArkInventory.Output( j, " / ", obj.ARK_Data.IsDisplayed )
		
		ArkInventory.ThreadYield( thread_id )
		
		obj:SetSize( slotSize, slotSize )
		
		if ( j - 1 ) % bar.width == 0 then
			
			-- first item in a new row, set X offset
			itemOffsetX = padBarInternal
			
			if j == 1 then
				
				-- first row, first item, set Y offset
				itemOffsetY = padBarInternal
				
				-- increment Y offset if bar names are enabled and they are in the way
				if ( codex.style.bar.name.show or ( ArkInventory.Global.Mode.Edit and codex.style.bar.name.editmode ) ) and ( not codex.style.window.list ) then
					
					local nameAnchor = codex.style.bar.name.anchor
					if nameAnchor ~= ArkInventory.ENUM.ANCHOR.DEFAULT then
						
						local tempAnchor = ArkInventory.ENUM.ANCHOR.TOP
						if slotAnchor == ArkInventory.ENUM.ANCHOR.DEFAULT or slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT or slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
							tempAnchor = ArkInventory.ENUM.ANCHOR.BOTTOM
						end
						
						if nameAnchor == tempAnchor then
							itemOffsetY = itemOffsetY + padLabel
						end
						
					end
					
				end
				
			else
				
				itemOffsetY = itemOffsetY + slotSize + padSlot
				
			end
			
		else
			
			-- same row, subsequent items, increment X offset
			itemOffsetX = itemOffsetX + slotSize + padSlot
			
		end
		
		
		if slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMLEFT then
			obj:SetPoint( "BOTTOMLEFT", frame, itemOffsetX, itemOffsetY )
		elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPLEFT then
			obj:SetPoint( "TOPLEFT", frame, itemOffsetX, 0 - itemOffsetY )
		elseif slotAnchor == ArkInventory.ENUM.ANCHOR.TOPRIGHT then
			obj:SetPoint( "TOPRIGHT", frame, 0 - itemOffsetX, 0 - itemOffsetY )
		else -- slotAnchor == ArkInventory.ENUM.ANCHOR.BOTTOMRIGHT then
			obj:SetPoint( "BOTTOMRIGHT", frame, 0 - itemOffsetX, itemOffsetY )
		end
		
		--local parent = obj:GetParent( )
		--ArkInventory.Output( "parent ", parent:GetName( ), " [", parent:GetID( ), "]" )
		
		--ArkInventory.Output( "item ", j, ", x=", itemOffsetX, ", y=", itemOffsetY, " a=", slotAnchor )
		
		--ArkInventory.Output( "bar = ", bar )
		
		ArkInventory.ThreadYield( thread_id )
		
		ArkInventory.Frame_Item_Update_Instant( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
		
	end
	
	ArkInventory.ThreadYield( thread_id )
	
	
--	tz = debugprofilestop( ) - tz
--	ArkInventory.OutputThread( "draw compressed bar [", loc_id_window, "] [", bar_id, "] [", stack_id, "] [", string.format( "%0.02fms", tz ), "] " )
	
end

function ArkInventory.Frame_Action_Popup_Toggle( frame )
	
	local _, obj = ArkInventory.FrameBarPopupNameGet( )
	
	if obj:IsVisible( ) then
		ArkInventory.Frame_Action_Popup_Hide( )
	else
		ArkInventory.Frame_Action_Popup_Show( frame )
	end
	
end

function ArkInventory.Frame_Action_Popup_Show( frame )
	
	-- frame is the item frame, presuambly a compressed one, not the bar frame
	
	if not frame.ARK_Data.isCompressed then
		ArkInventory.OutputError( "code issue: Frame_Action_Popup_Show called by a non compressed item [", frame:GetName( ), "]" )
		return
	end
	
	--ArkInventory.Output( "Frame_Bar_Action_Show" )
	
	ArkInventory.Frame_Bar_Action_SetTimer( )
	
	
	-- assign new values to popup frame from compressed item frame
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	--local bar = codex.workpad.compress[stack_id]
	--ArkInventory.Util.Assert( bar, "workpad data for stack [", stack_id, "] does not exist" )
	
	ArkInventory.Frame_Bar_Action_Reset( loc_id_window, bar_id, stack_id )
	
	local _, obj = ArkInventory.FrameBarPopupNameGet( )
	
	obj:ClearAllPoints( )
	
	if codex.style.slot.stack.compress.anchor == ArkInventory.ENUM.ANCHOR.BOTTOM then
		obj:SetPoint( "TOP", frame, "BOTTOM", 0, 0 )
	else
		obj:SetPoint( "BOTTOM", frame, "TOP", 0, 0 )
	end
	
	
	ArkInventory.Frame_Bar_Action_Draw( obj )
	
	obj:Show( )
	
	--ArkInventory.Output( "Frame_Bar_Action_Show" )
	
end

function ArkInventory.Frame_Action_Popup_Reset( new_loc_id, new_bar_id, new_stack_id )
	
	local _, frame = ArkInventory.FrameBarPopupNameGet( )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bar_id = frame.ARK_Data.bar_id
	local stack_id = frame.ARK_Data.stack_id
	
	if stack_id then
		
		local codex = ArkInventory.Codex.GetLocation( loc_id_window )
		
		-- reset all popup item frames
		for _, stack in pairs( codex.workpad.compress or { } ) do
			for _, item in pairs( stack.item ) do
				
				local slot_id = item.slot_id
				
				local bag_id_window = item.bag_id_window
				
				local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id, ArkInventory.Const.ItemFrameType.Popup )
				ArkInventory.Util.Assert( obj, "xml element [", objname, "] is missing" )
				
				obj.ARK_Data.IsDisplayed = nil
				obj:ClearAllPoints( )
				obj:Hide( )
				
			end
		end
		
	end
	
	if new_stack_id then
		frame.ARK_Data.loc_id = new_loc_id
		frame.ARK_Data.bar_id = new_bar_id
		frame.ARK_Data.stack_id = new_stack_id
	end
	
end

function ArkInventory.Frame_Action_Popup_Hide( )
	
	local _, frame = ArkInventory.FrameBarPopupNameGet( )
	frame:Hide( )
	
	ArkInventory.Frame_Bar_Action_Reset( )
	
end

function ArkInventory.Frame_Action_Popup_OnLoad( frame )
	
	table.insert( UISpecialFrames, frame:GetName( ) )
	
	ArkInventory.Frame_AddBorder( frame )
	
	frame.ARK_Data = {
		loc_id = 0,
		bar_id = 0,
		stack_id = nil,
	}
	
	frame:SetID( 1 )
	
	ArkInventory.MediaFrameDefaultFontSet( frame )
	
	frame:Hide( )
	
end

function ArkInventory.Frame_Action_Popup_OnUpdate( frame, elapsed )
	
	if frame.timer_run then
		frame.timer_value = ( frame.timer_value or 0 ) + elapsed
		if frame.timer_value > 0.1 then
			frame.timer_value = nil
			--ArkInventory.Output( "auto closing popup item bar" )
			ArkInventory.Frame_Bar_Action_Hide( )
		end
	end
	
end

function ArkInventory.Frame_Action_Popup_SetTimer( frame, run )
	
	if not frame then
		local _
		_, frame = ArkInventory.FrameBarPopupNameGet( )
	end
	
	--ArkInventory.Output( "set timer [", not not run, "]" )
	frame.timer_run = run
	frame.timer_value = 0
	
end

function ArkInventory.Frame_Action_Popup_OnEnter( frame )
	--ArkInventory.Output( "on enter - popup bar" )
	ArkInventory.Frame_Bar_Action_SetTimer( frame )
end

function ArkInventory.Frame_Action_Popup_OnLeave( frame )
	--ArkInventory.Output( "on leave - popup bar" )
	ArkInventory.Frame_Bar_Action_SetTimer( frame, true )
end

function ArkInventory.Frame_Action_Popup_OnShow( frame )
	--ArkInventory.Output( "on show - popup bar" )
	ArkInventory.Frame_Bar_Action_SetTimer( frame )
end

function ArkInventory.Frame_Action_Popup_OnHide( frame )
	--ArkInventory.Output( "on hide - popup bar" )
	ArkInventory.Frame_Bar_Action_Hide( )
end

function ArkInventory.FrameActionPopupNameGet( )
	return ArkInventory.Const.Frame.ActionPopup.Name, _G[ArkInventory.Const.Frame.ActionPopup.Name]
end



function ArkInventory.Frame_Status_Action_OnClick( frame, button, mode )
	
	ArkInventory.MenuStatusActionOpen( frame )
	
end

function ArkInventory.Frame_Status_Update( frame )
	
	--ArkInventory.Output( "Frame_Status_Update" )
	
	local loc_id_window = frame.ARK_Data.loc_id
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	--ArkInventory.Output( ArkInventory.Global.Location[loc_id_window].Name, ", player = ", codex.player.current )
	
	-- hide the status window if it's not needed
	local frame = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Status.Name )]
	if codex.style.status.hide then
		frame:Hide( )
		frame:SetHeight( 1 )
		return
	end
	
	local height = codex.style.status.font.height + ArkInventory.Const.Frame.Status.Padding * 2
	if height < ArkInventory.Const.Frame.Status.MinHeight then
		height = ArkInventory.Const.Frame.Status.MinHeight
	end
	
	frame:SetHeight( height )
	frame:SetScale( codex.style.status.scale or 1 )
	frame:Show( )
	
	ArkInventory.MediaFrameFontSet( frame, nil, codex.style.status.font.height )
	
	
	-- update money
	local moneyFrameName = string.format( "%s%s", frame:GetName( ), "Money" )
	local moneyFrame = _G[moneyFrameName]
	ArkInventory.Util.Assert( moneyFrame, "xml element [", moneyFrameName, "] was not found" )
	
	if codex.style.status.money.show then
		
		moneyFrame:Show( )
		moneyFrame:SetHeight( codex.style.status.font.height )
		ArkInventory.MoneyFrame_SetType( moneyFrame, "STATIC" )
		
		if ArkInventory.Global.Location[loc_id_window].isOffline then
			
			local m = 0
			if loc_id_window == ArkInventory.Const.Location.Vault then
				m = codex.player.data.info.money
			elseif loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Util.isAccountBankUnlocked( ) then
				local account = ArkInventory.Codex.GetLocation( ArkInventory.Const.Location.AccountBank )
				m = account.player.data.info.money
			elseif loc_id_window == ArkInventory.Const.Location.Bag then
				m = codex.player.data.info.money
			end
			
			if ( m or 0 ) > 0 then
				ArkInventory.MoneyFrame_Update( moneyFrameName, m )
			else
				moneyFrame:Hide( )
			end
			
		else
			
			if loc_id_window == ArkInventory.Const.Location.Vault then
				ArkInventory.MoneyFrame_SetType( moneyFrame, "GUILDBANK" )
			elseif loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Util.isAccountBankUnlocked( ) then
				ArkInventory.MoneyFrame_SetType( moneyFrame, "ACCOUNT" )
			elseif loc_id_window == ArkInventory.Const.Location.Bag then
				ArkInventory.MoneyFrame_SetType( moneyFrame, "PLAYER" )
			else
				moneyFrame:Hide( )
			end
			
		end
	else
		
		moneyFrame:Hide( )
		
	end
	
	
	-- action button
	local actionButtonName = string.format( "%s%s", frame:GetName( ), "Action" )
	local actionButton = _G[actionButtonName]
	ArkInventory.Util.Assert( actionButton, "button [", actionButtonName, "] was not found" )
	
	if ( loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Util.isAccountBankUnlocked( ) ) or ( loc_id_window == ArkInventory.Const.Location.Vault ) then
		
		actionButton:Show( )
		actionButton:SetPoint( "RIGHT", frame, "RIGHT", -5, 0 )
		
		moneyFrame:SetPoint( "RIGHT", actionButton, "LEFT", -5, 0 )
		
	else
		
		actionButton:Hide( )
		
		moneyFrame:SetPoint( "RIGHT", frame, "RIGHT", -5, 0 )
		
	end
	
	
	-- update the empty slot count
	local obj = _G[string.format( "%s%s", frame:GetName( ), "EmptyText" )]
	if obj then
		if codex.style.status.emptytext.show then
			local y = ArkInventory.Frame_Status_Update_Empty( loc_id_window, codex )
			obj:SetText( y )
		else
			obj:SetText( "" )
		end
		--obj:SetHeight( height )
	end
	
	
	-- update currency tracking, and expand frame size if required
	local expand = ArkInventory.Frame_Status_Update_Tracking( loc_id_window )
	if codex.style.status.currency.show and expand then
		
		height = codex.style.status.font.height * 2 + ArkInventory.Const.Frame.Status.Padding * 4
		if height < ArkInventory.Const.Frame.Status.MinHeight then
			height = ArkInventory.Const.Frame.Status.MinHeight
		end
		
		frame:SetHeight( height )
		
	end
	
end

function ArkInventory.Frame_Status_Update_Empty( loc_id_window, codex, ldb )
	
	-- build the empty slot count status string
	
	local empty = { }
	
	for loc_id_storage in pairs( ArkInventory.Util.MapGetChildren( loc_id_window ) ) do
		
		local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
		
		for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
			
			local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
			
			if not empty[bag.type] then
				empty[bag.type] = { ["count"] = 0, ["empty"] = 0, ["type"] = bag.type }
			end
			
			if bag.status == ArkInventory.Const.Bag.Status.Active then
				empty[bag.type].count = empty[bag.type].count + bag.count
				empty[bag.type].empty = empty[bag.type].empty + bag.empty
			end
			
		end
		
		--ArkInventory.Output( "k=[", k, "] t=[", bag.type, "] c=[", bag.count, "], status=[", bag.status, "]" )
		
	end
	
	local ts = ArkInventory.Table.Sum( empty, function( a ) return a.count end )
	local ee = ArkInventory.Table.Sum( empty, function( a ) return a.empty end )
	
	local y = { }
	
	if ts == 0 then
		
		y[#y + 1] = ArkInventory.Localise["STATUS_NO_DATA"]
		
	else
		
		for t, e in ArkInventory.spairs( empty, function(a,b) return empty[a].type < empty[b].type end ) do
			
			local c = HIGHLIGHT_FONT_COLOR_CODE
			local n = string.format( " %s", ArkInventory.Const.Slot.Data[t].short )
			
			if ldb then
				
				if codex.player.data.ldb.bags.include[t] then
					
					if codex.player.data.ldb.bags.colour then
						c = codex.style.slot.background.colour[t]
						c = ArkInventory.ColourRGBtoCode( c.r, c.g, c.b )
					end
					
					if not codex.player.data.ldb.bags.includetype then
						n = ""
					end
					
					if codex.player.data.ldb.bags.full then
						y[#y + 1] = string.format( "%s%i/%i%s%s", c, e.count - e.empty, e.count, n, FONT_COLOR_CODE_CLOSE )
					else
						y[#y + 1] = string.format( "%s%i%s%s", c, e.empty, n, FONT_COLOR_CODE_CLOSE )
					end
					
				end
				
			else
				
				if codex.style.status.emptytext.include[t] then
					
					if codex.style.status.emptytext.colour then
						c = codex.style.slot.background.colour[t]
						c = ArkInventory.ColourRGBtoCode( c.r, c.g, c.b )
					end
					
					if not codex.style.status.emptytext.includetype then
						n = ""
					end
					
					if codex.player.data.info.class == ArkInventory.Const.Class.Account then
						y[#y + 1] = string.format( "%s%i%s%s", c, e.count, n, FONT_COLOR_CODE_CLOSE )
					elseif codex.style.status.emptytext.full then
						y[#y + 1] = string.format( "%s%i/%i%s%s", c, e.count - e.empty, e.count, n, FONT_COLOR_CODE_CLOSE )
					else
						y[#y + 1] = string.format( "%s%i%s%s", c, e.empty, n, FONT_COLOR_CODE_CLOSE )
					end
					
				end
				
			end
			
		end
		
	end
	
	return string.format( "|cfff9f9f9%s", table.concat( y, ", " ) )
	
end

function ArkInventory.Frame_Status_Update_Tracking( loc_id_window )
	
	--ArkInventory.Output( "Frame_Status_Update_Tracking( ", loc_id_window, " )" )
	
	if not ArkInventory:IsEnabled( ) then return end
	
	local loc_id_window = loc_id_window or ArkInventory.Const.Location.Bag
	if loc_id_window ~= ArkInventory.Const.Location.Bag then
		-- only works for the backpack
		return
	end
	
	local loc_id_window = ArkInventory.Const.Location.Currency
	if not ArkInventory.isLocationMonitored( loc_id_window ) then
		-- only works if currency is being monitored
		return
	end
	
	local loc_id_window = ArkInventory.Const.Location.Bag
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
	local frame = ArkInventory.Frame_Main_Get( loc_id_window )
	frame = _G[string.format( "%s%s", frame:GetName( ), ArkInventory.Const.Frame.Status.Name )]
	local expand = false
	
	
	local ArkScroll = frame.ArkScroll
	if codex.style.status.currency.show then
		
		--ArkInventory.Output( "in use - show" )
		ArkScroll:Show( )
		
		local ArkTracking = ArkScroll.ArkTracking
		--ArkTracking:Show( )
		
		local tw = 1
		
		for i = 1, ( MAX_WATCHED_TOKENS or 20 ) do
			
			local obj = _G[string.format( "%s%s%s", frame:GetName( ), "ScrollTracking", i )]
			local info = ArkInventory.CrossClient.GetBackpackCurrencyInfo( i )
			
			if info and info.currencyTypesID then
				
				if not obj then
					
					obj = CreateFrame( "Frame", string.format( "%s%s", ArkTracking:GetName( ), i ), ArkTracking, "ARKINV_TemplateCurrencyTracking" )
					
					if i == 1 then
						
						obj:SetPoint( "LEFT", ArkTracking )
						
					else
						
						local objprev = _G[string.format( "%s%s", ArkTracking:GetName( ), i - 1 )]
						obj:SetPoint( "LEFT", objprev, "RIGHT", ArkInventory.Const.Frame.Status.Padding * 2, 0 )
						
					end
					
					ArkInventory.MediaFrameFontSet( obj, ArkInventory.db.option.font.face, codex.style.status.font.height )
					
				end
				
				--ArkInventory.OutputDebug( "token ", i, " = ", info )
				
				obj.currencyID = info.currencyTypesID
				ArkInventory.SetTexture( obj.icon, info.iconFileID )
				obj.count:SetText( FormatLargeNumber( info.quantity or 0 ) )
				
				local w = obj.icon:GetWidth( ) + 2 + obj.count:GetWidth( )
				obj:SetWidth( w )
				obj:Show( )
				
				tw = obj:GetRight( ) - ArkTracking:GetLeft( )
				--tw = tw + w
				
				--ArkInventory.Output( i, " = ", w, " [", tw, "]" )
				
			else
				if obj then
					obj:SetWidth( 1 )
					obj:Hide( )
				end
			end
			
		end
		
		
		
		ArkScroll:SetHeight( codex.style.status.font.height )
		
		tw = math.floor( tw + 0.5 )
		--ArkInventory.Output( "tracking width = ", tw )
		ArkTracking:SetWidth( tw )
		ArkTracking:SetHeight( codex.style.status.font.height )
		
		local f1 = frame
		local f1a = "LEFT"
		local aw1 = math.floor( f1:GetLeft( ) + 0.5 )
		--ArkInventory.Output( "aw1 = ", aw1 )
		if codex.style.status.emptytext.show then
			f1 = frame.ArkEmptyText
			f1a = "RIGHT"
			aw1 = math.floor( f1:GetRight( ) + 0.5 )
			--ArkInventory.Output( "aw1 = ", aw1 )
		end
		
		local f2 = frame
		local f2a = "RIGHT"
		local aw2 = math.floor( f2:GetRight( ) - 0.5 )
		--ArkInventory.Output( "aw2 = ", aw2 )
		if codex.style.status.money.show then
			f2 = frame.ArkMoney
			f2a = "LEFT"
			aw2 = math.floor( f2:GetLeft( ) - 0.5 )
			--ArkInventory.Output( "aw2 = ", aw2 )
		end
		
		local aw = aw2 - aw1 - ArkInventory.Const.Frame.Status.Padding * 4
		--ArkInventory.Output( "line width 1 = ", aw )
		local offset = 0
		
		--frame.ArkScrollLeft:Hide( )
		--frame.ArkScrollRight:Hide( )
		
		if tw <= aw then
			
			--ArkInventory.Output( "fits in the top line" )
			
			--ArkScroll:SetHorizontalScroll( 0 )
			--ArkScroll.scrollBar:Hide( )
			
			ArkScroll:SetPoint( "TOP", frame, "TOP", 0, 0 - ArkInventory.Const.Frame.Status.Padding )
			
			offset = math.floor( ( aw - tw + ArkInventory.Const.Frame.Status.Padding * 4 ) / 2 )
			--ArkInventory.Output( "offset = ", offset )
			
			ArkScroll:SetPoint( "LEFT", f1, f1a, offset, 0 )
			ArkScroll:SetPoint( "RIGHT", f2, f2a, 0 - offset, 0 )
			
		else
			
			--ArkInventory.Output( "doesnt fit in the top line, move to second line" )
			
			expand = true
			
			aw = math.floor( frame:GetWidth( ) - ArkInventory.Const.Frame.Status.Padding * 4 + 0.5 )
			--ArkInventory.Output( "line width 2 = ", aw )
			
			ArkScroll:SetPoint( "TOP", frame, "TOP", 0, 0 - codex.style.status.font.height - ArkInventory.Const.Frame.Status.Padding * 2 )
			
			if tw <= aw then
				
				--ArkInventory.Output( "fits in the second line" )
				
				offset = math.floor( ( aw - tw + ArkInventory.Const.Frame.Status.Padding * 4 ) / 2 )
				--ArkInventory.Output( "offset = ", offset )
				
				ArkScroll:SetPoint( "LEFT", frame, offset, 0 )
				ArkScroll:SetPoint( "RIGHT", frame, 0 - offset, 0 )
				
				--ArkScroll:SetHorizontalScroll( 0 )
				--ArkScroll.scrollBar:Hide( )
				
			else
				
				--ArkInventory.Output( "doesnt fit in the second line, enable scroll bar" )
				
				offset = math.floor( ( codex.style.status.font.height * 2 + ArkInventory.Const.Frame.Status.Padding * 6 ) / 2 )
				--ArkInventory.Output( "offset = ", offset )
				
				ArkScroll:SetPoint( "LEFT", frame, offset, 0 )
				ArkScroll:SetPoint( "RIGHT", frame, 0 - offset, 0 )
				
				--ArkScroll.range = tw
				--ArkScroll.stepSize = ArkInventory.Const.Frame.Scroll.stepSize
				
				--frame.ArkScrollLeft:Show( )
				--frame.ArkScrollLeft:SetPoint( "RIGHT", ArkScroll, "LEFT", 0 - ArkInventory.Const.Frame.Status.Padding, 0 )
				--frame.ArkScrollLeft:SetWidth( codex.style.status.font.height )
				--frame.ArkScrollLeft:SetHeight( codex.style.status.font.height )
				
				--frame.ArkScrollRight:Show( )
				--frame.ArkScrollRight:SetPoint( "LEFT", ArkScroll, "RIGHT", ArkInventory.Const.Frame.Status.Padding, 0 )
				--frame.ArkScrollRight:SetWidth( codex.style.status.font.height )
				--frame.ArkScrollRight:SetHeight( codex.style.status.font.height )
				
			end
			
		end
		
	else
		
		--ArkInventory.Output( "not in use - hidden" )
		ArkScroll:Hide( )
		
	end
	
	--ArkInventory.Output( "expand = ", expand )
	return expand
	
end

function ArkInventory.HorizontalScrollBar_OnClick_Left( frame )
	local parent = frame:GetParent( )
	local v = parent:GetHorizontalScroll( )
	v = v - parent.stepSize
	if v < 0 then
		v = 0
	end
	ArkInventory.Output( "scroll left ", v )
	parent:SetHorizontalScroll( v )
end

function ArkInventory.HorizontalScrollBar_OnClick_Right( frame )
	local parent = frame:GetParent( )
	local v = parent:GetHorizontalScroll( )
	v = v + parent.stepSize
	if v > parent.range  then
		v = parent.range
	end
	ArkInventory.Output( "scroll right ", v )
	parent:SetHorizontalScroll( v )
end

function ArkInventory.Frame_Changer_OnLoad( frame, loc_id_window )
	
	if not ArkInventory.Global.Location[loc_id_window].isMapped then
		--ArkInventory.Output( "aborting Frame_Changer_OnLoad for ", ArkInventory.Global.Location[loc_id_window].Name )
		return
	end
	
	ArkInventory.Frame_AddBorder( frame )
	
	local templates
	
	if loc_id_window == ArkInventory.Const.Location.Bag then
		templates = { "ARKINV_TemplateChangerPlayerMain", "ARKINV_TemplateChangerGenericExtra" }
	elseif loc_id_window == ArkInventory.Const.Location.Bank then
		templates = { "ARKINV_TemplateChangerPlayerMain", "ARKINV_TemplateChangerGenericExtra" }
	elseif loc_id_window == ArkInventory.Const.Location.Vault then
		templates = { "ARKINV_TemplateChangerGenericExtra" }
	else
		ArkInventory.Util.Error( "invalid loc_id_window [", loc_id_window, "]" )
	end
	
	local framename = frame:GetName( )
	local template
	for bag_id_window in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		--ArkInventory.Output( "changer onload: ", loc_id_window, ".", bag_id_window )
		template = templates[bag_id_window] or template
		CreateFrame( ArkInventory.CrossClient.GetCreateFrameItemType( ), string.format( "%sBag%s", framename, bag_id_window ), frame, string.format( "%s%s", template, ArkInventory.CrossClient.TemplateVersion ) ) 
	end
	
end

function ArkInventory.Frame_Changer_Update( loc_id_window )
	
	if not ArkInventory.Global.Location[loc_id_window].hasChanger then return end
	
	
	for bag_id_window in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		ArkInventory.Frame_Changer_Slot_Update( loc_id_window, bag_id_window )
	end
	
	if loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.Bank then
		-- if at the bank then update the blizzard frame as well because the static dialog box we piggyback off uses the data in it
		UpdateBagSlotStatus( )
	end
	
	
	if loc_id_window == ArkInventory.Const.Location.Vault then
		
		local parent = string.format( "%s%s%s%s", ArkInventory.Const.Frame.Main.Name, loc_id_window, ArkInventory.Const.Frame.Changer.Name, "Window" )
		local buttonAction = _G[string.format( "%s%s", parent, "Action" )]
		
		if ArkInventory.Global.Location[loc_id_window].isOffline then
			if buttonAction then buttonAction:Hide( ) end
		else
			if buttonAction then buttonAction:Show( ) end
		end
		
	end
	
end

function ArkInventory.Frame_Changer_Secondary_OnDragStart( frame )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	
	if InCombatLockdown( ) or ArkInventory.Global.Mode.Edit or ArkInventory.Global.Location[loc_id_window].isOffline or loc_id == ArkInventory.Const.Location.Vault then
		return
	end
	
	local inv_id = ArkInventory.Util.getInventoryIDFromWindow( loc_id_window, bag_id_window )
	
	--ArkInventory.Output( "pick up bag ", loc_id_window, ".", bag_id_window, " = ", inv_id )
	
	PickupBagFromSlot( inv_id )
	
end

function ArkInventory.Frame_Changer_Secondary_OnReceiveDrag( frame )
	
	-- edit mode check needed?
	ArkInventory.GameTooltipHide( )
	
	ArkInventory.EditModeOnDragSet( )
	ArkInventory.SetCursor( )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local loc_id = frame.ARK_Data.loc_id
	
	if ArkInventory.Global.Location[loc_id].isOffline then
		return
	end
	
	
	ArkInventory.Frame_Changer_Slot_OnClick( frame )
	
end

function ArkInventory.Frame_Changer_Slot_OnLoad( frame )
	
	ArkInventory.Frame_AddBorder( frame )
	
	local framename = frame:GetName( )
	local loc_id, bag_id = string.match( framename, "^" .. ArkInventory.Const.Frame.Main.Name .. "(%d+).-(%d+)$" )
	
	loc_id = tonumber( loc_id )
	bag_id = tonumber( bag_id )
	
	
	frame.ARK_Data = {
		loc_id = loc_id,
		bag_id = bag_id,
	}
	
	if frame.BattlepayItemTexture then
		frame.BattlepayItemTexture:Hide( )
	end
	
	if frame.NewItemTexture then
		frame.NewItemTexture:Hide( )
	end
	
	frame.SplitStack = nil
	
	frame.locked = nil
	
	frame:RegisterForClicks( "AnyUp" )
	
	local obj = frame.Count
	if obj ~= nil then
		obj:SetPoint( "BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2 )
		obj:SetPoint( "LEFT", frame, "LEFT", 0, 0 )
	end

	local obj = _G[string.format( "%s%s", framename, "Stock" )]
	if obj ~= nil then
		obj:SetPoint( "TOPLEFT", frame, "TOPLEFT", 0, -2 )
		obj:SetPoint( "RIGHT", frame, "RIGHT", 0, 0 )
	end
	
	frame:Hide( )
	
end

function ArkInventory.Frame_Changer_Slot_Update( loc_id_window, bag_id_window )
	
	local frame = _G[string.format( "%s%s%s%s%s", ArkInventory.Const.Frame.Main.Name, loc_id_window, ArkInventory.Const.Frame.Changer.Name, "WindowBag", bag_id_window )]
	if not ArkInventory.ValidFrame( frame ) then return end
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	frame.ARK_Data.blizzard_id = frame.ARK_Data.blizzard_id or map.blizzard_id
	
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
	local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
	
	--ArkInventory.Output( "changer update[", codex.player.data.info.name, "].loc[", loc_id_window, "].bag[", bag_id_window, "]" )
	
	
	if bag.count > 0 then
		frame.size = bag.count or 0
	else
		frame.size = 0
	end
	
	ArkInventory.Frame_Item_Update_Border( frame, codex, true )
	
	ArkInventory.SetItemButtonTexture( frame, bag.texture or ArkInventory.Const.Texture.Empty.Bag )
	SetItemButtonCount( frame, frame.size )
	
	if bag.status == ArkInventory.Const.Bag.Status.Active then
		ArkInventory.SetItemButtonStock( frame, bag.empty )
	else
		ArkInventory.SetItemButtonStock( frame, nil, bag.status )
	end
	
	ArkInventory.Frame_Item_Update_Fade( frame, codex, true )
	
	if not map.fixed then
		ArkInventory.Frame_Item_Update_Lock( frame, codex, true )
	end
	
	
	-- tint non displayed bags
	if codex.player.data.option[loc_id_window].bag[bag_id_window].display then
		if bag.status == ArkInventory.Const.Bag.Status.Purchase then
			SetItemButtonTextureVertexColor( frame, 1.0, 0.1, 0.1 )
		else
			SetItemButtonTextureVertexColor( frame, 1.0, 1.0, 1.0 )
		end
	else
		SetItemButtonTextureVertexColor( frame, 1.0, 0.1, 0.1 )
	end
	
	ArkInventory.MediaFrameFontSet( frame, nil, codex.style.slot.itemcount.font.height )
	
	
	-- highlight active panel bag
	local active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
	if ( loc_id_window == ArkInventory.Const.Location.Bank or loc_id_window == ArkInventory.Const.Location.Vault ) and bag_id_window == active_map.bag_id_window then
		frame.IconOverlay:SetAtlas( "runecarving-icon-bag-item-glow", TextureKitConstants.UseAtlasSize )
		frame.IconOverlay:Show( )
	else
		frame.IconOverlay:Hide( )
	end
	
	
	local collapse = true -- FIX ME - add to config
	local display = true
	
	-- ContainerFrameItemButtonTemplate, must use bottomright as anchor point
	if bag_id_window == 1 then
		
		local h = frame:GetWidth( ) + 8
		local v = ( frame:GetParent( ):GetHeight( ) - frame:GetHeight( ) ) / 2
		frame:SetPoint( "BOTTOMRIGHT", frame:GetParent( ), "BOTTOMLEFT", h, v )
		
	else
		
		if collapse and bag_id_storage > 1 then
			local bag0 = storage.data.location[loc_id_storage].bag[bag_id_storage - 1]
			if bag.type == bag0.type and bag.status == ArkInventory.Const.Bag.Status.Purchase and bag.status == bag0.status then
				display = false
			end
		end
		
		local frame0 = _G[string.format( "%s%s%s%s%s", ArkInventory.Const.Frame.Main.Name, loc_id_window, ArkInventory.Const.Frame.Changer.Name, "WindowBag", bag_id_window - 1 )]
		local h = 0
		if display then
			h = frame:GetWidth( ) + 8
		end
		
		frame:SetPoint( "BOTTOMRIGHT", frame0, "BOTTOMRIGHT", h, 0 )
		
	end
	
	if display then
		frame:Show( )
	else
		frame:Hide( )
	end
	
end

function ArkInventory.Frame_Changer_Slot_Update_Lock( loc_id_window, bag_id_window )
	
	local frame = _G[string.format( "%s%s%sWindowBag%s", ArkInventory.Const.Frame.Main.Name, loc_id_window, ArkInventory.Const.Frame.Changer.Name, bag_id_window )]
	if not ArkInventory.ValidFrame( frame ) then return end
	
	if ArkInventory.Global.Location[loc_id_window].isOffline then return end
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local blizzard_id = map.blizzard_id
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
	if me.player.data.location[loc_id_window].bag[bag_id_window].h then
		
		local inv_id = ArkInventory.Util.getInventoryIDFromWindow( loc_id_window, bag_id_window )
		local locked = IsInventoryItemLocked( inv_id )
		ArkInventory.SetItemButtonDesaturate( frame, locked )
		frame.locked = locked
		
	else
		
		frame.locked = false
		
	end
	
end

function ArkInventory.Frame_Changer_Slot_OnClick( frame, button, loop_protection )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local panel_id = map.panel_id
	local blizzard_id = map.blizzard_id
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	--ArkInventory.Output( "Frame_Changer_Slot_OnClick ", frame:GetName( ), ", ", button, ", ", loop_protection, " " )
	--ArkInventory.Output( "Frame_Changer_Slot_OnClick ", loc_id_window, ".", bag_id_window, " / ", loc_id_storage, ".", bag_id_storage )
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
	local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
	
	
	if IsModifiedClick( "CHATLINK" ) then
		
		if bag.h and bag.count > 0 then
			ChatEdit_InsertLink( bag.h )
		end
		
		return
		
	end
		
	if ArkInventory.Global.Mode.Edit then
		ArkInventory.MenuBagOpen( frame )
		return
	end
	
	if button == "RightButton" then
		ArkInventory.MenuBagOpen( frame )
		return
	end
	
	if loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.AccountBank and map.loc_id_storage ~= ArkInventory.Const.Location.AccountBank and not ArkInventory.Global.Location[loc_id_window].isOffline then
		-- warbank distance inhibitor active, ignore clicks for any bank/reagent bank tabs
		return
	end
	
	if button == nil then
		
		if not ArkInventory.Global.Location[loc_id_window].isOffline then
			
			-- drop from drag'n'drop
			
			if loc_id_storage == ArkInventory.Const.Location.Bag and bag_id_storage == 1 then
				ArkInventory.CrossClient.PutItemInBackpack( )
			elseif loc_id_storage == ArkInventory.Const.Location.Bank and bag_id_storage == 1 then
				ArkInventory.CrossClient.PutItemInBank( )
			elseif loc_id_storage == ArkInventory.Const.Location.ReagentBank then
				ArkInventory.CrossClient.DropItemOnReagentBank( )
			elseif loc_id_storage == ArkInventory.Const.Location.AccountBank then
				ArkInventory.CrossClient.PutItemInAccountBank( blizzard_id )
			elseif loc_id_storage == ArkInventory.Const.Location.Vault then
				-- vault tabs cannot accept drag and drop
			end
			
			return
			
		end
		
	end
	
	if button == "LeftButton" then
		
		if bag.status == ArkInventory.Const.Bag.Status.Purchase then
			
			if CursorHasItem( ) then
				-- you cant drop items onto unpurchased slots
				return
			end
			
			if not ArkInventory.Global.Location[loc_id_window].isOffline then
				
				if loc_id_storage == ArkInventory.Const.Location.Bank then
					StaticPopup_Show( "CONFIRM_BUY_BANK_SLOT" )
					return
				end
				
				if loc_id_storage == ArkInventory.Const.Location.ReagentBank then
					StaticPopup_Show( "CONFIRM_BUY_REAGENTBANK_TAB" )
					return
				end
				
				if loc_id_storage == ArkInventory.Const.Location.AccountBank then
					if not ArkInventory.CrossClient.IsWarbankInUseByAnotherCharacter( ) then
						StaticPopup_Show( "CONFIRM_BUY_BANK_TAB", nil, nil, { bankType = ArkInventory.ENUM.BANKTYPE.ACCOUNT } )
					end
					return
				end
					
				if loc_id_storage == ArkInventory.Const.Location.Vault then
					if bag_id_storage <= MAX_BUY_GUILDBANK_TABS then
						StaticPopup_Show( "CONFIRM_BUY_GUILDBANK_TAB" )
					end
					return
				end
				
			end
			
			
			return
			
		end
		
		
		if bag.status == ArkInventory.Const.Bag.Status.Active or bag.status == ArkInventory.Const.Bag.Status.Empty then
			
			if CursorHasItem( ) then
				
				if not ArkInventory.Global.Location[loc_id_window].isOffline then
					
					if loc_id_storage == ArkInventory.Const.Location.Bag and bag_id_storage == 1 then
						ArkInventory.CrossClient.PutItemInBackpack( )
						return
					end
					
					if loc_id_storage == ArkInventory.Const.Location.Bank and bag_id_storage == 1 then
						ArkInventory.CrossClient.PutItemInBank( )
						return
					end
					
					if loc_id_storage == ArkInventory.Const.Location.ReagentBank then
						ArkInventory.CrossClient.DropItemOnReagentBank( )
						return
					end
					
					if loc_id_storage == ArkInventory.Const.Location.AccountBank then
						ArkInventory.CrossClient.PutItemInAccountBank( blizzard_id )
						return
					end
					
					if loc_id_storage == ArkInventory.Const.Location.Vault then
						-- vault tabs cannot accept an item drop
						--ArkInventory.PutItemInGuildBank( tab_id )
						return
					end
					
					if bag.inv_id then
						PutItemInBag( bag.inv_id )
						return
					end
					
				end
				
				return
				
			end
			
			
			
			local active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
			
			local bag_changed = ( bag_id_window ~= active_map.bag_id_window )
			local panel_changed = ( panel_id ~= active_map.panel_id )
			
			ArkInventory.Util.setWindowActiveMap( loc_id_window, map )
			
			if bag_changed then
				
				if loc_id_window == ArkInventory.Const.Location.Vault then
					
					PlaySound( SOUNDKIT.IG_MAINMENU_OPTION )
					
					if ArkInventory.Global.Location[loc_id_window].isOffline then
						ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Recalculate )
						return
					end
					
					local active_mode = ArkInventory.Global.Location[loc_id_window].active_mode
					ArkInventory.VaultTabClick( bag_id_window, active_mode )
					return
					
				end
				
				if loc_id_window == ArkInventory.Const.Location.Bank then
					
					local storage_changed
					
					if loc_id_storage == ArkInventory.Const.Location.Bank then
						
						if bag_id_storage > 1 then
							-- reset map to the bank slot when you click on any bank bag
							ArkInventory.Util.setWindowActiveMap( loc_id_window, ArkInventory.Util.MapGetStorage( loc_id_storage, 1 ) )
						end
						
						if loc_id_storage ~= active_map.loc_id_storage then
							storage_changed = true
						end
						
					end
					
					if loc_id_storage == ArkInventory.Const.Location.ReagentBank then
						storage_changed = true
					end
					
					if loc_id_storage == ArkInventory.Const.Location.AccountBank then
						storage_changed = true
						--ArkInventory.Output( "change accountbank to tab ", blizzard_id )
					end
					
					if not loop_protection then
						ArkInventory.Util.syncBlizzardBankUI( active_map, loc_id_storage, blizzard_id )
					end
					
					if storage_changed then
						PlaySound( SOUNDKIT.IG_MAINMENU_OPTION )
						ItemButtonUtil.TriggerEvent( ItemButtonUtil.Event.ItemContextChanged )
					end
					
					if panel_changed then
						ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Recalculate )
						return
					end
					
					if storage_changed then
						ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Refresh )
					end
					
				end
				
			end
			
			
			if not ArkInventory.Global.Location[loc_id_window].isOffline then
				
				if bag.h then
					--ArkInventory.Output( "pick up bag" )
					ArkInventory.Frame_Changer_Secondary_OnDragStart( frame )
					return
				end
				
			end
			
		end
		
	end
	
end

function ArkInventory.Frame_Changer_Slot_OnEnter( frame )
	
	if ArkInventory.db.option.tooltip.show then
		
		local loc_id_window = frame.ARK_Data.loc_id
		local bag_id_window = frame.ARK_Data.bag_id
		
		local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
		
		local loc_id_storage = map.loc_id_storage
		local bag_id_storage = map.bag_id_storage
		
		--ArkInventory.Output( "Frame_Changer_Slot_OnEnter ", loc_id_window, ".", bag_id_window, " / ", loc_id_storage, ".", bag_id_storage )
		
		local codex = ArkInventory.Codex.GetLocation( loc_id_window )
		local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
		local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
		
		
		ArkInventory.GameTooltipSetPosition( frame, true )
		
		if false then
			
			if ArkInventory.Global.Location[loc_id_window].isOffline then
				
				if bag.count == 0 then
					
					-- do nothing
					--GameTooltip:SetText( "empty bag slot", 1.0, 1.0, 1.0 )
					
				else
					
					if bag.h then
						
						GameTooltip:SetHyperlink( bag.h )
						
					else
						
						GameTooltip:SetText( ArkInventory.Localise["UNKNOWN"], 1.0, 1.0, 1.0 )
						
					end
					
				end
			end
			
		end
		
		--ArkInventory.Output( "bag status [", bag.status, "]" )
		
		if loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.AccountBank and map.loc_id_storage ~= ArkInventory.Const.Location.AccountBank and not ArkInventory.Global.Location[loc_id_window].isOffline then
			
			bankername = 
			GameTooltip:SetText( "this slot is not accessible when using the ", bankername )
			
		elseif loc_id_storage == ArkInventory.Const.Location.Bag and bag_id_storage == 1 then
			
			GameTooltip:SetText( BACKPACK_TOOLTIP, 1.0, 1.0, 1.0 )
			
		elseif loc_id_storage == ArkInventory.Const.Location.Bank and bag_id_storage == 1 then
			
			GameTooltip:SetText( ArkInventory.Localise["BANK"], 1.0, 1.0, 1.0 )
			
		elseif loc_id_storage == ArkInventory.Const.Location.AccountBank and ArkInventory.CrossClient.IsWarbankInUseByAnotherCharacter( ) then
			
			if not ArkInventory.Global.Location[loc_id_window].isOffline then
				GameTooltip:SetText( ArkInventory.Localise["ACCOUNT_BANK_LOCKED_PROMPT"] )
			end
			
		elseif bag.status == ArkInventory.Const.Bag.Status.Purchase then
			
			if not ArkInventory.Global.Location[loc_id_window].isOffline then
				if loc_id_storage == ArkInventory.Const.Location.Bank then
					GameTooltip:SetText( string.format( ArkInventory.Localise["TOOLTIP_PURCHASE_BANK_BAG_SLOT"], string.lower( ArkInventory.Localise["BANK"] ) ) )
				elseif loc_id_storage == ArkInventory.Const.Location.ReagentBank then
					GameTooltip:SetText( string.format( ArkInventory.Localise["TOOLTIP_PURCHASE_BANK_BAG_SLOT"], string.lower( ArkInventory.Localise["REAGENTBANK"] ) ) )
				elseif loc_id_storage == ArkInventory.Const.Location.AccountBank then
					GameTooltip:SetText( string.format( ArkInventory.Localise["TOOLTIP_PURCHASE_BANK_BAG_SLOT"], string.lower( ArkInventory.Localise["ACCOUNTBANK"] ) ) )
				elseif loc_id_storage == ArkInventory.Const.Location.Vault then
					GameTooltip:SetText( string.format( ArkInventory.Localise["TOOLTIP_PURCHASE_BANK_BAG_SLOT"], string.lower( ArkInventory.Localise["VAULT"] ) ) )
				end
			end
			
		elseif bag.status == ArkInventory.Const.Bag.Status.Active then
			
			if loc_id_storage == ArkInventory.Const.Location.ReagentBank then
				
				GameTooltip:SetText( ArkInventory.Localise["REAGENTBANK"], 1.0, 1.0, 1.0 )
				
			elseif loc_id_storage == ArkInventory.Const.Location.AccountBank then
				
				local txt = ArkInventory.Localise["ACCOUNTBANK"]
				txt = string.format( "%s\n%s", txt, string.format(ArkInventory.Localise["VAULT_TAB_NAME"], bag_id_storage, bag.name or bag_id_storage ) )
				
				GameTooltip:SetText( txt, 1.0, 1.0, 1.0 )
				
			elseif loc_id_storage == ArkInventory.Const.Location.Vault then
				
				if bag and bag.name then
					GameTooltip:SetText( string.format( ArkInventory.Localise["VAULT_TAB_NAME"], bag_id_storage, bag.name ) )
					GameTooltip:AddLine( string.format( ArkInventory.Localise["VAULT_TAB_ACCESS"], bag.access ) )
					if bag.withdraw then
						GameTooltip:AddLine( string.format( ArkInventory.Localise["VAULT_TAB_REMAINING_WITHDRAWALS"], bag.withdraw ) )
					end
					--GameTooltip:AddLine( string.format( NUM_GUILDBANK_TABS_PURCHASED, GetNumGuildBankTabs( ), MAX_BUY_GUILDBANK_TABS ) )
					GameTooltip:Show( )
				else
					--GameTooltip:Hide( )
				end
				
			elseif bag.h then
				
				GameTooltip:SetHyperlink( bag.h )
				
			elseif bag.inv_id then
				
				GameTooltip:SetInventoryItem( "player", inv_id )
				
			end
			
		elseif bag.status == ArkInventory.Const.Bag.Status.Unknown then
			
			GameTooltip:SetText( ArkInventory.Localise["UNKNOWN"] )
			
		end
		
	end
	
	CursorUpdate( frame )
	
	
	ArkInventory.Frame_Changer_Slot_Highlight( frame, true )
	
end

function ArkInventory.Frame_Changer_Generic_OnLeave( frame )
	GameTooltip:Hide( )
	ArkInventory.SetCursor( )
	ArkInventory.Frame_Changer_Slot_Highlight( frame, false )
end

function ArkInventory.Frame_Changer_Slot_Highlight( frame, show )
	
	if not ArkInventory.ValidFrame( frame ) then return end
	
	--ArkInventory.Output( "BagHighlight( ", frame:GetName( ), ", ", show, " )" )
	
	local loc_id_window = frame.ARK_Data.loc_id
	local bag_id_window = frame.ARK_Data.bag_id
	
--	local bagframename, bagframe = ArkInventory.ContainerBagNameGet( loc_id_window, bag_id_window )
--	if not bagframe then
--		return
--	end
	
	local codex = ArkInventory.Codex.GetLocation( loc_id_window )
	
--	local b = codex.player.data.location[loc_id_window].bag[bag_id_window]
--	if not b then
--		return
--	end
	
	local enabled = codex.style.changer.highlight.show
	local colour = codex.style.changer.highlight.colour
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	local storage = ArkInventory.Codex.GetStorage( nil, loc_id_storage )
	local bag = storage.data.location[loc_id_storage].bag[bag_id_storage]
	
	for slot_id in pairs( bag.slot ) do
		
		local objname, obj = ArkInventory.ContainerItemNameGet( loc_id_window, bag_id_window, slot_id )
		if obj then
			obj = obj.ArkHighlight or _G[string.format( "%s%s", objname, "ArkHighlight" )]
			if obj then
				ArkInventory.SetTexture( obj, enabled and show, colour.r, colour.g, colour.b, 0.3 )
			end
		end
		
	end
	
end

function ArkInventory.Frame_AddBorder( frame )
	if not frame.ArkBorder then
		local name = frame:GetName( )
		name = name and name .. "ArkBorder"
		frame.ArkBorder = CreateFrame( "Frame", name, frame, BackdropTemplateMixin and "BackdropTemplate" )
		frame.ArkBorder:SetAllPoints( )
		frame.ArkBorder:SetFrameLevel( frame:GetFrameLevel( ) + 1 )
	end
end

function ArkInventory.MyHook(...)
	if not ArkInventory:IsHooked(...) then
		ArkInventory:RawHook(...)
	end
end

function ArkInventory.MyUnhook(...)
	if ArkInventory:IsHooked(...) then
		ArkInventory:Unhook(...)
	end
end

function ArkInventory.MySecureHook(...)
	
	if not ArkInventory:IsHooked(...) then
		
		local arg1, arg2, arg3, arg4 = ...
		
		ArkInventory.Util.Assert( not arg4, "arg4 for MySecureHook exists, check you used '.' and not  ':'" )
		ArkInventory.Util.Assert( arg1, "arg1 for MySecureHook is missing" )
		ArkInventory.Util.Assert( type( arg1 ) == "string", "arg1 for MySecureHook is [", type( arg1 ), "], should be [string]" )
		ArkInventory.Util.Assert( arg2, "arg2 for MySecureHook is missing" )
		
		local obj = _G[arg1]
		if not obj then
			ArkInventory.OutputDebug( "could not secure hook ", arg1, " as it does not exist" )
		else
			if type( arg2 ) == "string" then
				
				if not obj[arg2] then
					ArkInventory.OutputDebug( "could not secure hook ", arg1, ":", arg2, " as it does not exist" )
				else
					ArkInventory.Util.Assert( arg3, "arg3 for MySecureHook is missing" )
					ArkInventory.Util.Assert( type( arg3 ) == "function", "arg3 for MySecureHook is [", type( arg3 ), "], should be [function]" )
					
					ArkInventory.OutputDebug( "secure hooking ", arg1, ":", arg2 )
					ArkInventory:SecureHook( obj, arg2, arg3 )
				end
				
			elseif type( arg2 ) == "function" then
				
				ArkInventory.Util.Assert( not arg3, "arg2 for MySecureHook is [function], should be [string] (as arg3 exists)" )
				ArkInventory.OutputDebug( "secure hooking ", arg1 )
				ArkInventory:SecureHook( arg1, arg2 )
				
			else
				ArkInventory.Util.Error( "arg2 for MySecureHook is [", type( arg2 ), "], should be [string] or [function]" )
			end
		end
		
	end
	
end

function ArkInventory.HookOpenBackpack( self, ... )

--	ArkInventory.OutputDebug( "HookOpenBackpack( )" )
	
	local loc_id = ArkInventory.Const.Location.Bag
	
	if ArkInventory.isLocationControlled( loc_id ) then
		-- original function returns state of backpack being open at time of call
		local BackpackAlreadyOpen = ArkInventory.Frame_Main_Get( loc_id ):IsVisible( )
		ArkInventory.Frame_Main_Show( loc_id )
		return BackpackAlreadyOpen
	end
	
	return ArkInventory.hooks.OpenBackpack( ... )
	
end

function ArkInventory.HookToggleBackpack( self, ... )

--	ArkInventory.OutputDebug( "HookToggleBackpack( )" )
	
	local loc_id = ArkInventory.Const.Location.Bag
	
	if ArkInventory.isLocationControlled( loc_id ) then
		ArkInventory.Frame_Main_Toggle( loc_id )
		return
	end
	
	return ArkInventory.hooks.ToggleBackpack( ... )
	
end

function ArkInventory.HookOpenBag( self, ... )
	
	local blizzard_id = ...
	
	--ArkInventory.Output( "HookOpenBag( ", blizzard_id, " )" )
	
	if blizzard_id then
		
		local map = ArkInventory.Util.MapGetBlizzard( blizzard_id )
		
		local loc_id_window = map.loc_id_window
		
		if loc_id_window == ArkInventory.Const.Location.Bag or ( loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.Bank ) then
			if ArkInventory.isLocationControlled( loc_id_window ) then
				ArkInventory:SendMessage( "EVENT_ARKINV_BAG_OPEN_BUCKET", loc_id_window )
				return
			end
		end
		
	end
	
	return ArkInventory.hooks.OpenBag( ... )
	
end

function ArkInventory.HookCloseBag( self, ... )
	
	local blizzard_id = ...
	
--	ArkInventory.OutputDebug( "HookCloseBag( ", blizzard_id, " )" )
	
	return ArkInventory.hooks.CloseBag( ... )
	
end

function ArkInventory.HookToggleBag( self, ... )
	
	local blizzard_id = ...
	
--	ArkInventory.OutputDebug( "HookToggleBag( ", blizzard_id, " )" )
	
	if blizzard_id then
		
		local map = ArkInventory.Util.MapGetBlizzard( blizzard_id )
		
		local loc_id_window = map.loc_id_window
		
		if loc_id_window == ArkInventory.Const.Location.Bag or ( loc_id_window == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.Bank ) then
			if ArkInventory.isLocationControlled( loc_id_window ) then
				ArkInventory.Frame_Main_Toggle( loc_id_window )
				return
			end
		end
		
	end
	
	return ArkInventory.hooks.ToggleBag( ... )
	
end

function ArkInventory.HookOpenAllBags( self, ... )
	
	--ArkInventory.Output( "---------------" )
	--ArkInventory.Output( "HookOpenAllBags" )
	
	local who = ...
	local whoname = who
	if who then
		whoname = who:GetName( )
	end
	
	local BackpackAlreadyOpen = ArkInventory.Frame_Main_Get( ArkInventory.Const.Location.Bag ):IsVisible( )
	ArkInventory.OutputDebug( "backpack was open: ", BackpackAlreadyOpen )
	
	if whoname then
		
		ArkInventory.OutputDebug( "opened by: ", whoname )
		
		if whoname == "MerchantFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				
				-- this is supposed to stop selling junk to merchants that wont buy anything from you
				-- theres no way to work that out though so sometimes youre screwed no matter what and it will just spit out errors
				if MerchantBuyBackItemItemButton and MerchantBuyBackItemItemButton:IsVisible( ) then
					if GetMerchantNumItems( ) > 0 then
						ArkInventory.Action.Vendor.Run( )
					end
				end
				
				if ArkInventory.db.option.auto.open.merchant == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
				
			end
			
		elseif whoname == "ExtVendor" then
			
			-- third party addon, replaces the merchant interface
			
			ArkInventory.Global.Mode.Merchant = true
			
			if GetMerchantNumItems( ) > 0 then
				--ArkInventory.Output( "auto sell starting" )
				ArkInventory.Action.Vendor.Run( )
			end
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.merchant == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "EngravingFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.rune == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "WardrobeFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.transmog == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "TradeFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.trade == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "AuctionHouseFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.auction == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "GuildBankFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.vault == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "BankFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.bank == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "GwBankFrame" then
			
			-- third party addon
			
			ArkInventory.Global.Mode.Bank = true
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.bank == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "MailFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.mail == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "ScrappingMachineFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.scrap == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "VoidStorageFrame" then
			
			if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
				if ArkInventory.db.option.auto.open.void == ArkInventory.ENUM.BAG.OPENCLOSE.NO and not BackpackAlreadyOpen then
					return
				end
			end
			
		elseif whoname == "AzeriteEssenceUI" or whoname == "ItemInteractionFrame" or whoname == "GearManagerDialogPopup" then
			
			-- dont care about these openers yet, just here to stop the warning message
			
		elseif whoname == "MailCommanderFrame" then
			
			-- third party addon
			-- nothing to do, just stop the warning message
			
		else
			
			ArkInventory.OutputWarning( "code issue - function for [HookOpenAllBags:", whoname, "] was not found - please notify the author so it can be fixed" )
			
		end
		
	end
	
	--ArkInventory.Output( "HookOpenAllBags - part 2" )
	
	if BackpackAlreadyOpen then
		who = nil
		whoname = nil
	end
	
	local loc_id = ArkInventory.Const.Location.Bag
	if not ArkInventory.isLocationControlled( loc_id ) then
--		ArkInventory.OutputDebug( "HookOpenAllBags - closing all bags" )
		CloseAllBags( )
	end
	
	if ArkInventory.Global.Mode.Bank then
		
		local loc_id = ArkInventory.Const.Location.Bank
		if not ArkInventory.isLocationControlled( loc_id ) then
			for x = ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + 1, ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + ArkInventory.Const.BLIZZARD.GLOBAL.BANK.NUM_BAGS do
				if ArkInventory.CrossClient.GetContainerNumSlots( x ) > 0 then
					--ArkInventory.OutputDebug( "HookOpenAllBags - closing bag ", x )
					CloseBag( x )
				end
			end
		end
		
	end
	
	local loc_id = ArkInventory.Const.Location.Bag
--	ArkInventory.OutputDebug( "HookOpenAllBags - opening all bags by ", whoname )
	ArkInventory.Global.BagsOpenedBy = whoname
	ArkInventory.hooks.OpenAllBags( who )
	
	
	if ArkInventory.Global.Mode.Bank then
		
		local loc_id = ArkInventory.Const.Location.Bank
		if not ArkInventory.isLocationControlled( loc_id ) then
			for x = ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + 1, ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + ArkInventory.Const.BLIZZARD.GLOBAL.BANK.NUM_BAGS do
				if ArkInventory.CrossClient.GetContainerNumSlots( x ) > 0 then
--					ArkInventory.OutputDebug( "HookOpenAllBags - opening bag ", x )
					ArkInventory.hooks.OpenBag( x )
				end
			end
		end
		
	end
	
	--ArkInventory.Output( "bags set to opened by ", ArkInventory.Global.BagsOpenedBy )
	
end

function ArkInventory.HookCloseAllBags( self, ... )
	
--	ArkInventory.OutputDebug( "HookCloseAllBags( )" )
	
	local who = ...
	local whoname = who
	if who then
		whoname = who:GetName( )
	end
	
--	ArkInventory.OutputDebug( "closed by ", whoname )
	
	return ArkInventory.hooks.CloseAllBags( ... )
	
end

local function helper_toggle_blizzard_bags( )
	
	local bagsOpen = 0
	local bagsTotal = 0
	
	-- close the open blizzard backpack
	bagsTotal = bagsTotal + 1
	if IsBagOpen( 0 ) then
		bagsOpen = bagsOpen + 1
		CloseBackpack( )
	end
	
	-- close any open blizzard bags
	for x = 1, ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS do
		if ArkInventory.CrossClient.GetContainerNumSlots( x ) > 0 then
			bagsTotal = bagsTotal + 1
			if IsBagOpen( x ) then
				bagsOpen = bagsOpen + 1
				CloseBag( x )
			end
		end
	end
	
	if bagsOpen < bagsTotal then
		
		-- open the backpack and all blizzard bags sequentially
		ArkInventory.hooks.OpenBackpack( )
		for x = 1, ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS do
			if ArkInventory.CrossClient.GetContainerNumSlots( x ) > 0 then
				ArkInventory.hooks.OpenBag( x )
			end
		end
		
	end
	
end

function ArkInventory.HookToggleAllBags( self, ... )
	
	if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) and ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then
		-- ai bags, ai bank
		ArkInventory.Frame_Main_Toggle( ArkInventory.Const.Location.Bag )
		return
	end
	
	if not ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) and not ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then
		-- blizzard bags, blizzard bank
		return ArkInventory.hooks.ToggleAllBags( ... )
	end
	
	
	if not ArkInventory.Global.Mode.Bank then	
		
		-- not at the bank
		
		if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
			
			-- ai bags
			
			ArkInventory.Frame_Main_Toggle( ArkInventory.Const.Location.Bag )
			
		else
			
			-- blizzard bags
			
			helper_toggle_blizzard_bags( )
			
		end
		
	else
		
		-- at the bank
		
		if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
			
			-- ai bags, blizzard bank
			
			local bagsOpen = 0
			local bagsTotal = 0
			
			bagsTotal = bagsTotal + 1
			local BackpackAlreadyOpen = ArkInventory.Frame_Main_Get( ArkInventory.Const.Location.Bag ):IsVisible( )
			if BackpackAlreadyOpen then
				bagsOpen = bagsOpen + 1
				ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
			end
			
			if bagsOpen < bagsTotal then
				
				ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
				
			else
				
				bagsOpen = 0
				bagsTotal = 0
				
				for x = ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + 1, ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + ArkInventory.Const.BLIZZARD.GLOBAL.BANK.NUM_BAGS do
					if ArkInventory.CrossClient.GetContainerNumSlots( x ) > 0 then
						bagsTotal = bagsTotal + 1
						if IsBagOpen( x ) then
							bagsOpen = bagsOpen + 1
							CloseBag( x )
						end
					end
				end
				
				if bagsOpen < bagsTotal then
					
					ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
					
					for x = ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + 1, ArkInventory.Const.BLIZZARD.GLOBAL.CONTAINER.NUM_BAGS + ArkInventory.Const.BLIZZARD.GLOBAL.BANK.NUM_BAGS do
						if ArkInventory.CrossClient.GetContainerNumSlots( x ) > 0 then
							ArkInventory.hooks.OpenBag( x )
						end
					end
					
				end
				
			end
			
		else
			
			-- blizzard bags, ai bank
			
			helper_toggle_blizzard_bags( )
			
		end
		
	end
	
end


function ArkInventory.HookPlayerInteractionShow( ... )
	local self, index = ...
	return ArkInventory.HookPlayerInteractionProcess( index, ArkInventory.Const.BLIZZARD.GLOBAL.FRAME.SHOW )
end

function ArkInventory.HookPlayerInteractionHide( ... )
	local self, index = ...
	return ArkInventory.HookPlayerInteractionProcess( index, ArkInventory.Const.BLIZZARD.GLOBAL.FRAME.HIDE )
end

function ArkInventory.HookPlayerInteractionProcess( index, state, event, ... )

	if ArkInventory:IsEnabled( ) then
		
		local e = event or "PLAYER_INTERACTION_HOOK"
		ArkInventory.OutputDebug( "PlayerInteraction [", index, "] [", state, "] [", e, "]" )
		
		if state == ArkInventory.Const.BLIZZARD.GLOBAL.FRAME.SHOW then
			
			if index == Enum.PlayerInteractionType.None then
				-- do nothing
			elseif index == Enum.PlayerInteractionType.Banker then
				ArkInventory:EVENT_ARKINV_BANK_ENTER( e )
				--if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then return end
			elseif index == Enum.PlayerInteractionType.AccountBanker then
				ArkInventory:EVENT_ARKINV_ACCOUNTBANK_ENTER( e )
				ArkInventory:EVENT_ARKINV_BANK_ENTER( e )
				--if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then return end
			elseif index == Enum.PlayerInteractionType.GuildBanker then
				ArkInventory:EVENT_ARKINV_VAULT_ENTER( e )
				--if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Vault ) then return end
			elseif index == Enum.PlayerInteractionType.MailInfo then
				ArkInventory:EVENT_ARKINV_MAIL_ENTER( e )
			elseif index == Enum.PlayerInteractionType.VoidStorageBanker then
				ArkInventory:EVENT_ARKINV_VOID_ENTER( e )
			elseif index == Enum.PlayerInteractionType.Transmogrifier then
				ArkInventory:EVENT_ARKINV_TRANSMOG_ENTER( e )
			elseif index == Enum.PlayerInteractionType.Auctioneer then
				ArkInventory:EVENT_ARKINV_AUCTION_ENTER( e )
			elseif index == Enum.PlayerInteractionType.TradePartner then
				ArkInventory:EVENT_ARKINV_TRADE_ENTER( e )
			elseif index == Enum.PlayerInteractionType.ObliterumForge then
				ArkInventory:EVENT_ARKINV_OBLITERUM_ENTER( e )
			elseif index == Enum.PlayerInteractionType.ScrappingMachine then
				ArkInventory:EVENT_ARKINV_SCRAP_ENTER( e )
			elseif index == Enum.PlayerInteractionType.Vendor or index == Enum.PlayerInteractionType.Merchant then
				ArkInventory:EVENT_ARKINV_MERCHANT_ENTER( e )
			else
				ArkInventory.OutputDebug( "code issue: PlayerInteraction-Show has uncoded index [", index, "]" )
			end
			
			if not event then
				
--				if InCombatLockdown( ) then
--					ArkInventory.OutputWarning( "you are in combat, opening this interaction window is going to fail due to in combat restrictions" )
--				end
				
				ArkInventory.OutputDebug( "show frame [", index, "]" )
				return ArkInventory.hooks[PlayerInteractionFrameManager].ShowFrame( nil, index )
				
			end
			
		elseif state == ArkInventory.Const.BLIZZARD.GLOBAL.FRAME.HIDE then
			
			if index == Enum.PlayerInteractionType.None then
				-- do nothing
			elseif index == Enum.PlayerInteractionType.Banker then
				ArkInventory:EVENT_ARKINV_BANK_LEAVE( e )
				--if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then return end
			elseif index == Enum.PlayerInteractionType.AccountBanker then
				ArkInventory:EVENT_ARKINV_ACCOUNTBANK_LEAVE( e )
				ArkInventory:EVENT_ARKINV_BANK_LEAVE( e )
				--if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then return end
			elseif index == Enum.PlayerInteractionType.GuildBanker then
				ArkInventory:EVENT_ARKINV_VAULT_LEAVE( e )
				--if ArkInventory.isLocationControlled( ArkInventory.Const.Location.Vault ) then return end
			elseif index == Enum.PlayerInteractionType.MailInfo then
				ArkInventory:EVENT_ARKINV_MAIL_LEAVE( e )
			elseif index == Enum.PlayerInteractionType.VoidStorageBanker then
				ArkInventory:EVENT_ARKINV_VOID_LEAVE( e )
			elseif index == Enum.PlayerInteractionType.Transmogrifier then
				ArkInventory:EVENT_ARKINV_TRANSMOG_LEAVE( e )
			elseif index == Enum.PlayerInteractionType.Auctioneer then
				ArkInventory:EVENT_ARKINV_AUCTION_LEAVE( e )
			elseif index == Enum.PlayerInteractionType.TradePartner then
				ArkInventory:EVENT_ARKINV_TRADE_LEAVE( e )
			elseif index == Enum.PlayerInteractionType.ObliterumForge then
				ArkInventory:EVENT_ARKINV_OBLITERUM_LEAVE( e )
			elseif index == Enum.PlayerInteractionType.ScrappingMachine then
				ArkInventory:EVENT_ARKINV_SCRAP_LEAVE( e )
			elseif index == Enum.PlayerInteractionType.Vendor or index == Enum.PlayerInteractionType.Merchant then
				ArkInventory:EVENT_ARKINV_MERCHANT_LEAVE( e )
			else
				ArkInventory.OutputDebug( "code issue: PlayerInteraction-Hide has uncoded index [", index, "]" )
			end
			
			if not event then
				ArkInventory.OutputDebug( "hide frame [", index, "]" )
				return ArkInventory.hooks[PlayerInteractionFrameManager].HideFrame( nil, index )
			end
			
		else
			
			ArkInventory.OutputWarning( "code issue: PlayerInteraction has unknown state [", state, "]" )
			
		end
		
	end
	
end

function ArkInventory.HookEngravingFrameHide( ... )
	
	if not ArkInventory:IsEnabled( ) then return end
	
	if ArkInventory.db.option.auto.close.rune > ArkInventory.ENUM.BAG.OPENCLOSE.NO and ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bag ) then
		if ArkInventory.db.option.auto.close.rune == ArkInventory.ENUM.BAG.OPENCLOSE.ALWAYS or ArkInventory.Global.BagsOpenedBy == "EngravingFrame" then
			ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
		end
	end
	
end

function ArkInventory.HookDoNothing( self )
	-- ArkInventory.OutputDebug( "HookDoNothing( )" )
	-- do nothing
end

function ArkInventory.HookBankFrame_ShowPanel( ... )
	
	-- account bank panel in bank clicked
	
	local loc_id_window = ArkInventory.Const.Location.Bank
	
	local arg1, arg2, arg3 = ...
	--ArkInventory.Output( "BankFrame_ShowPanel" )
	--ArkInventory.Output( "1 = [", arg1, "]" )
	--ArkInventory.Output( "2 = [", arg2, "]" )
	--ArkInventory.Output( "3 = [", arg3, "]" )
	
	if arg3 == "arkinv" then
		--ArkInventory.Output( "changed by arkinv - ignored" )
		return
	end
	
	if ArkInventory.Global.Location[loc_id_window].isOffline then
		--ArkInventory.Output( "bank window is offline - ignored" )
		return
	end
	
	if ArkInventory.isLocationControlled( loc_id_window ) then
		--ArkInventory.Output( "bank window is controlled by ai - ignored" )
		return
	end
	
	--ArkInventory.Output( "[", BankFrame.activeTabIndex, "]" )
	
	arg1 = BankFrame.activeTabIndex
	
	local map
	if arg1 == 1 then
		map = ArkInventory.Util.MapGetStorage( ArkInventory.Const.Location.Bank, 1 )
	elseif arg1 == 2 then
		map = ArkInventory.Util.MapGetStorage( ArkInventory.Const.Location.ReagentBank, 1 )
	elseif arg1 == 3 then
		map = ArkInventory.Util.MapGetStorage( ArkInventory.Const.Location.AccountBank, 1 )
	else
		ArkInventory.Util.Error( "uncoded bankframe panel [", arg1, "]" )
	end
	
	local framename = string.format( "ARKINV_Frame3ChangerWindowBag%s", map.bag_id_window )
	local frame = _G[framename]
	if frame then
		ArkInventory.Frame_Changer_Slot_OnClick( frame, "LeftButton", true )
	end
	
end

function ArkInventory.HookAccountBankPanelSelectTab( self, ... )
	
	-- accountbank tab clicked
	
	local loc_id_window = ArkInventory.Const.Location.Bank
	
	local arg1 = ...
	--ArkInventory.Output( "HookAccountBankPanelOnBankTabClicked" )
	--ArkInventory.Output( "1 = [", arg1, "]" )
	
	if ArkInventory.Global.Location[loc_id_window].isOffline then
		--ArkInventory.Output( "bank window is offline - ignored" )
		return
	end
	
	if ArkInventory.isLocationControlled( loc_id_window ) then
		--ArkInventory.Output( "bank window is controlled by ai - ignored" )
		return
	end
	
	if arg1 > 0 then
		
		local map = ArkInventory.Util.MapGetBlizzard( arg1 )
		--ArkInventory.Util.setWindowActiveMap( loc_id_window, map )
		
		local framename = string.format( "ARKINV_Frame3ChangerWindowBag%s", map.bag_id_window )
		local frame = _G[framename]
		if frame then
			ArkInventory.Frame_Changer_Slot_OnClick( frame, "LeftButton", true )
		end
		
	end
	
end

function ArkInventory.HookGuildBankPopupOkayButton_OnClick( self )

	--ArkInventory.OutputDebug( "GuildBankPopupOkayButton_OnClick( )" )
	--ArkInventory.hooks.GuildBankPopupOkayButton_OnClick( )
	
	local loc_id = ArkInventory.Const.Location.Vault
	
	if not ArkInventory.Global.Location[loc_id].isOffline then
		ArkInventory.Frame_Main_Generate( loc_id )
	end
	
end

function ArkInventory.HookVoidStorageShow( self, ... )
	ArkInventory:EVENT_ARKINV_VOID_ENTER( ... )
end

function ArkInventory.HookVoidStorageHide( self, ... )
	ArkInventory:EVENT_ARKINV_VOID_LEAVE( ... )
end

function ArkInventory.HookVoidStorageEvent( self, event )
--	ArkInventory.OutputDebug( "void storage event ", event )
end

function ArkInventory.HookFloatingBattlePet_Show( ... )
	
	-- speciesID, level, breedQuality, maxHealth, power, speed, customName, bPetID
	
	--ArkInventory.OutputDebug( "0 - HookFloatingBattlePet_Show" )
	
	if not ArkInventory:IsEnabled( ) then return end
	
	if not ArkInventory.db.option.tooltip.battlepet.enable then return end
	
	FloatingBattlePetTooltip:Hide( )
	
	local h = ArkInventory.BattlepetBaseHyperlink( ... )
	
	if not ItemRefTooltip:IsVisible( ) then
		ItemRefTooltip:SetOwner( UIParent, "ANCHOR_PRESERVE" )
	end
	
	if ItemRefTooltip:IsShown( ) and ItemRefTooltip.ARKTTD[1] == h then
		ItemRefTooltip:Hide( )
	else
		ArkInventory.TooltipCustomBattlepetShow( ItemRefTooltip, h )
	end
	
end

function ArkInventory.HookCPetJournalSetFavorite( ... )
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", "SET_FAVOURITE" )
end

function ArkInventory.HookCPetJournalSetCustomName( ... )
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", "RENAME" )
end

function ArkInventory.HookCToyboxSetFavorite( ... )
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET", "SET_FAVOURITE" )
end

function ArkInventory.LoadAddOn( addonname )
	if ArkInventory.CrossClient.IsAddOnLoaded( addonname ) then
		return true
	else
		local loaded, reason = ArkInventory.CrossClient.LoadAddOn( addonname )
		if reason then
			ArkInventory.OutputError( "Failed to load ", addonname, ": ", _G["ADDON_" .. reason] )
		else
			--ArkInventory.Output( "Loaded ", addonname )
		end
		return not not loaded
	end
end

function ArkInventory.BlizzardAPIHook( disable, reload )
	
	ArkInventory.OutputDebug( "BlizzardAPIHook - Start [", not not disable, "] [", not not reload, "]" )
	
	-- required blizzard internal addons - load them here as they expect to be loaded after the user has logged in, they usually have issues if you try to load them too early
	
	
	if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.CLASSIC ) then
		ArkInventory.LoadAddOn( "Blizzard_EngravingUI" )
	end
	
	
	if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.CATACLYSM ) then
		ArkInventory.LoadAddOn( "Blizzard_Collections" )
	end
	
	
--[[
	if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.PANDARIA ) then
		
		ArkInventory.LoadAddOn( "Blizzard_ScrappingMachineUI" )
		
		if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ) then
			ArkInventory.LoadAddOn( "Blizzard_Professions" )
		else
			ArkInventory.LoadAddOn( "Blizzard_TradeSkillUI" )
		end
		
	end
]]--
	
	--ArkInventory.LoadAddOn( "Blizzard_AuctionHouseUI" )
	
	
	if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) then
		ArkInventory.LoadAddOn( "Blizzard_GuildBankUI" )
	end
	
	
	if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Void].ClientCheck ) then
		ArkInventory.LoadAddOn( "Blizzard_VoidStorageUI" )
	end
	
	
	if not ArkInventory.Global.BlizzardAPIHook then
		
		-- void storage
		if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Void].ClientCheck ) then
			VoidStorageFrame:HookScript( "OnShow", ArkInventory.HookVoidStorageShow )
			VoidStorageFrame:HookScript( "OnHide", ArkInventory.HookVoidStorageHide )
		end
		
		
		-- collections
		if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].ClientCheck ) then
			PetJournal:HookScript( "OnHide", ArkInventory.Collection.Pet.OnHide )
		end
		
		if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].ClientCheck ) then
			MountJournal:HookScript( "OnHide", ArkInventory.Collection.Mount.OnHide )
		end
		
		if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Heirloom].ClientCheck ) then
			HeirloomsJournal:HookScript( "OnHide", ArkInventory.Collection.Heirloom.OnHide )
		end
		
		if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Toybox].ClientCheck ) then
			ToyBox:HookScript( "OnHide", ArkInventory.Collection.Toybox.OnHide )
		end
		
		if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Currency].ClientCheck ) then
			TokenFrame:HookScript( "OnHide", ArkInventory.Collection.Currency.OnHide )
		end
		
		if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Reputation].ClientCheck ) then
			ReputationFrame:HookScript( "OnHide", ArkInventory.Collection.Reputation.OnHide )
		end
		
		ArkInventory.Global.BlizzardAPIHook = true
		
	end
	
	if not disable and not reload then
		
		-- backpack functions
		ArkInventory:RawHook( "OpenBackpack", "HookOpenBackpack", true )
		ArkInventory:RawHook( "ToggleBackpack", "HookToggleBackpack", true )
		
		BackpackTokenFrame:SetWidth(500) -- allows GetMaxTokensWatched to return 10
		if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT, ArkInventory.ENUM.EXPANSION.DRAGONFLIGHT ) then
			ArkInventory.MySecureHook( "TokenFrame_SetTokenWatched", ArkInventory.EVENT_ARKINV_BACKPACK_TOKEN_UPDATE )
		elseif ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.TBC, ArkInventory.ENUM.EXPANSION.SHADOWLANDS ) then
			ArkInventory.MySecureHook( "BackpackTokenFrame_Update", ArkInventory.EVENT_ARKINV_BACKPACK_TOKEN_UPDATE )
		end
		
		
--		part of testing the professions addon being loaded up front
--		ArkInventory.MySecureHook( ScrollBoxListLinearViewMixin, "CalculateDataIndices", ArkInventory.CalculateDataIndices )
		
		
		-- bag functions
		ArkInventory:RawHook( "OpenBag", "HookOpenBag", true )
--		ArkInventory:RawHook( "CloseBag", "HookCloseBag", true ) -- this will cause taint when in combat now, so dont
		ArkInventory:RawHook( "ToggleBag", "HookToggleBag", true )
		ArkInventory:RawHook( "OpenAllBags", "HookOpenAllBags", true )
--		ArkInventory:RawHook( "CloseAllBags", "HookCloseAllBags", true ) -- this will cause taint when in combat now, so dont
		if ToggleAllBags then
			ArkInventory:RawHook( "ToggleAllBags", "HookToggleAllBags", true )
		end
		
		
		if EngravingFrame then
			ArkInventory.MySecureHook( "EngravingFrame_OnHide", ArkInventory.HookEngravingFrameHide )
		end
		
		
		-- bank functions (now opens via the ui panels in all versions)
		if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.CLASSIC ) then
			ArkInventory:RawHook( PlayerInteractionFrameManager, "ShowFrame", ArkInventory.HookPlayerInteractionShow, true )
			ArkInventory:RawHook( PlayerInteractionFrameManager, "HideFrame", ArkInventory.HookPlayerInteractionHide, true )
		end
		
		ArkInventory.MySecureHook( "BankFrame_ShowPanel", ArkInventory.HookBankFrame_ShowPanel )
		
		if ArkInventory.ClientCheck( ArkInventory.ENUM.EXPANSION.WARWITHIN ) then
			ArkInventory.MySecureHook( "AccountBankPanel", "SelectTab", ArkInventory.HookAccountBankPanelSelectTab )
		end
		
		
		-- mailbox fuctions
		ArkInventory.MySecureHook( "SendMail", ArkInventory.HookMailSend )
		ArkInventory.MySecureHook( "ReturnInboxItem", ArkInventory.HookMailReturn )
		
		
		-- battlepet functions
		ArkInventory.MySecureHook( "C_PetJournal", "SetFavorite", ArkInventory.HookCPetJournalSetFavorite )
		ArkInventory.MySecureHook( "C_PetJournal", "SetCustomName", ArkInventory.HookCPetJournalSetCustomName )
		
		
		-- toybox functions
		ArkInventory.MySecureHook( "C_ToyBox", "SetIsFavorite", ArkInventory.HookCToyboxSetFavorite )
		
		
		-- battlepet tooltips
		ArkInventory.MySecureHook( "BattlePetToolTip_Show", ArkInventory.HookBattlePetToolTip_Show )
		ArkInventory.MySecureHook( "FloatingBattlePet_Show", ArkInventory.HookFloatingBattlePet_Show )
		
		
		-- covenant sanctum, deposit button, mount check (no longer required, you are automatically dismounted now)
		--ArkInventory.MySecureHook( "C_CovenantSanctumUI", "DepositAnima", ArkInventory.HookCovenantSanctumDepositAnima )
		
		
		-- tradeskill tooltips
		--ArkInventory.MySecureHook( "C_TradeSkillUI", "SetTooltipRecipeResultItem", ArkInventory.HookC_TradeSkillUI_SetTooltipRecipeResultItem )
		
		
		-- tooltips
		for func, proj in pairs( ArkInventory.Const.BLIZZARD.TooltipFunctions ) do
			if true or proj then -- fix this once the table is sorted out
				-- one off error message here instead of one per tooltip below
				local myfunc = "HookTooltip"..func
				if not ArkInventory[myfunc] then
					ArkInventory.OutputWarning( "code issue - a matching function for [", myfunc, "] was not found!" )
				end
			end
		end
		
		
		for _, obj in pairs( ArkInventory.Global.Tooltip.WOW ) do
			if obj then
				
				ArkInventory.TooltipMyDataClear( obj )
				
				for func, proj in pairs( ArkInventory.Const.BLIZZARD.TooltipFunctions ) do
					if true or proj then -- fix this once the table is sorted out
						local myfunc = "HookTooltip"..func
						ArkInventory.MySecureHook( obj:GetName( ), func, ArkInventory[myfunc] )
					end
				end
				
				if obj:HasScript( "OnTooltipSetUnit" ) then
					if ArkInventory.ClientCheck( nil, ArkInventory.ENUM.EXPANSION.SHADOWLANDS ) then
						-- battlepet mouseovers (retail only check is in the hook function)
						--ArkInventory.Output( obj:GetName( ), " hooking OnTooltipSetUnit" )
						obj:HookScript( "OnTooltipSetUnit", ArkInventory.HookOnTooltipSetUnit )
					end
				end
				
				obj:HookScript( "OnUpdate", ArkInventory.HookTooltipOnUpdate )
				obj:HookScript( "OnShow", ArkInventory.HookTooltipOnShow )
				obj:HookScript( "OnHide", ArkInventory.HookTooltipOnHide )
				
				if obj == ItemRefTooltip then
					obj:HookScript( "OnEnter", ArkInventory.HookTooltipOnEnter )
					obj:HookScript( "OnLeave", ArkInventory.HookTooltipOnLeave )
				end
				
			end
		end
		
--		for x = 1, NUM_FACTIONS_DISPLAYED do
--			local obj = _G["ReputationBar" .. x]
--			obj:HookScript( "OnEnter", ArkInventory.TooltipAddCustomReputationToCharacterFrame )
--		end
		
	end
	
	
	if disable then
		ArkInventory.Frame_Main_Hide( )
	end
	
	
	-- bank
	if disable or not ArkInventory.isLocationControlled( ArkInventory.Const.Location.Bank ) then
		BankFrame:SetParent( UIParent )
		--BankFrame:RegisterEvent( "BANKFRAME_OPENED" )
	else
		ArkInventory.CrossClient.CloseBankFrame( )
		BankFrame:SetParent( ARKINV_Hidden )
		--BankFrame:UnregisterEvent( "BANKFRAME_OPENED" )
	end
	
	
	-- guild bank
	if ArkInventory.ClientCheck( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].ClientCheck ) then
		
		if not GuildBankFrame or not GuildBankPopupFrame then
			
			ArkInventory.OutputWarning( "GuildBankFrame or GuildBankPopupFrame are missing, cannot monitor or override vault" )
			
		else
			
			if disable or not ArkInventory.isLocationControlled( ArkInventory.Const.Location.Vault ) then
				
				-- restore guild bank functions
				
				--UIParent:RegisterEvent( "GUILDBANKFRAME_OPENED" )
				
				GuildBankFrame:SetParent( UIParent )
				--GuildBankFrame:RegisterEvent( "GUILDBANKBAGSLOTS_CHANGED" )
				--GuildBankFrame:RegisterEvent( "GUILDBANK_ITEM_LOCK_CHANGED" )
				--GuildBankFrame:RegisterEvent( "GUILDBANK_UPDATE_TABS" )
				--GuildBankFrame:RegisterEvent( "GUILDBANK_UPDATE_MONEY" )
				--GuildBankFrame:RegisterEvent( "GUILDBANK_UPDATE_TEXT" )
				--GuildBankFrame:RegisterEvent( "GUILD_ROSTER_UPDATE" )
				--GuildBankFrame:RegisterEvent( "GUILDBANKLOG_UPDATE" )
				--GuildBankFrame:RegisterEvent( "GUILDTABARD_UPDATE" )
				
				-- anchor pop-up to blizzard frame
				local frame = _G["GuildBankFrame"]
				if frame then
					GuildBankPopupFrame:ClearAllPoints( )
					GuildBankPopupFrame:SetPoint( "TOPLEFT", frame, "TOPRIGHT", -4, -30 )
				end
				
			else
				
				-- sever guild bank functions
				
				--UIParent:UnregisterEvent( "GUILDBANKFRAME_OPENED" )
				
				GuildBankFrame:SetParent( ARKINV_Hidden )
				--GuildBankFrame:UnregisterEvent( "GUILDBANKBAGSLOTS_CHANGED" )
				--GuildBankFrame:UnregisterEvent( "GUILDBANK_ITEM_LOCK_CHANGED" )
				--GuildBankFrame:UnregisterEvent( "GUILDBANK_UPDATE_TABS" )
				--GuildBankFrame:UnregisterEvent( "GUILDBANK_UPDATE_MONEY" )
				--GuildBankFrame:UnregisterEvent( "GUILDBANK_UPDATE_TEXT" )
				--GuildBankFrame:UnregisterEvent( "GUILD_ROSTER_UPDATE" )
				--GuildBankFrame:UnregisterEvent( "GUILDBANKLOG_UPDATE" )
				--GuildBankFrame:UnregisterEvent( "GUILDTABARD_UPDATE" )
				
				--GuildBankFrame:Hide( )
				
				-- anchor popup to AI frame
				local frame = _G[string.format( ArkInventory.Const.Frame.Main.Name, ArkInventory.Const.Location.Vault )]
				if frame then
					GuildBankPopupFrame:Hide( )
					GuildBankPopupFrame:ClearAllPoints( )
					GuildBankPopupFrame:SetPoint( "TOPLEFT", frame, "TOPRIGHT", -4, -30 )
				end
				
			end
			
		end
		
	end
	
	
	-- tooltips
	if disable or not ArkInventory.db.option.tooltip.show then
		for _, obj in pairs( ArkInventory.Global.Tooltip.WOW ) do
			ArkInventory.TooltipMyDataClear( tooltip )
		end
	else
		for _, obj in pairs( ArkInventory.Global.Tooltip.WOW ) do
			if obj then
				
				if ArkInventory.db.option.tooltip.scale.enabled then
					if not obj.IsEmbedded then
						-- do not scale embedded tooltips, theyre already scaled from their parent
						obj:SetScale( ArkInventory.db.option.tooltip.scale.amount or 1 )
					end
				end
				
			end
		end
	end
	
	
	-- battlepet tooltips
	if C_PetJournal then
		if disable or not ArkInventory.db.option.tooltip.battlepet.enable then
			ItemRefTooltip:Hide( )
		else
			FloatingBattlePetTooltip:Hide( )
		end
	end
	
	ArkInventory.OutputDebug( "BlizzardAPIHook - End" )
	
end



function ArkInventory.ClassColourRGB( class )
	
	if not class then return end
	
	local ct = nil
	
	-- reminder: ct will be pointing to a secured variable, if you change it you'll taint it and screw up AI (and a lot of other mods as well) - so dont.
	
	if class == ArkInventory.Const.Class.Guild then
		ct = ORANGE_FONT_COLOR
	elseif class == ArkInventory.Const.Class.Account then
		ct = YELLOW_FONT_COLOR
	else
		ct = ( CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] ) or RAID_CLASS_COLORS[class]
	end
	
	if not ct then
		return
	end
	
	local c = { r = ct.r <= 1 and ct.r >= 0 and ct.r or 0, g = ct.g <= 1 and ct.g >= 0 and ct.g or 0, b = ct.b <= 1 and ct.b >= 0 and ct.b or 0 }
	
	return c
	
end

function ArkInventory.ClassColourCode( class )
	
	local c = ArkInventory.ClassColourRGB( class )
	
	if not c then
		return HIGHLIGHT_FONT_COLOR:GenerateHexColor( )
	end
	
	return string.format( "|cff%02x%02x%02x", c.r * 255, c.g * 255, c.b * 255 )
	
end
	
function ArkInventory.ColourRGBtoCode( r, g, b, a, clean )
	
	if not r or not g or not b then
		return WHITE_FONT_COLOR:GenerateHexColor( )
	end
	
	local r = r <= 1 and r >= 0 and r or 0
	local g = g <= 1 and g >= 0 and g or 0
	local b = b <= 1 and b >= 0 and b or 0
	
	local a = a or 1
	a = a <= 1 and a >= 0 and a or 1
	
	local c = string.format( "%02x%02x%02x%02x", a * 255, r * 255, g * 255, b * 255 )
	if clean then
		return c
	else
		return string.format( "|c%s", c )
	end
	
end


function ArkInventory.CreateColour( r, g, b, a, f )
	
	local c = r
	local r = r
	local g = g
	local b = b
	local a = a
	local f = f -- false = return default colour on fail, true = return nil on fail
	
	if type( r ) == "string" then
		
		--ArkInventory.OutputDebug( string.gsub( c, "\124", "\124\124" ) )
		f = g
		a, r, g, b = string.match( c, "^|c(%x%x)([%x%s]%x)(%x%x)(%x%x)" )
		if not a then
			a, r, g, b = string.match( c, "^(%x%x)([%x%s]%x)(%x%x)(%x%x)" )
			if not a then
				r, g, b = string.match( c, "^(%x%x)(%x%x)(%x%x)" )
				a = "ff"
			end
		end
		
		if f and ( not a or not r or not g or not b ) then return end
		
		--ArkInventory.OutputDebug( r, "-", g, "-", b, "+", a )
		-- the trading parts colour has a space instead of a zero in the 3rd position for some reason
		-- at some point i need to work out if its from the alpha or the red value, im guessing red at the moment as they are a fairly bright light blue, almost heirloom
		
		a = ( tonumber( a or "ff", 16 ) or 255 ) / 255
		r = ( tonumber( r or "ff", 16 ) or 255 ) / 255
		g = ( tonumber( g or "ff", 16 ) or 255 ) / 255
		b = ( tonumber( b or "ff", 16 ) or 255 ) / 255
		
	end
	
	if f and not r and not g and not b then return end
	
	c = CreateColor( r, g, b, a )
	
	c.GenerateHexColor = function( self )
		-- we need the alpha so overwite the existing function
		local r, g, b, a = self:GetRGBAAsBytes( )
		return ("%.2x%.2x%.2x%.2x"):format( a, r, g, b )
	end
	
	--ArkInventory.OutputDebug( c:WrapTextInColorCode( "this should be coloured text" ) )
	
	return c
	
end

function ArkInventory.StripColourCodes( txt )
	local txt = txt or ""
	txt = string.gsub( txt, "|c%x%x%x%x%x%x%x%x", "" )
	txt = string.gsub( txt, "|c%x%x %x%x%x%x%x", "" ) -- the trading parts colour has a space instead of a zero in the 3rd position for some reason
	txt = string.gsub( txt, "|r", "" )
	return txt
end

function ArkInventory.ContainerNameGet( loc_id, ItemFrameType )
	
	if loc_id ~= nil then
		
		local base = ArkInventory.Const.Frame.Main.Name
		if ItemFrameType == ArkInventory.Const.ItemFrameType.Popup then
			base = ArkInventory.FrameBarPopupNameGet( )
		end
		
		local name = string.format( "%s%s%s", base, loc_id, ArkInventory.Const.Frame.Container.Name )
		return name, _G[name]
		
	end
end

function ArkInventory.ContainerBarNameGet( loc_id, bar_id )
	local name = ArkInventory.ContainerNameGet( loc_id )
	if name and bar_id ~= nil then
		name = string.format( "%s%s%s", name, "Bar", bar_id )
		return name, _G[name]
	end
end

function ArkInventory.ContainerBagNameGet( loc_id, bag_id, ItemFrameType )
	local name = ArkInventory.ContainerNameGet( loc_id, ItemFrameType )
	if name and bag_id ~= nil then
		name = string.format( "%s%s%s", name, "Bag", bag_id )
		return name, _G[name]
	end
end

function ArkInventory.ContainerItemNameGet( loc_id, bag_id, slot_id, ItemFrameType )
	local name = ArkInventory.ContainerBagNameGet( loc_id, bag_id, ItemFrameType )
	if name and slot_id ~= nil then
		name = string.format( "%s%s%s", name, "Item", slot_id )
		return name, _G[name]
	end
end

function ArkInventory.ToggleChanger( loc_id )
	local codex = ArkInventory.Codex.GetLocation( loc_id )
	codex.style.changer.hide = not codex.style.changer.hide
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
end

function ArkInventory.ToggleEditMode( )
	ArkInventory.Lib.Dewdrop:Close( )
	ArkInventory.Global.Mode.Edit = not ArkInventory.Global.Mode.Edit
	--ArkInventory.OutputWarning( "ToggleEditMode - .restart window draw" )
	for loc_id, loc_data in pairs( ArkInventory.Global.Location ) do
		if loc_data.isMapped and loc_data.canView then
			ArkInventory.Global.Location[loc_id].retryCount = 0
		end
	end
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Restart )
	--ArkInventory.Frame_Bar_Paint_All( )
end

function ArkInventory.Frame_Vault_Log_Update( )
	
	local loc_id_window = ArkInventory.Const.Location.Vault
	
	local active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
	local bag_id_window = active_map.bag_id_window
	
	local numTransactions = 0
	if GuildBankFrame.mode == "log" then
		numTransactions = GetNumGuildBankTransactions( bag_id_window ) or 0
	elseif GuildBankFrame.mode == "moneylog" then
		numTransactions = GetNumGuildBankMoneyTransactions( ) or 0
	end
	
	local maxLines = numTransactions
	
	if GuildBankFrame.mode == "moneylog" then
		maxLines = maxLines + 2
	end
	
	if numTransactions == 0 then
		maxLines = 1
	end
	
	local obj = _G[string.format( "%s%s%s%s", ArkInventory.Const.Frame.Main.Name, loc_id_window, ArkInventory.Const.Frame.Log.Name, ArkInventory.Const.Frame.Scrolling.List )]
	obj:SetMaxLines( 0 )
	obj:SetMaxLines( maxLines )
	obj:ScrollToTop( )
	
	--obj:SetInsertMode( "TOP" )
	--obj:AddMessage( "-*- end of list -*-" )
	
	if numTransactions == 0 then
		obj:AddMessage( ArkInventory.Localise["NO_DATA_AVAILABLE"] )
	end
	
	local msg, transaction, name, h, count, tab1, tab2, amount, year, month, day, hour, money
	
	for i = 1, numTransactions do
		
		if GuildBankFrame.mode == "log" then
			transaction, name, h, count, tab1, tab2, year, month, day, hour = GetGuildBankTransaction( bag_id_window, i )
		elseif GuildBankFrame.mode == "moneylog" then
			transaction, name, amount, year, month, day, hour = GetGuildBankMoneyTransaction( i )
		end
		
		if not name then
			name = UNKNOWN
		end
		
		name = string.format( "%s%s%s", NORMAL_FONT_COLOR_CODE, name, FONT_COLOR_CODE_CLOSE )
		
		if GuildBankFrame.mode == "log" then
			
			if transaction == "deposit" then
				msg = format( GUILDBANK_DEPOSIT_FORMAT, name, h )
				if count > 1 then
					msg = string.format( "%s%s", msg, string.format( GUILDBANK_LOG_QUANTITY, count ) )
				end
			elseif transaction == "withdraw" then
				msg = string.format( GUILDBANK_WITHDRAW_FORMAT, name, h )
				if count > 1 then
					msg = string.format( "%s%s", msg, format( GUILDBANK_LOG_QUANTITY, count ) )
				end
			elseif transaction == "move" then
				msg = format( GUILDBANK_MOVE_FORMAT, name, h, count, GetGuildBankTabInfo( tab1 ), GetGuildBankTabInfo( tab2 ) )
			end
			
		elseif GuildBankFrame.mode == "moneylog" then
			
			money = GetDenominationsFromCopper( amount )
			
			if transaction == "deposit" then
				msg = format( GUILDBANK_DEPOSIT_MONEY_FORMAT, name, money )
			elseif transaction == "withdraw" then
				msg = format( GUILDBANK_WITHDRAW_MONEY_FORMAT, name, money )
			elseif transaction == "repair" then
				msg = format( GUILDBANK_REPAIR_MONEY_FORMAT, name, money )
			elseif transaction == "withdrawForTab" then
				msg = format( GUILDBANK_WITHDRAWFORTAB_MONEY_FORMAT, name, money )
			elseif transaction == "buyTab" then
				msg = format( GUILDBANK_BUYTAB_MONEY_FORMAT, name, money )
			end
			
		end
		
		if msg then
			obj:AddMessage( string.format( "%s%s%s", msg, ArkInventory.Const.BLIZZARD.GLOBAL.GUILDBANK.LOG_TIME_PREPEND, string.format( GUILD_BANK_LOG_TIME, RecentTimeDate( year, month, day, hour ) ) ) )
		end
		
	end
	
	if GuildBankFrame.mode == "moneylog" then
		obj:AddMessage( " " )
		obj:AddMessage( string.format( "%s %s", GUILDBANK_CASHFLOW, GetDenominationsFromCopper( GetGuildBankBonusDepositMoney( ) ) ) )
	end
	
	--ArkInventory.OutputWarning( "Frame_Vault_Log_Update - .Recalculate" )
	ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Recalculate )
	
end

function ArkInventory.Frame_Vault_Info_Update( )
	
	local loc_id_window = ArkInventory.Const.Location.Vault
	
	local active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
	local bag_id_window = active_map.bag_id_window
	
	local obj = _G[string.format( "%s%s%s%s", ArkInventory.Const.Frame.Main.Name, loc_id_window, ArkInventory.Const.Frame.Info.Name, "ScrollInfo" )]
	
	local text = GetGuildBankText( bag_id_window )
	if text then
		obj.text = text
		obj:SetText( text )
	else
		obj.text = ""
		obj:SetText( "" )
	end
	
	--ArkInventory.OutputWarning( "Frame_Vault_Info_Update - .Recalculate" )
	ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Recalculate )
	
end

function ArkInventory.Frame_Vault_Info_Changed( self )
	
	local loc_id_window = ArkInventory.Const.Location.Vault
	
	local active_map = ArkInventory.Util.getWindowActiveMap( loc_id_window )
	local bag_id_window = active_map.bag_id_window
	
	local button = _G[self:GetParent( ):GetParent( ):GetName( ) .. "Save"]
	
	if bag_id_window <= GetNumGuildBankTabs( ) and CanEditGuildTabInfo( bag_id_window ) and self:GetText( ) ~= self.text then
		button:Enable( )
	else
		button:Disable( )
	end
	
end

function ArkInventory.ScrollingMessageFrame_Scroll( parent, name, direction )

	if not parent or not name then
		return
	end
	
	local obj = _G[string.format( "%s%s", parent:GetName( ), name )]
	if not obj then
		return
	end
	
	local i = obj:GetInsertMode( )
	
	if i == "TOP" then
	
		if direction == "up" and not obj:AtBottom( ) then
			obj:ScrollDown( )
		elseif direction == "pageup" and not obj:AtBottom( ) then
			obj:PageDown( )
		elseif direction == "down" and not obj:AtTop( ) then
			obj:ScrollUp( )
		elseif direction == "pagedown" and not obj:AtTop( ) then
			obj:PageUp( )
		end
	
	else
	
		if direction == "up" and not obj:AtTop( ) then
			obj:ScrollUp( )
		elseif direction == "pageup" and not obj:AtTop( ) then
			obj:PageUp( )
		elseif direction == "down" and not obj:AtBottom( ) then
			obj:ScrollDown( )
		elseif direction == "pagedown" and not obj:AtBottom( ) then
			obj:PageDown( )
		end
	
	end
	
end

function ArkInventory.ScrollingMessageFrame_ScrollWheel( parent, name, direction )
	
	if direction == 1 then
		ArkInventory.ScrollingMessageFrame_Scroll( parent, name, "down" )
	else
		ArkInventory.ScrollingMessageFrame_Scroll( parent, name, "up" )
	end
	
end

function ArkInventory.isLocationMonitored( loc_id_window )
	if ArkInventory.ClientCheck( ArkInventory.Global.Location[loc_id_window].ClientCheck ) then
		local me = ArkInventory.Codex.GetPlayer( loc_id_window )
		return me.profile.location[loc_id_window].monitor
	end
end

function ArkInventory.LocationMonitorChanged( loc_id_window )
	
	--ArkInventory.OutputDebug( "LocationMonitorChanged( ", loc_id, " )" )
	
	ArkInventory.ObjectCacheCountClear( nil, nil, loc_id_window )
	
	if loc_id_window == ArkInventory.Const.Location.Tradeskill then
		ArkInventory.Tradeskill.OnEnable( )
	else
		ArkInventory.ScanLocationWindow( loc_id_window )
	end
	
end

function ArkInventory.isLocationControlled( loc_id_window )
	if ArkInventory.ClientCheck( ArkInventory.Global.Location[loc_id_window].ClientCheck ) then
		local me = ArkInventory.Codex.GetPlayer( loc_id_window )
		return me.profile.location[loc_id_window].override
	end
end

function ArkInventory.isLocationSaved( loc_id_window )
	if ArkInventory.ClientCheck( ArkInventory.Global.Location[loc_id_window].ClientCheck ) then
		local me = ArkInventory.Codex.GetPlayer( loc_id_window )
		return me.profile.location[loc_id_window].save
	end
	return false
end

function ArkInventory.DisplayName1( p )
	
	-- window titles (normal)
	local name = p.name or ArkInventory.Localise["UNKNOWN"]
	if ( p.istimerunner or 0 ) > 0 then
		name = string.format( "%s%s", ArkInventory.Const.Texture.TimeRunnerText, name )
	end
	
	if p.class == ArkInventory.Const.Class.Account then
		return name
	else
		return string.format( "%s\n%s > %s", name, p.faction_local or ArkInventory.Localise["UNKNOWN"], p.realm or ArkInventory.Localise["UNKNOWN"] )
	end
end

function ArkInventory.DisplayName2( p )
	
	-- switch menu
	
	local name = p.name or ArkInventory.Localise["UNKNOWN"]
	if ( p.istimerunner or 0 ) > 0 then
		name = string.format( "%s%s", ArkInventory.Const.Texture.TimeRunnerText, name )
	end
	
	if p.class == ArkInventory.Const.Class.Account then
		return name
	else
		return string.format( "%s > %s > %s", p.realm or ArkInventory.Localise["UNKNOWN"], p.faction_local or ArkInventory.Localise["UNKNOWN"], name )
	end
	
end

function ArkInventory.DisplayName3( p, paint, ref )
	
	-- tooltip item/gold count
	
	ArkInventory.Util.Assert( p, "p is nil" )
	
	local me = ArkInventory.Codex.GetPlayer( )
	local ref = ref or me.player.data.info
	
	local name = p.name or ArkInventory.Localise["UNKNOWN"]
	if ( p.istimerunner or 0 ) > 0 then
		name = string.format( "%s%s", ArkInventory.Const.Texture.TimeRunnerText, name )
	end
	if paint then
		name = string.format( "%s%s", ArkInventory.ClassColourCode( p.class ), name )
	end
	
	local realm = p.realm or ArkInventory.Localise["UNKNOWN"]
	if p.class == ArkInventory.Const.Class.Account or realm == ref.realm then
		realm = ""
	else
		realm = string.format( " - %s", realm )
	end
	
	local faction_local = p.faction_local or ArkInventory.Localise["UNKNOWN"]
	if p.class == ArkInventory.Const.Class.Account or faction_local == ref.faction_local then
		faction_local = ""
	else
		faction_local = string.format( " [%s]", faction_local )
	end
	
	local account = ""
	if p.account_id ~= ref.account_id then
		account = string.format( " (** %s **)", ArkInventory.db.account.data[p.account_id].name or ArkInventory.Localise["UNKNOWN"] )
	end
	
	local r = string.format( "%s%s%s%s", name, realm, faction_local, account )
	if paint then
		r = string.format( "%s|r", r )
	end
	
	return r
	
end

function ArkInventory.DisplayName4( p, f )
	
	-- switch character
	
	if p.class == ArkInventory.Const.Class.Account then
		
		return string.format( "%s%s|r", ArkInventory.ClassColourCode( p.class ), p.name or ArkInventory.Localise["UNKNOWN"] )
		
	else
		
		local name = p.name or ArkInventory.Localise["UNKNOWN"]
		if ( p.istimerunner or 0 ) > 0 then
			name = string.format( "%s%s", ArkInventory.Const.Texture.TimeRunnerText, name )
		end
		
		local class = p.class_local or ArkInventory.Localise["UNKNOWN"] 
		
		local level = p.level or ArkInventory.Localise["UNKNOWN"]
		
		local faction = ""
		if p.faction == f then
			faction = string.format( " [%s]", p.faction_local or ArkInventory.Localise["UNKNOWN"] )
		end
		
		return string.format( "%s%s (%s:%s)%s|r", ArkInventory.ClassColourCode( p.class ), name, class, level, faction )
		
	end
	
end

function ArkInventory.DisplayName5( p )
	
	-- window titles (thin)
	
	local name = p.name or ArkInventory.Localise["UNKNOWN"]
	if ( p.istimerunner or 0 ) > 0 then
		name = string.format( "%s%s", ArkInventory.Const.Texture.TimeRunnerText, name )
	end
	
	return name
	
end

function ArkInventory.MemoryUsed( c )

	if c then
		collectgarbage( "stop" )
	end

	--UpdateAddOnMemoryUsage( )

	--local am = GetAddOnMemoryUsage( ArkInventory.Const.Program.Name ) * 1000
	local am = collectgarbage( "count" )
	
	if not c then
		collectgarbage( "restart" )
	end
	
	return am

end

function ArkInventory.TimeAsMinutes( )
	return math.floor( time( date( '*t' ) ) / 60 ) -- minutes
end

function ArkInventory.ItemAgeGet( age )
	
	if age and type( age ) == "number" then
		
		local s = ArkInventory.Localise["DHMS"]
		
		local x = ArkInventory.TimeAsMinutes( ) - age
		local m = x + 1 -- push seconds up so that items with less than a minute get displayed
		
		local d = math.floor( m / 1440 )
		m = math.floor( m - d * 1440 )
		local h = math.floor( m / 60 )
		m = math.floor( m - h * 60 )
		
		local t = ""
		
--[[
		if d > 0 then
			t = string.format( "%d%s ", d, string.sub( s, 1, 1 ) )
		end
		
		if h > 0 or ( d > 0 and m > 0 ) then
			t = string.format( "%s%d%s ", t, h, string.sub( s, 2, 2 ) )
		end
		
		if m > 0 and d == 0 then -- only show minutes if were not into days
			t = string.format( "%s%d%s", t, m, string.sub( s, 3, 3 ) )
		end
]]--
		
		if d > 0 then
			t = string.format( "%d:%d%s", d, h, string.sub( s, 1, 1 ) )
		elseif h > 0 then
			t = string.format( "%d:%d%s", h, m, string.sub( s, 2, 2 ) )
		else
			t = string.format( "%d%s", m, string.sub( s, 3, 3 ) )
		end
		
		return x, string.trim( t )
		
	end
	
	return false, ""
	
end

function ArkInventory.StartupChecks( )
	
end

function ArkInventory.UiSetEditBoxLabel( frame, label )
	
	ArkInventory.Util.Assert( frame, "frame is nil" )
	
	local objname = string.format( "%s%s", frame:GetName( ), "Label" )
	local obj = _G[objname]
	ArkInventory.Util.Assert( obj, "xml object [", objname, "] was not found" )
	
	ArkInventory.Util.Assert( label, "label is nil" )
	
	obj:SetText( label )
	
end

function ArkInventory.UiTabToNext( frame, c, p, n )
	
	ArkInventory.Util.Assert( frame, "frame is nil" )
	ArkInventory.Util.Assert( c, "c is nil" )
	ArkInventory.Util.Assert( p, "p is nil" )
	ArkInventory.Util.Assert( n, "n is nil" )
	
	local f = frame:GetName( )
	f = string.sub( f, 1, string.len( f ) - string.len( c ) )
	
	if IsShiftKeyDown( ) then
		f = string.format( "%s%s", f, p )
	else
		f = string.format( "%s%s", f, n )
	end
	
	local w = _G[f]
	ArkInventory.Util.Assert( w, "invalid prev/next argument [", f, "]" )
	w:SetFocus( )
	
end


function ArkInventory.ThreadRunning( thread_id )
	
	if not thread_id then return end
	if not ArkInventory.Global.Thread.Use then return end
	
	local data = ArkInventory.Global.Thread.data[thread_id]
	if data and data.thread and type( data.thread ) == "thread" and coroutine.status( data.thread ) ~= "dead" then
		return true
	end
	
	return false
	
end

function ArkInventory.ThreadStart( thread_id, thread_func )
	
	if ArkInventory.Global.Thread.Use and thread_id then
		
		local threads = ArkInventory.Global.Thread.data
		
		if threads[thread_id] then
			
			ArkInventory.OutputThread( thread_id, " restarting" )
			
		else
			
			local tz = debugprofilestop( )
			
			ArkInventory.OutputThread( thread_id, " starting" )
			threads[thread_id] = {
				timer = nil, -- if the thread needs to wait before running again then this needs to be set
				duration = 0, -- how long the thread actually ran for
			}
			
			
			if thread_id == ArkInventory.Global.Thread.Format.ActionVendor then
				threads[thread_id].timer = ArkInventory.db.option.thread.timeout.junksell
			elseif thread_id == ArkInventory.Global.Thread.Format.ActionUse then
				threads[thread_id].timer = ArkInventory.db.option.thread.timeout.useitem
			elseif thread_id == ArkInventory.Global.Thread.Format.ActionScrap then
				threads[thread_id].timer = ArkInventory.db.option.thread.timeout.actionscrap
			elseif thread_id == ArkInventory.Global.Thread.Format.Tradeskill then
				--threads[thread_id].timer = ArkInventory.db.option.thread.timeout.tradeskill
			end
			
		end
		
		threads[thread_id].resumed = debugprofilestop( )
		threads[thread_id].thread = coroutine.create( thread_func )
		
		ARKINV_ThreadTimer:Show( )
		
	else
		
		local tz = debugprofilestop( )
		ArkInventory.OutputThread( thread_id, " starting" )
		thread_func( )
		tz = debugprofilestop( ) - tz
		ArkInventory.OutputThread( thread_id, string.format( " took %0.0fms", tz ) )
		
	end
	
end

function ArkInventory.ThreadResume( )
	
	local threads = ArkInventory.Global.Thread.data
	
	--ArkInventory.Output( threads )
	
	local tz = debugprofilestop( )
	
	-- the onupdate timer controls the resume loop
	
	
	-- find the first suspended thread that is allowed to resume, then resume it
	-- it lets us run them in a priority order (based on a sorted thread_id)
	
	for thread_id, data in ArkInventory.spairs( threads, function( a, b ) return a < b end ) do
		
		if data and data.thread and type( data.thread ) == "thread" then
			
			if coroutine.status( data.thread ) == "suspended" then
				
				if ( data.event or data.temp_event ) and ( not data.temp_timer ) then
					
					-- event based threads use the timer value as a backup timeout
					-- if the event hasnt triggered by then the thread will be resumed
					
					local event = data.temp_event or data.event
					
					--ArkInventory.Output( "ignoring thread [", thread_id, "] pending event [", event, "]" )
					return false
					
				elseif data.timer or data.temp_timer then
					
					-- threads that have to wait a certain amount of time before they can run again
					
					local timer = data.temp_timer or data.timer
					
					if data.duration < timer then
						
						-- increment duration until timer is reached
						
						if data.duration == 0 then
							data.resumed = tz - 1 -- needs a small offset or duration never gets off zero
						end
						
						data.duration = tz - data.resumed
						
						--ArkInventory.OutputThread( string.format( "%s %s waiting %0.2fms (%0.2fms)", thread_id, coroutine.status( data.thread ), data.duration, timer ) )
						
						return false
						
					else
						
						--ArkInventory.OutputThread( string.format( "%s %s waited %0.2fms (%0.2fms)", thread_id, coroutine.status( data.thread ), data.duration, timer ) )
						
						data.temp_timer = nil
						data.temp_event = nil
						
						local ok, errmsg = coroutine.resume( data.thread )
						
						-- yields come back here
						
						if not ok then
							ArkInventory.Util.Error( errmsg )
						end
						
						data.duration = 0
						
						return false
						
					end
					
				else
					
					-- threads that can be resumed at any time
					-- they just needed to yield so as not to reach the script timer
					
					data.resumed = tz
					
					local ok, errmsg = coroutine.resume( data.thread )
					
					-- yields come back here
					
					tz = debugprofilestop( ) - data.resumed
					data.duration = data.duration + tz
					ArkInventory.OutputThread( string.format( "%s %s after %0.2fms (%0.2fms)", thread_id, coroutine.status( data.thread ), tz, data.duration ) )
					
					if not ok then
						ArkInventory.OutputWarning( errmsg )
						--error( errmsg )
					end
					
					return false
					
				end
				
			else
				
				ArkInventory.OutputThread( thread_id, ": clearing (state is ", coroutine.status( data.thread ), ")" )
				ArkInventory.Global.Thread.data[thread_id] = nil
				return false
				
			end
			
		else
			
			ArkInventory.OutputThread( thread_id, ": clearing (not a thread)" )
			ArkInventory.Global.Thread.data[thread_id] = nil
			return false
			
		end
		
	end
	
	return true
	
end

function ArkInventory.ThreadResume_Event( event )
	
	-- find all suspended threads that are waiting for an event and resume them
	
	ArkInventory.Util.Assert( type( event ) == "string", "event is [", type( event ), "], should be [string]" )
	
	--ArkInventory.Output( "resume based on event [", event, "]" )
	
	local threads = ArkInventory.Global.Thread.data
	
	for thread_id, data in ArkInventory.spairs( threads, function( a, b ) return a < b end ) do
		if data and data.thread and type( data.thread ) == "thread" then
			if coroutine.status( data.thread ) == "suspended" then
				
				if data.temp_event == event then
					
					-- threads waiting for a specific event to happen before they can run again
					-- the event function needs to call the resume function or it will never resume
					
					--ArkInventory.Output( "resuming event thread [", thread_id, "]" )
					
					data.temp_timer = nil
					data.temp_event = nil
					
					local ok, errmsg = coroutine.resume( data.thread )
					
					-- yields come back here
					
					if not ok then
						ArkInventory.Util.Error( errmsg )
					end
					
					data.duration = 0
					
				end
				
			end
		end
	end
	
end

function ArkInventory.ThreadYield( thread_id, force_override, temp_timer, temp_event )
	
	-- if thread_id is nil, it will just return back where it came from.  it should really error
	ArkInventory.Util.Assert( type( thread_id ) == "string", "thread_id is [", type( thread_id ), "], should be [string]" )
	
	-- no point doing anything if threads are disabled
	if not ArkInventory.Global.Thread.Use then return end
	
	local thread = ArkInventory.Global.Thread.data[thread_id]
	if not thread then
		ArkInventory.Output( "thread id [", thread_id, "] was not found" )
	end
	
	-- if you call this function before a thread reaches its duration we return back to the thread immediately
	-- we will only actually yield if the duration has been breached, or force_override is set
	
	local tz = debugprofilestop( )
	
	-- duration is how many milliseconds the thread has been running since it was last resumed
	local duration = tz - thread.resumed or 0
	
	-- timeout is how many milliseconds the thread is allowed to run before its forced to yield
	local timeout = 50 --ArkInventory.db.option.thread.timeout.normal
	
	-- if you set temp_timer it needs to forcibly yield for it to kick in
	if temp_timer then
		--ArkInventory.Output( "setting temporary timer to [", temp_timer, "]" )
		thread.temp_timer = temp_timer
		force_override = true
	end
	
	-- if you set temp_event it needs to forcibly yield for it to kick in
	if temp_event then
		--ArkInventory.Output( "setting temporary event to [", temp_event, "]" )
		thread.temp_event = temp_event
		force_override = true
	end
	
	
	if thread_id == ArkInventory.Global.Thread.Format.Tooltip then
		
		--timeout = ArkInventory.db.option.thread.timeout.tooltip
		
	elseif thread_id == ArkInventory.Global.Thread.Format.ObjectData then
		
		--timeout = ArkInventory.db.option.thread.timeout.objectdata
		
	elseif thread_id == ArkInventory.Global.Thread.Format.Search then
		
		timeout = 50
		
	elseif thread_id == ArkInventory.Global.Thread.Format.Tradeskill then
		
		timeout = 100
		
	elseif thread_id == ArkInventory.Global.Thread.Format.ActionVendor then
		
		force_override = true
		
	elseif thread_id == ArkInventory.Global.Thread.Format.ActionMail then
		
		force_override = true
		
	elseif thread_id == ArkInventory.Global.Thread.Format.ActionUse then
		
		force_override = true
		
	elseif thread_id == ArkInventory.Global.Thread.Format.ActionScrap then
		
		force_override = true
		
	elseif thread_id == ArkInventory.Global.Thread.Format.Restack then
		
		
		
	else
		
		if InCombatLockdown( ) then
			--timeout = ArkInventory.db.option.thread.timeout.combat
		end
		
	end
	
	if force_override or duration >= timeout then
		
		if force_override then
			--ArkInventory.OutputThread( string.format( "%s forced yield (%0.0fms)", thread_id, duration ) )
		else
			--ArkInventory.OutputThread( string.format( "%s yielding %0.0f >= %0.0f", thread_id, duration, timeout ) )
		end
		
		--ArkInventory.Output( "yielding ", thread_id )
		ARKINV_ThreadTimer:Show( )
		coroutine.yield( )
		
		-- thread will resume here
		
	else
		
		--ArkInventory.OutputThread( string.format( "%s continue %0.0f <= %0.0f", thread_id, duration, timeout ) )
		
	end
	
end


function ArkInventory.ThreadYield_Force( thread_id )
	ArkInventory.ThreadYield( thread_id, true )
end

function ArkInventory.ThreadYield_Scan( thread_id )
	ArkInventory.ThreadYield( thread_id )
end

function ArkInventory.ThreadYield_Window( loc_id )
	local thread_id
	if loc_id then
		thread_id = string.format( ArkInventory.Global.Thread.Format.Window, loc_id )
	end
	ArkInventory.ThreadYield( thread_id )
end

function ArkInventory.CheckPlayerHasControl( )
	
	if UnitOnTaxi( "player" ) or UnitInVehicle( "player" ) then
		return false, ERR_CLIENT_ON_TRANSPORT
	end
	
	if C_LossOfControl.GetNumEvents then
		
		if C_LossOfControl.GetNumEvents( ) > 0 then
			local locType, spellID, text, iconTexture, startTime, timeRemaining, duration, lockoutSchool, priority, displayType = C_LossOfControl.GetEventInfo( 1 )
			return false, string.format( SPELL_FAILED_PREVENTED_BY_MECHANIC, text )
		end
	
	elseif C_LossOfControl.GetActiveLossOfControlDataCount then
		
		if C_LossOfControl.GetActiveLossOfControlDataCount( ) > 0 then
			local tbl = C_LossOfControl.GetActiveLossOfControlData( 1 )
			return false, string.format( SPELL_FAILED_PREVENTED_BY_MECHANIC, tbl.displayText or ArkInventory.Localise["UNKNOWN"] )
		end
		
	end
	
	return true
	
end

function ArkInventory.EditModeMove( Type, loc_id, bar_id, cat_id )
	
	-- move via menu
	
	if frame then
		local i = ArkInventory.Frame_Item_GetDB( frame )
		loc_id = i.loc_id
		cat_id = ArkInventory.ItemCategoryGet( i )
		bar_id = ArkInventory.CategoryLocationGet( loc_id, cat_id )
	end

	ArkInventory.Global.Options.MoveType = Type
	ArkInventory.Global.Options.MoveLocation = loc_id
	ArkInventory.Global.Options.MoveSourceBar = bar_id
	ArkInventory.Global.Options.MoveSourceData = cat_id
	ArkInventory.Global.Options.MoveSourceFrame = frame
	
end

function ArkInventory.EditModeIsDragging( )
	if ArkInventory.Global.Mode.Edit and ArkInventory.Global.Options.OnDragSourceFrame then
		return true
	end
end

function ArkInventory.EditModeOnDragSet( dragtype, frame )
	
	-- move from drag and drop
	
	local loc_id = frame and frame.ARK_Data.loc_id
	local bar_id = frame and frame.ARK_Data.bar_id
	local cat_id
	
	if frame then
		local i = ArkInventory.Frame_Item_GetDB( frame )
		if i then
			cat_id = ArkInventory.ItemCategoryGet( i )
			bar_id = ArkInventory.CategoryLocationGet( loc_id, cat_id )
		end
	end
	
	ArkInventory.Global.Options.OnDragSourceFrame = frame
	ArkInventory.Global.Options.OnDragType = dragtype
	ArkInventory.Global.Options.OnDragLocation = loc_id
	ArkInventory.Global.Options.OnDragSourceBar = bar_id
	ArkInventory.Global.Options.OnDragSourceCategory = cat_id
	
end

function ArkInventory.IsBound( bind )
	if bind == ArkInventory.ENUM.ITEM.BINDING.PICKUP or bind == ArkInventory.ENUM.ITEM.BINDING.ACCOUNT then
		return true
	end
end

function ArkInventory.SetCursor( cursor )
	if cursor then
		SetCursor( cursor )
	else
		ResetCursor( )
	end
end

ArkInventory.MailRecipients = { }
function ArkInventory.GenerateMailRecipients( )
	
	local me = ArkInventory.Codex.GetPlayer( )
	local show, player, text
	
	for n, tp in ArkInventory.spairs( ArkInventory.db.player.data, function( a, b ) return ( a < b ) end ) do
		
		show = true
		
		if tp.info.class == ArkInventory.Const.Class.Guild then
			show = false
		elseif tp.info.class == ArkInventory.Const.Class.Account then
			show = false
		elseif tp.info.faction ~= me.player.data.info.faction then
			show = false
		end
		
		if show then
			
			player = string.gsub( tp.info.player_id, "%s+", "" )
			player = string.lower( player )
			
			text = ArkInventory.DisplayName3( tp.info, true )
			
			ArkInventory.MailRecipients[player] = text
			
		end
		
	end
	
end

function ArkInventory.LocationOverrideSet( loc_id, value )
	
	if value and not ArkInventory:IsEnabled( ) then
		ArkInventory:Enable( )
	end
	
	local codex = ArkInventory.Codex.GetPlayer( loc_id )
	
	if value then
		-- enabled ai for this location - hide any opened blizzard frames
		if loc_id == ArkInventory.Const.Location.Bag then
			CloseAllBags( )
		elseif loc_id == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.Bank then
			ArkInventory.CrossClient.CloseBankFrame( )
		elseif loc_id == ArkInventory.Const.Location.Vault and ArkInventory.Global.Mode.Vault then
			CloseGuildBankFrame( )
		end
	else
		-- disabled ai for this location - hide ai frame
		ArkInventory.Frame_Main_Hide( loc_id )
	end
	
	codex.profile.location[loc_id].override = value
	ArkInventory.BlizzardAPIHook( false, true )
	
end

function ArkInventory:EVENT_ARKINV_DRAGONRACE_ENTER( ... )
	
	--ArkInventory.Output( "dragon race started" )
	
end

function ArkInventory:EVENT_ARKINV_DRAGONRACE_LEAVE( ... )
	
	--ArkInventory.Output( "dragon race ended" )
	
	for loc_id in pairs( ArkInventory.Global.ScanAfterDragonRace ) do
		
		ArkInventory.Global.ScanAfterDragonRace[loc_id] = nil
		
		if loc_id == ArkInventory.Const.Location.Pet then
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", "DRAGONRACE_ENDED" )
		elseif loc_id == ArkInventory.Const.Location.Mount then
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE_BUCKET", "DRAGONRACE_ENDED" )
		elseif loc_id == ArkInventory.Const.Location.Toybox then
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET", "DRAGONRACE_ENDED" )
		elseif loc_id == ArkInventory.Const.Location.Heirloom then
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_HEIRLOOM_UPDATE_BUCKET", "DRAGONRACE_ENDED" )
		elseif loc_id == ArkInventory.Const.Location.Currency then
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_CURRENCY_UPDATE_BUCKET", "DRAGONRACE_ENDED" )
		elseif loc_id == ArkInventory.Const.Location.Reputation then
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", "DRAGONRACE_ENDED" )
		end
		
	end
	
end

function ArkInventory.DragonRaceCheck( )
	--ArkInventory.Output( "race check" )
	if not ArkInventory.Global.Mode.DragonRace then
		-- was not previously racing, am i in a race now?
		if ArkInventory.CrossClient.GetItemCount( ArkInventory.Const.DragonRaceItem ) == 1 then
			ArkInventory.Global.Mode.DragonRace = true
			ArkInventory.EVENT_ARKINV_DRAGONRACE_ENTER( )
		end
	else
		-- was previously in a race, has it ended?
		if ArkInventory.CrossClient.GetItemCount( ArkInventory.Const.DragonRaceItem ) == 0 then
			ArkInventory.Global.Mode.DragonRace = false
			ArkInventory.EVENT_ARKINV_DRAGONRACE_LEAVE( )
		end
	end
end

function ArkInventory:EVENT_ARKINV_UNIT_AURA_BUCKET( events )
	
end

function ArkInventory:EVENT_ARKINV_UNIT_AURA( event, ... )
	
	local arg1, arg2, arg3 = ...
	
	if arg1 == "player" then
		--ArkInventory.Output( "event = [", event, "] [", arg1, "] [", arg2, "] [", arg3, "]" )
		--ArkInventory:SendMessage( "EVENT_ARKINV_UNIT_AURA_BUCKET", event )
		ArkInventory.DragonRaceCheck( )
	end
	
end





local factor_slot = 1000
local factor_bag = 100
local factor_loc = 10000

function ArkInventory.LocationEncode( loc_id, bag_id, slot_id )
	return ( slot_id or factor_slot - 1 ) + ( ( bag_id or factor_bag - 1 ) * factor_slot ) + ( ( loc_id or factor_loc - 1 ) * factor_slot * factor_bag )
end

-- /dump ArkInventory.LocationDecode( 102005 )
function ArkInventory.LocationDecode( id )
	
	local loc_id = ( id or factor_slot * factor_bag * factor_loc - 1 )
	local slot_id = mod( loc_id, factor_slot )
	loc_id = ( loc_id - slot_id ) / factor_slot
	local bag_id = mod( loc_id, factor_bag )
	loc_id = ( loc_id - bag_id ) / factor_bag
	
	--ArkInventory.Output( "id ", loc_id, "-", bag_id, "-", slot_id )
	
	if slot_id == 999 then slot_id = nil end
	if bag_id == 99 then bag_id = nil end
	if loc_id == 9999 then loc_id = nil end
	
	return loc_id, bag_id, slot_id
	
end
