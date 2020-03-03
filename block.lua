local Block = {HP=1,tag='box',color='red'};


function Block:new(o)    --constructor
	o = o or {}; 
	setmetatable(o, self);
	self.__index= self;
	return o;
end


function Block:spawn()
	self.shape= display.newRect(self.xPos, self.yPos,(display.contentWidth-40)/6,display.contentHeight/12);
	self.shape.anchorX = 0;
	self.shape.anchorY = 0;
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape:setFillColor(1,0,0);
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
