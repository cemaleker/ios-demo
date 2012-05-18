//
//  CETwitterDataSource.m
//  ios-demo
//
//  Created by Bal on 5/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETwitterDataSource.h"
#import "CETwitterModel.h"
#import "CETweet.h"
#import "CETableTweetItem.h"
#import "CETableTweetItemCell.h"

@implementation CETwitterDataSource

- (id) init {
    TTDINFO(@"Data source init");
    self = [super init];
    
    if (self) {
        _twitterModel = [[CETwitterModel alloc] init];
    }
    
    return self;
}

- (void) dealloc {
    TT_RELEASE_SAFELY(_twitterModel);
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (CETweet* tweet in _twitterModel.tweets) {
        [items addObject: [TTTableMessageItem itemWithTitle:tweet.user 
                                                    caption:tweet.user_name 
                                                       text:tweet.tweet_text 
                                                  timestamp:tweet.created 
                                                   imageURL:tweet.profile_image_url 
                                                        URL:@""]];
    }
    
    self.items = items;
    TT_RELEASE_SAFELY(items);
}

- (id<TTModel>)model {
    return _twitterModel;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//-(Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
//    return [super tableView:tableView cellClassForObject:object];
//
//}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (_twitterModel.updatingLocation) {
        return @"Retrieving location data...";
    } else if (reloading) {
        return @"Updating tweets...";
    } else {
        return @"Loading tweets...";
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return @"No tweeets found nearby";
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return @"Sorry, there was an error loading tweets.";
}


@end
