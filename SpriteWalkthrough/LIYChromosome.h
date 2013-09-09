//
//  LIYChromosome.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface LIYChromosome : SKSpriteNode
@property (strong, readonly, nonatomic) NSNumber *geneFitenss;
@property (strong, nonatomic) NSMutableArray *behavior;
@property (strong, nonatomic) NSDictionary *gene;
- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other;
- (BOOL)isFitterThanChromosome:(LIYChromosome *)other forTargetSequence:(NSString *)sequence;
@end
