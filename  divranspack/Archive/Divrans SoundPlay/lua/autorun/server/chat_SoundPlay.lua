-------------------------------------------------------------------------------------------------------------------------
-- Chat Sound
-- By Divran

-- How to add your own sound to the list
-- Copy the following (without the /* and */)
/*
local Sound5 = {}
Sound5.ChatCmd = "Cmd here"
Sound5.Path = "Path here"
Sound5.Pitch = 100
Sound5.Volume = 100
	table.insert( SoundList, Sound5)
*/
-- Paste it after the example sounds below.
-- After you have copied it, change the number "5" if necessary.
-------------------------------------------------------------------------------------------------------------------------

-- Don't change this
local SoundList = {}
-- Don't change this

-------------------------------------------------------------------------------------------------------------------------
-- Set up the list of sounds
-- NOTE: Pitch and Volume are in % (percent)
-------------------------------------------------------------------------------------------------------------------------

-- Example sounds. You can replace these with your own sounds if you want.
local Sound1 = {}
Sound1.ChatCmd = "hax"
Sound1.Path = "vo/npc/male01/hacks01.wav"
Sound1.Pitch = 150
Sound1.Volume = 100
	table.insert( SoundList, Sound1 )
local Sound2 = {}
Sound2.ChatCmd = "lol"
Sound2.Path = "vo/Citadel/br_laugh01.wav"
Sound2.Pitch = 190
Sound2.Volume = 100
	table.insert( SoundList, Sound2 )
local Sound3 = {}
Sound3.ChatCmd = "muhaha"
Sound3.Path = "vo/ravenholm/madlaugh03.wav"
Sound3.Pitch = 70
Sound3.Volume = 100
	table.insert( SoundList, Sound3 )
local Sound4 = {}
Sound4.ChatCmd = "rawr"
Sound4.Path = "npc/ichthyosaur/attack_growl3.wav"
Sound4.Pitch = 85
Sound4.Volume = 100
	table.insert( SoundList, Sound4 )
local Sound5 = {}
Sound5.ChatCmd = "wth"
Sound5.Path = "vo/k_lab/ba_whatthehell.wav"
Sound5.Pitch = 100
Sound5.Volume = 100
	table.insert( SoundList, Sound5 )
local Sound6 = {}
Sound6.ChatCmd = "oops"
Sound6.Path = "vo/k_lab/ba_whoops.wav"
Sound6.Pitch = 100
Sound6.Volume = 100
	table.insert( SoundList, Sound6 )
local Sound7 = {}
Sound7.ChatCmd = "hello"
Sound7.Path = "vo/npc/male01/hi01.wav"
Sound7.Pitch = 100
Sound7.Volume = 100
	table.insert( SoundList, Sound7 )
local Sound8 = {}
Sound8.ChatCmd = "help"
Sound8.Path = "vo/npc/male01/help01.wav"
Sound8.Pitch = 100
Sound8.Volume = 100
	table.insert( SoundList, Sound8 )
local Sound9 = {}
Sound9.ChatCmd = "incoming"
Sound9.Path = "vo/npc/male01/incoming02.wav"
Sound9.Pitch = 100
Sound9.Volume = 100
	table.insert( SoundList, Sound9 )
local Sound10 = {}
Sound10.ChatCmd = "nice"
Sound10.Path = "vo/npc/male01/nice.wav"
Sound10.Pitch = 100
Sound10.Volume = 100
	table.insert( SoundList, Sound10 )
local Sound11 = {}
Sound11.ChatCmd = "sorry"
Sound11.Path = "vo/npc/male01/sorry01.wav"
Sound11.Pitch = 100
Sound11.Volume = 100
	table.insert( SoundList, Sound11 )
local Sound12 = {}
Sound12.ChatCmd = "yeah"
Sound12.Path = "vo/npc/male01/yeah02.wav"
Sound12.Pitch = 100
Sound12.Volume = 100
	table.insert( SoundList, Sound12 )
	
-------------------------------------------------------------------------------------------------------------------------
-- Detect when someone writes in chat and play the sound
-------------------------------------------------------------------------------------------------------------------------

function Detect( ply, text )
	for k,v in pairs(SoundList) do
		if (string.find( string.lower(text), SoundList[k].ChatCmd )) then
			ply:EmitSound( SoundList[k].Path, SoundList[k].Volume, SoundList[k].Pitch )
		end
	end
end
hook.Add( "PlayerSay", "Detect", Detect )