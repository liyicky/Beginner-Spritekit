//
//  LIYChromosome.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "LIYGeneticAlgoScene.h"

@interface LIYChromosome : SKSpriteNode <SKPhysicsContactDelegate>

@property (nonatomic) NSInteger geneFitness;
@property (strong, nonatomic) NSMutableArray *behavior;
@property (strong, nonatomic) NSDictionary *gene;
@property (nonatomic) float lifeTime;


- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other;
- (void)die;

@end
