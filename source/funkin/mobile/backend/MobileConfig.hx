package funkin.mobile.backend;

import flixel.FlxG;
import flixel.util.FlxSave;
import funkin.backend.system.Main; // Para acessar o save path

class MobileConfig
{
    private static var save:FlxSave;
    
    public static function init():Void
    {
        if (save == null)
        {
            save = new FlxSave();
            save.bind("MobileConfig", Main.savePath);
        }
    }
    
    public static function getControlMode():String
    {
        init();
        return save.data.controlMode != null ? save.data.controlMode : "PAD";
    }
    
    public static function setControlMode(mode:String):Void
    {
        init();
        save.data.controlMode = mode;
        save.flush();
    }
    
    public static function getPadX():Float
    {
        init();
        return save.data.padX != null ? save.data.padX : 20;
    }
    
    public static function setPadX(x:Float):Void
    {
        init();
        save.data.padX = x;
        save.flush();
    }
    
    public static function getPadY():Float
    {
        init();
        var defaultY = FlxG.height - 350;
        return save.data.padY != null ? save.data.padY : defaultY;
    }
    
    public static function setPadY(y:Float):Void
    {
        init();
        save.data.padY = y;
        save.flush();
    }
    
    public static function getPadSize():Float
    {
        init();
        return save.data.padSize != null ? save.data.padSize : 0.8;
    }
    
    public static function setPadSize(size:Float):Void
    {
        init();
        save.data.padSize = size;
        save.flush();
    }
    
    public static function getPadAlpha():Float
    {
        init();
        return save.data.padAlpha != null ? save.data.padAlpha : 0.7;
    }
    
    public static function setPadAlpha(alpha:Float):Void
    {
        init();
        save.data.padAlpha = alpha;
        save.flush();
    }
    
    public static function getVibrationEnabled():Bool
    {
        init();
        return save.data.vibration != null ? save.data.vibration : true;
    }
    
    public static function setVibrationEnabled(enabled:Bool):Void
    {
        init();
        save.data.vibration = enabled;
        save.flush();
    }
}