local widget = require( "widget" );
local composer = require( "composer" )

local intro = composer.newScene("intro");

local btnOpt =
    {
    frames = {
        { x = 3, y = 2, width=70, height = 22}, --frame 1
        { x = 78, y = 2, width=70, height = 22}, --frame 2
    }
};

local buttonSheet = graphics.newImageSheet( "button.png", btnOpt );

local transition = {effect = "fade", time = 500}

local function sceneChange(sn)
    composer.gotoScene(sn, transition);
end

local function progExit()
    native.requestExit();
end

function intro:create(event)

    local sceneGroup = self.view;

    level1 = widget.newButton(
        {
            x = display.contentCenterX - 200,
            y = display.contentCenterY + 500,
            id = "level 1",
            label = "Level 1",
            sheet = buttonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onEvent = function() sceneChange("level_1"); end,
            labelColor = {default = {0,0,0}, over={0,0,1,0.7}}
        }
    )
    level1.xScale = 5; level1.yScale = 5;


    exit = widget.newButton(
        {
            x = display.contentCenterX,
            y = display.contentCenterY + 700,
            id = "exit",
            label = "Exit",
            sheet = buttonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onPress = progExit,
            labelColor = {default = {0,0,0}, over={0,0,1,0.7}}
        }
    )
    exit.xScale = 5; exit.yScale = 5;
    
    level2 = widget.newButton(
        {
            x = display.contentCenterX + 200,
            y = display.contentCenterY + 500,
            id = "Level 2",
            label = "Level 2",
            sheet = buttonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onEvent = function() sceneChange("level_2"); end,
            labelColor = {default = {0,0,0}, over={0,0,1,0.7}}
        }
    )
    level2.xScale = 5; level2.yScale = 5;


    sceneGroup:insert(level1);
    sceneGroup:insert(exit);
    sceneGroup:insert(level2);
    


end

-- hide()
function intro:hide( event )

    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene( "intro", true );
    end
end


function intro:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        intro:create(event);
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end

-- destroy()
function intro:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 


intro:addEventListener( "create", intro);
intro:addEventListener( "show", intro );
intro:addEventListener( "hide", intro );
intro:addEventListener( "destroy", intro );

return intro;
