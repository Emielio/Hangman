#Evil Hangman: design document#

##### Emiel Hoogeboom #####
##### Hangman #####
##### Date: 14 - 11 - 2013 #####


The following document provides an insight into the user interface of the app, as well as the underlying structure. The contents of this document are as follows: First the user interface

###User Interface and Human Interaction###

![Alt text](MainView.jpg) 
![Alt text](SettingsView.jpg)  
The first screen is the main view of the application. This screen will continue an existing game or start a new one.


###List of classes and public methods:###
HangmanBrain
- (BOOL)checkIfWon;
- (void)guessLetter:(char)guess;

State
- (NSString *)getGuesses;
- (void)saveGuesses(NSString *);


###Libraries used by the program###
- UIKit: For user interface elements
- Foundation: To use Objective-C elements like NSObject


## Header 2 ##
