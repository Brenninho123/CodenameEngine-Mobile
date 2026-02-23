package funkin.mobile.backend;

import flixel.FlxG;
import funkin.mobile.backend.MobileConfig;
#if android
import openfl.utils.JNI;
#end

class MobileUtils
{
    public static function vibrate(duration:Int = 50):Void
    {
        #if android
        if (!MobileConfig.getVibrationEnabled()) return;
        
        try
        {
            var vibrator = JNI.createStaticMethod("android/os/Vibrator", "vibrate", "(J)V");
            var context = JNI.createStaticMethod("org/haxe/lime/HaxeObject", "getContext", "()Landroid/content/Context;");
            
            if (vibrator != null && context != null)
                vibrator(context(), duration);
        }
        catch (e:Dynamic)
        {
            trace("Vibration error: " + e);
        }
        #end
    }
    
    public static function getExternalStoragePath():String
    {
        #if android
        try
        {
            var getPath = JNI.createStaticMethod("android/os/Environment", "getExternalStorageDirectory", "()Ljava/io/File;");
            var file = getPath();
            var getAbsolutePath = JNI.createMemberMethod("java/io/File", "getAbsolutePath", "()Ljava/lang/String;");
            
            if (file != null && getAbsolutePath != null)
                return getAbsolutePath(file);
        }
        catch (e:Dynamic)
        {
            trace("Error getting external path: " + e);
        }
        #end
        
        return "mods/";
    }
    
    public static function getModsPath():String
    {
        #if android
        return getExternalStoragePath() + "/FNF/Mods/";
        #else
        return "mods/";
        #end
    }
    
    public static function checkPermissions():Bool
    {
        #if android
        try
        {
            var checkPermission = JNI.createStaticMethod("android/support/v4/content/ContextCompat", 
                "checkSelfPermission", "(Landroid/content/Context;Ljava/lang/String;)I");
            
            var context = JNI.createStaticMethod("org/haxe/lime/HaxeObject", "getContext", "()Landroid/content/Context;");
            var permission = JNI.createStaticField("android/Manifest$permission", "READ_EXTERNAL_STORAGE", "Ljava/lang/String;");
            
            if (checkPermission != null && context != null && permission != null)
            {
                var result = checkPermission(context(), permission);
                return result == 0;
            }
        }
        catch (e:Dynamic)
        {
            trace("Permission check error: " + e);
        }
        #end
        
        return true;
    }
    
    public static function getScreenDPI():Float
    {
        #if android
        try
        {
            var getMetrics = JNI.createStaticMethod("android/util/DisplayMetrics", "getDeviceMetrics", "()Landroid/util/DisplayMetrics;");
            var getDPI = JNI.createMemberMethod("android/util/DisplayMetrics", "densityDpi", "()I");
            
            if (getMetrics != null && getDPI != null)
            {
                var metrics = getMetrics();
                return getDPI(metrics);
            }
        }
        catch (e:Dynamic)
        {
            trace("DPI check error: " + e);
        }
        #end
        
        return 320; // Valor padrão
    }
}