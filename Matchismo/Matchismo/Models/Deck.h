//
//  Deck.h
//  Matchismo
//
//  Created by Andrew Jaeger on 2/1/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
