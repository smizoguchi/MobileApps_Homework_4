local composer = require( "composer" )
local block = require("block")
local blue = require("blue")
local yellow = require("yellow")
local grey = require("grey")

local transition = {effect = "fade", time = 500}

local function sceneChange(sn)
    composer.gotoScene(sn, transition);
end

local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 

  
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
 
    local sceneGroup = self.view;
    
    -- Code here runs when the scene is first created but has not yet appeared on screen


 
end

 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        local physics = require("physics");
        physics.start();
        
        physics.setGravity(0,0);

        
        local top = display.newRect(0,100,display.contentWidth, 20);
        local left = display.newRect(0,0,20, display.contentHeight);
        local right = display.newRect(display.contentWidth-20,0,20,display.contentHeight);
        local bottom = display.newRect(0,display.contentHeight-20, display.contentWidth, 20);

        
        sceneGroup:insert(top);
        sceneGroup:insert(left);
        sceneGroup:insert(right);
        sceneGroup:insert(bottom);
        top.anchorX= 0;top.anchorY = 0;
        left.anchorX= 0;left.anchorY = 0;
        right.anchorX= 0;right.anchorY = 0;
        bottom.anchorX= 0;bottom.anchorY = 0;


        physics.addBody( bottom, "static" );
        physics.addBody( top, "static" );
        physics.addBody( left, "static" );
        physics.addBody( right, "static" );


        local paddle = display.newRect(display.contentCenterX, display.contentHeight-100, 200, 20);
        physics.addBody( paddle, "kinematic");
        sceneGroup:insert(paddle);

        local function move ( event )
            if event.phase== "began" then
                paddle.markX= paddle.x
            elseif event.phase== "moved" then
                    local x = (event.x-event.xStart) + paddle.markX;paddle.x= x;
            end
        end

        Runtime:addEventListener("touch", move);


        local playerHP = 5;
        local lifeCount = display.newText(
        {
            text = "Lives: "..playerHP,
            x = display.contentCenterX,
            y = 50,
            width = 1080,
            font = native.systemFontBold,
            fontSize = 48,
            align = "center"
        });
        sceneGroup:insert(lifeCount);

        local ball = display.newCircle(display.contentCenterX, display.contentCenterY-50, 20);
        physics.addBody(ball, "dynamic", {bounce=1, radius=20} );

        sceneGroup:insert(ball);

        ball:applyForce(0,50,ball.x,ball.y)

        local normCount = 0;
        local yCount = 0;
        local gCount = 0;
        local all = display.newGroup();

            
        local function yhit(all)
                print("ycol called")
            for i=1,all.numChildren do
                print("hello")
                local target = all[i];
                if (target.color == 'blue') then
                    target:setFillColor(1,0,0)
                    target.HP = 1
                elseif (target.color == 'red') then
                    target:setFillColor(0,0,1)
                    target.HP = 2
                end
            end
        end


        local function cheat(event) 
            if (event.phase == "began") then
                if (event.target.tag == "box") then
                    if (event.target.color == "yellow") then
                        print("in the yellow call")
                        yhit(all);
                    end
                    event.target.pp:hit();
                end
            end
        end


		for counta = 1,4 do
			for countb = 1,6 do

                local spawned = false

                while (spawned == false) do
    				local bType = math.random(1,4)

    				local xpos = (((display.contentWidth-40)/6) * countb) -((display.contentWidth-40)/6) +20;
    				local ypos = ((display.contentHeight/12) * counta) -(display.contentHeight/12) + 120;
    				
    				if (bType == 1) then
    					if normCount < 18 then
    						normCount = normCount + 1
    						r = block:new({xPos=xpos, yPos=ypos});
    						r = r:spawn();
                            all:insert(r);
                            r:addEventListener("touch", cheat)
                            spawned =true;
    					end
    				elseif (bType == 2) then
    					if normCount < 18 then
    						normCount = normCount + 1
    						b = blue:new({xPos=xpos, yPos=ypos});
    						b = b:spawn();
                            all:insert(b);
                            b:addEventListener("touch", cheat)
                            spawned =true;
    					end
    				elseif (bType == 3) then
    					if yCount < 2 then
    						yCount = yCount + 1;
    						y = yellow:new({xPos=xpos, yPos=ypos});
    						y = y:spawn();
                            all:insert(y);
                            y:addEventListener("touch", cheat)
                            spawned =true;
    					end
    				else
    					if gCount < 4 then
    						gCount = gCount + 1;
    						g = grey:new({xPos=xpos, yPos=ypos});
                            g = g:spawn();
                            sceneGroup:insert(g);	
                            spawned =true;
    					end
    				end
                end
			end
        end

        --Doesn't get called
        local function endLevel(event)
            if(event.phase== "began")then
                if(all.numChildren == 0)then
                    sceneChange("level_2");
                end
            end
        end

        local function ballCollision(event)
            if (event.phase== "began") then
                if (event.other== paddle) then
                    lifeCount.text="Lives: "..playerHP;
                elseif (event.other == bottom) then
                    print("hello")
                    playerHP = playerHP - 1
                    lifeCount.text="Lives: "..playerHP;

                    if playerHP==0 then
                        lifeCount.text = "You're bad at this game."
                        ball:removeSelf();
                        ball=nil;
                    end
                elseif (event.other.tag == 'box') then
                    print(event.other.color)
                	if(event.other.color ~= 'grey') then
                        if(event.other.color == 'yellow') then
                            print("call yellow collision")
                            yhit(all); 
                        end
                        
                        event.other.pp:hit();
                    end
                end;
            end
        end
        ball:addEventListener("collision", ballCollision);

        --Doesn't get called
        --[[ ball:addEventListener("endLevel", endLevel); ]]
        if(all.numChildren == 0)then
            sceneChange("level_2");
        end
    end
    

end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
