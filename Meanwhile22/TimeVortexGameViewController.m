//
//  TimeVortexGameViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/30/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "TimeVortexGameViewController.h"

//The "Answer" BOOLs work by setting the correct anser to "Yes"
//And the others will default to "No", once enabled as "No" in ViewDidLoad
BOOL Answer1Correct;
BOOL Answer2Correct;
BOOL Answer3Correct;
BOOL Answer4Correct;

BOOL GameInProgress;

@interface TimeVortexGameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIView *overlayContainer;
@property (weak, nonatomic) IBOutlet UIImageView *overlayImage;
@property (weak, nonatomic) IBOutlet UIView *resultContainer;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;
@property (weak, nonatomic) IBOutlet UIView *startContainer;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UIView *overlayButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *nextCategoryButton;

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UIView *middleContainer;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIButton *answer1Button;
@property (weak, nonatomic) IBOutlet UIButton *answer2Button;
@property (weak, nonatomic) IBOutlet UIButton *answer3Button;
@property (weak, nonatomic) IBOutlet UIButton *answer4Button;

@property NSTimer *openingTimer;
@property NSInteger openingSeconds;

@property NSTimer *gameTimer;
@property NSInteger gameSeconds;

@property NSMutableArray *questionArray;
@property NSMutableArray *usedQuestionArray;
@property NSInteger randomIndex;

- (IBAction)answer1Tapped:(id)sender;
- (IBAction)answer2Tapped:(id)sender;
- (IBAction)answer3Tapped:(id)sender;
- (IBAction)answer4Tapped:(id)sender;
- (IBAction)playAgainTapped:(id)sender;
- (IBAction)nextCategoryTapped:(id)sender;





@end

@implementation TimeVortexGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.topContainer.backgroundColor = [UIColor clearColor];
    
    self.middleContainer.backgroundColor = [UIColor clearColor];
    self.middleContainer.layer.borderColor = [UIColor yellowColor].CGColor;
    self.middleContainer.layer.borderWidth = 2.0;
    self.middleContainer.layer.cornerRadius = 8.0;
    
    [self buttonBackgroundColor:[self buttonArray]];
    [self createButtonBorderWidth:2.0 forArray:[self buttonArray]];
    [self buttonCornerRadius:8.0 forArray:[self buttonArray]];
    [self centerButtonText:[self buttonArray]];
    
    
    //Set these BOOLs to "NO" so that you only have to change the correct answer BOOL in the Category methods.
    Answer1Correct = NO;
    Answer2Correct = NO;
    Answer3Correct = NO;
    Answer4Correct = NO;
    
    self.startLabel.text = @"START!";
    
    self.openingSeconds = 4;
    self.openingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(labelCountdown)
                                                userInfo:nil
                                                 repeats:YES];
    
    self.questionArray = [NSMutableArray new];
    self.usedQuestionArray = [NSMutableArray new];
    
    
    
    
    
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
        button.backgroundColor = [UIColor clearColor];
        
    }
    
}

-(void)createButtonBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = 2.0;
        button.layer.borderColor = [UIColor yellowColor].CGColor;
        
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
    NSArray *buttons = @[self.answer1Button, self.answer2Button, self.answer3Button, self.answer4Button];
    return buttons;
    
}

-(void)labelFade
{
    [UIView animateWithDuration:0.75
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.startLabel.alpha = 0;
                         
                     }
                     completion:nil];
    
}

-(void)labelCountdown
{
    
    self.openingSeconds --;
    
    if (self.openingSeconds == 3)
    {
        self.startLabel.alpha = 1;
        [self labelFade];
        
    }
    
    if (self.openingSeconds == 2)
    {
        self.startLabel.text = @"THE!";
        self.startLabel.alpha = 1;
        [self labelFade];
    }
    
    if (self.openingSeconds == 1)
    {
        self.startLabel.text = @"VORTEX!";
        self.startLabel.alpha = 1;
        [self labelFade];
    }
    
    if (self.openingSeconds == 0)
    {
        
        [self.openingTimer invalidate];
        self.overlayContainer.hidden = YES;
        
        [self gameTime];
    }
    
}


-(void)gameCountdown
{
    self.gameSeconds --;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%li", (long)self.gameSeconds];
    
    
    if (self.gameSeconds == 30)
    {
        self.timerLabel.textColor = [UIColor yellowColor];
        
    }
    
    if (self.gameSeconds == 15)
    {
        self.timerLabel.textColor = [UIColor redColor];
        
    }
    
    if (self.gameSeconds == 0)
    {
        [self.gameTimer invalidate];
        self.timerLabel.adjustsFontSizeToFitWidth = YES;
        self.timerLabel.text = @"TIME'S UP!";
        NSLog(@"DONE!!");
    }
    
}

- (void)gameTime
{
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(gameCountdown)
                                           userInfo:nil
                                            repeats:YES];
    
    self.gameSeconds = 90;
    
}





- (IBAction)answer1Tapped:(id)sender
{
    
    
}

- (IBAction)answer2Tapped:(id)sender
{
    
    
}

- (IBAction)answer3Tapped:(id)sender
{
    
    
}

- (IBAction)answer4Tapped:(id)sender
{
    
    
}

- (IBAction)playAgainTapped:(id)sender
{
    
    
}

- (IBAction)nextCategoryTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)Film001
{
    self.questionLabel.text = @"Gone With The - ?";
    [self.answer1Button setTitle:@"Wind" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Dinosaurs" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Empire" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Electoral Vote" forState:UIControlStateNormal];
    Answer1Correct = YES;
    
}

-(void)Film002
{
    self.questionLabel.text = @"What was Rosebud in Citizen Kane?";
    [self.answer1Button setTitle:@"Manor" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Dance Club" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Sled" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Vodka Brand" forState:UIControlStateNormal];
    Answer3Correct = YES;
    
}

-(void)Film003
{
    self.questionLabel.text = @"Who played Dorothy in The Wizard of Oz?";
    [self.answer1Button setTitle:@"Tom Cruise" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Tina Fey" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Elke Sommers" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Judt Garland" forState:UIControlStateNormal];
    Answer4Correct = YES;
    
}

-(void)Film004
{
    self.questionLabel.text = @"Which movie did NOT star Tom Cuise?";
    [self.answer1Button setTitle:@"Mission Impossible" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Next" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Top Gun" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Risky Business" forState:UIControlStateNormal];
    Answer2Correct = YES;
    
}



















@end
