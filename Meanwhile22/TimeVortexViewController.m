//
//  TimeVortexViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/28/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "TimeVortexViewController.h"
#import "VortexBannerAnimationView.h"
#import "MethodsCache.h"

@interface TimeVortexViewController ()

@property (weak, nonatomic) IBOutlet UIView *backButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;


@property (weak, nonatomic) IBOutlet VortexBannerAnimationView *bannerAnimation;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;


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
    
    MethodsCache *methods = [MethodsCache new];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self containerArray]];
    [methods createImageBorderWidth:2.0 color:[UIColor blackColor] forArray:[self imageArray]];
    [methods createButtonBorderWidth:1.0 color:[UIColor blackColor] forArray:[self otherButtonArray]];
    
    self.bannerAnimation.backgroundColor = [methods colorWithHexString:@"FFF2AA" alpha:1.0];
    [self.bannerAnimation addVortexBannerAnimation];
    
    self.overlayImage.image = [UIImage imageNamed:@"science nerd"];
    
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

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.previousButton, self.comicButton, self.movieButton, self.tvButton, self.gameButton];
    return buttons;
}

-(NSArray *)containerArray
{
    NSArray *containers = @[self.ambienceContainer, self.middleContainer, self.overlayContainer, self.infoContainer, self.bannerAnimation];
    return containers;
}

-(NSArray *)imageArray
{
    NSArray *images = @[self.overlayImage];
    return images;
}

-(NSArray *)otherButtonArray
{
    NSArray *buttons = @[self.noShowButton];
    return buttons;
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
