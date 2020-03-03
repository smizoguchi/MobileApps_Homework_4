local composer = require( "composer" )
 
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


    local physics = require("physics");
    physics.start();
    physics.setDrawMode("hybrid")
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
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        local ball = display.newCircle(display.contentCenterX, display.contentCenterY-50, 20);
        physics.addBody(ball, "dynamic", {bounce=1, radius=20} );

        sceneGroup:insert(ball);

        ball:applyForce(0,50,ball.x,ball.y)


        local function ballCollision(event)
            if (event.phase== "began") then
                if (event.other== paddle) then
                    show.text="Lives: "..life;
                elseif (event.other == bottom) then
                    life = life - 1
                    show.text="Lives: "..life;

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
