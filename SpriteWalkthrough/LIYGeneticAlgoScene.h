//
//  LIYGeneticAlgoScene.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const uint32_t chromosomeCategory = 0x1 << 0;
static const uint32_t sceneCategory = 0x1 << 1;

@interface LIYGeneticAlgoScene : SKScene <SKPhysicsContactDelegate>

@end
