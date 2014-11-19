//
//  hangmanBrain.m
//  Hangman
//
//  Created by Emiel on 11/7/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "HangmanBrain.h"

@implementation HangmanBrain
@synthesize hangmanWord = _hangmanWord;
@synthesize currentState = _currentState;
@synthesize guessedLetters = _guessedLetters;
@synthesize lives = _lives;

- (HangmanBrain *)initWithLives:(int)lives {
    /*
     * Initialize a HangmanBrain with an amount of lives.
     */
    self = [super init];
    self.lives = lives;
    return self;
}

- (NSString *)hangmanWord {
    /*
     * Returns pointer to a NSString: the word to be guessed
     */
    _hangmanWord = @"testing";
    return _hangmanWord;
}

- (NSString *)currentState {
    /*
     * Create a new current state if none exists
     */
    if (_currentState == nil)
    {
        NSMutableString *new = [[NSMutableString alloc] init];
        
        NSUInteger n = [self.hangmanWord length];
        for (int i = 0; i < n; i++) {
            [new appendFormat:@"_"];
        }
        self.currentState = new;
    }
    return _currentState;
}

- (NSMutableArray *)guessedLetters {
    /*
     * guessedLetters will contain all characters that have been guessed
     */
    if (_guessedLetters == nil) {
        _guessedLetters = [NSMutableArray array];
    }
    return _guessedLetters;
}


- (BOOL)guess:(char)letter {
    /*
     * Guess whether a letter is in the secret word.
     */
    [self.guessedLetters addObject:[NSString stringWithFormat:@"%c", letter]];
    
    return [self updateCurrentStateWithLetter:letter];
}

- (BOOL)updateCurrentStateWithLetter:(char)guess {
    /*
     * Updates the current state with the chars instead of '_' where it is guessed.
     */
    NSInteger wordLength = [self.hangmanWord length];
    
    NSMutableString *newState = [NSMutableString string];
    
    BOOL guessCorrect = NO;
    
    for (int i = 0; i < wordLength; i++) {
        char letter = [self.hangmanWord characterAtIndex:i];
        
        char currentLetter = [self.currentState characterAtIndex:i];
        
        if (letter == guess) {
            guessCorrect = YES;
            // Append letters that are guessed
            [newState appendFormat:@"%c", letter];
        }
        else if (currentLetter != '_')
        {
            // Append letters that already have been guessed
            [newState appendFormat:@"%c", currentLetter];
        }
        else
        {
            // Append a _ if letter is not yet known
            [newState appendFormat:@"_"];
        }
    }
    self.currentState = newState;
    
    return guessCorrect;
}

- (BOOL)won {
    /*
     * Check if the currentState is the secret word.
     */
    return [self.hangmanWord isEqualToString:self.currentState];
}

- (BOOL)lost
{
    /*
     * Check whether the lives are 0 (or less).
     */
    if (self.lives <= 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)clean
{
    /*
     * Detroys all objects
     */
    self.currentState = nil;
    self.guessedLetters = nil;
}

@end
