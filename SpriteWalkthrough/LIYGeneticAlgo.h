//
//  LIYGeneticAlgo.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIYGeneticAlgo : NSObject
@property (readonly, assign, nonatomic) NSInteger generations;
@property (readonly, strong, nonatomic) NSString *result;
@property (readwrite, strong, nonatomic) NSMutableArray *chromosomes;
@property (readwrite, strong, nonatomic) NSMutableArray *chromosomeFitness;
- (id)initWithTargetSequence:(NSString *)sequence;
- (void)execute;
@end
