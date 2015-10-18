//
//  ViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 10/17/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "ViewController.h"
#import "Podcast.h"
#import "PodcastParser.h"

@interface ViewController ()

@property NSMutableArray *podcastArray;
@property NSMutableArray *podcastTitles;
@property NSMutableArray *podcastSubtitles;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *midContainer;
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
    
    self.podcastArray = [NSMutableArray new];
    self.podcastTitles = [NSMutableArray new];
    self.podcastSubtitles = [NSMutableArray new];
    
    PodcastParser *episodeParser = [[PodcastParser alloc]initWithArray:self.podcastArray];
    [episodeParser parseXMLFile];
    
    //Iterate through the titles and split the string into 2 parts and add to arrays
    for (NSInteger i=0; i<[self.podcastArray count]; i++)
    {
        Podcast *episode = self.podcastArray[i];
        NSString *originalTitle = episode.title;
        
        //Range is for the first instance of " : "
        NSRange range = [originalTitle rangeOfString:@":"];
        
        //Grabs everything before the range but needs "-1" to remove the " : " from the results
        NSString *episodeTitle = [originalTitle substringToIndex:NSMaxRange(range)-1];
        
        //Grabs everything after the range but needs "+1" to remove the space following " : " from the results
        NSString *episodeSubtitle = [originalTitle substringFromIndex:NSMaxRange(range)+1];
        
        [self.podcastTitles addObject:episodeTitle];
        [self.podcastSubtitles addObject:episodeSubtitle];
        
    }
    
    NSLog(@"%@", self.podcastTitles);
    NSLog(@"%@", self.podcastSubtitles);
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)twitterTapped:(id)sender {
}

- (IBAction)facebookTapped:(id)sender {
}
@end
