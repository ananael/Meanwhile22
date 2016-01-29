//
//  TimeVortexViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/28/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "TimeVortexViewController.h"

@interface TimeVortexViewController ()

@property (weak, nonatomic) IBOutlet UIView *backButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;

@property (weak, nonatomic) IBOutlet UIView *middleContainer;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIButton *comicButton;
@property (weak, nonatomic) IBOutlet UIButton *movieButton;
@property (weak, nonatomic) IBOutlet UIButton *tvButton;
@property (weak, nonatomic) IBOutlet UIButton *gameButton;

@property (weak, nonatomic) IBOutlet UIView *overlayContainer;
@property (weak, nonatomic) IBOutlet UIImageView *overlayImage;
@property (weak, nonatomic) IBOutlet UIView *infoContainer;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIView *overlayButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *noShowButton;


- (IBAction)previousTapped:(id)sender;
- (IBAction)comicTapped:(id)sender;
- (IBAction)movieTapped:(id)sender;
- (IBAction)tvTapped:(id)sender;
- (IBAction)gameTapped:(id)sender;
- (IBAction)closeTapped:(id)sender;
- (IBAction)noShowTapped:(id)sender;



@end

@implementation TimeVortexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper B lite"];
    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    [self createViewBorderWidth:2.0 forArray:[self containerArray]];
    [self createButtonBorderWidth:2.0 forArray:[self buttonArray]];
    
    self.bannerImage.animationImages = [self animationArray];
    self.bannerImage.animationDuration = 1.5;
    self.bannerImage.animationRepeatCount = 0;
    [self.bannerImage startAnimating];
    
    self.bannerImage.layer.borderColor = [UIColor blackColor].CGColor;
    self.bannerImage.layer.borderWidth = 2.0;
    
    self.overlayImage.image = [UIImage imageNamed:@"science nerd"];
    
    self.overlayImage.layer.borderColor = [UIColor blackColor].CGColor;
    self.overlayImage.layer.borderWidth = 2.0;
    
    self.noShowButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.noShowButton.layer.borderWidth = 1.0;
    
    self.overlayContainer.backgroundColor = [UIColor whiteColor];
    
    self.noShowButton.layer.cornerRadius = 8.0;
    self.closeButton.layer.cornerRadius = 8.0;
    
    [self.comicButton setBackgroundImage:[UIImage imageNamed:@"comics button"] forState:UIControlStateNormal];
    [self.gameButton setBackgroundImage:[UIImage imageNamed:@"games button"] forState:UIControlStateNormal];
    [self.movieButton setBackgroundImage:[UIImage imageNamed:@"movies button"] forState:UIControlStateNormal];
    [self.tvButton setBackgroundImage:[UIImage imageNamed:@"tv button"] forState:UIControlStateNormal];
    
    NSString *one = @"I'm a Nerd Genius.";
    NSString *two = @"Are you?";
    NSString *three = @"Correctly answer as many questions as you can in 60 seconds.";
    NSString *four = @"Don't get lost in the Time Vortex!";
    
    self.infoLabel.text = [NSString stringWithFormat:@"%@\n%@\n\n%@\n\n%@", one, two, three, four];
    
    //If it is the first time the user loads this screen OR did NOT click "Do Not Show Again" button,
    //the instruction screen will appear.
    //However, if user did click "Do Not Show Again" button, the instruction screen will not show again.
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"doNotShowVortex"])
    {
        self.overlayContainer.hidden = YES;
        
    } else
    {
        self.overlayContainer.hidden = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createButtonBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = 2.0;
        button.layer.borderColor = [UIColor blackColor].CGColor;
    }
}

-(void)createViewBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIView *view in array)
    {
        view.layer.borderWidth = 2.0;
        view.layer.borderColor = [UIColor blackColor].CGColor;
    }
}

-(NSArray *)animationArray
{
    NSArray *images = @[[UIImage imageNamed:@"banner swirl 01"], [UIImage imageNamed:@"banner swirl 02"], [UIImage imageNamed:@"banner swirl 03"], [UIImage imageNamed:@"banner swirl 04"], [UIImage imageNamed:@"banner swirl 05"], [UIImage imageNamed:@"banner swirl 06"], [UIImage imageNamed:@"banner swirl 07"], [UIImage imageNamed:@"banner swirl 08"], [UIImage imageNamed:@"banner swirl 09"], [UIImage imageNamed:@"banner swirl 10"], [UIImage imageNamed:@"banner swirl 11"], [UIImage imageNamed:@"banner swirl 12"], [UIImage imageNamed:@"banner swirl 13"], [UIImage imageNamed:@"banner swirl 14"], [UIImage imageNamed:@"banner swirl 15"], [UIImage imageNamed:@"banner swirl 16"], [UIImage imageNamed:@"banner swirl 17"], [UIImage imageNamed:@"banner swirl 18"], [UIImage imageNamed:@"banner swirl 19"], [UIImage imageNamed:@"banner swirl 20"], [UIImage imageNamed:@"banner swirl 21"], [UIImage imageNamed:@"banner swirl 22"],[UIImage imageNamed:@"banner swirl 23"], [UIImage imageNamed:@"banner swirl 24"]];
    return images;
    
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.previousButton, self.comicButton, self.movieButton, self.tvButton, self.gameButton];
    return buttons;
}

-(NSArray *)containerArray
{
    NSArray *containers = @[self.ambienceContainer, self.middleContainer, self.overlayContainer, self.infoContainer];
    return containers;
}

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)comicTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"CategorySaved"];
}

- (IBAction)movieTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"CategorySaved"];
}

- (IBAction)tvTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:3 forKey:@"CategorySaved"];
}

- (IBAction)gameTapped:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setInteger:4 forKey:@"CategorySaved"];
}

- (IBAction)closeTapped:(id)sender
{
    self.overlayContainer.hidden = YES;
}

- (IBAction)noShowTapped:(id)sender
{
    self.overlayContainer.hidden = YES;
    
    //Sets the BOOL to "YES" and activates the IF Statement in ViewDidLoad
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"doNotShowVortex"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}






@end
