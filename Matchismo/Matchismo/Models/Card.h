//
//  Card.h
//  Matchismo
//
//  Created by Andrew Jaeger on 2/1/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;
- (BOOL)matchesOtherCard:(Card *)otherCard;
@end
