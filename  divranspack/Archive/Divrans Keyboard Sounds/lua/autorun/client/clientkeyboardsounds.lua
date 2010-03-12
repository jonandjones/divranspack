local Time = false
local function TimerFalse()
	Time = false
end

local function ChatKeyboardSounds( Text )
	if (Time == false) then
		if (Text != "") then
			RunConsoleCommand( "ChatChanged" )
			Time = true
			timer.Simple( 0.1, function() TimerFalse() end )
		end
	end
end
hook.Add( "ChatTextChanged", "ChatKeyboardSounds", ChatKeyboardSounds )