//
//  LIYChromosome.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYChromosome.h"
#import "LIYGeneticAlgoScene.h"

@interface LIYChromosome ()
@property (strong, nonatomic) SKAction *trait1;
@property (strong, nonatomic) SKAction *trait2;
@property (strong, nonatomic) SKAction *trait3;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGSize size;
@property uint32_t category;
@end

@implementation LIYChromosome

- (id)init
{
    self = [super init];
    if (self) {
        
        [self createOrganism];

    }
    return self;
}

- (void)createOrganism
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screen.size.width;
    CGFloat screenHeigh = screen.size.height;
    NSInteger xRand = arc4random() % 20 + 1;
    NSInteger yRand = arc4random() % 20 + 1;
    NSInteger xRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 100);
    NSInteger yRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 100);
    CGFloat hue = ( arc4random() % 256 / 256.0);
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    NSDate *startLife = [NSDate date];
    self.lifeTime = [startLife timeIntervalSinceNow];
    self.geneFitness = 0;
    self.color = color;
    self.position = CGPointMake(skRand(0, screenWidth), skRand(0, screenHeigh));
    self.size = CGSizeMake(xRand, yRand);
    self.name = @"chromosome";
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.restitution = 1.0;
    self.physicsBody.categoryBitMask = self.category;
    
    self.physicsBody.collisionBitMask = chromosome1Category | chromosome2Category | chromosome3Category | chromosome4Category | chromosome5Category | chromosome6Category | chromosome7Category | chromosome8Category | chromosome9Category | chromosome10Category;
    
    self.physicsBody.contactTestBitMask = chromosome1Category | chromosome2Category | chromosome3Category | chromosome4Category | chromosome5Category | chromosome6Category | chromosome7Category | chromosome8Category | chromosome9Category | chromosome10Category;
    
    self.physicsBody.velocity = CGVectorMake(xRandAction, yRandAction);
    
    [self makeGene];
    
    
}

- (NSMutableDictionary *)makeGene
{
    
    UIColor *geneColor = self.color;
    NSValue *genePosition = [NSValue valueWithCGPoint:self.position];
    NSValue *geneSize = [NSValue valueWithCGSize:self.size];
    NSNumber *geneVelocityDX = [NSNumber numberWithFloat:self.physicsBody.velocity.dx];
    NSNumber *geneVelocityDY = [NSNumber numberWithFloat:self.physicsBody.velocity.dy];
    NSNumber *lifeTime = [NSNumber numberWithFloat:self.lifeTime];
    NSNumber *geneFitness = [NSNumber numberWithInt:self.geneFitness];
    
    
    self.gene = @{@"Color"      : geneColor,
                  @"Position"   : genePosition,
                  @"Size"       : geneSize,
                  @"VelocityDX" : geneVelocityDX,
                  @"VelocityDY" : geneVelocityDY,
                  @"LifeTime"   : lifeTime,
                  @"GeneFitness": geneFitness};

    return self.gene;
}

- (LIYChromosome *)changePosition
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screen.size.width;
    CGFloat screenHeigh = screen.size.height;
    self.position = CGPointMake(skRand(0, screenWidth), skRand(0, screenHeigh));
    return self;
}

- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other
{
    NSInteger rand = arc4random() % 20;
    
    if (self.geneFitness < other.geneFitness) {
        self.trait1 = other.trait1;
        self.trait2 = other.trait2;
        self.size = other.size;
        self.color = other.color;
        self.physicsBody.velocity = other.physicsBody.velocity;
    } else {
        other.trait1 = self.trait1;
        other.trait2 = self.trait2;
        other.trait3 = self.trait3;
        other.size = self.size;
        other.color = self.color;
        other.physicsBody.velocity = self.physicsBody.velocity;
    }
    
    if (rand > 15) {
        [self mutate];
        NSLog(@"MUTATION! %i", rand);
    }
    
    NSLog(@"%i - %i", self.geneFitness, other.geneFitness);

    
    return self;
}

- (void)die
{
    [self runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:1 duration:5.2],
                                         [SKAction removeFromParent]]]];
    
    for (NSString *key in [self.gene allKeys]) {
        if ([key  isEqual: @"VelocityDY"])
            NSLog(@"%@ : %@", key, [self.gene objectForKey:key]);
        if ([key  isEqual: @"VelocityDX"])
            NSLog(@"%@ : %@", key, [self.gene objectForKey:key]);
    }
}
- (void)mutate
{
    NSInteger rand = arc4random() % 3;
    NSInteger xRand = arc4random() % 20 + 1;
    NSInteger yRand = arc4random() % 20 + 1;
    NSInteger xRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 1000);
    NSInteger yRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 1000);
    CGFloat hue = ( arc4random() % 256 / 256.0);
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    if (rand == 0)
        self.color = color;
    else if (rand == 1)
        self.size = CGSizeMake(xRand, yRand);
    else if (rand == 2)
        self.physicsBody.velocity = CGVectorMake(xRandAction, yRandAction);
}

- (BOOL)isFitterThanChromosom:(LIYChromosome *)other
{
    NSNumber *selfFitness = [NSNumber numberWithInt:self.geneFitness];
    NSNumber *otherFitness = [NSNumber numberWithInt:other.geneFitness];
    return selfFitness > otherFitness;
}


@end