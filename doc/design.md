#Evil Hangman: design document#

##### Emiel Hoogeboom #####
##### Hangman #####
##### Date: 14 - 11 - 2013 #####


The following document provides an insight into the user interface of the app, as well as the underlying structure. The contents of this document are as follows: First the document will discuss the user interface, then the classes and finally the libraries the program will use.

###User Interface and Human Interaction###

![Alt text](MainView.jpg) 
![Alt text](SettingsView.jpg)  
The first screen is the main ViewController of the application. This screen will continue an existing game or start a new one. The game input is a letter, when a letter is entered, it is greyed out on the guessedLabel. The user is shown whether the letter is present in the word and where it is located. The settings button takes the user to the picture on the right: the SettingsViewController. Here the wordsize an the amount of guesses(lives) can be specified. If the new game button is clicked, a new game with the new settings can be started. If you however go back without pressing the button, the current game can still be played.


###List of classes and public methods:###
HangmanBrain
- (BOOL)checkIfWon;
- (void)guessLetter:(char)guess;

State
- (NSString *)getGuesses;
- (void)saveGuesses(NSString *);

MainViewController
- @property (weak, nonatomic) IBOutlet UILabel *guessedLabel;
- @property (weak, nonatomic) IBOutlet UILabel *wordLabel;
- @property (weak, nonatomic) IBOutlet UITextField *guessField;

- (IBAction)checkUserInput:(UIButton *)sender;
- (IBAction)settingsButton:(UIButton *)sender;

SettingsViewController
- @property (weak, nonatomic) IBOutlet UILabel *wordsizeLabel;
- @property (weak, nonatomic) IBOutlet UISlider *wordsize;
- @property (weak, nonatomic) IBOutlet UILabel *livesLabel;
- @property (weak, nonatomic) IBOutlet UISlider *lives;
- (IBAction)backButton:(UIButton *)sender;

###Libraries used by the program###
- UIKit: For user interface elements
- Foundation: To use Objective-C elements like NSObject
