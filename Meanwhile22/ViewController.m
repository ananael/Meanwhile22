//
//  ViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 10/17/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "ViewController.h"

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
    
    [[self.twitterButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [[self.facebookButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    
    //TODO: remove
//    self.ambienceContainer.layer.borderColor = [UIColor blackColor].CGColor;
//    self.ambienceContainer.layer.borderWidth = 2.0;
//    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    self.logoImage.layer.borderColor = [UIColor blackColor].CGColor;
    self.logoImage.layer.borderWidth = 2.0;
    
    self.episodeButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.episodeButton.layer.borderWidth = 2.0;
    [[self.episodeButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    
    self.quizButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.quizButton.layer.borderWidth = 2.0;
    [[self.quizButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    
    self.hostButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.hostButton.layer.borderWidth = 2.0;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
