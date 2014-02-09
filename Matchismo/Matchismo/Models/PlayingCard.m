//
//  PlayingCard.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/1/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}
    
@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♥", @"♦", @"♠", @"♣"];
}
    
- (void)setSuit:(NSString *)suit {
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSUInteger)matchBonus:(int)matchCount {
    return pow((matchCount + 1), 2);
}

+ (int)matchCard:(PlayingCard *)card withOtherCard:(PlayingCard *)otherCard {
    int score = 0;
    if(card.rank == otherCard.rank) {
        score += 4;
    } else if ([card.suit isEqualToString:otherCard.suit]) {
        score += 1;
    }
    return score;
}

- (BOOL)matchesOtherCard:(Card *)otherCard {
    BOOL matches = NO;
    PlayingCard *card = (PlayingCard *)otherCard;
    if((self.rank == card.rank) || [self.suit isEqualToString:card.suit]) {
        matches = YES;
    }
    return matches;
}

- (int)match:(NSArray *)otherCards {
    NSMutableArray *allCards = [[NSMutableArray alloc] initWithArray:otherCards];
    [allCards addObject:self];
    NSMutableDictionary *cardMatchDict = [[NSMutableDictionary alloc] init];
    
    for (PlayingCard *card in allCards) {
        cardMatchDict[card.contents] = [[NSMutableArray alloc] init];
    }
    
    int score = 0;
    int matches = 0;
    
    for (PlayingCard *card in allCards) {
        for (PlayingCard *otherCard in allCards) {
            if ([card.contents isEqualToString:otherCard.contents]) {
                continue;
            }
            NSMutableArray *cardMatchArray = cardMatchDict[card.contents];
            NSInteger otherCardIndex = [cardMatchArray indexOfObject:otherCard];
            if (otherCardIndex == NSNotFound) {
                int matchScore = [PlayingCard matchCard:card withOtherCard:otherCard];
                if (matchScore) {
                    score += matchScore;
                    matches++;
                    [cardMatchDict[card.contents] addObject:otherCard];
                    [cardMatchDict[otherCard.contents] addObject:card];
                }
            }
        }
    }
    
    return score * [self matchBonus:matches];
}

@end
