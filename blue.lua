local Block = require("Block");
local Blue = Block:new({HP=2,tag='box',color='blue'});


function Blue:spawn()
	self.shape= display.newRect(self.xPos, self.yPos,(display.contentWidth-40)/6,display.contentHeight/12);
	self.shape.anchorX = 0;
	self.shape.anchorY = 0;
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape.color = self.color;
	self.shape:setFillColor(0,0,1);
	physics.addBody(self.shape, "kinematic"); 
	return self.shape
end

return Blue;
