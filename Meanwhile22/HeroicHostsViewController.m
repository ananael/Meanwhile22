//
//  HeroicHostsViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 1/21/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "HeroicHostsViewController.h"
#import "MethodsCache.h"

@interface HeroicHostsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIImageView *comingSoon;
@property (weak, nonatomic) IBOutlet UIView *backButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

- (IBAction)previousTapped:(id)sender;

@end

@implementation HeroicHostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper C lite"];
    self.bannerImage.image = [UIImage imageNamed:@"heroic banner"];
    self.comingSoon.image = [UIImage imageNamed:@"coming soon"];
    
    MethodsCache *methods = [MethodsCache new];
    [methods createButtonBorderWidth:2.0 color:[UIColor blackColor] forArray:[self buttonArray]];
    [methods createViewBorderWidth:2.0 color:[UIColor blackColor] forArray:[self containerArray]];
    
    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.previousButton];
    return buttons;
}

-(NSArray *)containerArray
{
    NSArray *containers = @[self.ambienceContainer, self.topContainer, self.bottomContainer];
    return containers;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



















@end
