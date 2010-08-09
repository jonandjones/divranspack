local Obj = EGP:NewObject( "TextLayout" )
Obj.h = 512
Obj.w = 512
Obj.text = ""
Obj.fontid = 1
Obj.size = 18
Obj.valign = 0
Obj.halign = 0
Obj.Draw = function( self )
	if (self.text and #self.text>0) then
		surface.SetTextColor( self.r, self.g, self.b, self.a )
		
		local font = "WireEGP_" .. self.size .. "_" .. self.fontid
		if (!EGP.ValidFonts_Lookup[font]) then
			surface.CreateFont( EGP.ValidFonts[self.fontid], self.size, 800, true, false, font )
			table.insert( EGP.ValidFonts, font )
			EGP.ValidFonts_Lookup[font] = true
		end
		surface.SetFont( font )
		
		--[[
		local w,h
		local x, y = self.x, self.y
		if (self.halign != 0) then
			w,h = surface.GetTextSize( self.text )
			x = x - (w * ((self.halign%10)/2))
		end
		]]
		local y = 0
		if (self.valign) then
			_,h = surface.GetTextSize( self.text )
			y = -(h * ((self.valign%10)/2))
		end
		
		
		if (!self.layouter) then self.layouter = MakeTextScreenLayouter() end
		self.layouter:DrawText( self.text, self.x, self.y + y, self.w, self.h, self.halign, self.valign )
		
		--surface.SetTextPos( x, y )
		--surface.DrawText( self.text )
	end
end
Obj.Transmit = function( self )
	EGP:SendPosSize( self )
	EGP.umsg.String( self.text )
	EGP.umsg.Char( self.fontid-128 )
	EGP.umsg.Char( math.Clamp(self.size,0,128)-128 )
	EGP.umsg.Char( math.Clamp(self.valign,0,2) )
	EGP.umsg.Char( math.Clamp(self.halign,0,2) )
	EGP.umsg.Short( self.parent )
	EGP:SendColor( self )
end
Obj.Receive = function( self, um )
	local tbl = {}
	EGP:ReceivePosSize( tbl, um )
	tbl.text = um:ReadString()
	tbl.fontid = um:ReadChar()+128
	tbl.size = um:ReadChar()+128
	tbl.valign = um:ReadChar()
	tbl.halign = um:ReadChar()
	tbl.parent = um:ReadShort()
	EGP:ReceiveColor( tbl, self, um )
	return tbl
end
Obj.DataStreamInfo = function( self )
	return { align = self.align, size = self.size, r = self.r, g = self.g, b = self.b, a = self.a, text = self.text, fontid = self.fontid }
end