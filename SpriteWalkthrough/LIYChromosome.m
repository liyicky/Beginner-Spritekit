//
//  LIYChromosome.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYChromosome.h"

#define ARC4RANDOM_MAX (0x100000000)
#define FIRST_CHAR (32)
#define LAST_CHAR (122)
#define MUTATION_DELTA_MAX (6)
#define MUTATION_RATE (0.20f)
#define MUTATION_THRESHOLD (ARC4RANDOM_MAX * MUTATION_RATE)
#define RANDOM() (arc4random())
#define RANDOM_MOD(_MOD) (arc4random_uniform(_MOD))

@interface LIYChromosome ()
@property (strong, nonatomic) NSNumber *cachedOverallFitness;
@property (strong, nonatomic) NSMutableArray *fitnessBuffer;
@property (strong, nonatomic) NSMutableString *geneBuffer;
- (NSInteger)fitnessForTargetSequence:(NSString *)sequence;
- (NSInteger)fitnessOfGeneAtIndex:(NSUInteger)geneIndex forTargetSequence:(NSString *)sequence;
- (void)mutate;
@end

@implementation LIYChromosome
@synthesize cachedOverallFitness;
@synthesize fitnessBuffer;
@synthesize geneFitness;
@synthesize geneBuffer;
@dynamic geneSequence;

- (NSNumber *)geneFitness
{
    return self.cachedOverallFitness;
}

- (NSString *)geneSequence
{
    return [NSString stringWithString:geneBuffer];
}

- (id)initWithGeneCount:(NSUInteger)count
{
    self = [super init];
    if (self)
    {
        self.fitnessBuffer = [NSMutableArray arrayWithCapacity:count];
        self.geneBuffer = [NSMutableString stringWithCapacity:count];
        for (int geneIndex = 0; geneIndex < count; geneIndex++)
        {
            int value = RANDOM_MOD(LAST_CHAR - FIRST_CHAR);
            value += FIRST_CHAR;
            NSString *gene = [NSString stringWithFormat:@"%c", value];
            [self.geneBuffer appendString:gene];
        }
        
    }
    return self;
}

- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other
{
    LIYChromosome *child = [[LIYChromosome alloc] initWithGeneCount:0];
    NSUInteger count = self.geneBuffer.length;
    NSNumber *mine, *theirs;
    LIYChromosome *winner;
    unichar geneValue;
    NSString *gene;
    
    for (int i = 0; i < count; i++)
    {
        mine = [self.fitnessBuffer objectAtIndex:i];
        theirs = [other.fitnessBuffer objectAtIndex:i];
        winner = [mine integerValue] > [theirs integerValue] ? self : other;
        geneValue = [winner.geneBuffer characterAtIndex:i];
        gene = [NSString stringWithFormat:@"%c" , geneValue];
        [child.geneBuffer appendString:gene];
    }
    
    if (RANDOM() < MUTATION_THRESHOLD)
    {
        [child mutate];
    }
    
    return child;
}

- (BOOL)isFitterThanChromosome:(LIYChromosome *)other forTargetSequence:(NSString *)sequence
{
    NSInteger mine = [self fitnessForTargetSequence:sequence];
    NSInteger theirs = [other fitnessForTargetSequence:sequence];
    
    return mine > theirs;
}

- (NSInteger)fitnessForTargetSequence:(NSString *)sequence
{
    if (!self.cachedOverallFitness)
    {
        NSInteger overallFitness = 0, fitness = 0;
        NSNumber *box = nil;
        NSUInteger count = sequence.length;
        
        for (int i = 0; i < count; i++)
        {
            fitness = [self fitnessOfGeneAtIndex:i forTargetSequence:sequence];
            box = [NSNumber numberWithInteger:fitness];
            [self.fitnessBuffer addObject:box];
            overallFitness += fitness;
            
        }
        self.cachedOverallFitness = [NSNumber numberWithInteger:overallFitness];
    }
    return [self.cachedOverallFitness integerValue];
}

- (NSInteger)fitnessOfGeneAtIndex:(NSUInteger)geneIndex forTargetSequence:(NSString *)sequence
{
    unichar target = [sequence characterAtIndex:geneIndex];
    unichar actual = [geneBuffer characterAtIndex:geneIndex];
    
    return abs(target - actual) * -1;
}

- (void)mutate
{
    NSInteger delta = RANDOM_MOD(MUTATION_DELTA_MAX);
    BOOL negate = RANDOM_MOD(2) == 0;
    if (negate)
        delta *= -1;
    
    NSUInteger geneIndex = RANDOM_MOD(self.geneBuffer.length);
    unichar gene = [self.geneBuffer characterAtIndex:geneIndex];
    unichar proposedGene = gene + delta;
    if (proposedGene < FIRST_CHAR || proposedGene > LAST_CHAR)
        delta *= -1;
    
    unichar value = gene + delta;
    NSString *mutant = [NSString stringWithFormat:@"%c", value];
    NSRange range = (NSRange) {geneIndex, 1};
    [self.geneBuffer replaceCharactersInRange:range withString:mutant];
    self.cachedOverallFitness = nil;
    
}





@end
