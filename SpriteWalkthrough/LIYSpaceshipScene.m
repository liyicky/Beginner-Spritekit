//
//  LIYSpaceshipScene.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 7/22/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYSpaceshipScene.h"

@interface LIYSpaceshipScene ()
@property BOOL contentCreated;
@property (nonatomic) SKSpriteNode *ship;
@property (nonatomic) SKLabelNode *collisionCounter;
@property (nonatomic) NSInteger collisionCount;
@end

static const uint32_t shipCategory = 0x1 << 0;
static const uint32_t rockCategory = 0x1 << 1;
static const uint32_t gokuCategory = 0x1 << 2;
static const uint32_t restingCategory = 0x1 << 3;

@implementation LIYSpaceshipScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.physicsWorld.gravity = CGPointMake(0, -12);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}
- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & shipCategory) != 0) {
        self.collisionCount++;
        self.collisionCounter.text = [NSString stringWithFormat:@"Hits: %i", self.collisionCount];
        [secondBody.node runAction:[SKAction moveToY:8000 duration:12.0]];
//        [secondBody.node.physicsBody applyImpulse:CGPointMake((secondBody.node.physicsBody.velocity)/200, 2.0)];
//        [secondBody applyImpulse:CGVectorMake((secondBody.velocity.dx)/5000, (secondBody.velocity.dy)/5000) atPoint:CGPointMake(0, 0)];

//        secondBody.categoryBitMask = restingCategory;
//        secondBody.collisionBitMask = shipCategory | rockCategory;
//        secondBody.contactTestBitMask = 0;
    }
    
    if ((firstBody.categoryBitMask & gokuCategory) != 0) {
        [firstBody.node runAction:[SKAction rotateByAngle:0.01 duration:0.001]];
    }
    
    if ((firstBody.categoryBitMask & rockCategory) !=0) {

    }
}

- (void)createSceneContents
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    self.ship = [self newShip];

    self.collisionCounter = [self createCounter];
    [self addChild:self.collisionCounter];
    
    self.ship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-200);
    [self addChild:self.ship];
    SKAction *makeRain = [SKAction sequence:@[
                                               [SKAction performSelector:@selector(addDrop) onTarget:self],
                                               [SKAction waitForDuration: 0.0 withRange:0.5]]];
    [self runAction:[SKAction repeatActionForever:makeRain]];
    
    SKSpriteNode *goku = [self makeGoku];
    goku.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    [self addChild:goku];
    
    
//Rotation Recognition ~~~
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:rotationRecognizer];
    
//Pinching Recognition ~~~
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
}

- (SKSpriteNode *)newShip
{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(400, 40)];
    
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-28.0, 6.0);
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(28.0, 6.0);
    
    [hull addChild:light1];
    [hull addChild:light2];
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction moveByX:0 y:0 duration:
                                            10.0],
                                           [SKAction moveByX:-0 y:0 duration:10.0]]];
//    [hull runAction:[SKAction repeatActionForever:hover]];
    
    hull.userInteractionEnabled = YES;
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO;
    hull.physicsBody.usesPreciseCollisionDetection = YES;
    hull.physicsBody.categoryBitMask = shipCategory;
    hull.physicsBody.collisionBitMask = shipCategory | rockCategory;
    hull.physicsBody.contactTestBitMask = shipCategory | rockCategory;
    
    return hull;
    
}

- (SKSpriteNode *)newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8,8)];
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction:blinkForever];
    
    return light;
}

- (void)addDrop
{
    SKSpriteNode *drop = [[SKSpriteNode alloc] init];
    drop.position = CGPointMake(skRand(0, self.size.width), self.size.height);
//    drop.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height);
    
    drop.color = [SKColor blueColor];
    drop.size = CGSizeMake(8,8);
    drop.name = @"drop";
    drop.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:drop.size];
    drop.physicsBody.dynamic = YES;
    drop.physicsBody.usesPreciseCollisionDetection = YES;
    SKAction *randAni = [SKAction sequence:@[
                                           [SKAction fadeAlphaTo:skRand(0.0, 1.0) duration:0.5],
                                           [SKAction fadeAlphaTo:skRand(0.0, 1.0) duration:0.5]]];
    SKAction *randAniForever = [SKAction repeatActionForever:randAni];
//    [drop runAction:randAniForever];
    drop.physicsBody.categoryBitMask = rockCategory;
    drop.physicsBody.collisionBitMask = shipCategory | gokuCategory| rockCategory;
    drop.physicsBody.contactTestBitMask = shipCategory | gokuCategory | rockCategory;
    
    [self addChild:drop];
}

- (void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"drop" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y > 2500) {
            [node removeFromParent];
        }
        if (node.position.y < 0) {
            [node removeFromParent];
        }
        if (node.position.x < 0) {
            [node removeFromParent];
        }
        if (self.children.count > 120) {
            [node removeFromParent];
        }
    }];
}

- (SKSpriteNode *)makeGoku
{
    SKSpriteNode *goku = [[SKSpriteNode alloc] initWithImageNamed:@"goku_ssj.png"];
    goku.size = CGSizeMake(150, 120);
    goku.name = @"goku";
    goku.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:goku.size];
    goku.physicsBody.usesPreciseCollisionDetection = YES;
    goku.physicsBody.dynamic = NO;
    goku.physicsBody.categoryBitMask = gokuCategory;
    goku.physicsBody.collisionBitMask = gokuCategory | rockCategory;
    goku.physicsBody.contactTestBitMask = gokuCategory | rockCategory;
    
    return goku;
    
}

- (SKLabelNode *)createCounter
{
    self.collisionCounter = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    
    self.collisionCounter.position = CGPointMake(100, 2000);
    self.collisionCounter.text = @"Hits: ";
    self.collisionCounter.fontColor = [SKColor whiteColor];
    self.collisionCounter.fontSize = 30;
    return self.collisionCounter;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self.view];
        
//        NSLog(@"Location: %f", location);
//        NSLog(@"Touch: %f", touch);
//        NSLog(@"Ship POSITION: %f, %f", self.ship.position.x, self.ship.position.y);
//        NSLog(@"Converted Location: %f, %f", [self.view convertPoint:location toScene:self.scene].x, [self.view convertPoint:location toScene:self.scene].y);
        
        self.ship.position = [self.view convertPoint:location toScene:self.scene];
        
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);

    recognizer.scale = 1;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer
{
    SKAction *rotate = [SKAction sequence:@[[SKAction rotateByAngle:-(recognizer.rotation) duration:0.0]]];
    [self.ship runAction:rotate];
    recognizer.rotation = 0;
}

@end