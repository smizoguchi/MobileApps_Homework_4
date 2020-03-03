local Block = {HP=1,tag='box',color='red'};


function Block:new(o)    --constructor
	o = o or {}; 
	setmetatable(o, self);
	self.__index= self;
	return o;
end


function Block:spawn()
	self.shape= display.newCircle(self.xPos, self.yPos,15);
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape:setFillColor(1,1,0);
	physics.addBody(self.shape, "kinematic"); 
end


function Block:hit()
	self.HP=self.HP-1;
	if(self.HP > 0) then
		self.shape:setFillColor(1,0,0);
	else
		self.shape:removeSelf();
		self.shape=nil;
		self=nil;
	end
end

function Block:debug()
    event.target:hit();
end

return Block;
