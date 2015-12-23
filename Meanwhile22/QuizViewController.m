//
//  QuizViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/27/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@property (weak, nonatomic) IBOutlet UIView *backButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;

@property (weak, nonatomic) IBOutlet UIView *middleContainer;
@property (weak, nonatomic) IBOutlet UIView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIButton *timeVortexButton;
@property (weak, nonatomic) IBOutlet UIButton *deadly100Button;

- (IBAction)timeVortexTapped:(id)sender;
- (IBAction)deadly100Tapped:(id)sender;
- (IBAction)previousTapped:(id)sender;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper texture A"];
    self.bannerImage.image = [UIImage imageNamed:@"quiz smasher banner"];
    
    self.ambienceContainer.layer.borderColor = [UIColor blackColor].CGColor;
    self.ambienceContainer.layer.borderWidth = 2.0;
    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    self.bannerImage.layer.borderColor = [UIColor blackColor].CGColor;
    self.bannerImage.layer.borderWidth = 2.0;
    
    self.middleContainer.layer.borderColor = [UIColor blackColor].CGColor;
    self.middleContainer.layer.borderWidth = 2.0;
    
    [self.timeVortexButton setBackgroundImage:[UIImage imageNamed:@"time vortex"] forState:UIControlStateNormal];
    [self.deadly100Button setBackgroundImage:[UIImage imageNamed:@"deadly 100 button"] forState:UIControlStateNormal];
    
    [self createButtonBorderWidth:2.0 forArray:[self buttonArray]];
    
    NSString *one = @"Think you know more than the Meanwhile 22 Pages Later hosts?";
    NSString *two = @"Are you the Ultimate Know-It-All?";
    NSString *three = @"Choose Time Vortex and see how many questions you can answer in 90 seconds.";
    NSString *four = @"Or, try your luck with The Deadly 100, where every wrong answer costs you a life.";
    self.instructionLabel.text = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n\n%@", one, two, three, four];
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    
    
    
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

-(void)createButtonBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = 2.0;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        
    }
    
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.previousButton, self.timeVortexButton, self.deadly100Button];
    return buttons;
    
}


- (IBAction)timeVortexTapped:(id)sender
{
    
    
}

- (IBAction)deadly100Tapped:(id)sender
{
    
    
}

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}























@end
