//
//  LIYGeneticAlgoScene.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYGeneticAlgoScene.h"
#import "LIYGeneticAlgo.h"

@interface LIYGeneticAlgoScene()
@property BOOL contentCreated;
@property (nonatomic) LIYGeneticAlgo *factory;
@property (nonatomic) LIYChromosome *chromo;
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
    
    if ((firstBody.categoryBitMask & chromosome1Category) != 0) {
        self.factory.chromosome1.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome2Category) != 0) {
        self.factory.chromosome2.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome3Category) != 0) {
        self.factory.chromosome3.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome4Category) != 0) {
        self.factory.chromosome4.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome5Category) != 0) {
        self.factory.chromosome5.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome6Category) != 0) {
        self.factory.chromosome6.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome7Category) != 0) {
        self.factory.chromosome7.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome8Category) != 0) {
        self.factory.chromosome8.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome9Category) != 0) {
        self.factory.chromosome9.geneFitness++;
    }
    if ((firstBody.categoryBitMask & chromosome10Category) != 0) {
        self.factory.chromosome10.geneFitness++;
    }

}



@end
