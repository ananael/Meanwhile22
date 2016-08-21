//
//  ViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 10/17/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "ViewController.h"
#import "MethodsCache.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *midContainer;
@property (weak, nonatomic) IBOutlet UIButton *episodeButton;
@property (weak, nonatomic) IBOutlet UIButton *quizButton;
@property (weak, nonatomic) IBOutlet UIButton *hostButton;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

- (IBAction)twitterTapped:(id)sender;
- (IBAction)facebookTapped:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper B lite"];
    
    self.logoImage.image = [UIImage imageNamed:@"M22 Logo 2016"];
    self.logoImage.layer.borderColor = [UIColor blackColor].CGColor;
    self.logoImage.layer.borderWidth = 2.0;
    
    MethodsCache *methods = [MethodsCache new];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    
    [self.episodeButton setBackgroundImage:[UIImage imageNamed:@"vault of episodes"] forState:UIControlStateNormal];
    [self.quizButton setBackgroundImage:[UIImage imageNamed:@"quiz smasher button"] forState:UIControlStateNormal];
    [self.hostButton setBackgroundImage:[UIImage imageNamed:@"heroic hosts button"] forState:UIControlStateNormal];
    
    [[self.twitterButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [[self.facebookButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.episodeButton, self.quizButton, self.hostButton];
    return buttons;
}

- (IBAction)twitterTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/hashtag/meanwhile22pageslater"]];
    
}

- (IBAction)facebookTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/meanwhille22pageslater/"]];
    
}
@end
