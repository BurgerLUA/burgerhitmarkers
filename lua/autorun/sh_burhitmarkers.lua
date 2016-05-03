
if SERVER then

	util.AddNetworkString( "BurgerHitmarkers" )

	function BurHitmarkers(ply,hitgroup,dmginfo)
		local attacker = dmginfo:GetAttacker()
		net.Start("BurgerHitmarkers")
			net.WriteBool(true)
		net.Send(attacker)
	end
	hook.Add("ScalePlayerDamage","Burger's Hitmarker Damage",BurHitmarkers)
	
end

if CLIENT then

	local Mat = Material("vgui/crosshairs/crosshair6")

	local HitTrans = 0

	net.Receive("BurgerHitmarkers",function(len,ply)
		--print("hit")
		HitTrans = 300
	end)
	
	function BurHitmarkerDraw()
	
		HitTrans = math.Clamp(HitTrans - FrameTime()*300*2,0,300)
	
		local x = ScrW()/2
		local y = ScrH()/2
		local FinalAlpha = math.Clamp(HitTrans,0,255)
		local Size = 10 * (FinalAlpha/255)
		local Offset = (10*(FinalAlpha/255)) + Size
		
		surface.SetDrawColor(Color(255,255,255,FinalAlpha))
		surface.DrawLine( x - Size + Offset, y - Size + Offset, x + Size + Offset, y + Size + Offset)
		surface.DrawLine( x - Size - Offset, y - Size - Offset , x + Size - Offset, y + Size - Offset)	
		surface.DrawLine( x - Size + Offset, y + Size - Offset, x + Size + Offset, y - Size - Offset)
		surface.DrawLine( x - Size - Offset, y + Size + Offset , x + Size - Offset, y - Size + Offset)

	end
	
	hook.Add("HUDPaint","Burger's Hitmarker HUDPaint",BurHitmarkerDraw)
	
end