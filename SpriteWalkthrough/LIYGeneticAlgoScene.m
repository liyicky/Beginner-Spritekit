//
//  LIYGeneticAlgoScene.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYGeneticAlgoScene.h"
#import "LIYChromosome.h"

@interface LIYGeneticAlgoScene()
@property BOOL contentCreated;
@property (nonatomic) LIYChromosome *kittyCat;
@end

@implementation LIYGeneticAlgoScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.physicsWorld.gravity = CGPointMake(0, 0);
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


- (void)createSceneContents
{
    [self initScene];
    
    SKAction *breed = [SKAction sequence:@[[SKAction performSelector:@selector(testBreeding) onTarget:self], [SKAction waitForDuration:0.0 withRange:1.0]]];
    [self runAction:[SKAction repeatActionForever:breed]];
}

- (void)testBreeding
{
    LIYChromosome * kittyCat = [[LIYChromosome alloc] init];
    [self addChild:kittyCat];
}


- (void)initScene
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
}

- (void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"chromosome" usingBlock:^(SKNode *node, BOOL * stop) {
        if (node.position.y < 0) {
            NSLog(@"Lifetime :%f", self.kittyCat.lifeTime);
            [node removeFromParent];
        }
        if (node.position.x < 0) {
            NSLog(@"Lifetime :%f", self.kittyCat.lifeTime);
            [node removeFromParent];
        }
    }];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & chromosomeCategory) != 0) {
//        [firstBody applyTorque:(1.0)];
//        [secondBody applyForce:CGVectorMake(1, 1)];
    }
    
    if ((firstBody.categoryBitMask & sceneCategory) != 0) {
        [firstBody applyImpulse:CGVectorMake((firstBody.velocity.dx)/2, (firstBody.velocity.dy)/2)];
        
        NSLog(@"First Body V: %f, %f", firstBody.velocity.dx, firstBody.velocity.dy);
        NSLog(@"Second Body V: %f, %f", secondBody.velocity.dx, secondBody.velocity.dy);
    }
}



@end
