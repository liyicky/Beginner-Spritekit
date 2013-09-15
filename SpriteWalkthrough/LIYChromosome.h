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
@property (nonatomic) float lifeTime;
@property (strong, nonatomic) NSMutableDictionary *gene;

- (NSMutableDictionary *)gene;
- (BOOL)isFitterThanChromosom:(LIYChromosome *)other;
- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other;
- (void)die;
- (void)mutate;

@end
