package funkin.mobile.backend;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class MobileIcons extends FlxSpriteGroup
{
    public function new()
    {
        super();
        
        if (!FlxG.onMobile) return;
        
        // Ícone de bateria (canto superior direito)
        var batteryIcon = new FlxSprite(FlxG.width - 40, 10);
        batteryIcon.makeGraphic(30, 15, 0xFF00FF00);
        batteryIcon.pixels.fillRect(new openfl.geom.Rectangle(28, 3, 2, 9), 0xFF000000);
        add(batteryIcon);
        
        // Relógio
        var clockIcon = new FlxSprite(FlxG.width - 100, 10);
        clockIcon.makeGraphic(30, 15, 0xFFFFFF00);
        add(clockIcon);
        
        // Wi-Fi
        var wifiIcon = new FlxSprite(FlxG.width - 160, 10);
        wifiIcon.makeGraphic(30, 15, 0xFF0000FF);
        add(wifiIcon);
    }
}