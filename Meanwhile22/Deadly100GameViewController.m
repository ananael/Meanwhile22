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
#import "MethodsCache.h"

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
    
    self.questionArray = [NSMutableArray arrayWithArray:[self questionStringArray]];
    
    //This will set/reset the game back to the beginning state of 6 lives and "0" score
    //Creating the IF Statement here prevents the game from constantly resetting while playing
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"savedGame"])
    {
        self.scoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"savedScore"];
        self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"savedScore"]];
        self.livesNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"savedLives"];
        [self lifeImagesRemaining];
        
        //To remove the previously used questions from a saved game
        //The array of randomly chosen index numbers in arranged in descending order
        //Then the questions are removed from the questionArray
        NSArray *tempArray = [NSArray arrayWithArray:[self readArrayWithCustomObjFromUserDefaults:@"usedIndexNumber"]];
        NSArray *descendingTempArray = [[[tempArray sortedArrayUsingSelector:@selector(compare:)]reverseObjectEnumerator]allObjects];
        NSLog(@"Used Index Numbers: %@", descendingTempArray);
        
        for (NSInteger i=0; i<[descendingTempArray count]; i++)
        {
            NSNumber *indexNumber = [descendingTempArray objectAtIndex:i];
            [self.usedQuestionArray addObject:[self.questionArray objectAtIndex:[indexNumber integerValue]]];
            [self.questionArray removeObjectAtIndex:[indexNumber integerValue]];
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
    
    self.life1.image = [UIImage imageNamed:@"shield small"];
    self.life2.image = [UIImage imageNamed:@"shield small"];
    self.life3.image = [UIImage imageNamed:@"shield small"];
    self.life4.image = [UIImage imageNamed:@"shield small"];
    self.life5.image = [UIImage imageNamed:@"shield small"];
    self.life6.image = [UIImage imageNamed:@"shield small"];
    
    self.middleContainer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    self.scoreLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    self.scoreLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.scoreLabel.layer.borderWidth = 1;
    self.scoreLabel.layer.cornerRadius = 8;
    
    //Fixes self.scoreLabel font problem on iPhone 4s.
    if (self.view.frame.size.width == 320)
    {
        [self.scoreLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:20.0]];
    }
    
    [self questionBorders];
    
    MethodsCache *methods = [MethodsCache new];
    [methods createButtonBorderWidth:1.0 color:[UIColor whiteColor] forArray:[self buttonArray]];
    [methods createButtonBorderWidth:1.0 color:[UIColor blackColor] forArray:[self otherButtonArray]];
    
    [self buttonBackgroundColor:[self buttonArray]];
    [self buttonCornerRadius:8.0 forArray:[self buttonArray]];
    [self centerButtonText:[self buttonArray]];
    
    //Use 3 lines below: Text fits in button space for different phone sizes
    self.saveButton.titleLabel.numberOfLines = 1;
    self.saveButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.saveButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
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


// ***** UPDATE THIS ARRAY whenever new questions are added to DeadlyQuestions class *****
-(NSArray *)questionStringArray
{
    NSArray *questions = @[@"question001", @"question002", @"question003", @"question004", @"question005", @"question006", @"question007", @"question008", @"question009", @"question010", @"question011", @"question012", @"question013", @"question014", @"question015", @"question016", @"question017", @"question018", @"question019", @"question020", @"question021", @"question022", @"question023", @"question024", @"question025", @"question026", @"question027", @"question028", @"question029", @"question030", @"question031", @"question032", @"question033", @"question034", @"question035", @"question036", @"question037", @"question038", @"question039", @"question040", @"question041", @"question042", @"question043", @"question044", @"question045", @"question046", @"question047", @"question048", @"question049", @"question050", @"question051", @"question052", @"question053", @"question054", @"question055", @"question056", @"question057", @"question058", @"question059", @"question060", @"question061", @"question062", @"question063", @"question064", @"question065", @"question066", @"question067", @"question068", @"question069", @"question070", @"question071", @"question072", @"question073", @"question074", @"question075", @"question076", @"question077", @"question078", @"question079", @"question080", @"question081", @"question082", @"question083", @"question084", @"question085", @"question086", @"question087", @"question088", @"question089", @"question090", @"question091", @"question092", @"question093", @"question094", @"question095", @"question096", @"question097", @"question098", @"question099", @"question100", @"question101", @"question102", @"question103", @"question104", @"question105", @"question106", @"question107", @"question108", @"question109", @"question110", @"question111", @"question112", @"question113", @"question114", @"question115", @"question116", @"question117", @"question118", @"question119", @"question120", @"question121", @"question122", @"question123", @"question124", @"question125", @"question126", @"question127", @"question128", @"question129", @"question130", @"question131", @"question132", @"question133", @"question134", @"question135", @"question136", @"question137", @"question138", @"question139", @"question140", @"question141", @"question142", @"question143", @"question144", @"question145", @"question146", @"question147", @"question148", @"question149", @"question150", @"question151", @"question152", @"question153", @"question154", @"question155", @"question156", @"question157", @"question158", @"question159", @"question160", @"question161", @"question162", @"question163", @"question164", @"question165", @"question166", @"question167", @"question168", @"question169", @"question170", @"question171", @"question172", @"question173", @"question174", @"question175", @"question176", @"question177", @"question178", @"question179", @"question180", @"question181", @"question182", @"question183", @"question184", @"question185", @"question186", @"question187", @"question188", @"question189", @"question190", @"question191", @"question192", @"question193", @"question194", @"question195", @"question196", @"question197", @"question198", @"question199", @"question200", @"question201", @"question202", @"question203", @"question204", @"question205", @"question206", @"question207", @"question208", @"question209", @"question210", @"question211", @"question212", @"question213", @"question214", @"question215", @"question216", @"question217", @"question218", @"question219", @"question220", @"question221", @"question222", @"question223", @"question224", @"question225", @"question226", @"question227", @"question228", @"question229", @"question230", @"question231", @"question232", @"question233", @"question234", @"question235", @"question236", @"question237", @"question238", @"question239", @"question240", @"question241", @"question242", @"question243", @"question244", @"question245", @"question246", @"question247", @"question248", @"question249", @"question250", @"question251", @"question252", @"question253", @"question254", @"question255", @"question256", @"question257", @"question258", @"question259", @"question260", @"question261", @"question262", @"question263", @"question264", @"question265", @"question266", @"question267", @"question268", @"question269", @"question270", @"question271", @"question272", @"question273", @"question274", @"question275", @"question276", @"question277", @"question278", @"question279", @"question280", @"question281", @"question282", @"question283", @"question284", @"question285", @"question286", @"question287", @"question288", @"question289", @"question290", @"question291", @"question292", @"question293", @"question294", @"question295", @"question296", @"question297", @"question298", @"question299", @"question300"];
    return questions;
}

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

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.answer1Button, self.answer2Button, self.answer3Button, self.answer4Button, self.quitButton, self.fightAgainButton, self.fallBackButton];
    return buttons;
}

-(NSArray *)otherButtonArray
{
    NSArray *buttons = @[self.saveButton];
    return buttons;
}

-(void)questionBorders
{
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
    
    DeadlyQuestions *question = [DeadlyQuestions new];
    
    if ([self.questionArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.questionArray count];
        
        //NSLog(@"Index Chosen: %li", (long)self.randomIndex);
        //NSLog(@"Available Array Count: %li", (unsigned long)[self.questionArray count]);
        
        SEL selector = NSSelectorFromString([self.questionArray objectAtIndex:self.randomIndex]);
        IMP imp = [question methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(question, selector);
        
        self.questionLabel.text = question.question;
        [self.answer1Button setTitle:question.buttonA forState:UIControlStateNormal];
        [self.answer2Button setTitle:question.buttonB forState:UIControlStateNormal];
        [self.answer3Button setTitle:question.buttonC forState:UIControlStateNormal];
        [self.answer4Button setTitle:question.buttonD forState:UIControlStateNormal];
        
        if ([question.correctAnswer isEqualToString:@"A"])
        {
            self.Answer1Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"B"])
        {
            self.Answer2Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"C"])
        {
            self.Answer3Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"D"])
        {
            self.Answer4Correct = YES;
            
        }
        
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
        //NSLog(@"Current Array Count: %li", (unsigned long)[self.questionArray count]);
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

    [self answerBoolsReset];
    
    if (self.scoreNumber == 100)
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
    
    [self answerBoolsReset];
    
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

-(void)answerBoolsReset
{
    //The BOOLs need to be reset after each question.
    //If not, when a correct answer is pressed, that button stays as "YES".
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
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

-(void)saveAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROGRESSED SAVED!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)quitAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Continue without saving?" message:@"Progress will be lost." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"newGame"];
        [defaults setBool:NO forKey:@"savedGame"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Go Back" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:first];
    [alert addAction:second];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
    
    [self saveAlert];
    
}

- (IBAction)quitTapped:(id)sender
{
    [self quitAlert];
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








@end
