local Block = require("Block");
local Grey = Block:new({HP=99,tag='box',color='grey'});


function Grey:spawn()
	self.shape= display.newRect(self.xPos, self.yPos,display.contentWidth/6,display.contentHeight/12);
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape:setFillColor(.5,.5,.5);
	physics.addBody(self.shape, "kinematic"); 
end

return Grey;
