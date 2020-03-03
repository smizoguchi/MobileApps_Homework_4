local Block = require("Block");
local Blue = Block:new({HP=2,tag='box',color='blue'});


function Blue:spawn()
	self.shape= display.newRect(self.xPos, self.yPos,display.contentWidth/6,display.contentHeight/12);
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape:setFillColor(0,0,1);
	physics.addBody(self.shape, "kinematic"); 
end

return Blue;
