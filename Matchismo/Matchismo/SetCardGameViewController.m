//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/18/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end