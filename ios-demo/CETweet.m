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
        _user_id = [[dictionary objectForKey: @"from_user_id_str"] retain];
        _user_name = [[dictionary objectForKey: @"from_user_name"] retain];
        _tweet_source = [[dictionary objectForKey: @"source"] retain];
        _tweet_id = [[dictionary objectForKey: @"id_str"] retain];
        _tweet_text = [[dictionary objectForKey: @"text"] retain];
        _profile_image_url = [[dictionary objectForKey: @"profile_image_url"] retain];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
        [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
        _created = [[dateFormatter dateFromString: [dictionary objectForKey:@"created_at"]] retain];
        TT_RELEASE_SAFELY(dateFormatter);
        
        NSDictionary* geoObject = [dictionary objectForKey: @"geo"];
        if([geoObject isKindOfClass: [NSDictionary class]]) {
            TTDASSERT([geoObject isKindOfClass: [NSDictionary class]]);
            NSArray* coordinates = [geoObject objectForKey:@"coordinates"];
            TTDASSERT([coordinates isKindOfClass: [NSArray class]]);
            _location = [[CLLocation alloc] initWithLatitude: [[coordinates objectAtIndex:0] floatValue] longitude:[[coordinates objectAtIndex: 1] floatValue]];
        }
    }
    
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_created);
    TT_RELEASE_SAFELY(_user);
    TT_RELEASE_SAFELY(_user_id);
    TT_RELEASE_SAFELY(_user_name);
    TT_RELEASE_SAFELY(_location);
    TT_RELEASE_SAFELY(_tweet_source);
    TT_RELEASE_SAFELY(_tweet_id);
    TT_RELEASE_SAFELY(_tweet_text);
    TT_RELEASE_SAFELY(_profile_image_url);

    [super dealloc];
}

@end
