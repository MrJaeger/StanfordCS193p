//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/17/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shape in [SetCard validShapes]) {
                for (NSString *shade in [SetCard validShades]) {
                    for (NSUInteger rank = [SetCard minRank]; rank <= [SetCard maxRank]; rank++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shape = shape;
                        card.shade = shade;
                        card.rank = rank;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
