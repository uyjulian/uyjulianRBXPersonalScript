export modinfo = {
	type: "function"
	id: "GenerateDickTree"
	func: (location,complexity,width,height,anchor) ->
		Base = CreateInstance"Part"
			Name: "Trunk"
			FormFactor: "Custom"
			TopSurface: 0
			BottomSurface: 0
			Anchored: true
			BrickColor: ConfigSystem "Get", "Ero-iro"

		Leaves = Base\Clone!
		Leaves.Name = "Leaves"
		Leaves.CanCollide = true
		Leaves.BrickColor = ConfigSystem("Get", "Ero sentan no iro")
		leafmesh = CreateInstance"SpecialMesh"
			Parent: Leaves
			Scale: Vector3.new 0.5, 0.5, 0.5
		basemesh = CreateInstance"CylinderMesh"
			Parent: Base
		Branch = (base,c) ->
			-- get dot product of yz angles
			dot = (c1,c2) ->
				m = CFrame.Angles math.pi/2,0,0
				(c1*m).lookVector\Dot (c2*m).lookVector
			-- multiplier for various sizes of foliage

			leaf_mult = {
				Vector3.new 1.5,1.5,1.2
				Vector3.new 1.5,1,1.5
				Vector3.new 1.2,1.5,1.5
				Vector3.new 1.5,1.5,1.5
			}
			if c <= 0
				-- if the complexity has run out, generate some foliage
				leaves = Leaves\Clone!
				vol = base.Size.x+base.Size.y+base.Size.z -- determine size based on branch size
				leaves.Mesh.Scale = leaf_mult[math.random(1,#leaf_mult)]*math.random(2,4)/2
				leaves.Size = leaves.Mesh.Scale*0.50
				leaves.CFrame = base.CFrame * CFrame.new 0,base.Size.y/2,0 -- center foliage at top of branch
				leaves.Parent = base.Parent
			else
				-- otherwise, make some more branches
				pos = base.CFrame*CFrame.new(0,base.Size/2,0)
				height = base.Size.y
				width = base.Size.x
				nb = math.random 2,2 -- # of possible branches (2 seems to work fine for now)
				r = math.random 45,135 -- rotation of branches on y axis
				-- branch split angle difference
				-- the less complexity, the greater the possible angle
				-- minimum: 20-75; maximum: 40-80
				da = math.random 20+55/c,40+40/c
				-- branch angle (overall angle of all branches)
				ba = math.random -da/3,da/3
				-- ba+da/2 shouldn't be near or greater than 90 degrees
				for i=0,nb-1 -- for each branch
					branch = base\Clone!
					branch.Name = "Branch"
					h = height * math.random(95,115) / 100 -- height .95 to 1.15 of original
					-- make new cframe
					-- move new to top of base, then apply branch angle (ba)
					new = branch.CFrame * CFrame.new(0,height/2,0) * CFrame.Angles(0,0,math.rad(ba))
					-- next, rotate branch so that it faces away from others, also apply overall rotation (r)
					-- also, apply the split angle (da)
					-- finally, move branch upward by half it's size
					new = new * CFrame.Angles(0,i*(math.pi*2/nb)+r,math.rad(da/2)) * CFrame.new(0,h/2,0)
					-- determine width by branch's final angle; greater the angle, smaller the width
					-- also shave off a bit of width for more dramatic change in size
					-- a frustum cone mesh would really help here
					w = dot(new,branch.CFrame)*width*0.9
					branch.Size = Vector3.new(w,h,w)
					branch.CFrame = new
					branch.Parent = base.Parent
					-- create the next set of branches with one less complexity
					Branch branch,c-1
		tree = CreateInstance"Model"
			Name: "Tree"
			Parent: workspace
		base = Base\Clone!
		base.Parent = tree
		base.Size = Vector3.new width,height,width
		-- move up by half its height, and rotate randomly
		base.CFrame = CFrame.new(location) * CFrame.new(0,height/2,0) * CFrame.Angles(0,math.rad(math.random(1,360)),0)
		-- start branching
		Branch base,complexity
		tree

}
