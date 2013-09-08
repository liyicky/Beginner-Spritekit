//
//  LIYChromosome.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIYChromosome : NSObject
@property (strong, nonatomic, readonly) NSString *geneSequence;
@property (strong, nonatomic, readonly) NSNumber *geneFitness;
- (id)initWithGeneCount:(NSUInteger)count;
- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other;
- (BOOL)isFitterThanChromosome:(LIYChromosome *)other forTargetSequence:(NSString *)sequence;
@end
