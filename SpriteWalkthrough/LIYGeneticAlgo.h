//
//  LIYGeneticAlgo.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "LIYChromosome.h"

@interface LIYGeneticAlgo : NSObject

@property (nonatomic) NSMutableArray *population;
@property (nonatomic) LIYChromosome *chromosome1;
@property (nonatomic) LIYChromosome *chromosome2;
@property (nonatomic) LIYChromosome *chromosome3;
@property (nonatomic) LIYChromosome *chromosome4;
@property (nonatomic) LIYChromosome *chromosome5;
@property (nonatomic) LIYChromosome *chromosome6;
@property (nonatomic) LIYChromosome *chromosome7;
@property (nonatomic) LIYChromosome *chromosome8;
@property (nonatomic) LIYChromosome *chromosome9;
@property (nonatomic) LIYChromosome *chromosome10;

- (id)initWithScene:(SKScene *)scene;
- (void)run;
- (void)execute;

@end
