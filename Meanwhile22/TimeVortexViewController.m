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

- (IBAction)previousTapped:(id)sender;


@end

@implementation TimeVortexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper texture A"];
    
    self.ambienceContainer.layer.borderColor = [UIColor blackColor].CGColor;
    self.ambienceContainer.layer.borderWidth = 2.0;
    
    self.previousButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.previousButton.layer.borderWidth = 2.0;
    
    
    
    
    
    
    
    
    
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

- (IBAction)previousTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}























@end
