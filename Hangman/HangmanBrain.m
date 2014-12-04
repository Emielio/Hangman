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
@property (retain, readwrite, nonatomic) NSArray *possibleWords;

@property (assign, readwrite, nonatomic) int wordsize;
@property (assign, readwrite, nonatomic) int initialLives;
@end


@implementation HangmanBrain
@synthesize currentState = _currentState;
@synthesize areLettersInWord = _areLettersInWord;
@synthesize lives = _lives;
@synthesize wordsize = _wordsize;
@synthesize wordlist = _wordlist;
@synthesize possibleWords = _possibleWords;
@synthesize score = _score;
@synthesize progress = _progress;


#pragma mark - init
- (HangmanBrain *)initWithLives:(int)lives andWordsize:(int)wordsize {
    /*
     * Initialize a HangmanBrain with an amount of lives, wordsize and score.
     */
    self = [super init];
    self.wordsize = wordsize;
    self.lives = lives;
    self.initialLives = lives;
    self.score = 100 - lives;
    
    return self;
}

#pragma mark - Getters/Setters
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
    /*
     * Returns an array with the currently still possible words.
     */
    if (_possibleWords == nil)
    {
        NSMutableArray *storage = [NSMutableArray array];
        for (NSString *word in self.wordlist)
        {
            if (word.length == self.wordsize)
                [storage addObject:word];
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
        _currentState = [NSMutableArray arrayWithCapacity:self.wordsize];
        
        for (int i = 0, n = self.wordsize; i < n; i++)
            [_currentState addObject:@""];
    }
    return _currentState;
}

- (NSMutableDictionary *)areLettersInWord {
    /*
     * guessedLetters will contain all characters that have been guessed
     */
    if (_areLettersInWord == nil)
        _areLettersInWord = [NSMutableDictionary dictionaryWithCapacity:26];

    return _areLettersInWord;
}

- (void)setLives:(int)lives {
    /*
     * Updates progress if lives is set.
     */
    _lives = lives;
    
    _progress = 1.0 - (double) lives / self.initialLives;
}

#pragma mark - Game Core
- (void)guess:(NSString *)letter {
    /*
     * Guess whether a letter is in the secret word.
     */
    NSMutableDictionary *containers = [NSMutableDictionary dictionary];
    
    for (NSString *word in self.possibleWords)
    {
        NSString *key = [self hash:letter inString:word];
        
        if ([containers objectForKey:key] == nil)
            containers[key] = [NSMutableArray array];
        
        [containers[key] addObject:word];
    }
    
    NSArray *largestContainer;
    NSString *correspondingKey;

    for (NSString *key in containers) {
        if ([containers[key] count] > largestContainer.count) {
            NSArray *temp = containers[key];
            largestContainer = temp;
            correspondingKey = key;
        }
    }
    
    self.possibleWords = largestContainer;
    NSLog(@"%@", self.possibleWords);
    
    if ([correspondingKey isEqualToString:@""]) {
        [self.areLettersInWord setObject:[NSNumber numberWithBool:NO] forKey:letter];
        self.lives--;
        self.score--;
    }
    else {
        [self.areLettersInWord setObject:[NSNumber numberWithBool:YES] forKey:letter];
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

- (NSString *)answer {
    return self.possibleWords[0];
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
