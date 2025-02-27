﻿local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table

local loc_id = ArkInventory.Const.Location.Reputation

ArkInventory.Collection.Reputation = { }

local collection = {
	
	isInit = false,
	isScanning = false,
	isReady = false,
	
	numTotal = 0, -- number of total reputations
	numOwned = 0, -- number of known reputations
	
	list = { }, -- [index] = { } - reputations and headers in order from the blizard frame
	cache = { }, -- [id] -- all reputations
	
	filter = {
		ignore = false,
		expanded = { },
		backup = false,
	},
	
}

local ImportCrossRefTable = true

function ArkInventory.Collection.Reputation.ImportCrossRefTable( )
	
	if not ImportCrossRefTable then return end
	
	local rid, item, key1, key2
	
	for k, v in ArkInventory.Lib.PeriodicTable:IterateSet( "ArkInventory.System.XREF.Reputation" ) do
		
		item = tonumber( k ) or 0
		rid = tonumber( v ) or 0
		
		if rid > 0 and item > 0 then
			
			key1 = ArkInventory.ObjectIDCount( string.format( "item:%s", item ) )
			key2 = ArkInventory.ObjectIDCount( string.format( "reputation:%s", rid ) )
			
			--ArkInventory.OutputDebug( key1, " / ", key2 )
			
			if not ArkInventory.Global.ItemCrossReference[key1] then
				ArkInventory.Global.ItemCrossReference[key1] = { }
			end
			
			ArkInventory.Global.ItemCrossReference[key1][key2] = true
			
			if not ArkInventory.Global.ItemCrossReference[key2] then
				ArkInventory.Global.ItemCrossReference[key2] = { }
			end
			
			ArkInventory.Global.ItemCrossReference[key2][key1] = true
			
		end
		
	end
	
	ImportCrossRefTable = nil
	
end

local function FilterActionBackup( )
	
	if collection.filter.backup then return end
	
	local n, e, c
	local p = 0
	ArkInventory.Table.Wipe( collection.filter.expanded )
	
	collection.filter.ignore = true
	
	repeat
		
		p = p + 1
		n = ArkInventory.CrossClient.GetNumFactions( )
		--ArkInventory.Output( "pass=", p, " num=", n )
		e = true
		
		for index = 1, n do
			
			local info = ArkInventory.CrossClient.GetFactionInfo( index )
			if info and info.isHeader and info.isCollapsed then
				--ArkInventory.Output( "expanding [", index, "] [", info.name, "]" )
				collection.filter.expanded[index] = true
				ArkInventory.CrossClient.ExpandFactionHeader( index )
				e = false
				break
			end
			
		end
		
	until e or p > n * 1.5
	
	collection.filter.ignore = false
	
	collection.filter.backup = true
	
end

local function FilterActionRestore( )
	
	if not collection.filter.backup then return end
	
	collection.filter.ignore = true
	
	local n = ArkInventory.CrossClient.GetNumFactions( )
	
	for index = n, 1, -1 do
		
		if collection.filter.expanded[index] then
			local info = ArkInventory.CrossClient.GetFactionInfo( index )
			--ArkInventory.Output( "collapse header i=[",index,"] [", info.name, "]" )
			ArkInventory.CrossClient.CollapseFactionHeader( index )
		end
		
	end
	
	collection.filter.ignore = false
	
	collection.filter.backup = false
	
end

function ArkInventory.Collection.Reputation.OnHide( )
	--ArkInventory.OutputDebug( "Reputation.OnHide" )
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", "FRAME_CLOSED" )
end

function ArkInventory.Collection.Reputation.IsReady( )
	return collection.isReady
end

function ArkInventory.Collection.Reputation.GetCount( )
	return collection.numOwned, collection.numTotal
end

function ArkInventory.Collection.Reputation.Iterate( )
	local t = collection.cache
	return ArkInventory.spairs( t, function( a, b ) return ( t[a].name or "" ) < ( t[b].name or "" ) end )
end

function ArkInventory.Collection.Reputation.GetByID( id )
	if type( id ) == "number" then
		return collection.cache[id]
	end
end

function ArkInventory.Collection.Reputation.LevelText( ... )
	
	if not ArkInventory.Collection.Reputation.IsReady( ) then
		return ArkInventory.Localise["DATA_NOT_READY"]
	end
	
	local id, style, standingText, barValue, barMin, barMax, isCapped, paragonLevel, hasReward, rankValue, rankMax = ...
	
	--ArkInventory.OutputDebug( { ... } )
	
	local n = select( '#', ... )
	
	if n == 0 then
		return "empty request for data"  -- !!!fix me
	end
	
--[[
	*nn* = name
	*st* = standing text
	*bv* = bar value
	*bn* = bar min
	*bm* = bar max
	*bp[n]* = bar percent [n=decimal places (0-2)]
	*br* = bar remaining
	*rv* = rank value
	*rm* = rank max
	*pv* = paragon value (+N)
	*pr* = paragon reward icon
]]--
	
	local object = ArkInventory.Collection.Reputation.GetByID( id )
	if not object then
		return "repuation not found"  -- !!!fix me
	end
	
	--ArkInventory.OutputDebug( object )
	
	standingText = standingText or object.standingText or ArkInventory.Localise["UNKNOWN"]
	barValue = barValue or object.barValue or 0
	barMin = barMin or object.barMin or 0
	barMax = barMax or object.barMax or 0
	isCapped = isCapped or object.isCapped or 0
	paragonLevel = paragonLevel or object.paragonLevel or 0
	hasReward = hasReward or object.hasReward or 0
	rankValue = rankValue or object.rankValue or 0
	rankMax = rankMax or object.rankMax or 0
	
	local name = object.name or ArkInventory.Localise["UNKNOWN"]
	local rewardIcon = string.format( "|T%s:0|t", [[Interface\ICONS\INV_Misc_Coin_01]] ) -- [[Interface\MINIMAP\TRACKING\Banker]]
	local result = string.lower( style or ArkInventory.Const.Reputation.Style.OneLine )
	
	if barValue > 0 and barMax > 0 and barValue < barMax then
		
		--ArkInventory.Output( "bar [", barValue, "] [", barMax, "] ", name )
		
		result = string.gsub( result, "%*bv%*", FormatLargeNumber( barValue ) )
		result = string.gsub( result, "%*bm%*", FormatLargeNumber( barMax ) )
		
		if barValue < barMax then
			result = string.gsub( result, "%*bp1%*", string.format( "%.1f", barValue / barMax * 100 ) .. "%%" )
			result = string.gsub( result, "%*bp2%*", string.format( "%.2f", barValue / barMax * 100 ) .. "%%" )
			result = string.gsub( result, "%*bp%d*%*", string.format( "%.0f", barValue / barMax * 100 ) .. "%%" )
			result = string.gsub( result, "%*br%*", FormatLargeNumber( barMax - barValue ) )
		end
		
	end
	
	if rankValue > 0 and rankMax >0 and rankValue < rankMax then
		
		--ArkInventory.Output( "rank [", rankValue, "] [", rankMax, "] ", name )
		
		result = string.gsub( result, "%*rv%*", FormatLargeNumber( rankValue ) )
		
		if rankMax > 0 then
			result = string.gsub( result, "%*rm%*", FormatLargeNumber( rankMax ) )
		end
		
	end
	
	if isCapped == 1 then
		
		if paragonLevel > 0 then
			
			paragonLevel = paragonLevel - 1
			
			if paragonLevel > 0 then
				result = string.gsub( result, "%*pv%*", "+" .. FormatLargeNumber( paragonLevel ) )
			end
			
			if hasReward == 1 then
				result = string.gsub( result, "%*pr%*", rewardIcon )
			end
			
		end
	end
	
	result = string.gsub( result, "%*nn%*", name )
	result = string.gsub( result, "%*st%*", standingText )
	
	-- remove any left over tokens
	result = string.gsub( result, "%*bv%*", "" )
	result = string.gsub( result, "%*bm%*", "" )
	result = string.gsub( result, "%*bc%*", "" )
	result = string.gsub( result, "%*bp%d?%*", "" )
	result = string.gsub( result, "%*br%*", "" )
	result = string.gsub( result, "%*rv%*", "" )
	result = string.gsub( result, "%*rm%*", "" )
	result = string.gsub( result, "%*rc%*", "" )
	result = string.gsub( result, "%*pv%*", "" )
	result = string.gsub( result, "%*pr%*", "" )
	
	-- clean up
	result = string.gsub( result, "%(%s*/%s*%)", "" )
	result = string.gsub( result, "%[%s*/%s*%]", "" )
	result = string.gsub( result, "%(%s*%)", "" )
	result = string.gsub( result, "%[%s*%]", "" )
	result = string.gsub( result, "\n$", "" )
	result = string.gsub( result, "|n$", "" )
	result = string.gsub( result, "%s%s", " " )
	result = string.gsub( result, ",%s*,", "," )
	result = string.gsub( result, ",*$", "" )
	result = string.trim( result )
	
	return result
	
end

function ArkInventory.Collection.Reputation.ListIterate( )
	local t = collection.list
	return ArkInventory.spairs( t, function( a, b ) return ( t[a].index or 0 ) < ( t[b].index or 0 ) end )
end

function ArkInventory.Collection.Reputation.GetByIndex( index )
	if type( index ) == "number" then
		return collection.list[index]
	end
end

function ArkInventory.Collection.Reputation.ToggleAtWar( id )
	
	if type( id ) == "number" then
		
		FilterActionBackup( )
		
		local data = ArkInventory.Collection.Reputation.GetByID( id )
		if data and data.canToggleAtWar then
			FactionToggleAtWar( data.index )
		end
		
		FilterActionRestore( )
		
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", "TOGGLE_AT_WAR" )
		
	end
	
end

function ArkInventory.Collection.Reputation.ListSetActive( index, state, bulk )
	
	if type( index ) ~= "number" then return end
	if type( state ) ~= "boolean" then return end
	
	if not bulk then
		FilterActionBackup( )
	end
	
	local entry = ArkInventory.Collection.Reputation.GetByIndex( index )
	if entry then
		
		--ArkInventory.Output( "INDEX=[", entry.index, "] NAME=[", entry.name, "] ACTIVE=[", entry.active, "]" )
		
		if state then
			if not entry.active then
				--ArkInventory.Output( "Active: INDEX=[", entry.index, "] NAME=[", entry.name, "]" )
				ArkInventory.CrossClient.SetFactionActive( entry.index )
			end
		else
			if entry.active then
				--ArkInventory.Output( "Inactive: INDEX=[", entry.index, "] NAME=[", entry.name, "]" )
				ArkInventory.CrossClient.SetFactionInactive( entry.index )
			end
		end
		
	end
	
	if not bulk then
		FilterActionRestore( )
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", "TOGGLE_ACTIVE" )
	end
	
end

function ArkInventory.Collection.Reputation.ToggleShowAsExperienceBar( id )
	
	if type( id ) == "number" then
		
		FilterActionBackup( )
		
		local object = ArkInventory.Collection.Reputation.GetByID( id )
		if object then
			if object.isWatched then
				--ArkInventory.OutputDebug( "SetWatchedFactionByIndex( 0 )" )
				ArkInventory.CrossClient.SetWatchedFactionByIndex( 0 )
			else
				--ArkInventory.OutputDebug( "SetWatchedFactionByIndex( ", object.index, " )" )
				ArkInventory.CrossClient.SetWatchedFactionByIndex( object.index )
			end
		end
		
		FilterActionRestore( )
		
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", "TOGGLE_SHOW_AS_XP" )
		
	end
	
end

function ArkInventory.Collection.Reputation.ReactivateAll( )
	
	FilterActionBackup( )
	
	for _, entry in ArkInventory.Collection.Reputation.ListIterate( ) do
		if not entry.isHeader then
			--ArkInventory.Output( "activate ", entry.index )
			ArkInventory.Collection.Reputation.ListSetActive( entry.index, true, true )
		end
	end
	
	FilterActionRestore( )
	
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", "REACTIVATE_ALL" )
	
end



local function ScanBase( id )
	
	if not id or type( id ) ~= "number" then
		return
	end
	
	local cache = collection.cache
	
	if not cache[id] then
		
		if id > 0 then
			
			local factionInfo = ArkInventory.CrossClient.GetFactionInfoByID( id )
			if factionInfo then
				
				if factionInfo.name and factionInfoname ~= "" then
					
					cache[id] = {
						id = id,
						link = string.format( "reputation:%s", id ),
						name = factionInfo.name,
						description = factionInfo.description,
						isHeaderWithRep = factionInfo.isHeaderWithRep,
						canToggleAtWar = factionInfo.canToggleAtWar,
						canSetInactive = factionInfo.canSetInactive,
						isAccountWide = factionInfo.isAccountWide,
					}
					
					collection.numTotal = collection.numTotal + 1
					
					ArkInventory.db.cache.reputation[id] = {
						n = factionInfo.name,
						d = factionInfo.description,
						r = factionInfo.isHeaderWithRep,
						w = factionInfo.canToggleAtWar,
						i = factionInfo.canSetInactive,
					}
					
				else
					
					local cr = ArkInventory.db.cache.reputation[id]
					if cr then
						cache[id] = {
							id = id,
							link = string.format( "reputation:%s", id ),
							name = cr.n,
							description = cr.d,
							isHeaderWithRep = cr.r,
							canToggleAtWar = cr.w,
							canSetInactive = cr.i,
							icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Reputation].Texture
						}
					end
					
				end
				
			end
			
		else
			
			cache[id] = {
				id = id,
				link = "",
				name = string.format( "Header %s", math.abs( id ) ),
				description = "fake entry for an index header",
			}
			
		end
		
	end
	
end

local function ScanInit( thread_id )
	
	--ArkInventory.Output( "Reputation Init: Start Scan @ ", time( ) )
	
	for id = 1, 5000 do
		
		ScanBase( id )
		
		if id % 200 == 0 then
			ArkInventory.ThreadYield_Scan( thread_id )
		end
		
	end
	
--	if collection.numTotal > 0 then
		collection.isInit = true
--	end
	
	--ArkInventory.Output( "Reputation Init: End Scan @ ", time( ), " [", collection.numTotal, "]" )
	
end

local function Scan_Threaded( thread_id )
	
	local update = false
	
	local numOwned = 0
	local YieldCount = 0
	
	--ArkInventory.Output( "Reputation: Start Scan @ ", time( ) )
	
	if not collection.isInit then
		ScanInit( thread_id )
	end
	
	FilterActionBackup( )
	
	-- scan the reuptation frame (now fully expanded) for known factions
	
	ArkInventory.Table.Wipe( collection.list )
	
	local cache = collection.cache
	local list = collection.list
	local active = true
	local fakeID = 0
	local parentIndex
	local childIndex
	
	for index = 1, ArkInventory.CrossClient.GetNumFactions( ) do
		
		--ArkInventory.Output( "faction: ", index )
		
		if ReputationFrame:IsVisible( ) then
			ArkInventory.OutputDebug( "REPUTATION: ABORTED (REPUTATION FRAME WAS OPENED)" )
			FilterActionRestore( )
			return
		end
		
		if ArkInventory.Global.Mode.Combat then
			ArkInventory.OutputDebug( "REPUTATION: ABORTED (ENTERED COMBAT)" )
			ArkInventory.Global.ScanAfterCombat[loc_id] = true
			FilterActionRestore( )
			return
		end
		
		if ArkInventory.Global.Mode.DragonRace then
			ArkInventory.OutputDebug( "REPUTATION: ABORTED (DRAGON RACE)" )
			ArkInventory.Global.ScanAfterDragonRace[loc_id] = true
			FilterActionRestore( )
			return
		end
		
		
		YieldCount = YieldCount + 1
		
		local factionInfo = ArkInventory.CrossClient.GetFactionInfo( index )
		if factionInfo then
			
			local factionID = factionInfo.factionID
			if not factionID then
				-- cater for list headers like other and inactive that dont have a faction id assigned to them
				fakeID = fakeID - 1
				factionID = fakeID
			end
			
			--ArkInventory.Output( index, " = ", factionID )
			
			if not list[index] then
				list[index] = {
					index = index,
					id = factionID,
					name = factionInfo.name,
					description = factionInfo.description,
					isHeader = factionInfo.isHeader,
					isHeaderWithRep = factionInfo.isHeaderWithRep,
					isChild = factionInfo.isChild,
					parentIndex = nil,
					isAccountWide = factionInfo.isAccountWide,
					data = nil, -- will eventually point to the correct cache entry
				}
			end
			
			if factionInfo.isHeader then
				
				childIndex = index
				
				if factionInfo.isChild then
					
					list[index].parentIndex = parentIndex
					
				else
					
					if factionInfo.name == ArkInventory.Localise["FACTION_INACTIVE"] then
						--ArkInventory.OutputDebug( "REPUTATION: inactive header at ", index, " = ", factionInfo )
						active = false
					end
					
					parentIndex = index
					
				end
				
			end
			
			if ( not factionInfo.isHeader ) or factionInfo.isHeaderWithRep then
				
				local id = factionInfo.name and factionInfo.name ~= "" and factionID
				if id then
					
					numOwned = numOwned + 1
					
					if not cache[id] then
						ScanBase( id )
						update = true
					end
					
					if cache[id] then
						
						list[index].data = cache[id]
						
						if not factionInfo.isHeader then
							list[index].parentIndex = childIndex
						end
						
						-- update cached data if changed
						
						if cache[id].index ~= index then
							cache[id].index = index
							update = true
						end
						
						if cache[id].name ~= factionInfo.name then
							cache[id].name = factionInfo.name
							update = true
						end
						
						if cache[id].isOwned ~= true then
							cache[id].isOwned = true
							update = true
						end
						
						if cache[id].atWarWith ~= factionInfo.atWarWith then
							cache[id].atWarWith = factionInfo.atWarWith
							update = true
						end
						
						if cache[id].canToggleAtWar ~= factionInfo.canToggleAtWar then
							cache[id].canToggleAtWar = factionInfo.canToggleAtWar
							update = true
						end
						
						if cache[id].canSetInactive ~= factionInfo.canSetInactive then
							cache[id].canSetInactive = factionInfo.canSetInactive
							update = true
						end
						
						if cache[id].isWatched ~= factionInfo.isWatched then
							cache[id].isWatched = factionInfo.isWatched
							update = true
						end
						
						if cache[id].isHeaderWithRep ~= factionInfo.isHeaderWithRep then
							cache[id].isHeaderWithRep = factionInfo.isHeaderWithRep
							update = true
						end
						
						local isAccountWide = not not factionInfo.isAccountWide -- needs to be boolean, not nil (lower game clients that dont have this will return nil)
						if cache[id].isAccountWide ~= isAccountWide then
							cache[id].isAccountWide = isAccountWide
							update = true
						end
						
						
						
						local friendID = 0
						local icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Reputation].Texture
						local standingText = ""
						local barValue = 0
						local barMin = 0
						local barMax = 0
						local rankValue = 0
						local rankMax = MAX_REPUTATION_REACTION
						local isCapped = 0
						local paragonLevel = 0
						local paragonRewardPending = 0
						
						local isMajorFaction = ArkInventory.CrossClient.IsMajorFaction( id )
						if isMajorFaction then
							
							-- renown factions (numeric based rank levels)
							
							--ArkInventory.OutputDebug( id, " = ", factionInfo.name, " = renown" )
							
							local factionInfo = ArkInventory.CrossClient.GetMajorFactionData( id )
							if factionInfo then
								barMax = factionInfo.renownLevelThreshold
								isCapped = ArkInventory.CrossClient.HasMaximumRenown( id )
								barValue = isCapped and factionInfo.renownLevelThreshold or factionInfo.renownReputationEarned or 0
								standingText = string.format( "%s%s", RENOWN_LEVEL_LABEL, factionInfo.renownLevel )
								isCapped = isCapped and 1 or 0
								rankValue = factionInfo.renownLevel
								rankMax = #ArkInventory.CrossClient.GetRenownLevels( id )
							end
							
						else
							
							-- 2526 winterpelt
							
							local friendInfo = ArkInventory.CrossClient.GetFriendshipReputation( id )
							if friendInfo then
								
								-- friendship based faction (customised rank levels)
								
								--ArkInventory.OutputDebug( id, " = ", factionInfo.name, " = friend" )
								
								friendID = friendInfo.friendshipFactionID
								icon = friendInfo.texture or icon --[[Interface\Challenges\challenges-copper]]
								standingText = friendInfo.reaction
								
								local rankInfo = ArkInventory.CrossClient.GetFriendshipReputationRanks( friendID )
								if rankInfo then
									rankValue = rankInfo.currentLevel
									rankMax = rankInfo.maxLevel
								end
								
								if friendInfo.nextThreshold then
									barMin = friendInfo.reactionThreshold
									barMax = friendInfo.nextThreshold
									barValue = friendInfo.standing
								else
									barMin = 0
									barMax = 0
									barValue = 0
									isCapped = 1
								end
								
							else
								
								-- original rank levels (hated to exalted)
								
								--ArkInventory.OutputDebug( id, " = ", factionInfo.name, " = normal" )
								--ArkInventory.Output( id, "/", index, " = ", factionInfo )
								
								barValue = factionInfo.currentStanding
								barMin = factionInfo.barMin or 0
								barMax = factionInfo.nextReactionThreshold
								
								rankValue = factionInfo.reaction
								
								rankMax = MAX_REPUTATION_REACTION or 8
								standingText = _G["FACTION_STANDING_LABEL" .. rankValue] or ArkInventory.Localise["UNKNOWN"]
								
							end
							
						end
						
						
						
						if factionInfo.atWarWith then
							icon = [[Interface\Calendar\UI-Calendar-Event-PVP]]
						end
						
						
						if rankValue == rankMax then
							
							if barValue == barMax and barMax == barMin then
								isCapped = 1
							end
							
							rankValue = 0
							rankMax = 0
							
						end
						
						local isParagon = ArkInventory.CrossClient.IsFactionParagon( id )
						if isParagon then
							
							-- reputation level stops at exalted 42,000 - paragon values take over from there
							
							-- highmountain
							-- /dump GetFactionInfoByID( 1828 )
							-- /dump C_Reputation.GetFactionParagonInfo( 1828 )
							
							-- 2510 = valdrakken accord C_Reputation.GetFactionParagonInfo(2510)
							-- artisans consortium
							-- /dump C_Reputation.GetFactionParagonInfo( 2544 )
							
							local paragonInfo = ArkInventory.CrossClient.GetFactionParagonInfo( id )
							
							if paragonInfo and paragonInfo.value and paragonInfo.threshold and not paragonInfo.tooLowLevel then
								
								standingText = ArkInventory.Localise["PARAGON"]
								paragonLevel = math.floor( paragonInfo.value / paragonInfo.threshold ) + 1
								barMin = 0
								barMax = paragonInfo.threshold
								barValue = paragonInfo.value % paragonInfo.threshold
								
								paragonRewardPending = paragonInfo.rewardPending and 1 or 0
								if paragonRewardPending == 1 then
									
									icon = [[Interface\ICONS\INV_Misc_Coin_01]]
									
									if not cache[id].notify then
										ArkInventory.Output( GREEN_FONT_COLOR_CODE, "ALERT> A paragon reward for ", cache[id].name, " is ready for collection" )
										cache[id].notify = true
									end
									
								end
								
							end
							
						end
						
						
						cache[id].friendID = friendID
						
						if cache[id].isCapped ~= isCapped then
							cache[id].isCapped = isCapped
							update = true
						end
						
						barMax = barMax - barMin
						barValue = barValue - barMin
						
						if cache[id].barValue ~= barValue then
							
							cache[id].icon = icon or ArkInventory.Const.Texture.Missing
							cache[id].standingText = standingText
							cache[id].barValue = barValue
							cache[id].barMin = barMin
							cache[id].barMax = barMax
							cache[id].paragonLevel = paragonLevel
							cache[id].paragonRewardPending = paragonLevel > 0 and paragonRewardPending
							cache[id].rankMax = rankMax
							cache[id].rankValue = rankValue
							
							-- custom itemlink, not blizzard supported
							--ArkInventory.Output( { id, standingText, barValue, barMax, isCapped, paragonLevel, paragonRewardPending, rankValue, rankMax } )
							cache[id].link = string.format( "reputation:%s:%s:%s:%s:%s:%s:%s:%s:%s:%s", id or 0, standingText or "", barValue or 0, barMin or 0, barMax or 0, isCapped or 0, paragonLevel or 0, paragonRewardPending or 0, rankValue or 0, rankMax or 0)
							
							update = true
							
						end
						
					else
						
						--ArkInventory.Output( "not cached: ", index, " / ", id )
						
					end
					
				end
				
			end
			
			list[index].active = active
			--ArkInventory.Output( list[index].name, " = ", list[index].active )
			
		end
		
		if YieldCount % ArkInventory.Const.YieldAfter == 0 then
			ArkInventory.ThreadYield_Scan( thread_id )
		end
		
	end
	
	ArkInventory.ThreadYield_Scan( thread_id )
	
	FilterActionRestore( )
	
	collection.numOwned = numOwned
	
	--ArkInventory.Output( "Reputation: End Scan @ ", time( ), " ( ", collection.numOwned, " of ", collection.numTotal, " ) update=", update )
	
	if not collection.isReady then
		collection.isReady = true
		ArkInventory:SendMessage( "EVENT_ARKINV_LDB_REPUTATION_UPDATE_BUCKET" )
	end
	
	if update then
		--ArkInventory.Output( "REQUESTING LOCATION SCAN - REPUTATION" )
		ArkInventory.ScanLocationWindow( loc_id )
	else
		--ArkInventory.Output( "IGNORED (NO UPDATES FOUND)" )
	end
	
end

local function Scan( )
	
--	if true then return end -- disable reputation scanning
	
	local thread_id = string.format( ArkInventory.Global.Thread.Format.Collection, "reputation" )
	
	local thread_func = function( )
		Scan_Threaded( thread_id )
	end
	
	ArkInventory.ThreadStart( thread_id, thread_func )
	
end

function ArkInventory:EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET( events )
	
	--ArkInventory.Output( "REPUTATION BUCKET [", events, "]" )
	
	if not ArkInventory:IsEnabled( ) then return end
	
	local loc_id_window = ArkInventory.Const.Location.Reputation
	
	if not ArkInventory.isLocationMonitored( loc_id_window ) then
		--ArkInventory.Output( "IGNORED (REPUTATION NOT MONITORED)" )
		return
	end
	
	if ReputationFrame:IsVisible( ) then
		--ArkInventory.Output( "IGNORED (REPUTATION FRAME IS OPEN)" )
		return
	end
	
	if ArkInventory.Global.Mode.Combat then
		--ArkInventory.Output( "IGNORED (IN COMBAT)" )
		ArkInventory.Global.ScanAfterCombat[loc_id_window] = true
		return
	end
	
	if ArkInventory.Global.Mode.DragonRace then
		--ArkInventory.Output( "IGNORED (DRAGON RACING)" )
		ArkInventory.Global.ScanAfterDragonRace[loc_id_window] = true
		return
	end
	
	
	if not collection.isScanning then
		collection.isScanning = true
		--ArkInventory.Output( "scan reputation" )
		Scan( )
		collection.isScanning = false
	else
		--ArkInventory.Output( "IGNORED (REPUTATION SCAN IN PROGRESS - WILL RESCAN WHEN FINISHED)" )
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", "RESCAN" )
	end
	
end

function ArkInventory:EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE( event, ... )
	
	--ArkInventory.Output( "REPUTATION UPDATE [", event, "]" )
	
	if event == "UPDATE_FACTION" then
		if ReputationFrame:IsVisible( ) then
			--ArkInventory.Output( "IGNORED (REPUTATION FRAME IS OPEN)" )
			return
		elseif collection.filter.ignore then
			--ArkInventory.Output( "IGNORED (FILTER CHANGED BY ME)" )
			return
		end
	end
	
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_REPUTATION_UPDATE_BUCKET", event )
	
end
