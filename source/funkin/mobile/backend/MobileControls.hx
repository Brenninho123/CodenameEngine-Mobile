package funkin.mobile.backend;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import funkin.mobile.backend.TouchPad;
import funkin.mobile.backend.MobileConfig;
import funkin.mobile.backend.MobileUtils;

class MobileControls extends FlxGroup
{
    public static var instance:MobileControls;
    
    public var touchPad:TouchPad;
    public var hitbox:TouchPad;
    
    private var controlMode:String = "PAD";
    private var canUseTouch:Bool = false;
    
    public function new()
    {
        super();
        instance = this;
        
        if (!FlxG.onMobile) return;
        
        canUseTouch = true;
        loadConfig();
        createControls();
        
        // Verifica permissões na inicialização
        MobileUtils.checkPermissions();
    }
    
    private function loadConfig():Void
    {
        var savedMode = MobileConfig.getControlMode();
        if (savedMode != null)
            controlMode = savedMode;
    }
    
    private function createControls():Void
    {
        // Limpa controles existentes
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
        
        updateControlsPosition();
    }
    
    public function updateControlsPosition():Void
    {
        if (!canUseTouch) return;
        
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
    
    public function getControlMode():String
    {
        return controlMode;
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        if (!canUseTouch) return;
        
        // Atualiza inputs para o jogo
        updateInputs();
    }
    
    private function updateInputs():Void
    {
        // Reseta inputs
        resetInputs();
        
        // Pega inputs do touchPad
        if (touchPad != null)
        {
            // Direcionais
            if (touchPad.buttonLeft != null) FlxG.save.data.padLeft = touchPad.buttonLeft.pressed;
            if (touchPad.buttonDown != null) FlxG.save.data.padDown = touchPad.buttonDown.pressed;
            if (touchPad.buttonUp != null) FlxG.save.data.padUp = touchPad.buttonUp.pressed;
            if (touchPad.buttonRight != null) FlxG.save.data.padRight = touchPad.buttonRight.pressed;
            
            // Botões de ação
            if (touchPad.buttonA != null) FlxG.save.data.padA = touchPad.buttonA.pressed;
            if (touchPad.buttonB != null) FlxG.save.data.padB = touchPad.buttonB.pressed;
            if (touchPad.buttonX != null) FlxG.save.data.padX = touchPad.buttonX.pressed;
            if (touchPad.buttonY != null) FlxG.save.data.padY = touchPad.buttonY.pressed;
        }
        
        // Pega inputs do hitbox
        if (hitbox != null)
        {
            if (hitbox.buttonLeft != null) FlxG.save.data.hitboxLeft = hitbox.buttonLeft.pressed;
            if (hitbox.buttonDown != null) FlxG.save.data.hitboxDown = hitbox.buttonDown.pressed;
            if (hitbox.buttonUp != null) FlxG.save.data.hitboxUp = hitbox.buttonUp.pressed;
            if (hitbox.buttonRight != null) FlxG.save.data.hitboxRight = hitbox.buttonRight.pressed;
        }
    }
    
    private function resetInputs():Void
    {
        FlxG.save.data.padLeft = false;
        FlxG.save.data.padDown = false;
        FlxG.save.data.padUp = false;
        FlxG.save.data.padRight = false;
        FlxG.save.data.padA = false;
        FlxG.save.data.padB = false;
        FlxG.save.data.padX = false;
        FlxG.save.data.padY = false;
        FlxG.save.data.hitboxLeft = false;
        FlxG.save.data.hitboxDown = false;
        FlxG.save.data.hitboxUp = false;
        FlxG.save.data.hitboxRight = false;
    }
}