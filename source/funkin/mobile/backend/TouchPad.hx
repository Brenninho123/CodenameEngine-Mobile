package funkin.mobile.backend;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import funkin.mobile.backend.TouchButton;

class TouchPad extends FlxSpriteGroup
{
    public var buttonLeft:TouchButton;
    public var buttonDown:TouchButton;
    public var buttonUp:TouchButton;
    public var buttonRight:TouchButton;
    
    public var buttonA:TouchButton;
    public var buttonB:TouchButton;
    public var buttonX:TouchButton;
    public var buttonY:TouchButton;
    
    private var padType:String;
    private var baseSize:Int = 130;
    private var spacing:Int = 15;
    
    public function new(Type:String = "PAD")
    {
        super();
        padType = Type;
        
        switch (padType)
        {
            case "PAD":
                createDPad();
                createActionButtons();
            case "HITBOX":
                createHitbox();
        }
    }
    
    private function createDPad():Void
    {
        // Botão Esquerda
        buttonLeft = new TouchButton(0, baseSize + spacing, "◀");
        buttonLeft.setSize(baseSize, baseSize);
        add(buttonLeft);
        
        // Botão Baixo
        buttonDown = new TouchButton(baseSize + spacing, (baseSize + spacing) * 2, "▼");
        buttonDown.setSize(baseSize, baseSize);
        add(buttonDown);
        
        // Botão Cima
        buttonUp = new TouchButton(baseSize + spacing, 0, "▲");
        buttonUp.setSize(baseSize, baseSize);
        add(buttonUp);
        
        // Botão Direita
        buttonRight = new TouchButton((baseSize + spacing) * 2, baseSize + spacing, "▶");
        buttonRight.setSize(baseSize, baseSize);
        add(buttonRight);
    }
    
    private function createActionButtons():Void
    {
        var startX = FlxG.width - (baseSize * 2 + spacing * 4);
        var startY = FlxG.height - (baseSize * 2 + spacing * 3);
        
        // Botão A (Verde)
        buttonA = new TouchButton(startX + baseSize + spacing * 2, startY + baseSize + spacing, "A");
        buttonA.setSize(baseSize, baseSize);
        buttonA.setColor(FlxColor.GREEN);
        add(buttonA);
        
        // Botão B (Vermelho)
        buttonB = new TouchButton(startX + (baseSize + spacing) * 2 + spacing, startY + baseSize + spacing, "B");
        buttonB.setSize(baseSize, baseSize);
        buttonB.setColor(FlxColor.RED);
        add(buttonB);
        
        // Botão X (Azul)
        buttonX = new TouchButton(startX + baseSize + spacing * 2, startY, "X");
        buttonX.setSize(baseSize, baseSize);
        buttonX.setColor(FlxColor.BLUE);
        add(buttonX);
        
        // Botão Y (Amarelo)
        buttonY = new TouchButton(startX + (baseSize + spacing) * 2 + spacing, startY, "Y");
        buttonY.setSize(baseSize, baseSize);
        buttonY.setColor(FlxColor.YELLOW);
        add(buttonY);
    }
    
    private function createHitbox():Void
    {
        var buttonWidth = FlxG.width / 4;
        var buttonHeight = Std.int(FlxG.height / 2.5);
        
        // Hitbox estilo 4 notas
        buttonLeft = new TouchButton(0, FlxG.height - buttonHeight, "←");
        buttonLeft.setSize(buttonWidth, buttonHeight);
        buttonLeft.setColor(FlxColor.fromRGB(255, 100, 100));
        add(buttonLeft);
        
        buttonDown = new TouchButton(buttonWidth, FlxG.height - buttonHeight, "↓");
        buttonDown.setSize(buttonWidth, buttonHeight);
        buttonDown.setColor(FlxColor.fromRGB(100, 255, 100));
        add(buttonDown);
        
        buttonUp = new TouchButton(buttonWidth * 2, FlxG.height - buttonHeight, "↑");
        buttonUp.setSize(buttonWidth, buttonHeight);
        buttonUp.setColor(FlxColor.fromRGB(100, 100, 255));
        add(buttonUp);
        
        buttonRight = new TouchButton(buttonWidth * 3, FlxG.height - buttonHeight, "→");
        buttonRight.setSize(buttonWidth, buttonHeight);
        buttonRight.setColor(FlxColor.fromRGB(255, 255, 100));
        add(buttonRight);
    }
    
    public function setScale(scale:Float):Void
    {
        var newSize = baseSize * scale;
        
        if (buttonLeft != null) buttonLeft.setSize(newSize, newSize);
        if (buttonDown != null) buttonDown.setSize(newSize, newSize);
        if (buttonUp != null) buttonUp.setSize(newSize, newSize);
        if (buttonRight != null) buttonRight.setSize(newSize, newSize);
        if (buttonA != null) buttonA.setSize(newSize, newSize);
        if (buttonB != null) buttonB.setSize(newSize, newSize);
        if (buttonX != null) buttonX.setSize(newSize, newSize);
        if (buttonY != null) buttonY.setSize(newSize, newSize);
    }
}