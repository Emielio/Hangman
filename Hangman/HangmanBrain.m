//
//  hangmanBrain.m
//  Hangman
//
//  Created by Emiel on 11/7/14.
//  Copyright (c) 2014 mprog. All rights reserved.
//

#import "HangmanBrain.h"
@interface HangmanBrain ()
@property (retain, readwrite, nonatomic) DictionaryModel *dictionaryModel;
@property (retain, readwrite, nonatomic) NSArray *possibleWords;

@property (assign, readwrite, nonatomic) int wordsize;
@property (assign, readwrite, nonatomic) int initialLives;
@property (assign, readwrite, nonatomic) BOOL evil;
@end


@implementation HangmanBrain
@synthesize currentState = _currentState;
@synthesize areLettersInWord = _areLettersInWord;
@synthesize lives = _lives;
@synthesize score = _score;
@synthesize progress = _progress;

@synthesize dictionaryModel = _dictionaryModel;
@synthesize possibleWords = _possibleWords;
@synthesize wordsize = _wordsize;
@synthesize initialLives = _initialLives;
@synthesize evil = _evil;

#pragma mark - init
- (HangmanBrain *)initWithLives:(int)lives andWordsize:(int)wordsize isEvil:(BOOL)evil {
    /*
     * Initialize a HangmanBrain with an amount of lives, wordsize and score.
     */
    self = [super init];
    self.wordsize = wordsize;
    self.lives = lives;
    self.initialLives = lives;
    self.evil = evil;
    self.score = 100 - lives;
    
    [self.dictionaryModel loadDictionary];
    
    if (!evil) {
        self.possibleWords = @[[self randomWordFromArray:self.possibleWords]];
    }
    
    return self;
}

#pragma mark - Getters/Setters
- (DictionaryModel *)dictionaryModel {
    if (_dictionaryModel == nil)
    {
        _dictionaryModel = [[DictionaryModel alloc] init];
    }
    return _dictionaryModel;
}

/*
 * Returns an array with the currently still possible words.
 */
- (NSArray *)possibleWords {
    if (_possibleWords == nil)
    {
        NSMutableArray *storage = [NSMutableArray array];
        for (NSString *word in self.dictionaryModel.wordlist)
        {
            if (word.length == self.wordsize)
                [storage addObject:word];
        }
        
        if (storage.count < 200)
            self.score -= 10;

        _possibleWords = storage;
    }
    return _possibleWords;
}

/*
 * Create a new current word state if none exists
 */
- (NSMutableArray *)currentState {
    if (_currentState == nil)
    {
        _currentState = [NSMutableArray arrayWithCapacity:self.wordsize];
        
        for (int i = 0, n = self.wordsize; i < n; i++)
            [_currentState addObject:@""];
    }
    return _currentState;
}

/*
 * guessedLetters will contain all characters that have been guessed
 */
- (NSMutableDictionary *)areLettersInWord {
    if (_areLettersInWord == nil)
        _areLettersInWord = [NSMutableDictionary dictionaryWithCapacity:26];

    return _areLettersInWord;
}

/*
 * Updates progress if lives is set.
 */
- (void)setLives:(int)lives {
    _lives = lives;
    
    _progress = 1.0 - (double) lives / self.initialLives;
}

#pragma mark - Game Core
/*
 * Guess whether a letter is in the secret word.
 */
- (void)guess:(NSString *)letter {
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
            largestContainer = containers[key];
            correspondingKey = key;
        }
    }
    
    self.possibleWords = largestContainer;
    
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
            continue;

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

- (NSString *)randomWordFromArray:(NSArray *)array {
    NSUInteger max = [array count];
    
    return array[rand() % max];
}

- (NSString *)answer {
    return [self randomWordFromArray:self.possibleWords];
}

- (void)memoryWarning {
    [self.dictionaryModel clean];
    self.dictionaryModel = nil;
}

- (void)clean
{
    /*
     * Detroys all objects
     */
    [self.dictionaryModel clean];
    self.dictionaryModel = nil;
    
    self.currentState = nil;
    self.areLettersInWord = nil;
    self.possibleWords = nil;
}

@end
