-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require("physics");
physics.start();
physics.setDrawMode("hybrid")
physics.setGravity(0,0);

local timeVal = 100;
local life = 10

local droplets=0;
local bounces=0;
local show = display.newText(
	{text="Droplets:0  Bounces:0",
	x=display.contentCenterX, y=50,fontSize=50});

local top = display.newRect(0,100,display.contentWidth, 20);
local left = display.newRect(0,0,20, display.contentHeight);
local right = display.newRect(display.contentWidth-20,0,20,display.contentHeight);
local bottom = display.newRect(0,display.contentHeight-20, display.contentWidth, 20);
top.anchorX= 0;top.anchorY = 0;
left.anchorX= 0;left.anchorY = 0;
right.anchorX= 0;right.anchorY = 0;
bottom.anchorX= 0;bottom.anchorY = 0;


physics.addBody( bottom, "static" );
physics.addBody( top, "static" );
physics.addBody( left, "static" );
physics.addBody( right, "static" );
local ball = display.newCircle(display.contentCenterX, display.contentCenterY-50, 20);
physics.addBody(ball, "dynamic", {bounce=1.1, radius=20} );


ball:applyForce(0,50,ball.x,ball.y)


local paddle = display.newRect(display.contentCenterX, display.contentHeight-100, 200, 20);
physics.addBody( paddle, "kinematic");


local function move ( event )
	if event.phase== "began" then
		paddle.markX= paddle.x
	elseif event.phase== "moved" then
			local x = (event.x-event.xStart) + paddle.markX;paddle.x= x;
	end
end

Runtime:addEventListener("touch", move);

local function ballCollision(event)
	if (event.phase== "began") then
		if (event.other== paddle) then
			bounces=bounces+1;
			show.text= "Droplets:"..droplets.."   Bounces:"..bounces.."   Lives: "..life;
		elseif (event.other == bottom) then
			life = life - 1
			show.text= "Droplets:"..droplets.."   Bounces:"..bounces.."   Lives: "..life;

			if life==0 then
				show.text  = "You're bad at this game."
				ball:removeSelf();
				ball=nil;
			else
			end
		end 
	end
end

ball:addEventListener("collision", ballCollision);

