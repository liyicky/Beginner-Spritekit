//
//  LIYGeneticAlgo.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYGeneticAlgo.h"
#import "LIYChromosome.h"

//@interface LIYGeneticAlgo()
//@property (strong, readwrite, nonatomic) NSString *result;
//@property (assign, readwrite, nonatomic) NSInteger generations;
//@property (strong, nonatomic) NSMutableArray *population;
//@property (copy, nonatomic) NSString *targetSequence;
//- (void)populate;
//- (void)run;
//- (void)breedNextGeneration;
//- (void)shufflePopulation;
//- (void)analyzePopulation;
//@end
//
//@implementation LIYGeneticAlgo
//@synthesize generations;
//@synthesize population;
//@synthesize result;
//@synthesize targetSequence;
//@synthesize chromosomes;
//
//#define MAX_GENERATIONS 1000
//#define POPULATION_SIZE 750
//
//- (id)initWithTargetSequence:(NSString *)sequence
//{
//    self = [super init];
//    if (self) {
//        self.targetSequence = sequence;
//        self.population = [NSMutableArray arrayWithCapacity:POPULATION_SIZE];
//        self.chromosomes = [NSMutableArray array];
//    }
//    return self;
//}
//
//- (void)execute
//{
//    [self populate];
//    [self run];
//}
//
//- (void)populate
//{
//    NSUInteger geneCount = self.targetSequence.length;
//    LIYChromosome *chromosome;
//    for (int i = 0; i < POPULATION_SIZE; i++) {
//        chromosome = [[LIYChromosome alloc] initWithGeneCount:geneCount];
//        [self.population addObject:chromosome];
//    }
//}
//
//- (void)run
//{
//    for (self.generations = 0;
//         self.generations < MAX_GENERATIONS && !self.result;
//         self.generations++) {
//        [self breedNextGeneration];
//        [self shufflePopulation];
//        [self analyzePopulation];
//    }
//    --self.generations;
//}
//
//- (void)breedNextGeneration
//{
//    NSUInteger index1, index2, deadIndex;
//    LIYChromosome *chromo1, *chromo2, *child;
//    NSString *sequence = self.targetSequence;
//    BOOL keepFirst;
//    NSUInteger count = self.population.count;
//    
//    for (int i = 0; i < count; i++) {
//        index1 = i;
//        index2 = i + 1;
//        chromo1 = [self.population objectAtIndex:index1];
//        chromo2 = [self.population objectAtIndex:index2];
//        keepFirst = [chromo1 isFitterThanChromosome:chromo2 forTargetSequence:sequence];
//        deadIndex = keepFirst ? index1 : index2;
//        child = [chromo1 mateWithChromosome:chromo2];
//        [self.population replaceObjectAtIndex:deadIndex withObject:child];
//    }
//}
//
//- (void)shufflePopulation
//{
//    LIYChromosome *last = [self.population lastObject];
//    [population removeLastObject];
//    [population insertObject:last atIndex:0];
//}
//
//- (void)analyzePopulation
//{
//    LIYChromosome *champion = nil;
//    NSString *sequence = self.targetSequence;
//    
//    for (LIYChromosome *contender in self.population) {
//        if (!champion || [contender isFitterThanChromosome:champion forTargetSequence:sequence]) {
//            champion = contender;
//        }
//    }
//    
//    NSString *fittest = champion.geneSequence;
//    NSNumber *fittestInt = champion.geneFitness;
//    NSArray *entry = @[fittest, fittestInt];
//    
//    BOOL matchesTarget = [fittest isEqualToString:sequence];
//    
//    if (matchesTarget) {
//        self.result = fittest;
//        [chromosomes addObject:@[fittest, fittestInt]];
//    } else {
//        [chromosomes addObject:entry];
//    }
//}
//
//
//
//@end
