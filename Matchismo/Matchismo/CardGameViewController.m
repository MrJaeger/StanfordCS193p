//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andrew Jaeger on 1/30/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *matchModeSlider;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)createNewGame {
    int matchMode = 2;
    if (!self.matchModeSlider.on) {
        matchMode = 3;
    }
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] withMatchMode:matchMode];
}

- (CardMatchingGame *)game {
    if (!_game) _game = [self createNewGame];
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
    self.game = [self createNewGame];
    self.scoreLabel.text = @"Score: 0";
    self.resultsLabel.text = @"";
    self.matchModeSlider.enabled = YES;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.matchModeSlider.enabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateDescription:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)toggleMatchCountSwitch:(UISwitch *)sender {
    if (sender.on) {
        self.game.matchMode = 2;
    } else {
        self.game.matchMode = 3;
    }
}

- (void)updateDescription:(int)chosenButtonIndex {
    if ([self.game.currentCards count] == self.game.matchMode) {
        NSMutableArray *matchingCards = [[NSMutableArray alloc] init];
        for (Card *card in self.game.currentCards) {
            for (Card *otherCard in self.game.currentCards) {
                if ([card.contents isEqualToString:otherCard.contents]) {
                    continue;
                }
                if ([card matchesOtherCard:otherCard]) {
                    if (![matchingCards containsObject:card]) {
                        [matchingCards addObject:card];
                    }
                    if (![matchingCards containsObject:otherCard]) {
                        [matchingCards addObject:otherCard];
                    }
                }
            }
        }
        NSMutableArray *notMatchingCards = [[NSMutableArray alloc] init];
        for (Card *card in self.game.currentCards) {
            if (![matchingCards containsObject:card]) {
                [notMatchingCards addObject:card];
            }
        }
        NSString *description = @"";
        for (Card *card in matchingCards) {
            description = [description stringByAppendingString:card.contents];
        }
        if ([matchingCards count] > 0) {
            description = [description stringByAppendingString:@" Matched!"];
        }
        description = [description stringByAppendingString:@"  "];
        for (Card *card in notMatchingCards) {
            description = [description stringByAppendingString:card.contents];
        }
        if ([notMatchingCards count] > 0) {
            description = [description stringByAppendingString:@" Didn't match."];
        }
        description = [NSString stringWithFormat:@"%@  You got %d points.", description, self.game.currentScore];
        self.resultsLabel.text = description;
        if ([matchingCards count]) {
            self.game.currentCards = [[NSMutableArray alloc] init];
        } else {
            self.game.currentCards = [[NSMutableArray alloc] initWithArray:@[[self.game cardAtIndex:chosenButtonIndex]]];
        }
        self.game.currentScore = 0;
    } else {
        NSString *description = @"";
        for (PlayingCard *card in self.game.currentCards) {
            description = [description stringByAppendingString:card.contents];
            description = [description stringByAppendingString:@" "];
        }
        description = [description stringByAppendingString:@"Chosen"];
        self.resultsLabel.text = description;
    }
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex= [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
