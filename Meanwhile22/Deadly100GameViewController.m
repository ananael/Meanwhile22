//
//  Deadly100GameViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 12/13/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "Deadly100GameViewController.h"

@interface Deadly100GameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

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

//The "Answer" BOOLs work by setting the correct anser to "Yes"
//And the others will default to "No", once enabled as "No" in ViewDidLoad
@property BOOL Answer1Correct;
@property BOOL Answer2Correct;
@property BOOL Answer3Correct;
@property BOOL Answer4Correct;

@property BOOL gameInProgress;

- (IBAction)answer1Tapped:(id)sender;
- (IBAction)answer2Tapped:(id)sender;
- (IBAction)answer3Tapped:(id)sender;
- (IBAction)answer4Tapped:(id)sender;
- (IBAction)saveTapped:(id)sender;
- (IBAction)quitTapped:(id)sender;


@end

@implementation Deadly100GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //This will set/reset the game back to the beginning state of 6 lives and "0" score
    //Creating the IF Statement here prevents the game from constantly resetting while playing
    if (self.gameInProgress == NO)
    {
        self.livesNumber = 6;
        self.scoreNumber = 0;
        self.gameInProgress = YES;
    }
    
    //Creates top border for self.middleContainer
    CGFloat borderWidth = 2;
    UIView *topBorder = [UIView new];
    topBorder.backgroundColor = [UIColor blackColor];
    [topBorder setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    topBorder.frame = CGRectMake(0, 0, self.middleContainer.frame.size.width, borderWidth);
    [self.middleContainer addSubview:topBorder];
    
    //Creates bottom border for self.middleContainer
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor blackColor];
    [bottomBorder setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    bottomBorder.frame = CGRectMake(0, self.middleContainer.frame.size.height, self.middleContainer.frame.size.width, borderWidth);
    [self.middleContainer addSubview:bottomBorder];
    
    [self buttonBackgroundColor:[self buttonArray]];
    [self createButtonBorderWidth:1.0 forArray:[self buttonArray]];
    [self buttonCornerRadius:8.0 forArray:[self buttonArray]];
    [self centerButtonText:[self buttonArray]];
    
    self.saveButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.saveButton.layer.borderWidth = 1;
    
    self.saveButton.layer.cornerRadius = 10;
    self.quitButton.layer.cornerRadius = 10;
    
    //Set these BOOLs to "NO" so that you only have to change the correct answer BOOL in the Category methods.
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;

    
    self.questionLabel.text = @"How much wood would a woodchuck chuck if a woodchuck would chuck wood?";
    
    
    
    
    
    
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

- (IBAction)saveTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)quitTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}






















@end
