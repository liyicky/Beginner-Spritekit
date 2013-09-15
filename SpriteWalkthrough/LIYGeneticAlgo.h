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
#import "LIYGeneticAlgoScene.h"

@interface LIYGeneticAlgo : NSObject
@property (nonatomic) NSMutableArray *population;

- (id)initWithScene:(SKScene *)scene;
- (void)run;
- (void)execute;

@end
