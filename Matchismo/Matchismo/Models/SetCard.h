//
//  SetCard.h
//  Matchismo
//
//  Created by Andrew Jaeger on 2/17/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *shade;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShades;
+ (NSUInteger)minRank;
+ (NSUInteger)maxRank;
@end
