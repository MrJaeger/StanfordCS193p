//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Andrew Jaeger on 2/18/14.
//  Copyright (c) 2014 Stanford C193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UITextView *resultsText;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation SetCardGameViewController

- (void)viewDidLoad {
    [self updateUI];
}

- (CardMatchingGame *)createNewGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] withMatchMode:3];
}

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
    self.game = [self createNewGame];
    self.scoreLabel.text = @"Score: 0";
    self.resultsText.text = @"";
    [self updateUI];
}

- (void)updateDescription {
    if ([self.game.currentCards count] == self.game.matchMode) {
        NSMutableAttributedString *description = [[NSMutableAttributedString alloc] init];
        for (SetCard *card in self.game.currentCards) {
            [description appendAttributedString:[self contentsForCard:card]];
            [description appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        if (self.game.currentScore < 0) {
            [description appendAttributedString:[[NSAttributedString alloc] initWithString:@"didnt't match."]];
        } else {
            [description appendAttributedString:[[NSAttributedString alloc] initWithString:@"matched."]];
        }
        [description appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  You got %d points", self.game.currentScore]]];
        self.resultsText.attributedText = [description copy];
        self.game.currentCards = [[NSMutableArray alloc] init];
        self.game.currentScore = 0;
    } else {
        NSMutableAttributedString *description = [[NSMutableAttributedString alloc] initWithString:@""];
        for (SetCard *card in self.game.currentCards) {
            [description appendAttributedString:[self contentsForCard:card]];
            [description appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        [description appendAttributedString:[[NSAttributedString alloc] initWithString:@"Chosen"]];
        self.resultsText.attributedText = description;
    }
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex= [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
        NSAttributedString *str = [self contentsForCard:card];
        [cardButton setAttributedTitle:str forState:UIControlStateNormal];
        if (card.isChosen) {
            cardButton.layer.borderWidth = 2.0f;
            cardButton.layer.borderColor = [[UIColor redColor] CGColor];
        } else {
            cardButton.layer.borderWidth = 0.0f;
        }
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (CGFloat)cardAlpha:(NSString *)shade {
    if ([shade isEqualToString:@"filled"] || [shade isEqualToString:@"empty"]) {
        return 1.0;
    } else if([shade isEqualToString:@"shaded"]) {
        return 0.3;
    }
    return 1.0;
}

- (NSNumber *)cardShade:(NSString *)shade {
    NSDictionary *shades = @{
                           @"filled": @-1,
                           @"shaded": @-1,
                           @"empty": @2
                           };
    return shades[shade];
}

- (UIColor *)cardColor:(NSString *)color {
    NSDictionary *colors = @{
                             @"red": [UIColor redColor],
                             @"green": [UIColor greenColor],
                             @"purple": [UIColor purpleColor]
                             };
    return colors[color];
}

- (NSAttributedString *)contentsForCard:(SetCard *)card {
    NSString* regularTitle = @"";
    for (NSUInteger i = [SetCard minRank]; i <= card.rank; i++) {
        regularTitle = [regularTitle stringByAppendingString:card.shape];
    }
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:regularTitle];
    [title setAttributes:@{NSForegroundColorAttributeName: [[self cardColor:card.color] colorWithAlphaComponent:[self cardAlpha:card.shade]],
                           NSStrokeWidthAttributeName: [self cardShade:card.shade]}
                   range:(NSRange){0,[title length]}];
    return [title copy];
}

@end