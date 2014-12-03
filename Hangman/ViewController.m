//
//  ViewController.m
//  Hangman
//
//  Created by Emiel on 11/6/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (retain, readwrite, nonatomic) HangmanBrain *brain;
@property (weak, readonly, nonatomic) NSUserDefaults *userDefaults;
@end

@implementation ViewController
@synthesize brain = _brain;
@synthesize userDefaults = _userDefaults;

@synthesize guessedLabel = _guessedLabel;
@synthesize wordLabel = _wordLabel;
@synthesize livesLabel = _livesLabel;
@synthesize inputLabel = _inputLabel;
@synthesize instructionLabel = _instructionLabel;
@synthesize instructionArrow = _instructionArrow;

#pragma mark - Getters
- (HangmanBrain *)brain {
    /*
     * HangmanBrain is instanciated when a new one is necessary.
     */
    if (_brain == nil) {
        int lives = (int) [self.userDefaults integerForKey:@"lives"];
        int wordsize = (int) [self.userDefaults integerForKey:@"wordsize"];
        _brain = [[HangmanBrain alloc] initWithLives:lives andWordsize:wordsize];
    }
    return _brain;
}

- (NSUserDefaults *)userDefaults {
    /*
     * Settings are retreived from standardUserDefaults when requested.
     */
    if (_userDefaults == nil) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

#pragma mark - UIViewController method overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [self.guessField setDelegate:self];
    // Update labels
    [self updateLabels];
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - IBActions

- (IBAction)doneEditing:(id)sender {
    [self checkUserInput];
}

- (IBAction)newGame:(UIButton *)sender {
    [self clean];
    [self updateLabels];
}


#pragma mark - Game Handling
- (void)checkUserInput {
    /*
     * User's input (a letter) is tested in
     * the hangmanbrain.
     */
    if (self.inputLabel.text.length != 1) {
        return;
    }
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{self.instructionLabel.alpha = 0; self.instructionArrow.alpha = 0;}
                     completion:^(BOOL finished){self.instructionLabel.hidden = YES; self.instructionArrow.hidden = YES;}];
    
    NSString *letter = [self.inputLabel.text substringWithRange:NSMakeRange(0, 1)];
    
    if ([self.brain.areLettersInWord objectForKey:letter] != nil)
    {
        [self updateLabels];
        return;
    }
    
    BOOL letterInWord = [self.brain guess:letter];
    
    [self updateLabels];
    
    if ([self.brain won])
    {
        [self eventAlertWon];
    }
    
    if ([self.brain lost])
    {
        [self eventAlertLost];
    }
}


- (void)eventAlertLost {
    NSString *titleKey = @"alert_title_game_lost";
    NSString *messageKey = @"alert_message_game_lost";
    NSString *buttonTitleKey = @"alert_buttonTitle_game_lost";
    
    NSString *finalWord = self.brain.possibleWords[0];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(titleKey, nil) message:[NSString stringWithFormat:NSLocalizedString(messageKey, nil),finalWord] delegate:self cancelButtonTitle:NSLocalizedString(buttonTitleKey, nil) otherButtonTitles:nil];
    
    [alert show];
}


- (void)eventAlertWon {
    NSString *titleKey = @"alert_title_game_won";
    NSString *messageKey = @"alert_message_game_won";
    NSString *buttonTitleKey = @"alert_buttonTitle_game_won";
    NSString *enterScoreKey = @"alert_buttonTitle_enter_score";
    
    int score = self.brain.score;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(titleKey, nil) message:[NSString stringWithFormat:NSLocalizedString(messageKey, nil),score] delegate:self cancelButtonTitle:NSLocalizedString(buttonTitleKey, nil) otherButtonTitles:NSLocalizedString(enterScoreKey, nil), nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [self resignFirstResponder];
    
    [[alert textFieldAtIndex:0] becomeFirstResponder];
    
    [alert show];
}

- (void)updateLabels {
    NSMutableString *wordLabelText = [NSMutableString string];
    
    for (NSString *letter in self.brain.currentState)
    {
        if ([letter isEqualToString:@""])
        {
            [wordLabelText appendString:@"_ "];
        }
        else
        {
            [wordLabelText appendString:letter];
        }
    }
    
    self.wordLabel.text = wordLabelText;
    
    NSMutableString *wrongLetters = [NSMutableString string];
    if (self.brain.areLettersInWord.count > 0)
        [wrongLetters appendString:@"Guessed: "];
    
    for (NSString *key in self.brain.areLettersInWord) {
        if ([self.brain.areLettersInWord[key] boolValue] == NO) {
            [wrongLetters appendFormat:@"%@ ", key];
        }
    }
    
    self.guessedLabel.text = wrongLetters;
    
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.brain.lives];

    self.inputLabel.text = @"";
}

- (void)clean
{
    [self.brain clean];
    self.brain = nil;
}

- (void)enterHighScore:(int)score withName: (NSString *)name {
    if (name.length > 10) {
        name = [name substringToIndex:10];
    }
    
    
    NSMutableArray *highScores = [[self.userDefaults objectForKey:@"highScoreList"] mutableCopy];
    
    NSArray *current = @[[NSNumber numberWithInt:score], name];
    
    for (int i = 0; i < highScores.count; i++) {
        if ([current[0] integerValue] >= [highScores[i][0] integerValue]) {
            [highScores insertObject:current atIndex:i];
            break;
        }
    }
    
    NSArray *output;
    if (highScores.count > 10) {
        output = [highScores subarrayWithRange:NSMakeRange(0, 10)];
    }
    else {
        output = highScores;
    }
    
    [self.userDefaults setObject:output forKey:@"highScoreList"];
    [self.userDefaults synchronize];
}

#pragma mark - UIAlertViewDelegate Protocol implementation
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[alertView textFieldAtIndex:0] resignFirstResponder];
    
    if (buttonIndex == 1) {
        [self enterHighScore: self.brain.score withName:[alertView textFieldAtIndex:0].text];
        
        [self performSegueWithIdentifier:@"highScoreSegue" sender:self];
    }
    else {
        [self becomeFirstResponder];
    }
    
    [self clean];
    [self updateLabels];

}


#pragma mark - UIKeyInput Protocol implementation

- (BOOL)hasText {
    return NO;
}

- (void)insertText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self checkUserInput];
        return;
    }
    
    NSString *input = [[text uppercaseString]
                       stringByTrimmingCharactersInSet:
                       [[NSCharacterSet characterSetWithRange:NSMakeRange('A', 26)] invertedSet]];
    
    
    self.inputLabel.text = input;
}

- (void)deleteBackward {
    self.inputLabel.text = @"";
}
    
#pragma mark - UIKeyboard Customization

- (UIReturnKeyType)returnKeyType {
    return UIReturnKeyDone;
}

- (UITextSpellCheckingType)spellCheckingType {
    return UITextSpellCheckingTypeNo;
}

- (UIKeyboardAppearance)keyboardAppearance {
    return UIKeyboardAppearanceDark;
}

- (UITextAutocorrectionType)autocorrectionType {
    return UITextAutocorrectionTypeNo;
}

@end
