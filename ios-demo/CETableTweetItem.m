//
//  CETableTweetItem.m
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETableTweetItem.h"


@implementation CETableTweetItem

@synthesize 
    user = _user,
    userName = _userName,
    tweetBody = _tweetBody,
    timestamp = _timestamp,
    imageUrl = _imageUrl;


- (void)dealloc {
    TT_RELEASE_SAFELY(_user);
    TT_RELEASE_SAFELY(_userName);
    TT_RELEASE_SAFELY(_tweetBody);
    TT_RELEASE_SAFELY(_timestamp);
    TT_RELEASE_SAFELY(_imageUrl);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	self = [super initWithCoder:decoder];
    if (self) {
        self.user = [decoder decodeObjectForKey:@"user"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.tweetBody = [decoder decodeObjectForKey:@"tweetBody"];
        self.timestamp = [decoder decodeObjectForKey:@"timestamp"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
    [super encodeWithCoder:encoder];
    if(self.user) {
        [encoder encodeObject: self.user forKey:@"user"];
    }
    
    if(self.userName) {
        [encoder encodeObject: self.userName forKey:@"userName"];
    }
    
    if(self.tweetBody) {
        [encoder encodeObject: self.tweetBody forKey:@"tweetBody"];
    }
    
    if(self.timestamp) {
        [encoder encodeObject: self.timestamp forKey:@"timestamp"];
    }
    
    if(self.imageUrl) {
        [encoder encodeObject: self.imageUrl forKey:@"imageUrl"];
    }
}


@end
