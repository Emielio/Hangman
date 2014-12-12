//
//  ViewController.m
//  Hangman
//
//  Created by Emiel on 11/6/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//
//  Controls the Main View of the application. Handles user input
//  and controls all other controllers.


#import "MainViewController.h"

@interface MainViewController ()
@property (retain, readwrite, nonatomic) HangmanBrain *brain;
@property (weak, readonly, nonatomic) NSUserDefaults *defaults;
@end

@implementation MainViewController
@synthesize brain = _brain;
@synthesize defaults = _defaults;

@synthesize guessedLabel = _guessedLabel;
@synthesize wordLabel = _wordLabel;
@synthesize livesLabel = _livesLabel;
@synthesize inputLabel = _inputLabel;
@synthesize instructionLabel = _instructionLabel;
@synthesize instructionArrow = _instructionArrow;
@synthesize gallow = _gallow;

#pragma mark - Getters
/*
 * HangmanBrain is instanciated when a new one is necessary, complete with lives,
 * wordsize and evilmode option.
 */
- (HangmanBrain *)brain {
    if (_brain == nil) {
        int lives = (int) [self.defaults integerForKey:@"lives"];
        int wordsize = (int) [self.defaults integerForKey:@"wordsize"];
        BOOL evil = [self.defaults boolForKey:@"evilMode"];
        _brain = [[HangmanBrain alloc] initWithLives:lives andWordsize:wordsize isEvil:evil];
    }
    return _brain;
}

- (NSUserDefaults *)defaults {
    /*
     * Settings are retreived from standardUserDefaults when requested.
     */
    if (_defaults == nil) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

#pragma mark - UIViewController method overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Update labels
    [self updateLabels];
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.brain memoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * If viewcontroller segues to a PauseViewController, send self as delegate
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqualToString:@"pauseSegue"]) {
        PauseViewController *pauseViewController = segue.destinationViewController;
        [pauseViewController setDelegate:self];
    }
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}


#pragma mark - Game Handling
/*
 * This method is called when user input should be checked. After the information 
 * has been sent to the HangmanBrain, the method makes sure labels and images are
 * updated.
 */
- (void)checkUserInput {
    /*
     * User's input (a letter) is tested in
     * the hangmanbrain.
     */
    if (self.inputLabel.text.length != 1)
        return;

    // Hide the instruction label and image if not already hidden.
    if (self.instructionLabel.hidden == NO) {
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{self.instructionLabel.alpha = 0; self.instructionArrow.alpha = 0;}
                         completion:^(BOOL finished){self.instructionLabel.hidden = YES; self.instructionArrow.hidden = YES;}];
    }
    
    NSString *letter = [self.inputLabel.text substringWithRange:NSMakeRange(0, 1)];
    
    // Send the letter to the HangmanBrain.
    [self.brain guess:letter];
    
    [self updateGallow];
    [self updateLabels];
    
    if ([self.brain won])
        [self eventAlertWon];
    
    if ([self.brain lost])
        [self eventAlertLost];
}

/*
 * Displays the lost alert.
 */
- (void)eventAlertLost {
    NSString *titleKey = @"alert_title_game_lost";
    NSString *messageKey = @"alert_message_game_lost";
    NSString *buttonTitleKey = @"alert_buttonTitle_game_lost";
    
    NSString *finalWord = [self.brain answer];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(titleKey, nil) message:[NSString stringWithFormat:NSLocalizedString(messageKey, nil),finalWord] delegate:self cancelButtonTitle:NSLocalizedString(buttonTitleKey, nil) otherButtonTitles:nil];
    
    [alert show];
}

/*
 * Displays the won alert.
 */
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

/*
 * Updates all labels in the view.
 */
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
    for (char c = 'A'; c <= 'Z'; c++) {
        NSString *letter = [NSString stringWithFormat:@"%c", c];
        
        if (self.brain.areLettersInWord[letter] != nil)
            if ([self.brain.areLettersInWord[letter] boolValue] == NO)
                [wrongLetters appendFormat:@"%c ", c];
    }
    self.instructionLabel.text = NSLocalizedString(@"instruction_game_launch", nil);
    
    self.guessedLabel.text = wrongLetters;
    
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.brain.lives];

    self.inputLabel.text = @"";
}


/*
 * Updates the gallow image, with the progress as a percentage from the HangmanBrain.
 */
- (void)updateGallow {
    NSString *imageName = [NSString stringWithFormat:@"gallow%i.png", (int) (self.brain.progress * 13 + 0.5)];
    self.gallow.image = [UIImage imageNamed:imageName];
}

- (void)clean
{
    [self.brain clean];
    self.brain = nil;
}

#pragma mark - PauseControllerDelegate Protocol implementation
- (void)newGame {
    [self clean];
    [self updateGallow];
    [self updateLabels];
}

#pragma mark - UIAlertViewDelegate Protocol implementation
/*
 * Method to segue to highscores when a high score is entered.
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [HighScoreModel enterHighScore: self.brain.score withName:[alertView textFieldAtIndex:0].text];
        
        [self performSegueWithIdentifier:@"highScoreSegue" sender:self];
    }
    else {
        [[alertView textFieldAtIndex:0] resignFirstResponder];
        [self becomeFirstResponder];
    }
    [self clean];
    [self updateGallow];
    [self updateLabels];

}


#pragma mark - UIKeyInput Protocol implementation
- (BOOL)hasText {
    if ([self.inputLabel.text isEqualToString:@""]) {
        return NO;
    }
    else {
        return YES;
    }
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

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeASCIICapable;
}

- (UIReturnKeyType)returnKeyType {
    return UIReturnKeyGo;
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

- (BOOL)enablesReturnKeyAutomatically {
    return YES;
}

@end
