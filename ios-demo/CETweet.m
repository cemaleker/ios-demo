//
//  CETweet.m
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETweet.h"


@implementation CETweet

@synthesize 
    created = _created, 
    user = _user, 
    user_id = _user_id, 
    user_name = _user_name, 
    location = _location, 
    tweet_source = _tweet_source, 
    tweet_id = _tweet_id, 
    tweet_text = _tweet_text,
    profile_image_url = _profile_image_url;

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if(self) {
        _user = [[NSString stringWithFormat:@"@%@", [dictionary objectForKey: @"from_user"]] retain];
        _user_id = [[dictionary objectForKey: @"from_user_id_str"] copy];
        _user_name = [[dictionary objectForKey: @"from_user_name"] copy];
        _tweet_source = [[dictionary objectForKey: @"source"] copy];
        _tweet_id = [[dictionary objectForKey: @"id_str"] copy];
        _tweet_text = [[dictionary objectForKey: @"text"] copy];
        _profile_image_url = [[dictionary objectForKey: @"profile_image_url"] copy];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale: usLocale];
        [usLocale release], usLocale = nil;
        
        [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        _created = [[dateFormatter dateFromString: [dictionary objectForKey:@"created_at"]] retain];
        [dateFormatter release], dateFormatter = nil;
        
        NSDictionary* geoObject = [dictionary objectForKey: @"geo"];
        if([geoObject isKindOfClass: [NSDictionary class]]) {
            NSAssert([geoObject isKindOfClass: [NSDictionary class]], @"Geo Object must be a dictionary");
            NSArray* coordinates = [geoObject objectForKey:@"coordinates"];
            NSAssert([coordinates isKindOfClass: [NSArray class]], @"Coordinates must be an array");
            _location = [[CLLocation alloc] initWithLatitude: [[coordinates objectAtIndex:0] floatValue] longitude:[[coordinates objectAtIndex: 1] floatValue]];
        }
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Tweet from: %@, %@", self.user, self.tweet_text]; 
}

- (void)dealloc {
    [_created release], _created = nil;
    [_user release], _user = nil;
    [_user_id release], _user_id = nil;
    [_user_name release], _user_name = nil;
    [_location release], _location = nil;
    [_tweet_source release], _tweet_source = nil;
    [_tweet_id release], _tweet_id = nil;
    [_tweet_text release], _tweet_text = nil;
    [_profile_image_url release], _profile_image_url = nil;
    
    [super dealloc];
}

@end
