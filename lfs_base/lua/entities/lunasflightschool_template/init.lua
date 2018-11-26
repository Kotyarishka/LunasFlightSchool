-- YOU CAN EDIT AND REUPLOAD THIS FILE. 
-- HOWEVER MAKE SURE TO RENAME THE FOLDER TO AVOID CONFLICTS

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName ) -- called by garry
	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal * 20 ) -- spawn 20 units above ground
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:OnTick() -- use this instead of "think"
end

function ENT:RunOnSpawn() -- called when the vehicle is spawned
end

function ENT:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimary( 0.15 )
	
	--[[ do primary attack code here ]]--
	
	self:EmitSound( "Weapon_SMG1.NPC_Single" )
	
	local Driver = self:GetDriver()
	
	local bullet = {}
	bullet.Num 	= 1
	bullet.Src 	= self:LocalToWorld( Vector(20,0,10) )
	bullet.Dir 	= self:GetForward()
	bullet.Spread 	= Vector( 0.015,  0.015, 0 )
	bullet.Tracer	= 1
	bullet.TracerName	= "lfs_tracer_green"
	bullet.Force	= 10
	bullet.HullSize 	= 5
	bullet.Damage	= 5
	bullet.Attacker 	= Driver
	bullet.AmmoType = "Pistol"
	
	self:FireBullets( bullet )
	
	self:TakePrimaryAmmo()
end

function ENT:SecondaryAttack()
	if not self:CanPrimaryAttack() then return end
	
	self:SetNextPrimary( 0.15 )

	--[[ do secondary attack code here ]]--
	
	self:TakePrimaryAmmo()
end

function ENT:CreateAI() -- called when the ai gets enabled
end

function ENT:RemoveAI() -- called when the ai gets disabled
end

function ENT:OnEngineStarted()
	--[[ play engine start sound? ]]--
	self:EmitSound( "vehicles/airboat/fan_motor_start1.wav" )
end

function ENT:OnEngineStopped()
	--[[ play engine stop sound? ]]--
	self:EmitSound( "vehicles/airboat/fan_motor_shut_off1.wav" )
end

function ENT:OnLandingGearToggled( bOn )
	self:EmitSound( "vehicles/tank_readyfire1.wav" )
	
	if bOn then
		--[[ set bodygroup of landing gear down? ]]--
	else
		--[[ set bodygroup of landing gear up? ]]--
	end
end