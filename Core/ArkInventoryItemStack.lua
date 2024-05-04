local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table

local frame = ARKINV_ItemStack

function ArkInventory.ItemStackClear( )
	
end

function ArkInventory.ItemStackBuild( loc_id, itemid )
	
	-- set border style / colour
	-- set background colour
	
	
	
	
	
	
	frame:SetWidth( 200 )
	frame:SetHeight( 20 )
end

function ArkInventory.ItemStackShow( loc_id, itemid )
	ArkInventory.ItemStackBuild( loc_id, itemid )
	frame:Show( )
end

function ArkInventory.ItemStackHide( )
	frame:Hide( )
	ArkInventory.ItemStackClear( )
end
