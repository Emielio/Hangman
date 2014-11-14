//
//  hangmanBrain.h
//  Hangman
//
//  Created by Emiel on 11/7/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangmanBrain : NSObject

@property (readonly, nonatomic) NSString *hangmanWord;
@property (copy, readwrite, nonatomic) NSString *currentState;
@property (copy, readonly, nonatomic) NSMutableArray *guessedLetters;

- (BOOL)checkIfWon;

- (void)guessLetter:(char)guess;

@end
