//
//  PodcastParser.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 10/17/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "PodcastParser.h"
#import "Podcast.h"

@interface PodcastParser ()

@property NSXMLParser *parser;
@property NSString *element;

//Podcast properties
@property NSString *currentTitle;
@property NSString *currentItunesSummary;
@property NSInteger currentItunesDuration;
@property NSString *currentPodcastURL;

@end

@implementation PodcastParser

- (instancetype)initWithArray:(NSMutableArray *)podcastArray
{
    self = [super init];
    if (self) {
        self.podcastArray = podcastArray;
    }
    return self;
}

-(void)parseXMLFile
{
    //Use the code below if the xml file is available via web page
    NSURL *xmlPath = [[NSURL alloc]initWithString:@"https://feeds.audiometric.io/1574314397"];
    
    self.parser = [[NSXMLParser alloc]initWithContentsOfURL:xmlPath];
    
    //Calls the delegate
    self.parser.delegate = self;
    
    //This starts the parsing process
    [self.parser parse];
    
}

// *** Three main delgeates to employ below ***

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    self.element = elementName;
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.element isEqualToString:@"title"])
    {
        self.currentTitle = string;
    }
    else if ([self.element isEqualToString:@"itunes:summary"])
    {
        self.currentItunesSummary = string;
    }
    else if ([self.element isEqualToString:@"itunes:duration"])
    {
        self.currentItunesDuration = string.integerValue;
    }
    else if ([self.element isEqualToString:@"guid"])
    {
        self.currentPodcastURL = string;
    }
    
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        Podcast *thisPodcast = [[Podcast alloc]initWithTitle:self.currentTitle
                                                     Summary:self.currentItunesSummary
                                                        Time:self.currentItunesDuration
                                                         URL:self.currentPodcastURL];
        
        [self.podcastArray addObject:thisPodcast];
    }
    
    //Clears self.element after each pass through the feed
    self.element = nil;
    
}















@end
