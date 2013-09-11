//
//  LIYChromosome.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYChromosome.h"

#define ARC4RANDOM_MAX (0x100000000)
#define MUTATION_DELTA_MAX (6)
#define MUTATION_RATE (0.20f)
#define MUTATION_THRESHOLD (ARC4RANDOM_MAX * MUTATION_RATE)
#define RANDOM() (arc4random())
#define RANDOM_MOD(_MOD) (arc4random_uniform(_MOD))

@interface LIYChromosome ()
@property (nonatomic) NSInteger *fitness;
@property (strong, nonatomic) SKAction *trait1;
@property (strong, nonatomic) SKAction *trait2;
@property (strong, nonatomic) SKAction *trait3;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGSize size;
@end

static const uint32_t chromosomeCategory = 0x1 << 0;

@implementation LIYChromosome
@synthesize fitness;
@synthesize behavior;

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self createOrganisum];

    }
    return self;
}

//- (NSDictionary *)gene
//{
//    CGFloat position_x = self.position.x;
//    self.gene = @{@"trait1" : self.trait1, @"trait2" : self.trait2, @"position_x" : position_x, @"position_y" : self.position.y, @"size" : self.size};
//    return self.gene;
//}

- (void)createOrganisum
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screen.size.width;
    CGFloat screenHeigh = screen.size.height;
    NSInteger rand = arc4random() % 20 + 1;
    NSInteger xRand = arc4random() % 20 + 1;
    NSInteger yRand = arc4random() % 20 + 1;
    NSInteger xRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 800);
    NSInteger yRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 800);
    NSInteger randColor = arc4random() % 80;
    NSLog(@"LRAND: %i, %i", xRand, yRand);
    
    NSDate *startLife = [NSDate date];
    
    
    
    self.color = [SKColor colorWithRed:randColor green:randColor blue:randColor alpha:1.0];
    self.lifeTime = [startLife timeIntervalSinceNow];
    self.position = CGPointMake(skRand(0, screenWidth), skRand(0, screenHeigh));
    self.size = CGSizeMake(xRand, yRand);
    self.name = @"chromosome";
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.categoryBitMask = chromosomeCategory;
    self.physicsBody.collisionBitMask = chromosomeCategory;
    self.physicsBody.contactTestBitMask = chromosomeCategory;
    self.physicsBody.mass = 1;

    self.trait1 = [SKAction rotateByAngle:rand duration:rand];
    self.trait2 = [SKAction moveByX:xRandAction y:yRandAction duration:rand];
    [self runAction:self.trait1];
    [self runAction:self.trait2];

}

- (NSInteger *)geneFitness
{
    return self.fitness;
}

- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other
{
    LIYChromosome *child = [[LIYChromosome alloc] init];
    LIYChromosome *champ;
    
    if (self.lifeTime > other.lifeTime) {
        child.trait1 = self.trait1;
        child.trait2 = self.trait2;
        child.position = self.position;
        child.size = self.size;
    } else {
        child.trait1 = other.trait1;
        child.trait2 = other.trait2;
        child.position = other.position;
        child.size = other.size;
    }
    
    if (RANDOM() < MUTATION_THRESHOLD) {
        [child mutate];
    }
    
    return child;
}

- (void)mutate
{
    
}


@end