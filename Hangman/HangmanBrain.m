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

- (NSString *)hangmanWord {
    _hangmanWord = @"testing";
    return _hangmanWord;
}

- (NSString *)currentState {
    if (_currentState == nil)
    {
        NSInteger length = [self.hangmanWord length];
        NSMutableString *new = [[NSMutableString alloc] init];
        for (int i = 0; i < length; i++) {
            [new appendFormat:@"_"];
        }
        self.currentState = new;
    }
    return _currentState;
}

- (NSMutableArray *)guessedLetters {
    if (_guessedLetters == nil) {
        _guessedLetters = [NSMutableArray array];
    }
    return _guessedLetters;
}


- (void)guessLetter:(char)guess {
    [self.guessedLetters addObject:[NSString stringWithFormat:@"%c", guess]];
    
    [self updateCurrentStateWithLetter:guess];
}

- (void)updateCurrentStateWithLetter:(char)guess {
    NSInteger wordLength = [self.hangmanWord length];
    
    NSMutableString *newState = [NSMutableString string];
    
    
    for (int i = 0; i < wordLength; i++) {
        char letter = [self.hangmanWord characterAtIndex:i];
        
        char currentLetter = [self.currentState characterAtIndex:i];
        
        if (letter == guess) {
            NSLog(@"We've found a letter at index %d", i);
            [newState appendFormat:@"%c", letter];
        }
        else if (currentLetter != '_')
        {
            [newState appendFormat:@"%c", currentLetter];
        }
        else
        {
            [newState appendFormat:@"_"];
        }
    }
    
    self.currentState = newState;
    
    NSLog(@"new word: %@", newState);
}


- (BOOL)checkIfWon {
    return [self.hangmanWord isEqualToString:self.currentState];
}

@end
