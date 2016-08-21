//
//  Deadly100ViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/28/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "Deadly100ViewController.h"
#import "MethodsCache.h"

@interface Deadly100ViewController ()

@property (weak, nonatomic) IBOutlet UIView *backButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIImageView *gameImage;
@property (weak, nonatomic) IBOutlet UIButton *gameButton;

@property (weak, nonatomic) IBOutlet UIView *overlayContainer;
@property (weak, nonatomic) IBOutlet UIImageView *overlayImage;
@property (weak, nonatomic) IBOutlet UIView *infoContainer;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UIView *overlayButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *noShowButton;

- (IBAction)previousTapped:(id)sender;
- (IBAction)gameTapped:(id)sender;
- (IBAction)closeTapped:(id)sender;
- (IBAction)noShowTapped:(id)sender;

@end

@implementation Deadly100ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper A lite"];
    self.bannerImage.image = [UIImage imageNamed:@"deadly 100 banner"];
    self.overlayImage.image = [UIImage imageNamed:@"warrior large"];
    self.gameImage.image = [UIImage imageNamed:@"deadly start"];
    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    MethodsCache *methods = [MethodsCache new];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self containerArray]];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray1]];
    [methods createButtonBorderWidth:1.0 color:[UIColor blackColor] forArray:[self buttonArray2]];
    [methods createButtonBorderWidth:2.0 color:[methods colorWithHexString:@"6E0000" alpha:1.0] forArray:[self buttonArray3]];
    
    self.overlayContainer.backgroundColor = [UIColor whiteColor];
    
    self.noShowButton.layer.cornerRadius = 8.0;
    self.closeButton.layer.cornerRadius = 8.0;
    self.gameButton.layer.cornerRadius = 8.0;
    
    NSString *one = @"The Apostles of the Sphinx are attacking!";
    NSString *two = @"And their questions are deadly.";
    NSString *three = @"You have 6 chances to survive 100 questions.";
    NSString *four = @"You must not fail us ...";
    
    
    self.infoLabel.text = [NSString stringWithFormat:@"%@\n%@\n\n%@\n\n%@", one, two, three, four];
    
    //If it is the first time the user loads this screen OR did NOT click "Do Not Show Again" button,
    //the instruction screen will appear.
    //However, if user did click "Do Not Show Again" button, the instruction screen will not show again.
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"doNotShowDeadly"])
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

-(NSArray *)buttonArray1
{
    NSArray *buttons = @[self.previousButton];
    return buttons;
    
}

-(NSArray *)buttonArray2
{
    NSArray *buttons = @[self.noShowButton];
    return buttons;
    
}

-(NSArray *)buttonArray3
{
    NSArray *buttons = @[self.gameButton];
    return buttons;
    
}

-(NSArray *)containerArray
{
    NSArray *containers = @[self.ambienceContainer, self.topContainer, self.bottomContainer, self.overlayContainer, self.infoContainer];
    return containers;
    
}

- (IBAction)closeTapped:(id)sender
{
    self.overlayContainer.hidden = YES;
}

- (IBAction)noShowTapped:(id)sender
{
    self.overlayContainer.hidden = YES;
    
    //Sets the BOOL to "YES" and activates the ELSE Statement in ViewDidLoad
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"doNotShowDeadly"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)gameTapped:(id)sender
{
    
}
























@end
