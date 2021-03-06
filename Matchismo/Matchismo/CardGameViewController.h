//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Andrew Jaeger on 1/30/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//
// Abstract Controller

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
- (Deck *)createDeck;

@end
