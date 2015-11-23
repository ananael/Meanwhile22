//
//  EpisodePlayerViewController.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/19/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodeListViewController.h"
#import "Podcast.h"


@interface EpisodePlayerViewController : UIViewController

@property Podcast *episode;
@property NSString *episodeTitle;
@property NSString *episodeSubtitle;
@property NSArray *podcastArray;

@end
