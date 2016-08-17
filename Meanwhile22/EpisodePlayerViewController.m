//
//  EpisodePlayerViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/19/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "EpisodePlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PodcastParser.h"

@interface EpisodePlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *backButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *ambienceContainer;

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UIImageView *avImage;
@property (weak, nonatomic) IBOutlet UIView *timeContainer;
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timerImage;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UIView *middleContainer;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *backward30;
@property (weak, nonatomic) IBOutlet UIButton *forward30;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *soFarLabel;
@property (weak, nonatomic) IBOutlet UIView *scrollContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property AVPlayerViewController *videoPlayerController;
@property AVPlayerItem *playerItem;
@property AVPlayer *player;

@property BOOL isScrubbing;

@property NSTimer *elapsedTimer;
@property NSTimer *remainingTimer;
@property NSTimer *sliderTimer;

- (IBAction)sliderActivated:(id)sender;
- (IBAction)previousTapped:(id)sender;
- (IBAction)pauseTapped:(id)sender;
- (IBAction)playTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)backward30Tapped:(id)sender;
- (IBAction)forward30Tapped:(id)sender;







@end

@implementation EpisodePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"paper C lite"];
    [self.pauseButton setBackgroundImage:[UIImage imageNamed:@"pause button"] forState:UIControlStateNormal];
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"play button"] forState:UIControlStateNormal];
    [self.stopButton setBackgroundImage:[UIImage imageNamed:@"stop button@2X"] forState:UIControlStateNormal];
    [self.backward30 setBackgroundImage:[UIImage imageNamed:@"time back button"] forState:UIControlStateNormal];
    [self.forward30 setBackgroundImage:[UIImage imageNamed:@"time forward button"] forState:UIControlStateNormal];
    
    self.bannerImage.image = [UIImage imageNamed:@"robot banner"];
    self.avImage.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"wave 1"], [UIImage imageNamed:@"wave 2"], [UIImage imageNamed:@"wave 3"], [UIImage imageNamed:@"wave 4"], [UIImage imageNamed:@"wave 5"], [UIImage imageNamed:@"wave 6"], [UIImage imageNamed:@"wave 7"], [UIImage imageNamed:@"wave 8"], nil];
    self.avImage.animationDuration = 1.5;
    self.avImage.animationRepeatCount = 0;
    [self.avImage startAnimating];
    
    self.ambienceContainer.layer.borderColor = [UIColor blackColor].CGColor;
    self.ambienceContainer.layer.borderWidth = 2.0;
    self.ambienceContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    
    self.bottomContainer.layer.borderColor = [UIColor blackColor].CGColor;
    self.bottomContainer.layer.borderWidth = 2.0;
    
    self.soFarLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.soFarLabel.layer.borderWidth = 2.0;
    
    [self createImageBorderWidth:2.0 forArray:[self imageViewArray]];
    [self createButtonBorderWidth:2.0 forArray:[self buttonArray]];
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.titleLabel.text = self.episodeTitle;
    self.summaryLabel.text = [NSString stringWithFormat:@"\n%@", self.episode.itunesSummary];
    
    //This code is needed when the app is run for the first time (or re-installed)
    //Because it handles the situation when there is no savedProgress
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"savedProgress"])
    {
        //NSLog(@"Brand new Launch !!");
        
        NSURL *episodeURL = [NSURL URLWithString:self.episode.podcastURL];
        self.playerItem = [[AVPlayerItem alloc]initWithURL:episodeURL];
        self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
        
        [self.player play];
    }
    
    //If there is savedProgress (and the same podcast url is choen), the audio begins where it left off
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"savedProgress"])
    {
        NSString *savedUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"savedPodcast"];
        NSInteger savedSeconds = [[NSUserDefaults standardUserDefaults] integerForKey:@"savedTime"];
        CMTime storedTime = CMTimeMake(savedSeconds, 1);
        
        //NSLog(@"Stored Time: %ld", (long)savedSeconds);
        
        if ([savedUrl isEqualToString:self.episode.podcastURL])
        {
            //NSLog(@"PODCAST MATCH !!");
            
            NSURL *episodeURL = [NSURL URLWithString:savedUrl];
            self.playerItem = [[AVPlayerItem alloc]initWithURL:episodeURL];
            self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
            
            [self.player seekToTime:storedTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
            
            [self.player play];
            
        } else
        {
            //NSLog(@"NOPE. DIFFERENT PODCASTS!");
            
            //This routine starts if the player has been previously used but a different podcast is chosen
            NSURL *episodeURL = [NSURL URLWithString:self.episode.podcastURL];
            self.playerItem = [[AVPlayerItem alloc]initWithURL:episodeURL];
            self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
            
            [self.player play];
        }
    };
    
    //relates to the time labels
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];
    
    self.elapsedTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(displayTimeElapsed)
                                                userInfo:nil
                                                 repeats:YES];
    
    self.remainingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                          target:self
                                                        selector:@selector(displayTimeRemaining)
                                                        userInfo:nil
                                                         repeats:YES];
    
    [self.slider setThumbImage:[UIImage imageNamed:@"blue rocket"] forState:UIControlStateNormal];
    
    //Sets slider max value to audio duration
    self.slider.maximumValue = [self formattedTimeFromString:self.episode.itunesDuration];
    self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                        target:self
                                                      selector:@selector(updateSlider)
                                                      userInfo:nil
                                                       repeats:YES];
    
    
    
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

-(void)createImageBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIImageView *image in array)
    {
        image.layer.borderWidth = 2.0;
        image.layer.borderColor = [UIColor blackColor].CGColor;
    }
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.previousButton, self.pauseButton, self.playButton, self.stopButton, self.backward30, self.forward30];
    return buttons;
}

-(NSArray *)imageViewArray
{
    NSArray *images = @[self.bannerImage, self.avImage, self.timerImage];
    return images;
    
}

// *** Shown in elapsedTimeLabel ***
- (void)displayTimeElapsed
{
    NSInteger dur = CMTimeGetSeconds([self.player currentTime]);
    
    NSString *currentTime = [self formattedTime:dur];
    self.elapsedTimeLabel.text = currentTime;
}

// *** Shown in durationLabel ***
-(void)displayTimeRemaining
{
    NSInteger dur = CMTimeGetSeconds([self.player currentTime]);
    //NSInteger remaining = (self.episode.itunesDuration - dur);
    NSInteger remaining = ([self formattedTimeFromString:self.episode.itunesDuration] - dur);
    
    NSString *remainingTime = [self formattedTime:remaining];
    self.durationLabel.text = remainingTime;
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    [self.elapsedTimer invalidate];
    self.elapsedTimer = nil;
    
    [self.player seekToTime:kCMTimeZero];
}

//Use if the parsed duration is in seconds
- (NSString *)formattedTime:(NSInteger)duration
{
    //Asks player for current time
    //The number returned is actually a double, but this stores it as an NSUinteger
    
    NSInteger time = duration;
    
    NSInteger hours = (time/3600);
    NSInteger minutes = (time/60) % 60;
    NSInteger seconds = time % 60;
    
    NSString *format = @"%02i:%02i:%02i";
    
    return [NSString stringWithFormat:format, hours, minutes, seconds];
}

//Use if the parsed duration is in hours/minutes/seconds
- (NSInteger)formattedTimeFromString:(NSString *)duration
{
    
    NSString *timeString = duration;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm:ss";
    NSDate *timeDate = [formatter dateFromString:timeString];
    
    formatter.dateFormat = @"hh";
    NSInteger hours = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat = @"mm";
    NSInteger minutes = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat = @"ss";
    NSInteger seconds = [[formatter stringFromDate:timeDate] intValue];
    
    NSInteger timeInSeconds = seconds + minutes * 60 + hours * 3600;
    return timeInSeconds;
}



- (IBAction)previousTapped:(id)sender
{
    [self.player pause];
    
    //Saves progress in case user leaves playerVC but returns and clicks on same podcast episode
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger seconds = CMTimeGetSeconds([self.player currentTime]);
    [defaults setBool:YES forKey:@"savedProgress"];
    [defaults setObject:self.episode.podcastURL forKey:@"savedPodcast"];
    [defaults setInteger:seconds forKey:@"savedTime"];
    //NSLog(@"Show the current SAVED time: %f", CMTimeGetSeconds([self.player currentTime]));
    
    [self.player seekToTime:kCMTimeZero];
    self.player = nil;
    [self.avImage stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Player Controls

-(void)updateSlider
{
    NSInteger dur = CMTimeGetSeconds([self.player currentTime]);
    self.slider.value = dur;
}

- (IBAction)sliderActivated:(id)sender
{
    [self.player pause];
    CMTime newTime = CMTimeMakeWithSeconds(self.slider.value, 1);
    [self.player seekToTime:newTime];
    
    //Ths code smooths the slider action by delaying play action until the streaming is ready
    [self.player prerollAtRate:1.0 completionHandler:^(BOOL finished) {
        if (finished) {
            [self.player play];
        }
    }];
}

- (IBAction)pauseTapped:(id)sender
{
    [self.player pause];
    [self.avImage stopAnimating];
    
    //Extra "savedProgress" location, in case user pauses then closes app without engaging "previous" button
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger seconds = CMTimeGetSeconds([self.player currentTime]);
    [defaults setBool:YES forKey:@"savedProgress"];
    [defaults setObject:self.episode.podcastURL forKey:@"savedPodcast"];
    [defaults setInteger:seconds forKey:@"savedTime"];
    //NSLog(@"Show the current PAUSE time: %f", CMTimeGetSeconds([self.player currentTime]));
}

- (IBAction)playTapped:(id)sender
{
    
    [self.player play];
    [self.avImage startAnimating];
}

- (IBAction)stopTapped:(id)sender
{
    [self.player pause];
    
    [self.player seekToTime:kCMTimeZero];
    [self.avImage stopAnimating];
}

- (IBAction)backward30Tapped:(id)sender
{
    [self.player pause];
    
    NSInteger current = CMTimeGetSeconds([self.player currentTime]);
    
    CMTime backTime = CMTimeMakeWithSeconds(current-30, 1);
    
    [self.player seekToTime:backTime];
    [self.player play];
    [self.avImage startAnimating];
}

- (IBAction)forward30Tapped:(id)sender
{
    [self.player pause];
    
    NSInteger current = CMTimeGetSeconds([self.player currentTime]);
    
    CMTime backTime = CMTimeMakeWithSeconds(current+30, 1);
    
    [self.player seekToTime:backTime];
    [self.player play];
    [self.avImage startAnimating];
}


@end
