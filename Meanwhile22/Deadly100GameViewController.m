//
//  Deadly100GameViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 12/13/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "Deadly100GameViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DeadlyQuestions.h"

@interface Deadly100GameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIImageView *overlayImage;
@property (weak, nonatomic) IBOutlet UIImageView *gameLostImage;
@property (weak, nonatomic) IBOutlet UIImageView *gameWonImage;
@property (weak, nonatomic) IBOutlet UIView *overlayButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *fightAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *fallBackButton;

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIView *livesContainer1;
@property (weak, nonatomic) IBOutlet UIImageView *life1;
@property (weak, nonatomic) IBOutlet UIImageView *life2;
@property (weak, nonatomic) IBOutlet UIImageView *life3;
@property (weak, nonatomic) IBOutlet UIView *scoreContainer;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;

@property (weak, nonatomic) IBOutlet UIView *livesContainer2;
@property (weak, nonatomic) IBOutlet UIImageView *life4;
@property (weak, nonatomic) IBOutlet UIImageView *life5;
@property (weak, nonatomic) IBOutlet UIImageView *life6;

@property (weak, nonatomic) IBOutlet UIView *middleContainer;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIButton *answer1Button;
@property (weak, nonatomic) IBOutlet UIButton *answer2Button;
@property (weak, nonatomic) IBOutlet UIButton *answer3Button;
@property (weak, nonatomic) IBOutlet UIButton *answer4Button;

@property NSInteger scoreNumber;
@property NSInteger livesNumber;
@property NSInteger randomIndex;

@property NSTimer *timer;
@property NSInteger seconds;
@property NSTimer *slideTimer;
@property NSInteger slideSeconds;

@property AVAudioPlayer *audioPlayer;

//The "Answer" BOOLs work by setting the correct anser to "Yes"
//And the others will default to "No", once enabled as "No" in ViewDidLoad
@property BOOL Answer1Correct;
@property BOOL Answer2Correct;
@property BOOL Answer3Correct;
@property BOOL Answer4Correct;

@property BOOL gameInProgress;

@property NSMutableArray *questionArray;
@property NSMutableArray *usedQuestionArray;
@property NSMutableArray *randomIndexArray;

- (IBAction)answer1Tapped:(id)sender;
- (IBAction)answer2Tapped:(id)sender;
- (IBAction)answer3Tapped:(id)sender;
- (IBAction)answer4Tapped:(id)sender;
- (IBAction)saveTapped:(id)sender;
- (IBAction)quitTapped:(id)sender;
- (IBAction)fightAgainTapped:(id)sender;
- (IBAction)fallBackTapped:(id)sender;

@end

@implementation Deadly100GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.questionArray = [NSMutableArray new];
    self.usedQuestionArray = [NSMutableArray new];
    self.randomIndexArray = [NSMutableArray new];
    
    self.questionArray = [NSMutableArray arrayWithArray:[self convertedQuestionArray]];
    
    //This will set/reset the game back to the beginning state of 6 lives and "0" score
    //Creating the IF Statement here prevents the game from constantly resetting while playing
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"savedGame"])
    {
        self.scoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"savedScore"];
        self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"savedScore"]];
        self.livesNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"savedLives"];
        [self lifeImagesRemaining];
        
        NSArray *tempArray = [NSArray arrayWithArray:[self readArrayWithCustomObjFromUserDefaults:@"usedIndexNumber"]];
        NSArray *descendingTempArray = [[[tempArray sortedArrayUsingSelector:@selector(compare:)]reverseObjectEnumerator]allObjects];
        NSLog(@"Used Index Numbers: %@", descendingTempArray);
        
//        for (NSInteger i=0; i<[descendingTempArray count]; i++)
//        {
//            NSNumber *indexNumber = [descendingTempArray objectAtIndex:i];
//            [self.usedQuestionArray addObject:[self.questionArray objectAtIndex:[indexNumber integerValue]]];
//            [self.questionArray removeObjectAtIndex:[indexNumber integerValue]];
//        }
        //TODO: Change code below back to the uncommented above oncwe more than 100 questions have been coded for game
        if ([descendingTempArray count] < [self.questionArray count])
        {
            for (NSInteger i=0; i<[descendingTempArray count]; i++)
            {
                NSNumber *indexNumber = [descendingTempArray objectAtIndex:i];
                [self.usedQuestionArray addObject:[self.questionArray objectAtIndex:[indexNumber integerValue]]];
                [self.questionArray removeObjectAtIndex:[indexNumber integerValue]];
            }
        } else
        {
            [self randomQuestion];
        }
        
        NSLog(@"New Question Count: %li", (unsigned long)[self.questionArray count]);
        
        
    } else if ([[NSUserDefaults standardUserDefaults]boolForKey:@"newGame"])
    {
        self.livesNumber = 6;
        self.scoreNumber = 0;
        self.gameInProgress = YES;
        
    } else if (self.gameInProgress == NO)
    {
        self.livesNumber = 6;
        self.scoreNumber = 0;
        self.gameInProgress = YES;
    }
    
    self.backgroundImage.image = [UIImage imageNamed:@"deadly background"];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayImage.image = [UIImage imageNamed:@"weapons one"];
    self.gameLostImage.image = [UIImage imageNamed:@"battle lost"];
    self.gameLostImage.hidden = YES;
    self.gameWonImage.image = [UIImage imageNamed:@"game won"];
    self.gameWonImage.hidden = YES;
    self.overlayButtonContainer.hidden = YES;
    [self.fightAgainButton setTitle:@"FIGHT\nAGAIN" forState:UIControlStateNormal];
    [self.fallBackButton setTitle:@"FALL\nBACK" forState:UIControlStateNormal];
    
    //[self swordSwipe];
    
    self.life1.image = [UIImage imageNamed:@"shield small"];
    self.life2.image = [UIImage imageNamed:@"shield small"];
    self.life3.image = [UIImage imageNamed:@"shield small"];
    self.life4.image = [UIImage imageNamed:@"shield small"];
    self.life5.image = [UIImage imageNamed:@"shield small"];
    self.life6.image = [UIImage imageNamed:@"shield small"];
    
    self.middleContainer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    self.scoreLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    
    //Fixes self.scoreLabel font problem on iPhone 4s.
    if (self.view.frame.size.width == 320)
    {
        [self.scoreLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:25.0]];
    }
    
    //Creates top border for self.middleContainer
    CGFloat borderWidth = 2;
    UIView *topBorder = [UIView new];
    topBorder.backgroundColor = [UIColor whiteColor];
    [topBorder setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    topBorder.frame = CGRectMake(0, 0, self.middleContainer.frame.size.width, borderWidth);
    [self.middleContainer addSubview:topBorder];
    
    //Creates bottom border for self.middleContainer
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor whiteColor];
    [bottomBorder setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    bottomBorder.frame = CGRectMake(0, self.middleContainer.frame.size.height, self.middleContainer.frame.size.width, borderWidth);
    [self.middleContainer addSubview:bottomBorder];
    
    //[self createImageViewBorderWidth:1.0 forArray:[self imageViewArray]];
    [self buttonBackgroundColor:[self buttonArray]];
    [self createButtonBorderWidth:1.0 forArray:[self buttonArray]];
    [self buttonCornerRadius:8.0 forArray:[self buttonArray]];
    [self centerButtonText:[self buttonArray]];
    
    self.saveButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.saveButton.layer.borderWidth = 1;
    //3 lines below: Text fits in button space for different phone sizes
    self.saveButton.titleLabel.numberOfLines = 1;
    self.saveButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.saveButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    self.quitButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.quitButton.layer.borderWidth = 1;
    
    self.saveButton.layer.cornerRadius = 10;
    self.quitButton.layer.cornerRadius = 10;
    
    //Set these BOOLs to "NO" so that you only have to change the correct answer BOOL in the Category methods.
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
    [self roundTimer];
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)buttonBackgroundColor:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        
    }
    
}

-(void)createButtonBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = width;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

-(void)buttonCornerRadius:(NSInteger)number forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.cornerRadius = number;
    }
}

-(void)centerButtonText:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

-(void)createImageViewBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIImageView *view in array)
    {
        view.layer.borderWidth = width;
        view.layer.borderColor = [UIColor blackColor].CGColor;
    }
    
}

-(NSArray *)imageViewArray
{
    NSArray *lives = @[self.life1, self.life2, self.life3, self.life4, self.life5, self.life6];
    return lives;
    
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.answer1Button, self.answer2Button, self.answer3Button, self.answer4Button, self.fightAgainButton, self.fallBackButton];
    return buttons;
}

-(void)roundTimer
{
    self.seconds = 2;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(roundCountdown)
                                                userInfo:nil
                                                 repeats:YES];
    
}

-(void)roundCountdown
{
    self.seconds --;
    
    self.overlayImage.image = [UIImage imageNamed:@"weapons one"];
    
    if (self.seconds == 1)
    {
        [self swordSwipe];
    }
    if (self.seconds == 0)
    {
        [self randomQuestion];
        
        self.overlayView.alpha = 1.0;
        [self overlayFadeOut];
    }
    
}

-(void)overlayFadeOut
{
    [UIView animateWithDuration:0.75
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.overlayView.alpha = 0;
                         
                     }
                     completion:nil];
    
}

-(void)overlayFadeIn
{
    [UIView animateWithDuration:0.75
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.overlayView.alpha = 1;
                         
                     }
                     completion:nil];
    
}

-(void)gameLostFadeIn
{
    self.gameLostImage.hidden = NO;
    [UIView animateWithDuration:0.75
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.overlayView.alpha = 1;
                         
                     }
                     completion:nil];
    
}

-(void)gameWonFadeIn
{
    self.gameWonImage.hidden = NO;
    [UIView animateWithDuration:0.75
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.overlayView.alpha = 1;
                         
                     }
                     completion:nil];
    
}

-(void)randomQuestion
{
    //If self.questionArray has more than "zero" items, a random item is selected
    //The random item is placed in self.usedQuestionArray and REMOVED from self.questionArray
    if ([self.questionArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.questionArray count];
        
        NSLog(@"Random Index: %li", (long)self.randomIndex);
        NSLog(@"Initial Count: %li", (unsigned long)[self.questionArray count]);
        
        SEL selector = [[self.questionArray objectAtIndex:self.randomIndex] pointerValue];
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
        
        [self.randomIndexArray addObject:[NSNumber numberWithInteger:self.randomIndex]];
        [self.usedQuestionArray addObject:[self.questionArray objectAtIndex:self.randomIndex]];
        [self.questionArray removeObjectAtIndex:self.randomIndex];
        
        //If self.questionArray has "zero" items, it is repopulated by the itmes in self.usedQuestionArray
        if ([self.questionArray count] == 0)
        {
            //The self.questionArray is populated with the items in self.usedQuestionArray
            self.questionArray = [NSMutableArray arrayWithArray:self.usedQuestionArray];
            
            //Then self.usedQuestionArray is cleaned out and ready to be repopulated by self.questionArray
            [self.usedQuestionArray removeAllObjects];
        }
        NSLog(@"New Count: %li", (unsigned long)[self.questionArray count]);
    }
    
}

-(void)lifeImagesRemaining
{
    if (self.livesNumber == 5)
    {
        self.life1.hidden = YES;
    }
    if (self.livesNumber == 4)
    {
        self.life1.hidden = YES;
        self.life2.hidden = YES;
    }
    if (self.livesNumber == 3)
    {
        self.life1.hidden = YES;
        self.life2.hidden = YES;
        self.life3.hidden = YES;
    }
    if (self.livesNumber == 2)
    {
        self.life1.hidden = YES;
        self.life2.hidden = YES;
        self.life3.hidden = YES;
        self.life4.hidden = YES;
    }
    if (self.livesNumber == 1)
    {
        self.life1.hidden = YES;
        self.life2.hidden = YES;
        self.life3.hidden = YES;
        self.life4.hidden = YES;
        self.life5.hidden = YES;
    }
}

-(void)restoreLives
{
    self.life1.hidden = NO;
    self.life2.hidden = NO;
    self.life3.hidden = NO;
    self.life4.hidden = NO;
    self.life5.hidden = NO;
    self.life6.hidden = NO;
}
 
-(void)rightAnswer
{
    self.scoreNumber = self.scoreNumber + 1;
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.scoreNumber];
    
    //The BOOLs need to be reset after each question.
    //If not, when a correct answer is pressed, that button stays as "YES".
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
    if (self.scoreNumber == 2)
    {
        self.overlayImage.hidden = YES;
        self.gameLostImage.hidden = YES;
        [self gameWonFadeIn];
        [self crowdCheering];
        
        self.overlayButtonContainer.hidden = NO;
    }
    
}

-(void)wrongAnswer
{
    self.livesNumber = self.livesNumber - 1;
    
    [self gunShot];
    
    //The BOOLs need to be reset after each question.
    //If not, when a correct answer is pressed, that button stays as "YES".
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
    if (self.livesNumber == 5)
    {
        self.life1.hidden = YES;
    }
    if (self.livesNumber == 4)
    {
        self.life2.hidden = YES;
    }
    if (self.livesNumber == 3)
    {
        self.life3.hidden = YES;
    }
    if (self.livesNumber == 2)
    {
        self.life4.hidden = YES;
    }
    if (self.livesNumber == 1)
    {
        self.life5.hidden = YES;
    }
    if (self.livesNumber == 0)
    {
        self.life6.hidden = YES;
        self.overlayImage.hidden = YES;
        self.gameWonImage.hidden = YES;
        [self gameLostFadeIn];
        [self maleScreaming];

        self.overlayButtonContainer.hidden = NO;
    }
    
}

-(void)gunShot
{
    // Construct URL to sound file
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"gun shot"
                                              withExtension:@"mp3"];
    // Create audio player object and initialize with URL to sound
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    
    [self.audioPlayer play];
    
}

-(void)swordSwipe
{
    // Construct URL to sound file
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"sword swipe"
                                              withExtension:@"mp3"];
    // Create audio player object and initialize with URL to sound
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    
    [self.audioPlayer play];
    
}

-(void)crowdCheering
{
    // Construct URL to sound file
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"crowd cheering"
                                              withExtension:@"mp3"];
    // Create audio player object and initialize with URL to sound
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    
    [self.audioPlayer play];
    
}

-(void)maleScreaming
{
    // Construct URL to sound file
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"male pain scream"
                                              withExtension:@"mp3"];
    // Create audio player object and initialize with URL to sound
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    
    [self.audioPlayer play];
    
}


- (IBAction)answer1Tapped:(id)sender
{
    if (self.Answer1Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    [self randomQuestion];
    
}

- (IBAction)answer2Tapped:(id)sender
{
    if (self.Answer2Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    [self randomQuestion];
    
}

- (IBAction)answer3Tapped:(id)sender
{
    if (self.Answer3Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    [self randomQuestion];
    
}

- (IBAction)answer4Tapped:(id)sender
{
    if (self.Answer4Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    [self randomQuestion];
    
}

//An NSArray (especially an NSMutableArray) cannot be directly saved to NSUserdefaults
//The NSCoding protocol must be implemented
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSArray *)myArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString *)keyName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    return myArray;
}

- (IBAction)saveTapped:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:@"savedGame"];
    [defaults setInteger:self.scoreNumber forKey:@"savedScore"];
    [defaults setInteger:self.livesNumber forKey:@"savedLives"];
    
    //Converts the contents of the mutableArray to an immutable array
    NSArray *usedIndex = [self.randomIndexArray copy];
    
    //Uses the method to hold the contents of the NSArray in NSUserDefaults
    [self writeArrayWithCustomObjToUserDefaults:@"usedIndexNumber" withArray:usedIndex];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)quitTapped:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"newGame"];
    [defaults setBool:NO forKey:@"savedGame"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)fightAgainTapped:(id)sender
{
    self.overlayButtonContainer.hidden = YES;
    [self overlayFadeOut];
    [self roundCountdown];
    self.livesNumber = 6;
    self.scoreNumber = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.scoreNumber];
    [self restoreLives];
    [self.audioPlayer stop];
    self.gameInProgress = YES;
    
}

- (IBAction)fallBackTapped:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"newGame"];
    [defaults setBool:NO forKey:@"savedGame"];
    [self.audioPlayer stop];
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Question Arrays

-(NSMutableArray *)convertedQuestionArray
{
    NSValue *question1 = [NSValue valueWithPointer:@selector(question_1)];
    NSValue *question2 = [NSValue valueWithPointer:@selector(question_2)];
    NSValue *question3 = [NSValue valueWithPointer:@selector(question_3)];
    NSValue *question4 = [NSValue valueWithPointer:@selector(question_4)];
    NSValue *question5 = [NSValue valueWithPointer:@selector(question_5)];
    NSValue *question6 = [NSValue valueWithPointer:@selector(question_6)];
    NSValue *question7 = [NSValue valueWithPointer:@selector(question_7)];
    NSValue *question8 = [NSValue valueWithPointer:@selector(question_8)];
    NSValue *question9 = [NSValue valueWithPointer:@selector(question_9)];
    NSValue *question10 = [NSValue valueWithPointer:@selector(question_10)];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:question1, question2, question3, question4, question5, question6, question7, question8, question9, question10, nil];
    return array;
}

#pragma mark - Questions

// **** New questions must be added to its "converted array method" AND the mutable array within ****

//Comics ***********

-(void)question_1
{
    self.questionLabel.text = @"What is comic has the first appearance of Superman?";
    [self.answer1Button setTitle:@"Detective Comics #32" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Amazing Stories #15" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Action Comics #1" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Superman #1" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)question_2
{
    self.questionLabel.text = @"In what year did Dick Grayson take up the code name Nightwing?";
    [self.answer1Button setTitle:@"1984" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"1977" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"1980" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"1988" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)question_3
{
    self.questionLabel.text = @"In Post-Crisis storytelling, who inspired Dick Grayson to take the code name Nightwing?";
    [self.answer1Button setTitle:@"Batman" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Starfire" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Speedy" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Superman" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)question_4
{
    self.questionLabel.text = @"Aquaman’s civilian name is … ?";
    [self.answer1Button setTitle:@"Adam Strange" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Arthur Curry" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"George Finn" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Glenn King" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)question_5
{
    self.questionLabel.text = @"Hunter Rose was the first person to assume which code name?";
    [self.answer1Button setTitle:@"Grendel" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Kraven the Hunter" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Deadshot" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Lone Ranger" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)question_6
{
    self.questionLabel.text = @"Detective Comics #140 was the first appearance of which character?";
    [self.answer1Button setTitle:@"Joker" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Catwoman" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Penguin" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Riddler" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)question_7
{
    self.questionLabel.text = @"Which X-Men villain is not a mutant?";
    [self.answer1Button setTitle:@"Magneto" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Stryfe" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Juggernaut" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Sebastian Shaw" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)question_8
{
    self.questionLabel.text = @"The first incarnation of Firestorm consisted of … ?";
    [self.answer1Button setTitle:@"Hank Hall and Don Hall" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Ronnie Raymand and Martin Stein" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Johnny Storm and Angelica Jones" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Bruce Wayne and Clark Kent" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)question_9
{
    self.questionLabel.text = @"Mirror Master is an arch-enemy of which DC superhero?";
    [self.answer1Button setTitle:@"Flash" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Batman" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Doctor Fate" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Booster Gold" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)question_10
{
    self.questionLabel.text = @"Marvel Comics’ Captain Marvel died from … ?";
    [self.answer1Button setTitle:@"Vampire bite" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Head trauma" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"AIDS complications" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Cancer" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}






















@end
