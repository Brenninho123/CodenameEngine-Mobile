package funkin.mobile.backend;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import funkin.mobile.backend.MobileUtils;

class TouchButton extends FlxSpriteGroup
{
    public var pressed:Bool = false;
    public var justPressed:Bool = false;
    public var justReleased:Bool = false;
    
    private var key:String;
    private var bounds:FlxRect;
    private var wasPressed:Bool = false;
    private var bg:FlxSprite;
    private var label:FlxText;
    
    public function new(X:Float, Y:Float, Key:String)
    {
        super(X, Y);
        
        key = Key;
        
        // Fundo do botão
        bg = new FlxSprite();
        bg.makeGraphic(150, 150, FlxColor.fromRGB(50, 50, 50, 180));
        bg.alpha = 0.6;
        add(bg);
        
        // Texto do botão
        label = new FlxText(0, 0, 150, key, 48);
        label.alignment = CENTER;
        label.font = "assets/fonts/vcr.ttf"; // Ajuste para a fonte do jogo
        label.color = FlxColor.WHITE;
        label.borderStyle = FlxTextBorderStyle.OUTLINE;
        label.borderColor = FlxColor.BLACK;
        label.borderSize = 2;
        label.screenCenter();
        add(label);
        
        bounds = new FlxRect(x, y, width, height);
        scrollFactor.set(0, 0);
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        // Atualiza bounds
        bounds.x = x;
        bounds.y = y;
        bounds.width = width;
        bounds.height = height;
        
        // Verifica toques
        wasPressed = pressed;
        pressed = checkTouch();
        
        justPressed = pressed && !wasPressed;
        justReleased = !pressed && wasPressed;
        
        // Feedback visual
        if (justPressed)
        {
            bg.color = FlxColor.LIME;
            scale.set(0.9, 0.9);
            MobileUtils.vibrate(30);
        }
        else if (pressed)
        {
            bg.color = FlxColor.GREEN;
            scale.set(0.95, 0.95);
        }
        else
        {
            bg.color = FlxColor.GRAY;
            scale.set(1, 1);
        }
    }
    
    private function checkTouch():Bool
    {
        if (FlxG.touches.list.length == 0) return false;
        
        for (touch in FlxG.touches.list)
        {
            if (touch.justPressed || touch.pressed)
            {
                if (bounds.containsPoint(FlxPoint.get(touch.x, touch.y)))
                {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    public function setSize(Width:Float, Height:Float):Void
    {
        bg.setGraphicSize(Width, Height);
        bg.updateHitbox();
        
        label.setGraphicSize(Width, Height);
        label.updateHitbox();
        label.screenCenter();
        
        updateHitbox();
        bounds.set(x, y, width, height);
    }
    
    public function setColor(color:FlxColor):Void
    {
        bg.color = color;
    }
}