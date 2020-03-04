local Block = require("Block")

local yellow = Block:new({HP=1,tag='box',color="yellow"});



function yellow:spawn()
	self.shape= display.newRect(self.xPos, self.yPos,(display.contentWidth-40)/6,display.contentHeight/12);
	self.shape.anchorX = 0;
	self.shape.anchorY = 0;
	self.shape.pp= self;      -- parent pointer to parent object
	self.shape.tag= self.tag; --“enemy”
	self.shape.color = self.color;
	self.shape:setFillColor(1,1,0);
	physics.addBody(self.shape, "kinematic"); 
	return self.shape
end


return yellow;



--[[
        local function yCol(all)
                print("ycol called")
            for i=1,all.numChildren do
                print("hello")
                if (all[i].color == 'blue') then
                    all[i]:setfillColor(1,0,0)
                    all[i].shape.HP = 1
                elseif (all[i].color == 'red') then
                    all[i].shape:setfillColor(0,0,1)
                    all[i].shape.HP = 2
                end
            end
        end--]]