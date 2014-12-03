//
//  hangmanBrain.m
//  Hangman
//
//  Created by Emiel on 11/7/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "HangmanBrain.h"
@interface HangmanBrain ()
@property (retain, readwrite, nonatomic) NSArray *wordlist;
@property (assign, readwrite, nonatomic) int wordsize;
@end


@implementation HangmanBrain
@synthesize currentState = _currentState;
@synthesize areLettersInWord = _areLettersInWord;
@synthesize lives = _lives;
@synthesize wordsize = _wordsize;
@synthesize wordlist = _wordlist;
@synthesize possibleWords = _possibleWords;
@synthesize score = _score;


#pragma mark - init
- (HangmanBrain *)initWithLives:(int)lives andWordsize:(int)wordsize {
    /*
     * Initialize a HangmanBrain with an amount of lives, wordsize and score.
     */
    self = [super init];
    self.wordsize = wordsize;
    self.lives = lives;
    self.score = 100 - lives;
    
    return self;
}

#pragma mark - Getters
- (NSArray *)wordlist {
    /*
     * Returns a language dictionary, based on the word.plist file
     */
    if (_wordlist == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"words" ofType:@"plist"];
        _wordlist = [NSArray arrayWithContentsOfFile:path];
    }
    return _wordlist;
}

- (NSArray *)possibleWords {
    if (_possibleWords == nil)
    {
        NSMutableArray *storage = [NSMutableArray array];
        for (NSString *word in self.wordlist)
        {
            if (word.length == self.wordsize)
            {
                [storage addObject:word];
            }
        }
        _possibleWords = storage;
    }
    return _possibleWords;
}

- (NSMutableArray *)currentState {
    /*
     * Create a new current state if none exists
     */
    if (_currentState == nil)
    {
        _currentState = [NSMutableArray array];
        
        for (int i = 0, n = self.wordsize; i < n; i++) {
            [_currentState addObject:@""];
        }
    }
    return _currentState;
}

- (NSMutableDictionary *)areLettersInWord {
    /*
     * guessedLetters will contain all characters that have been guessed
     */
    if (_areLettersInWord == nil) {
        _areLettersInWord = [NSMutableDictionary dictionaryWithCapacity:26];
    }
    return _areLettersInWord;
}

#pragma mark - Game Core
- (BOOL)guess:(NSString *)letter {
    /*
     * Guess whether a letter is in the secret word.
     */
    BOOL isLetterInWord;
    
    NSMutableDictionary *containers = [NSMutableDictionary dictionary];
    
    for (NSString *word in self.possibleWords) {
        
        NSString *key = [self hash:letter inString:word];
        
        if ([containers objectForKey:key] == nil) {
            [containers setObject:[NSMutableArray array] forKey:key];
        }
        
        [[containers objectForKey:key] addObject:word];
    }
    
    NSArray *largestContainer = @[];
    NSString *correspondingKey;

    for (NSString *key in containers) {
        NSArray *temp = [containers objectForKey:key];
        
        if (temp.count > largestContainer.count) {
            largestContainer = temp;
            correspondingKey = key;
        }
    }
    
    self.possibleWords = largestContainer;
    NSLog(@"Container chosen: %@", largestContainer);
    
    if ([correspondingKey isEqualToString:@""]) {
        [self.areLettersInWord setObject:[NSNumber numberWithBool:NO] forKey:letter];
        self.lives--;
        self.score--;
        isLetterInWord = NO;
    }
    else {
        [self.areLettersInWord setObject:[NSNumber numberWithBool:YES] forKey:letter];
        isLetterInWord = YES;
    }
    
    NSArray *indices = [correspondingKey componentsSeparatedByString:@","];
    
    for (NSString *index in indices)
    {
        if ([index isEqualToString:@""])
        {
            continue;
        }
        [self.currentState replaceObjectAtIndex:[index integerValue] withObject:letter];
    }
    
    
    return isLetterInWord;
}

- (NSString *)hash:(NSString *) letter inString:(NSString *)string {
    /*
     * Returns a NSString with format "i_1,i_2,i_3," where i_n is
     * an index at which the letter is in the string.
     */
    char c = [letter characterAtIndex:0];
    
    NSMutableString *locations = [NSMutableString string];
    
    for (int i = 0; i < (int) string.length; i++) {
        if (c == [string characterAtIndex:i]) {
            [locations appendFormat:@"%i,", i];
        }
    }
    return locations;
}

- (BOOL)won {
    /*
     * Check if the currentState is the secret word.
     */
    for (NSString *letter in self.currentState)
    {
        if ([letter isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
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

- (void)memoryWarning {
    self.wordlist = nil;
}

- (void)clean
{
    /*
     * Detroys all objects
     */
    self.currentState = nil;
    self.areLettersInWord = nil;
}

@end
