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

- (BOOL) setMatch:(NSArray *)props{
    NSMutableArray *checked = [[NSMutableArray alloc] init];
    for (id prop in props) {
        if (![checked containsObject:prop]) {
            [checked addObject:prop];
        }
    }
    return (([checked count] == 1) || ([checked count] == 3));
}

- (BOOL)setMatchRank:(NSArray *)cards {
    NSArray *ranks = [[NSArray alloc] init];
    for (SetCard *card in cards) {
        ranks = [ranks arrayByAddingObject:[NSNumber numberWithUnsignedInteger:card.rank]];
    }
    return [self setMatch:ranks];
}

- (BOOL)setMatchShape:(NSArray *)cards {
    NSArray *shapes = [[NSArray alloc] init];
    for (SetCard *card in cards) {
        shapes = [shapes arrayByAddingObject:card.shape];
    }
    return [self setMatch:shapes];
}

- (BOOL)setMatchShade:(NSArray *)cards {
    NSArray *shades = [[NSArray alloc] init];
    for (SetCard *card in cards) {
        shades = [shades arrayByAddingObject:card.shade];
    }
    return [self setMatch:shades];
}

- (BOOL)setMatchColor:(NSArray *)cards {
    NSArray *colors = [[NSArray alloc] init];
    for (SetCard *card in cards) {
        colors = [colors arrayByAddingObject:[NSNumber numberWithUnsignedInteger:card.rank]];
    }
    return [self setMatch:colors];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    otherCards = [otherCards arrayByAddingObject:self];
    BOOL setMatch = ([self setMatchRank:otherCards] && [self setMatchColor:otherCards] && [self setMatchShade:otherCards] && [self setMatchShade:otherCards]);
    if (setMatch) {
        score = 20;
    }
    return score;
}

@end
