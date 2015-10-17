//
//  Podcast.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 10/17/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Podcast : NSObject

@property NSString *title;
@property NSString *itunesSummary;
@property NSInteger itunesDuration;
@property NSString *podcastURL;

-(instancetype)initWithTitle: (NSString *)title
                     Summary: (NSString *)itunesSummary
                        Time: (NSInteger)itunesDuration
                         URL: (NSString *)podcastURL;

@end
