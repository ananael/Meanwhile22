//
//  EpisodePlayerViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/19/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "EpisodePlayerViewController.h"
#import "MissingEpisodeSummaries.h"

@interface EpisodePlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *backButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;

@property (weak, nonatomic) IBOutlet UILabel *episodeDetail;

@property AVPlayerViewController *videoPlayerController;
@property AVPlayerItem *playerItem;
@property AVPlayer *player;

@property NSTimer *timer;
@property NSTimer *timeRemaining;

- (IBAction)previousTapped:(id)sender;






@end

@implementation EpisodePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    [self showMissingSummaries];
    
    self.episodeDetail.text = [NSString stringWithFormat:@"%@\n\n%@", self.self.episodeTitle, self.episode.itunesSummary];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showMissingSummaries
{
    MissingEpisodeSummaries *missing = [MissingEpisodeSummaries new];
    
    if ([self.self.episodeTitle isEqualToString:@"Episode 52"])
    {
        self.episode.itunesSummary = [missing episode52];
    } else if ([self.episodeTitle isEqualToString:@"Episode 51"])
    {
        self.episode.itunesSummary = [missing episode51];
    } else if ([self.episodeTitle isEqualToString:@"Episode 50"])
    {
        self.episode.itunesSummary = [missing episode50];
    } else if ([self.episodeTitle isEqualToString:@"Episode 49"])
    {
        self.episode.itunesSummary = [missing episode49];
    } else if ([self.episodeTitle isEqualToString:@"Episode 47"])
    {
        self.episode.itunesSummary = [missing episode47];
    } else if ([self.episodeTitle isEqualToString:@"Episode 46"])
    {
        self.episode.itunesSummary = [missing episode46];
    } else if ([self.episodeTitle isEqualToString:@"Episode 45"])
    {
        self.episode.itunesSummary = [missing episode45];
    } else if ([self.episodeTitle isEqualToString:@"Episode 44"])
    {
        self.episode.itunesSummary = [missing episode44];
    } else if ([self.episodeTitle isEqualToString:@"Episode 43"])
    {
        self.episode.itunesSummary = [missing episode43];
    } else if ([self.episodeTitle isEqualToString:@"Episode 42"])
    {
        self.episode.itunesSummary = [missing episode42];
    } else if ([self.episodeTitle isEqualToString:@"Episode 41"])
    {
        self.episode.itunesSummary = [missing episode41];
    } else if ([self.episodeTitle isEqualToString:@"Episode 40"])
    {
        self.episode.itunesSummary = [missing episode40];
    } else if ([self.episodeTitle isEqualToString:@"Episode 39"])
    {
        self.episode.itunesSummary = [missing episode39];
    } else if ([self.episodeTitle isEqualToString:@"Episode 38"])
    {
        self.episode.itunesSummary = [missing episode38];
    } else if ([self.episodeTitle isEqualToString:@"Episode 37"])
    {
        self.episode.itunesSummary = [missing episode37];
    } else if ([self.episodeTitle isEqualToString:@"Episode 36"])
    {
        self.episode.itunesSummary = [missing episode36];
    } else if ([self.episodeTitle isEqualToString:@"Episode 35"])
    {
        self.episode.itunesSummary = [missing episode35];
    } else if ([self.episodeTitle isEqualToString:@"Episode 34"])
    {
        self.episode.itunesSummary = [missing episode34];
    } else if ([self.episodeTitle isEqualToString:@"Episode 33"])
    {
        self.episode.itunesSummary = [missing episode33];
    } else if ([self.episodeTitle isEqualToString:@"Episode 32"])
    {
        self.episode.itunesSummary = [missing episode32];
    } else if ([self.episodeTitle isEqualToString:@"Episode 31"])
    {
        self.episode.itunesSummary = [missing episode31];
    } else if ([self.episodeTitle isEqualToString:@"Episode 30"])
    {
        self.episode.itunesSummary = [missing episode30];
    } else if ([self.episodeTitle isEqualToString:@"Episode 29"])
    {
        self.episode.itunesSummary = [missing episode29];
    } else if ([self.episodeTitle isEqualToString:@"Episode 28"])
    {
        self.episode.itunesSummary = [missing episode28];
    } else if ([self.episodeTitle isEqualToString:@"Episode 27"])
    {
        self.episode.itunesSummary = [missing episode27];
    } else if ([self.episodeTitle isEqualToString:@"Episode 26"])
    {
        self.episode.itunesSummary = [missing episode26];
    } else if ([self.episodeTitle isEqualToString:@"Episode 25"])
    {
        self.episode.itunesSummary = [missing episode25];
    } else if ([self.episodeTitle isEqualToString:@"Episode 24"])
    {
        self.episode.itunesSummary = [missing episode24];
    } else if ([self.episodeTitle isEqualToString:@"Episode 23"])
    {
        self.episode.itunesSummary = [missing episode23];
    } else if ([self.episodeTitle isEqualToString:@"Episode 22"])
    {
        self.episode.itunesSummary = [missing episode22];
    } else if ([self.episodeTitle isEqualToString:@"Episode 21"])
    {
        self.episode.itunesSummary = [missing episode21];
    }
    
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
