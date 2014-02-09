//
//  PlayingCard.h
//  Matchismo
//
//  Created by Andrew Jaeger on 2/1/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
