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
    NSLog(@"Lifetime :%f", self.kittyCat.lifeTime);
    [self addChild:kittyCat];
}


- (void)initScene
{
    self.scaleMode = SKSceneScaleModeAspectFit;
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
//        [secondBody.node runAction:[SKAction moveToY:8000 duration:12.0]];
    }
}




@end
