local block = require("block")

local yellow = block:new({HP=1,tag='box',color="yellow"});



function yellow:spawn()
	self.shape= display.newRect(self.xPos, self.yPos,(display.contentWidth-40)/6,display.contentHeight/12);
	self.shape.anchorX = 0;
	self.shape.anchorY = 0;
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape:setFillColor(1,1,0);
	physics.addBody(self.shape, "kinematic"); 
end

return yellow;
