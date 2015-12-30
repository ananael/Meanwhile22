//
//  Deadly100ViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/28/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "Deadly100ViewController.h"

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
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper texture A"];
    self.bannerImage.image = [UIImage imageNamed:@"deadly 100 banner"];
    self.overlayImage.image = [UIImage imageNamed:@"warrior large"];
    
    self.ambienceContainer.layer.borderColor = [UIColor blackColor].CGColor;
    self.ambienceContainer.layer.borderWidth = 2.0;
    
    self.previousButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.previousButton.layer.borderWidth = 2.0;
    
    [self createViewBorderWidth:2.0 forArray:[self containerArray]];
    
    self.noShowButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.noShowButton.layer.borderWidth = 1.0;
    
    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    self.overlayContainer.backgroundColor = [UIColor whiteColor];
    
    self.noShowButton.layer.cornerRadius = 8.0;
    self.closeButton.layer.cornerRadius = 8.0;
    
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)createViewBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIView *view in array)
    {
        view.layer.borderWidth = 2.0;
        view.layer.borderColor = [UIColor blackColor].CGColor;
        
    }
    
}

-(NSArray *)containerArray
{
    NSArray *containers = @[self.ambienceContainer, self.overlayContainer, self.infoContainer];
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
