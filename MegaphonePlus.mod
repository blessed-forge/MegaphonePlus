<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="MegaphonePlus" version="2.2" date="27/11/2017" >

		<Author name="Richard Conner" email="rkc@pacbell.net" />
		<Author name="Elesthor" version= "2.2"/>
		<Description text="v2.0 Makes your warband leaders instructions into system alerts. Now you can chose among 26 fonts!" />
		<VersionSettings gameVersion="1.4.0" windowsVersion="1.0" savedVariablesVersion="1.0" />

		<Dependencies>
			<Dependency name="EA_ChatWindow" />
			<Dependency name="LibSlash"/>
		</Dependencies>
		
		<Files>
			<File name="MegaphonePlus.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="Megaphone.Initialize" />
		</OnInitialize>
		<SavedVariables>
			<SavedVariable name="Megaphone.Font" global="false"/>
			<SavedVariable name="Megaphone.Name" global="false"/>
		</SavedVariables>
		
		<OnUpdate/>
		
		<OnShutdown/>
		<WARInfo>
		<Categories>
			<Category name="RVR" />
			<Category name="GROUPING" />
			<Category name="COMBAT" />
			
		</Categories>
		<Careers>
			<Career name="BLACKGUARD" />
			<Career name="WITCH_ELF" />
			<Career name="DISCIPLE" />
			<Career name="SORCERER" />
			<Career name="IRON_BREAKER" />
			<Career name="SLAYER" />
			<Career name="RUNE_PRIEST" />
			<Career name="ENGINEER" />
			<Career name="BLACK_ORC" />
			<Career name="CHOPPA" />
			<Career name="SHAMAN" />
			<Career name="SQUIG_HERDER" />
			<Career name="WITCH_HUNTER" />
			<Career name="KNIGHT" />
			<Career name="BRIGHT_WIZARD" />
			<Career name="WARRIOR_PRIEST" />
			<Career name="CHOSEN" />
			<Career name="MARAUDER" />
			<Career name="ZEALOT" />
			<Career name="MAGUS" />
			<Career name="SWORDMASTER" />
			<Career name="SHADOW_WARRIOR" />
			<Career name="WHITE_LION" />
			<Career name="ARCHMAGE" />
		</Careers>
	</WARInfo>
				
	</UiMod>
</ModuleFile>