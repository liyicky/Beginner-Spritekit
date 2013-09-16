//
//  LIYChromosome.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

static const uint32_t chromosome1Category  = 0x1 << 1;
static const uint32_t chromosome2Category  = 0x1 << 2;
static const uint32_t chromosome3Category  = 0x1 << 3;
static const uint32_t chromosome4Category  = 0x1 << 4;
static const uint32_t chromosome5Category  = 0x1 << 5;
static const uint32_t chromosome6Category  = 0x1 << 6;
static const uint32_t chromosome7Category  = 0x1 << 7;
static const uint32_t chromosome8Category  = 0x1 << 8;
static const uint32_t chromosome9Category  = 0x1 << 9;
static const uint32_t chromosome10Category = 0x1 << 10;

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
