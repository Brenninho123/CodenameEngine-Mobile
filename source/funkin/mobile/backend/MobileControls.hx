package mobile.backend;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import mobile.backend.TouchPad;
import mobile.backend.MobileConfig;

class MobileControls extends FlxGroup
{
    public static var instance:MobileControls;
    
    public var touchPad:TouchPad;
    public var hitbox:TouchPad; // Hitbox style controls
    
    private var controlMode:String = "PAD"; // PAD, HITBOX, BOTH
    
    public function new()
    {
        super();
        instance = this;
        
        // Carrega configuração salva
        loadConfig();
        
        // Cria controles baseado no modo
        createControls();
    }
    
    private function loadConfig():Void
    {
        var savedMode = MobileConfig.getControlMode();
        if (savedMode != null)
            controlMode = savedMode;
    }
    
    private function createControls():Void
    {
        // Remove controles existentes
        if (touchPad != null) remove(touchPad);
        if (hitbox != null) remove(hitbox);
        
        switch (controlMode)
        {
            case "PAD":
                touchPad = new TouchPad("PAD");
                add(touchPad);
                
            case "HITBOX":
                hitbox = new TouchPad("HITBOX");
                add(hitbox);
                
            case "BOTH":
                touchPad = new TouchPad("PAD");
                hitbox = new TouchPad("HITBOX");
                add(touchPad);
                add(hitbox);
        }
        
        // Ajusta posição baseado nas configurações
        updateControlsPosition();
    }
    
    private function updateControlsPosition():Void
    {
        var padX = MobileConfig.getPadX();
        var padY = MobileConfig.getPadY();
        var padSize = MobileConfig.getPadSize();
        var padAlpha = MobileConfig.getPadAlpha();
        
        if (touchPad != null)
        {
            touchPad.x = padX;
            touchPad.y = padY;
            touchPad.setScale(padSize);
            touchPad.alpha = padAlpha;
        }
        
        if (hitbox != null)
        {
            hitbox.x = FlxG.width - hitbox.width - 20;
            hitbox.y = FlxG.height - hitbox.height - 20;
            hitbox.setScale(padSize);
            hitbox.alpha = padAlpha;
        }
    }
    
    public function setControlMode(mode:String):Void
    {
        controlMode = mode;
        MobileConfig.setControlMode(mode);
        createControls();
    }
    
    public function updateSettings():Void
    {
        updateControlsPosition();
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        // Atualiza inputs
        updateInputs();
    }
    
    private function updateInputs():Void
    {
        // Mapeia toques para ações do jogo
        if (touchPad != null)
        {
            FlxG.save.data.padLeft = touchPad.buttonLeft.pressed;
            FlxG.save.data.padDown = touchPad.buttonDown.pressed;
            FlxG.save.data.padUp = touchPad.buttonUp.pressed;
            FlxG.save.data.padRight = touchPad.buttonRight.pressed;
            
            FlxG.save.data.padA = touchPad.buttonA.pressed;
            FlxG.save.data.padB = touchPad.buttonB.pressed;
            FlxG.save.data.padX = touchPad.buttonX.pressed;
            FlxG.save.data.padY = touchPad.buttonY.pressed;
        }
        
        if (hitbox != null)
        {
            FlxG.save.data.hitboxLeft = hitbox.buttonLeft.pressed;
            FlxG.save.data.hitboxDown = hitbox.buttonDown.pressed;
            FlxG.save.data.hitboxUp = hitbox.buttonUp.pressed;
            FlxG.save.data.hitboxRight = hitbox.buttonRight.pressed;
        }
    }
        }
