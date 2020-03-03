local Block = require("Block");
local Grey = Block:new({HP=1,tag='box',color='grey'});


function Grey:spawn()
	self.shape= display.newRect(self.xPos, self.yPos,(display.contentWidth-40)/6,display.contentHeight/12);
	self.shape.anchorX = 0;
	self.shape.anchorY = 0;
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape:setFillColor(.5,.5,.5);
	physics.addBody(self.shape, "kinematic"); 
end

function Grey:hit()
	return
end

return Grey;
