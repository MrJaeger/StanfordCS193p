//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andrew Jaeger on 2/2/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                    withMatchMode:(NSUInteger)mode;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger matchMode;
@property (nonatomic, strong) NSMutableArray *currentCards;
@property (nonatomic) NSInteger currentScore;

@end
