//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/18/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end