//
//  SetCard.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/17/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

NSUInteger MIN_RANK = 1;
NSUInteger MAX_RANK = 3;

+ (NSArray *)validShapes {
    return @[@"▲", @"■", @"●"];
}

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShades {
    return @[@"filled", @"shaded", @"empty"];
}

+ (NSUInteger)minRank {
    return MIN_RANK;
}

+ (NSUInteger)maxRank {
    return MAX_RANK;
}

- (void)setShape:(NSString *)shape {
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setShade:(NSString *)shade {
    if ([[SetCard validShades] containsObject:shade]) {
        _shade = shade;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank >= [SetCard minRank] && rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}

@end
