-- Type B

ArkInventoryTabSettingsTypeBMixin = { }

function ArkInventory.TabSettingsTypeBOpen( loc_id_window, bag_id_window )
	
	local map = ArkInventory.Util.MapGetWindow( loc_id_window, bag_id_window )
	
	local self = _G["ARKINV_TabSettingsTypeBFrame"]
	
	if self.DepositSettingsMenu then
		self.DepositSettingsMenu:Show( )
	end
	
	self:Hide( )
	
	self.ARK_Data = {
		blizzard_id = map.blizzard_id,
		loc_id_window = map.loc_id_window,
		bag_id_window = map.bag_id_window,
		loc_id_storage = map.loc_id_storage,
		bag_id_storage = map.bag_id_storage,
	}
	
	local ARK_TabData

	if map.loc_id_storage == ArkInventory.Const.Location.Bank then
		
		ARK_TabData = C_Bank.FetchPurchasedBankTabData( ArkInventory.ENUM.BANKTYPE.CHARACTER )[map.tab_id]
		ARK_TabData.tabNameEditBoxHeader = CHARACTER_BANK_TAB_NAME_PROMPT

	elseif map.loc_id_storage == ArkInventory.Const.Location.AccountBank then
		
		ARK_TabData = C_Bank.FetchPurchasedBankTabData( ArkInventory.ENUM.BANKTYPE.ACCOUNT )[map.tab_id]
		ARK_TabData.tabNameEditBoxHeader = ACCOUNT_BANK_TAB_NAME_PROMPT

	else

		ArkInventory.OutputWarning( "uncoded type B tab setings location [", map.loc_id_storage, "]" )
		return

	end
	
	ARK_TabData.tab = map.bag_id_storage

	self.ARK_TabData = ArkInventoryTabSettingsTypeAMixin.ArkValidateData( ARK_TabData )
	
	self.selectedTabData = ARK_TabData
	
	self.BorderBox.EditBoxHeaderText:SetText( ARK_TabData.tabNameEditBoxHeader )
	
	self.mode = IconSelectorPopupFrameModes.Edit
	
	self:Show( )
	
end

function ArkInventoryTabSettingsTypeBMixin:OnShow( )
	
	local loc_id_window = self.ARK_Data.loc_id_window
	local bag_id_window = self.ARK_Data.bag_id_window
	
	local parentframename = string.format( "ARKINV_Frame%dTitle", loc_id_window )
	local parentframe = _G[parentframename]
	
	self:ClearAllPoints( )
	self:SetScale( 0.75 )
	self:SetPoint( "TOPLEFT", parentframe, "TOPRIGHT", 10, 0 )
	
	--ArkInventory.OutputDebug( loc_id_window, " / ", bag_id_window, " / ", parentframename )
	
	--CallbackRegistrantMixin.OnShow( self )

	IconSelectorPopupFrameTemplateMixin.OnShow( self )
	
	self.iconDataProvider = self:RefreshIconDataProvider( )
	
	self:Update( )
	
	self:SetIconFilter( IconSelectorPopupFrameIconFilterTypes.All )
	
	self.BorderBox.IconSelectorEditBox:SetFocus( )
	self.BorderBox.IconSelectorEditBox:OnTextChanged( )
	
	PlaySound( SOUNDKIT.IG_CHARACTER_INFO_OPEN )

end

function ArkInventoryTabSettingsTypeBMixin:UpdateBankTabSettings( )

	local ARK_TabData = self.ARK_TabData

	ARK_TabData.icon = self:GetNewTabIcon( )
	ARK_TabData.name = self:GetNewTabName( )
	ARK_TabData.depositFlags = self:GetNewTabDepositFlags( )

	ARK_TabData = ArkInventoryTabSettingsTypeAMixin.ArkValidateData( ARK_TabData )


	local loc_id_storage = self.ARK_Data.loc_id_storage

	if loc_id_storage == ArkInventory.Const.Location.Bank then
		
		C_Bank.UpdateBankTabSettings( ArkInventory.ENUM.BANKTYPE.CHARACTER, ARK_TabData.ID, ARK_TabData.name, ARK_TabData.icon, ARK_TabData.depositFlags )

	elseif loc_id_storage == ArkInventory.Const.Location.AccountBank then
		
		C_Bank.UpdateBankTabSettings( ArkInventory.ENUM.BANKTYPE.ACCOUNT, ARK_TabData.ID, ARK_TabData.name, ARK_TabData.icon, ARK_TabData.depositFlags )
		
	end
	

	-- update arkinventory data
	local bag_id_storage = self.ARK_Data.bag_id_storage
	local codex = ArkInventory.Codex.GetPlayer( loc_id_storage )
	local bag = codex.player.data.location[loc_id_storage].bag[bag_id_storage]

	bag.name = ARK_TabData.name
	bag.texture = ARK_TabData.icon
	bag.df = ARK_TabData.depositFlags

	ArkInventory:SendMessage( "EVENT_ARKINV_CHANGER_UPDATE_BUCKET", self.ARK_Data.loc_id_window )
	
end
