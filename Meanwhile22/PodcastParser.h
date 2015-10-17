//
//  PodcastParser.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 10/17/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PodcastParser : NSObject<NSXMLParserDelegate>

@property NSMutableArray *podcastArray;

-(instancetype)initWithArray: (NSMutableArray *)podcastArray;

-(void)parseXMLFile;


@end
