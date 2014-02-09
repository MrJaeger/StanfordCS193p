//
//  Card.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/1/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "Card.h"

@implementation Card

- (BOOL)matchesOtherCard:(Card *)otherCard {
    BOOL matches = NO;
    if([self.contents isEqualToString:otherCard.contents]) {
        matches = YES;
    }
    return matches;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
