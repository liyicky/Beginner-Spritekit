//
//  LIYGeneticAlgoScene.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYGeneticAlgoScene.h"
#import "LIYChromosome.h"
#import "LIYGeneticAlgo.h"

@interface LIYGeneticAlgoScene()
@property BOOL contentCreated;
@property (nonatomic) LIYGeneticAlgo *factory;
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

- (void)runAlgo
{
    [self.factory run];
}

- (void)createSceneContents
{
    [self initScene];
    [self.factory execute];
    [self runAlgo];
}

- (void)initScene
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.factory = [[LIYGeneticAlgo alloc] initWithScene:self];
}

- (void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"chromosome" usingBlock:^(SKNode *node, BOOL * stop) {
        if (node.position.y < 0) {
            [node removeFromParent];
        }
        if (node.position.x < 0) {
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
        self.factory.chromosome1.geneFitness++;
        self.factory.chromosome2.geneFitness++;
        self.factory.chromosome3.geneFitness++;
        self.factory.chromosome4.geneFitness++;
        self.factory.chromosome5.geneFitness++;
        self.factory.chromosome6.geneFitness++;
        self.factory.chromosome7.geneFitness++;
        self.factory.chromosome8.geneFitness++;
        self.factory.chromosome9.geneFitness++;
        self.factory.chromosome10.geneFitness++;
    }
    
}



@end
