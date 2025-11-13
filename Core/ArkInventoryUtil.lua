ArkInventory.Util = { }

--[[

code error:
is missing = could not be found
could not be found = was not found

]]--

local function ErrorDepth( level, ... )
	local msg = ArkInventory.OutputError( ... )
	error( msg, level )
end

function ArkInventory.Util.Error( ... )
	ErrorDepth( 2, ... )
end

function ArkInventory.Util.Assert( test, ... )
	if not test then
		ErrorDepth( 3, ... )
	end
end


function ArkInventory.Util.MapAddBag( info )
	
	-- blizzard_id = blizzard bag id
	-- loc_id_window = window location this bag belongs to
	-- loc_id_storage = storage location this bag belongs to
	-- bag_type = what type of bag slot this is
	-- hidden = do not add to list of bags to include in the window for this location
	
	-- bag_id_window = internal window bag id
	-- bag_id_storage = internal storage bag id
	
	
--[[
	ArkInventory.Global.Map = {
		Blizzard = {
			[blizzard_id] = <info>,
		},
		Storage = {
			[storage_loc_id] = {
				Bag = {
					[bag_id_storage] = <info>,
				},
				Parent = [loc_id_window],
			},
		},
		Window = {
			[loc_id_window] = {
				Bag = {
					[bag_id_window] = <info>,
				},
				Children = {
					[loc_id_storage] = Storage[loc_id_storage],
				},
			},
		},
	},
	
]]--
	
	local Map = ArkInventory.Global.Map
	
	ArkInventory.Util.Assert( type( info ) == "table", "info is [", type( info ), "], should be [table]" )
	
	
	local blizzard_id = info.blizzard_id
	
	ArkInventory.Util.Assert( type( blizzard_id ) == "number", "blizzard_id in map table is [", type( blizzard_id ), "], should be [number]" )
	ArkInventory.Util.Assert( not Map.Blizzard[blizzard_id], "blizzard_id [", blizzard_id, "] is already mapped to ", Map.Blizzard[blizzard_id] )
	
	local loc_id_window = info.loc_id_window
	
	ArkInventory.Util.Assert( type( loc_id_window ) == "number", "loc_id_window in map table is [", type( loc_id_window ), "], should be [number]" )
	ArkInventory.Util.Assert( ArkInventory.Global.Location[loc_id_window], "ArkInventory.Global.Location[", loc_id_window, "] is not mapped" )
	
	local loc_id_storage = info.loc_id_storage or info.loc_id_window
	info.loc_id_storage = loc_id_storage
	
	ArkInventory.Util.Assert( type( loc_id_storage ) == "number", "loc_id_storage in map table is [", type( loc_id_storage ), "], should be [number]" )
	ArkInventory.Util.Assert( ArkInventory.Global.Location[loc_id_storage], "ArkInventory.Global.Location[", loc_id_storage, "] is not mapped" )
	
	
	
	
	if info.fixed then
		info.texture = info.texture or ArkInventory.Global.Location[loc_id_storage].Texture or ArkInventory.Global.Location[loc_id_window].Texture
	end
	
	info.inv_id = ArkInventory.CrossClient.ContainerIDToInventoryID( blizzard_id )
	
	if not info.panel_id then
		info.panel_id = 1
	end
	
	
	if ArkInventory.ClientCheck( ArkInventory.Global.Location[loc_id_storage].ClientCheck ) then
		
		--ArkInventory.Output( "added bag for storage [", blizzard_id, " ", ArkInventory.Global.Location[loc_id_storage].Name, "]" )
		
		-- mark the location as active
		ArkInventory.Global.Location[loc_id_storage].isMapped = true
		
		--ArkInventory.Global.Location[loc_id_window].bagCount = ArkInventory.Global.Location[loc_id_window].bagCount or 0
		ArkInventory.Global.Location[loc_id_window].maxSlot = ArkInventory.Global.Location[loc_id_window].maxSlot or { }
		ArkInventory.Global.Location[loc_id_window].maxBar = ArkInventory.Global.Location[loc_id_window].maxBar or 0
		ArkInventory.Global.Location[loc_id_window].drawState = ArkInventory.Global.Location[loc_id_window].drawState or ArkInventory.Const.Window.Draw.Init
		
		
		
		-- add bag to blizzard table
		Map.Blizzard[blizzard_id] = info
		
		
		
		-- init storage table
		Map.Storage[loc_id_storage] = Map.Storage[loc_id_storage] or { Bag = { }, Parent = nil }
		
		-- add bag to storage table
		local bag_id_storage = #Map.Storage[loc_id_storage].Bag + 1
		info.bag_id_storage = bag_id_storage
		Map.Storage[loc_id_storage].Bag[bag_id_storage] = info
		
		
		
		-- set parent window
		Map.Storage[loc_id_storage].Parent = loc_id_window
		
		
		
		-- init window table
		Map.Window[loc_id_window] = Map.Window[loc_id_window] or { Bag = { }, Children = { } }
		
		-- link child storage location
		Map.Window[loc_id_window].Children[loc_id_storage] = true --Map.Storage[loc_id_storage]
		
		
		
		if not info.hidden then
			
			-- add bag to window table
			local bag_id_window = #Map.Window[loc_id_window].Bag + 1
			info.bag_id_window = bag_id_window
			Map.Window[loc_id_window].Bag[bag_id_window] = info
			
			--ArkInventory.OutputDebug( "added bag map for blizzard [", blizzard_id, "], ", ArkInventory.Global.Location[loc_id_window].Name, " window [", loc_id_window, ".", bag_id_window, "], ", ArkInventory.Global.Location[loc_id_storage].Name, " storage [", loc_id_storage, ".", bag_id_storage, "]" )
			
		else
			
			--ArkInventory.OutputDebug( "added bag map for blizzard [", blizzard_id, "], ", ArkInventory.Global.Location[loc_id_window].Name, " window [", loc_id_window, "], ", ArkInventory.Global.Location[loc_id_storage].Name, " storage [", loc_id_storage, ".", bag_id_storage, "]" )
			
		end
		
	end
	
end


function ArkInventory.Util.MapCheckBlizzard( blizzard_id )
	
	local Map = ArkInventory.Global.Map
	
	if type( blizzard_id ) == "number" and Map.Blizzard[blizzard_id] then
		return true
	end
	
end

function ArkInventory.Util.MapGetBlizzard( blizzard_id )
	
	local Map = ArkInventory.Global.Map
	
	if blizzard_id == nil then
		
		return Map.Blizzard
		
	else
		
		ArkInventory.Util.Assert( type( blizzard_id ) == "number", "blizzard_id is [", type( blizzard_id ), "], should be [number]" )
		ArkInventory.Util.Assert( Map.Blizzard[blizzard_id], "Map.Blizzard[", blizzard_id, "] is not mapped" )
		
		return Map.Blizzard[blizzard_id]
		
	end
	
end

function ArkInventory.Util.MapGetBlizzardStorageFirst( blizzard_id )
	-- return the map for the first sotrage bag in the window where the blizzard_id is from
	local src_map = ArkInventory.Util.MapGetBlizzard( blizzard_id )
	for _, map in ipairs( ArkInventory.Util.MapGetWindow( src_map.loc_id_window ) ) do
		if ( not map.hidden ) and ( map.loc_id_storage == src_map.loc_id_storage ) and ( map.bag_id_storage == 1 ) then
			return map
		end
	end
end

function ArkInventory.Util.getWindowIdFromBlizzardBagId( blizzard_id )
	local map = ArkInventory.Util.MapGetBlizzard( blizzard_id )
	return map.loc_id_window, map.bag_id_window
end

function ArkInventory.Util.getStorageIdFromBlizzardBagId( blizzard_id )
	local map = ArkInventory.Util.MapGetBlizzard( blizzard_id )
	return map.loc_id_storage, map.bag_id_storage
end


function ArkInventory.Util.MapCheckWindow( loc_id_window, bag_id_window )
	
	local Map = ArkInventory.Global.Map
	
	if type( loc_id_window ) == "number" and Map.Window[loc_id_window] then
		
		if ArkInventory.Global.Location[loc_id_window].canView then
			
			if bag_id_window == nil then
				
				return true
				
			else
				
				if type( bag_id_window ) == "number" and Map.Window[loc_id_window].Bag[bag_id_window] then
					return true
				end
				
			end
			
		end
		
	end
	
end

function ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local Map = ArkInventory.Global.Map
	
	if loc_id_window == nil and bag_id_window == nil then
		
		return Map.Window
		
	else
		
		ArkInventory.Util.Assert( type( loc_id_window ) == "number", "loc_id_window is [", type( loc_id_window ), "], should be [number]" )
		ArkInventory.Util.Assert( Map.Window[loc_id_window], "Map.Window[", loc_id_window, "] is not mapped" )
		
		if bag_id_window == nil then
			
			return Map.Window[loc_id_window].Bag
			
		else
			
			ArkInventory.Util.Assert( type( bag_id_window ) == "number", "bag_id_window is [", type( bag_id_window ), "], should be [number]" )
			ArkInventory.Util.Assert( Map.Window[loc_id_window].Bag[bag_id_window], "Map.Window[", loc_id_window, "].Bag[", bag_id_window, "] is not mapped" )
			
			return Map.Window[loc_id_window].Bag[bag_id_window]
			
		end
		
	end
	
end

function ArkInventory.Util.getBlizzardBagIdFromWindowId( loc_id_window, bag_id_window )
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	return map.blizzard_id
end

function ArkInventory.Util.getInventoryIDFromWindow( loc_id_window, bag_id_window, slot_id )
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local loc_id_storage = map.loc_id_storage
	local bag_id_storage = map.bag_id_storage
	
	return ArkInventory.Util.getInventoryIDFromStorage( loc_id_storage, bag_id_storage, slot_id )
	
end


function ArkInventory.Util.MapCheckStorage( loc_id_storage, bag_id_storage )
	
	local Map = ArkInventory.Global.Map
	
	if type( loc_id_storage ) == "number" and Map.Storage[loc_id_storage] then
		
		if bag_id_storage == nil then
			
			return true
			
		else
			
			if type( bag_id_storage ) == "number" and Map.Storage[loc_id_storage].Bag[bag_id_storage] then
				return true
			end
			
		end
		
	end
	
end

function ArkInventory.Util.MapGetStorage( loc_id_storage, bag_id_storage )
	
	local Map = ArkInventory.Global.Map
	
	if loc_id_storage == nil and bag_id_storage == nil then
		
		return Map.Storage
		
	else
		
		ArkInventory.Util.Assert( type( loc_id_storage ) == "number", "loc_id_storage is [", type( loc_id_storage ), "], should be [number]" )
		ArkInventory.Util.Assert( Map.Storage[loc_id_storage], "Map.Storage[", loc_id_storage, "] is not mapped" )
		
		if bag_id_storage == nil then
			
			return Map.Storage[loc_id_storage].Bag
			
		else
			
			ArkInventory.Util.Assert( type( bag_id_storage ) == "number", "bag_id_storage is [", type( bag_id_storage ), "], should be [number]" )
			ArkInventory.Util.Assert( Map.Storage[loc_id_storage].Bag[bag_id_storage], "Map.Storage[", loc_id_storage, "].Bag[", bag_id_storage, "] is not mapped" )
			
			return Map.Storage[loc_id_storage].Bag[bag_id_storage]
			
		end
		
	end
	
end

function ArkInventory.Util.getBlizzardBagIdFromStorageId( loc_id_storage, bag_id_storage )
	local map = ArkInventory.Util.MapGetStorage( loc_id_storage, bag_id_storage )
	return map.blizzard_id
end

function ArkInventory.Util.getInventoryIDFromStorage( loc_id_storage, bag_id_storage, slot_id )
	
	local map = ArkInventory.Util.MapGetStorage( loc_id_storage, bag_id_storage )
	
	local blizzard_id = map.blizzard_id
	
	if loc_id_storage == ArkInventory.Const.Location.Bag and bag_id_storage > 1 then
		
		return ArkInventory.CrossClient.ContainerIDToInventoryID( blizzard_id )
		
	elseif loc_id_storage == ArkInventory.Const.Location.ReagentBag then
		
		return ArkInventory.CrossClient.ContainerIDToInventoryID( blizzard_id )
		
	elseif loc_id_storage == ArkInventory.Const.Location.Wearing then
		
		for k, v in pairs( ArkInventory.Const.InventorySlotName ) do
			if k == slot_id then
				local id = GetInventorySlotInfo( v )
				return id
			end
		end
		
	elseif loc_id_storage == ArkInventory.Const.Location.Bank and bag_id_storage > 1 then
		
		return ArkInventory.CrossClient.ContainerIDToInventoryID( blizzard_id )
		
	end
	
end


function ArkInventory.Util.MapGetParent( loc_id_storage )
	
	local Map = ArkInventory.Global.Map
	
	ArkInventory.Util.Assert( type( loc_id_storage ) == "number", "loc_id_storage is [", type( loc_id_storage ), "], should be [number]" )
	ArkInventory.Util.Assert( Map.Storage[loc_id_storage], "Map.Storage[", loc_id_storage, "] is not mapped" )
	
	return Map.Storage[loc_id_storage].Parent
	
end

function ArkInventory.Util.MapGetChildren( loc_id_window )
	
	local Map = ArkInventory.Global.Map
	
	ArkInventory.Util.Assert( type( loc_id_window ) == "number", "loc_id_window is [", type( loc_id_window ), "], should be [number]" )
	ArkInventory.Util.Assert( Map.Window[loc_id_window], "Map.Window[", loc_id_window, "] is not mapped" )
	
	return Map.Window[loc_id_window].Children
	
end

function ArkInventory.Util.CheckZeroSizeBag( count, blizzard_id )
	
	if count == 0 then
		
		if ArkInventory.db.option.bugfix.zerosizebag.alert then
			local loc_id, bag_id = ArkInventory.Util.getStorageIdFromBlizzardBagId( blizzard_id )
			ArkInventory.OutputWarning( "Aborted scan of blizzard bag [", blizzard_id, "], location [", loc_id, " / ", ArkInventory.Global.Location[loc_id].Name, "], bag [", bag_id, "], size returned was ", count, ", rescan has been scheduled for 5 seconds.  This warning can be disabled in the config menu" )
		end
		
		ArkInventory:SendMessage( "EVENT_ARKINV_BAG_RESCAN_BUCKET", blizzard_id )
		
		return true
		
	end
	
end

function ArkInventory.Util.isAccountBankUnlocked( )
	return ArkInventory.Util.MapCheckStorage( ArkInventory.Const.Location.AccountBank )
end


function ArkInventory.Util.WindowPanelBagToggle( codex, loc_id_window, bag_id_window )
	codex.player.data.option[loc_id_window].bag[bag_id_window].display = not codex.player.data.option[loc_id_window].bag[bag_id_window].display
end

function ArkInventory.Util.WindowPanelBagDisplayAll( codex, loc_id_window )
	for x, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		codex.player.data.option[loc_id_window].bag[x].display = true
	end
end

function ArkInventory.Util.WindowPanelBagShowAll( codex, loc_id_window, panel_id )
	for x, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		if panel_id == map.panel_id then
			codex.player.data.option[loc_id_window].bag[x].display = true
		end
	end
end

function ArkInventory.Util.WindowPanelBagIsolate( codex, loc_id_window, bag_id_window, panel_id )
	for x, map in ipairs( ArkInventory.Util.MapGetWindow( loc_id_window ) ) do
		if panel_id == map.panel_id then
			if bag_id_window == map.bag_id_window then
				codex.player.data.option[loc_id_window].bag[x].display = true
			else
				codex.player.data.option[loc_id_window].bag[x].display = false
			end
		end
	end
end


function ArkInventory.Util.getWindowActiveMap( loc_id_window )
	
	ArkInventory.Util.Assert( type( loc_id_window ) == "number", "loc_id_window is [", type( loc_id_window ), "], should be [number]" )
	
	ArkInventory.Util.setWindowActiveMap( loc_id_window )
	
	return ArkInventory.Global.Location[loc_id_window].active_map
	
end

function ArkInventory.Util.setWindowActiveMap( loc_id_window, map )
	
	ArkInventory.Util.Assert( type( loc_id_window ) == "number", "loc_id_window is [", type( loc_id_window ), "], should be [number]" )
	
	local bag_id_window = 1
	map = map or ArkInventory.Global.Location[loc_id_window].active_map

	if ArkInventory.Const.BLIZZARD.CLIENT.ELEVEN_POINT_TWO and loc_id_window == ArkInventory.Const.Location.Bank then

		local me = ArkInventory.Codex.GetPlayer( )

		if map then

			me.profile.location[loc_id_window].lastselected.bag_id_window = map.bag_id_window

		else

			if me.profile.location[loc_id_window].lastselected.remember == ArkInventory.ENUM.TAB_RESELECT.ALWAYS then
				
				bag_id_window = me.profile.location[loc_id_window].lastselected.bag_id_window

			end

		end

	end

	ArkInventory.Global.Location[loc_id_window].active_map = map or ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )

end

function ArkInventory.Util.setBankPanelLayout( )
	
	local panel_id = 1
	local loc_id_window = ArkInventory.Const.Location.Bank
	local codex = ArkInventory.Codex.GetLocation( ArkInventory.Const.Location.Bank )
	local combine = codex.player.data.panel.bank.combine
	
	if combine.all then
		
		local loc_id_storage = ArkInventory.Const.Location.Bank
		if ArkInventory.Global.Location[loc_id_storage].ClientCheck then
			
			if ArkInventory.Util.MapCheckStorage( loc_id_storage ) then
				for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
					map.panel_id = 1
				end
			end

		end
		
		local loc_id_storage = ArkInventory.Const.Location.ReagentBank
		if ArkInventory.Global.Location[loc_id_storage].ClientCheck then
			
			if ArkInventory.Util.MapCheckStorage( loc_id_storage ) then
				for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
					map.panel_id = 1
				end
			end

		end
		
		local loc_id_storage = ArkInventory.Const.Location.AccountBank
		if ArkInventory.Global.Location[loc_id_storage].ClientCheck then
			
			if ArkInventory.Util.MapCheckStorage( loc_id_storage ) then
				for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
					map.panel_id = 1
				end
			end

		end

	else
		
		local loc_id_storage = ArkInventory.Const.Location.Bank
		if ArkInventory.Global.Location[loc_id_storage].ClientCheck then
			
			if ArkInventory.Util.MapCheckStorage( loc_id_storage ) then
				for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
					
					if not combine.bank then
						panel_id = panel_id + 1
					end
					
					map.panel_id = panel_id

				end
			end
			
			

		else
			--codex.player.data.panel.bank.combine.bank = false
		end
		
		local loc_id_storage = ArkInventory.Const.Location.ReagentBank
		if ArkInventory.Global.Location[loc_id_storage].ClientCheck then
			
			if not combine.bank or not combine.reagent then
				panel_id = panel_id + 1
			end

			if ArkInventory.Util.MapCheckStorage( loc_id_storage ) then
				for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
					
					if not combine.reagent and bag_id_storage > 1 then
						panel_id = panel_id + 1
					end
					
					map.panel_id = panel_id
					
				end
			end
			
		else
			--codex.player.data.panel.bank.combine.reagent = false
		end
		
		local loc_id_storage = ArkInventory.Const.Location.AccountBank
		if ArkInventory.Global.Location[loc_id_storage].ClientCheck then

			panel_id = panel_id + 1

			if ArkInventory.Util.MapCheckStorage( loc_id_storage ) then
				for bag_id_storage, map in ipairs( ArkInventory.Util.MapGetStorage( loc_id_storage ) ) do
					
					if not combine.account and bag_id_storage > 1 then
						panel_id = panel_id + 1
					end
					
					map.panel_id = panel_id
					
				end
			end

		else
			--codex.player.data.panel.bank.combine.account = false
		end

	end
	
	ArkInventory.Frame_Main_Generate( loc_id_window, ArkInventory.Const.Window.Draw.Recalculate )
	
end

function ArkInventory.Util.syncBlizzardBankUI( map, loc_id_storage, blizzard_id )
	
	--ArkInventory.OutputDebug( "syncBlizzardBankUI [", map, "] [", loc_id_storage, "] [", blizzard_id, "]" )
	
	-- sync the default bank frame tabs up to the current arkinventory frame tabs when clicked
	
	local loc_id_window = ArkInventory.Const.Location.Bank
		
	if ArkInventory.Global.Location[loc_id_window].isOffline then
		ArkInventory.OutputDebug( "offline - ignoring changer sync" )
		return
	end
	
	local map = map or ArkInventory.Util.getWindowActiveMap( loc_id_window )
	local loc_id_storage = loc_id_storage or map.loc_id_storage
	local blizzard_id = blizzard_id or map.blizzard_id
	
	ArkInventory.OutputDebug( "sync blizard bank frame to [", loc_id_storage, "] [", blizzard_id, "]" )
	
	if ArkInventory.Const.BLIZZARD.CLIENT.ELEVEN_POINT_TWO then

		if BankFrame and BankPanel then

--			local blizzard_TabID = BankFrame:GetTab( )
--			local blizzard_PanelID = BankPanel:GetSelectedTabID( )

			local tabID
			if loc_id_storage == ArkInventory.Const.Location.Bank then
				tabID = BankFrame.characterBankTabID
			elseif loc_id_storage == ArkInventory.Const.Location.AccountBank then
				tabID = BankFrame.accountBankTabID
			else
				ArkInventory.OutputWarning( "code failure - uncoded storage location [", loc_id_storage, "]" )
				return
			end
			
--			ArkInventory.OutputDebug( "updating blizzard bank tab to [", tabID, "]" )
			BankFrame:SetTab( tabID )
			--TabSystemOwnerMixin.SetTab( BankFrame, tabID )
			--BankFrame:UpdateWidthForSelectedTab( )

--			ArkInventory.OutputDebug( "updating blizzard panel tab to [", blizzard_id, "]" )
			BankPanel:SelectTab( blizzard_id )

		end

	elseif BankFrame_ShowPanel then
		
		if loc_id_storage == ArkInventory.Const.Location.Bank then
			--ArkInventory.Output( "bank")
			BankFrame_ShowPanel( BANK_PANELS[1].name, nil, "arkinv" )
		end
		
		if loc_id_storage == ArkInventory.Const.Location.ReagentBank then
			--ArkInventory.Output( "reagentbank")
			BankFrame_ShowPanel( BANK_PANELS[2].name, nil, "arkinv" )
		end
		
		if loc_id_storage == ArkInventory.Const.Location.AccountBank then
			--ArkInventory.Output( "warbank")
			BankFrame_ShowPanel( BANK_PANELS[3].name, nil, "arkinv" )
			
			local frame = ArkInventory.CrossClient.GetBankPanel( )
			if frame then
				frame:TriggerEvent( BankPanelMixin.Event.BankTabClicked, blizzard_id )
			end

		end

	end
	
end

local function initMovedItemBlock( blizzard_id, slot_id )
	
	if not ArkInventory.Global.MovedItemBlock then
		ArkInventory.Global.MovedItemBlock = { }
	end
	
	if not ArkInventory.Global.MovedItemBlock[blizzard_id] then
		ArkInventory.Global.MovedItemBlock[blizzard_id] = { }
	end
	
end

function ArkInventory.Util.clearMovedItemBlock( blizzard_id, slot_id )
	initMovedItemBlock( blizzard_id, slot_id )
	ArkInventory.Global.MovedItemBlock[blizzard_id][slot_id] = nil
end

function ArkInventory.Util.setMovedItemBlock( blizzard_id, slot_id )
	initMovedItemBlock( blizzard_id, slot_id )
	ArkInventory.Global.MovedItemBlock[blizzard_id][slot_id] = true
end

function ArkInventory.Util.getMovedItemBlock( blizzard_id, slot_id )
	initMovedItemBlock( blizzard_id, slot_id )
	return ArkInventory.Global.MovedItemBlock[blizzard_id][slot_id]
end
