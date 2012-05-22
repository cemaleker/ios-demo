//
//  CETweetViewController.h
//  ios-demo
//
//  Created by Bal on 5/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <HPUtils/HPUtils.h>

typedef enum {
    CETweetViewControllerLocation,
    CETweetViewControllerLoadingTweets,
    CETweetViewControllerReady,
    CETweetViewControllerLoadingMore,
    CETweetViewControllerLoadingFailed,
    CETweetViewControllerRefreshFailed,
    CETweetViewControllerLocationFailed,
} CETweetViewControllerLoadingState;


@interface CETweetViewController : HPImageLoadingTableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
    @private
    UISearchBar *_searchBar;
    UISearchDisplayController *__searchDisplayController;
    NSString *_nextPageQuery;
    NSString *_refreshQuery;
    NSError *_lastError;
    UILabel *_loadingLabel;
    NSArray *_tweets;
    CLLocation *_currentLocation;
    BOOL _hasNoMore;
    CETweetViewControllerLoadingState _state;
}

@end
