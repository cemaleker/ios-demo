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
        TTTableMessageItem *item = [[TTTableMessageItem alloc] init];
        item.title = tweet.user;
        item.caption = tweet.user_name;
        item.text = tweet.tweet_text;
        item.imageURL = tweet.profile_image_url;
        [items addObject: item];
        TT_RELEASE_SAFELY(item);
    }
    
    self.items = items;
    TT_RELEASE_SAFELY(items);
}

- (id<TTModel>)model {
    return _twitterModel;
}

- (void) setModel:(id<TTModel>)model {
    if(model != _twitterModel) {
        TT_RELEASE_SAFELY(_twitterModel);
        _twitterModel = [model retain];
    }
}

- (void)search:(NSString*)text {
    _twitterModel.query = text;
    [_twitterModel search];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
-(Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
    if([object isKindOfClass: [CETableTweetItem class]]) {
        return [CETableTweetItemCell class];
    }
    
    return [super tableView:tableView cellClassForObject:object];

}

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
