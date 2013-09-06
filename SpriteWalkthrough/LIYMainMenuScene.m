//
//  LIYMainMenuScene.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/1/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYMainMenuScene.h"
#import "LIYSpaceshipScene.h"

@interface LIYMainMenuScene()
@property BOOL contentCreated;
@property SKLabelNode *raindropsLabel;
@end

@implementation LIYMainMenuScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.raindropsLabel = [self createLabelWithText:@"Raindrops" name:@"raindropsButton" position:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self.scene addChild:[self raindropsLabel]];
    
}

- (SKLabelNode *)createLabelWithText:(NSString *)text name:(NSString *)name position:(CGPoint)position
{
    SKLabelNode *labelNode = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    
    labelNode.name = name;
    labelNode.text = text;
    labelNode.fontSize = 46;
    labelNode.position = position;
    labelNode.fontColor = [SKColor whiteColor];
    
    return labelNode;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self.view];
        
//        if ([self.view convertPoint:location fromScene:self.scene] == [touch locationInNode:self.raindropsLabel]) {
//            
//        }
        
    }
    SKScene *raindrops = [[LIYSpaceshipScene alloc] initWithSize:self.size];
    SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:1.0];
    [self.view presentScene:raindrops transition:doors];
}
@end
