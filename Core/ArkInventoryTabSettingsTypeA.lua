-- Type A

ArkInventoryTabSettingsTypeAMixin = { }

function ArkInventory.TabSettingsTypeAOpen( loc_id_window, bag_id_window )
	
	local self = _G["ARKINV_TabSettingsTypeAFrame"]

	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	self:Hide( )
	
	self.ARK_Data = {
		blizzard_id = map.blizzard_id,
		loc_id_window = map.loc_id_window,
		bag_id_window = map.bag_id_window,
		loc_id_storage = map.loc_id_storage,
		bag_id_storage = map.bag_id_storage,
	}
	
	local ARK_TabData

	if map.loc_id_storage == ArkInventory.Const.Location.Vault then
		
		local name, icon = GetGuildBankTabInfo( map.tab_id )
		
		ARK_TabData = {
			header = GUILDBANK_POPUP_TEXT,
			name = name,
			icon = icon,
			depositFlags = 0,
		}
		
	else

		ArkInventory.OutputWarning( "uncoded type A tab setings location [", map.loc_id_storage, "]" )
		return

	end
	

	ARK_TabData.tab = map.bag_id_storage

	self.ARK_TabData = self.ArkValidateData( ARK_TabData )
	
	self.mode = IconSelectorPopupFrameModes.Edit
	
	self:Show( )
	
end

function ArkInventoryTabSettingsTypeAMixin.ArkValidateName( name, tabID )

	name = string.gsub( name or "", "\"", "" )
	name = string.trim( name )
	if ( not name or name == "" ) then
		name = GUILDBANK_TAB_NUMBER:format( tabID )
	end
	
	return name
	
end

function ArkInventoryTabSettingsTypeAMixin.ArkValidateData( data )
	
	data.name = ArkInventoryTabSettingsTypeAMixin.ArkValidateName( data.name, data.tab )

	if ( not data.icon ) or ( string.lower( data.icon ) == string.lower( QUESTION_MARK_ICON ) ) then
		data.icon = "1"
	end

	return data

end

function ArkInventoryTabSettingsTypeAMixin:Update( )
	
	IconSelectorPopupFrameTemplateMixin.Update( self )

	local ARK_TabData = self.ArkValidateData( self.ARK_TabData )
	
	--ArkInventory.Output( "name [", name, "], icon [", icon, "]" )
	
	self.BorderBox.EditBoxHeaderText:SetText( ARK_TabData.header )

	self.BorderBox.IconSelectorEditBox:SetText( ARK_TabData.name )
	self.BorderBox.IconSelectorEditBox:HighlightText( )
	
	self.IconSelector:SetSelectedIndex( self:GetIndexOfIcon( ARK_TabData.icon ) )
	self.BorderBox.SelectedIconArea.SelectedIconButton:SetIconTexture( ARK_TabData.icon )
	
	local getSelection = GenerateClosure( self.iconDataProvider.GetIconByIndex, self.iconDataProvider )
	local getNumSelections = GenerateClosure( self.iconDataProvider.GetNumIcons, self.iconDataProvider )
	
	self.IconSelector:SetSelectionsDataProvider( getSelection, getNumSelections )
	self.IconSelector:ScrollToSelectedIndex( )
	
	self:SetSelectedIconText( )

end

function ArkInventoryTabSettingsTypeAMixin:RefreshIconDataProvider( )
	
	if self.iconDataProvider == nil then
		self.iconDataProvider = CreateAndInitFromMixin( IconDataProviderMixin, IconDataProviderExtraType.None )
	end
	
	return self.iconDataProvider
	
end

function ArkInventoryTabSettingsTypeAMixin:OnLoad( )
	
	--CallbackRegistryMixin.OnLoad( self )
	
	IconSelectorPopupFrameTemplateMixin.OnLoad( self )
	
end

function ArkInventoryTabSettingsTypeAMixin:OnShow( )
	
	IconSelectorPopupFrameTemplateMixin.OnShow( self )

	local loc_id_window = self.ARK_Data.loc_id_window
	local bag_id_window = self.ARK_Data.bag_id_window
	
	local parentframename = string.format( "ARKINV_Frame%dTitle", loc_id_window )
	local parentframe = _G[parentframename]
	
	self:ClearAllPoints( )
	self:SetScale( 0.75 )
	self:SetPoint( "TOPLEFT", parentframe, "TOPRIGHT", 10, 0 )
	
	self.iconDataProvider = self:RefreshIconDataProvider( )
	
	self:SetIconFilter( IconSelectorPopupFrameIconFilterTypes.All )

	self:Update( )
	
	self.BorderBox.IconSelectorEditBox:SetFocus( )
	self.BorderBox.IconSelectorEditBox:OnTextChanged( )

	local function OnIconSelected( selectionIndex, icon )
		self.BorderBox.SelectedIconArea.SelectedIconButton:SetIconTexture( icon )
		self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetText( ICON_SELECTION_CLICK )
		self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetFontObject( GameFontHighlightSmall )
	end
	
	self.IconSelector:SetSelectedCallback( OnIconSelected )

	
	PlaySound( SOUNDKIT.IG_CHARACTER_INFO_OPEN )

end

function ArkInventoryTabSettingsTypeAMixin:OnHide( )
	
	IconSelectorPopupFrameTemplateMixin.OnHide( self )
	
	if self.iconDataProvider ~= nil then
		self.iconDataProvider:Release( )
		self.iconDataProvider = nil
	end

	PlaySound( SOUNDKIT.IG_CHARACTER_INFO_TAB )
	
end

function ArkInventoryTabSettingsTypeAMixin:OkayButton_OnClick( )
	
	IconSelectorPopupFrameTemplateMixin.OkayButton_OnClick( self )
	

	local ARK_TabData = self.ARK_TabData
	
	ARK_TabData.icon = self.BorderBox.SelectedIconArea.SelectedIconButton:GetIconTexture( )
	ARK_TabData.name = self.BorderBox.IconSelectorEditBox:GetText( )
	--ARK_TabData.depositFlags = 0

	ARK_TabData = self.ArkValidateData( ARK_TabData )


	local loc_id_storage = self.ARK_Data.loc_id_storage

	if loc_id_storage == ArkInventory.Const.Location.Vault then
		
		SetGuildBankTabInfo( ARK_TabData.tab, ARK_TabData.name, ARK_TabData.icon )
		
	end
	

	-- update arkinventory data
	local bag_id_storage = self.ARK_Data.bag_id_storage
	local codex = ArkInventory.Codex.GetPlayer( loc_id_storage )
	local bag = codex.player.data.location[loc_id_storage].bag[bag_id_storage]

	bag.name = ARK_TabData.name
	bag.texture = ARK_TabData.icon
	bag.df = ARK_TabData.depositFlags

	ArkInventory:SendMessage( "EVENT_ARKINV_CHANGER_UPDATE_BUCKET", self.ARK_Data.loc_id_window )
	

	PlaySound( SOUNDKIT.GS_TITLE_OPTION_OK )

end

function ArkInventoryTabSettingsTypeAMixin:CancelButton_OnClick( )
	
	IconSelectorPopupFrameTemplateMixin.CancelButton_OnClick( self )
	
	self.ARK_Data = nil
	self.ARK_TabData = nil

	PlaySound( SOUNDKIT.GS_TITLE_OPTION_OK )
	
end
