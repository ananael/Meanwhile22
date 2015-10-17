//
//  Podcast.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 10/17/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "Podcast.h"

@implementation Podcast

- (instancetype)initWithTitle:(NSString *)title
                      Summary:(NSString *)itunesSummary
                         Time:(NSInteger)itunesDuration
                          URL:(NSString *)podcastURL
{
    self = [super init];
    if (self) {
        self.title = title;
        self.itunesSummary = itunesSummary;
        self.itunesDuration = itunesDuration;
        self.podcastURL = podcastURL;
    }
    return self;
}

@end
