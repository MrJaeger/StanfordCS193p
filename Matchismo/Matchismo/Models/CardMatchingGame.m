//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/2/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)currentCards {
    if (!_currentCards) _currentCards = [[NSMutableArray alloc] init];
    return _currentCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck withMatchMode:(NSUInteger)mode {
    self = [super init];
    
    if (self) {
        
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
        if(mode) {
            self.matchMode = mode;
        } else {
            self.matchMode = 2;
        }
    }
    
    return self;
}


- (NSMutableArray *)chosenUnmatchedCards {
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            [chosenCards addObject:card];
        }
    }
    
    return chosenCards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    if (index < [self.cards count]) {
        return self.cards[index];
    }
    return nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    [self.currentCards addObject:card];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            card.chosen = YES;
            NSMutableArray *chosenCards = [self chosenUnmatchedCards];
            if ([chosenCards count] == self.matchMode) {
                [chosenCards removeObject:card];
                int score = [card match:[chosenCards copy]];
                if (score) {
                    for (Card *otherCard in chosenCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                } else {
                    for (Card *otherCard in chosenCards) {
                        otherCard.chosen = NO;
                        score -= MISMATCH_PENALTY * (self.matchMode - 1);
                    }
                    card.chosen = NO;
                }
                self.currentScore = score;
                self.score += score;
            }
            self.score -= COST_TO_CHOOSE;
        }
    }
}

@end