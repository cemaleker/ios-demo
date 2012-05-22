//
//  CETweetViewController.m
//  ios-demo
//
//  Created by Bal on 5/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETweetViewController.h"
#import "CEAPIManager.h"
#import "CETweet.h"
#import "CETweetCell.h"

@interface CETweetViewController (PrivateMethods) 
- (void)setLoadingState: (CETweetViewControllerLoadingState)state;
- (void)searchTweetsWithQuery:(NSString *)query withLocation:(CLLocation *)location;
- (void)loadMoreTweetsWithLastQuery;
@end

static NSString * kDefaultSearchQuery = @"ankara";
static NSString * kSearchRadius = @"10km";
static NSString * kDefaultRequestIdentifier = @"CETweetViewControllerRequest";

@implementation CETweetViewController

- (id)init {
    self = [super init];
    
    if(self) {
        _hasNoMore = NO;
    }
    
    return self;
}

- (void) searchTweetsWithQuery:(NSString *)query withLocation:(CLLocation *)location {
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             query, @"q",
                             [NSString stringWithFormat:@"%f,%f,%@", 
                              location.coordinate.latitude, 
                              location.coordinate.longitude, 
                              kSearchRadius], @"geocode",
                             nil];
    [_tweets release], _tweets = nil;
    [CEAPIManager searchTweetsWithOptions:options 
                           withIdentifier: kDefaultRequestIdentifier 
                          completionBlock:^(id resources, NSError *error) {
        if(error != nil) {
            [_lastError release], _lastError = [error retain];
            if(error.domain != kHPErrorDomain && error.code != kHPRequestConnectionCancelledErrorCode) {
                [self setLoadingState:CETweetViewControllerLoadingFailed];
            } else {
                [self setLoadingState:CETweetViewControllerReady];
            }
            return;
        }
        
        NSDictionary *response = (NSDictionary *)resources;
        NSAssert([response isKindOfClass: [NSDictionary class]], @"Response must be dictionary");
        
        NSString *nextPageQuery = (NSString*)[response objectForKey:@"next_page"];
        [_nextPageQuery release], _nextPageQuery = [nextPageQuery copy];
          if(_nextPageQuery == nil) {
              _hasNoMore = YES;
          }
        
        NSString *refreshQuery = (NSString*)[response objectForKey:@"refresh_url"];
        NSAssert([refreshQuery isKindOfClass: [NSString class]], @"Refresh query must be a string");
        [_refreshQuery release], _refreshQuery = [refreshQuery copy];

        NSArray *results = (NSArray *)[response objectForKey: @"results"];
        NSAssert([results isKindOfClass: [NSArray class]], @"Results must be an array");
        
        NSMutableArray* tweets = [[NSMutableArray alloc] initWithCapacity: [results count]];
        
        for (NSDictionary *tweetResult in results) {
            NSAssert([tweetResult isKindOfClass: [NSDictionary class]], @"Result must be a dictionary");
            CETweet *tweet = [[CETweet alloc] initWithDictionary: tweetResult];
            [tweets addObject: tweet];
            [tweet release], tweet = nil;
        }
        
        _tweets = [[NSArray alloc] initWithArray: tweets];
        [tweets release], tweets = nil;
        [__searchDisplayController.searchResultsTableView reloadData];
        [self setLoadingState: CETweetViewControllerReady];
    }];
}

#pragma mark - Private

- (void) loadMoreTweets {
    if(_hasNoMore) {
        return;
    }
    
    [self setLoadingState:CETweetViewControllerLoadingMore];
    [CEAPIManager searchTweetsWithQuery:_nextPageQuery withIdentifier:kDefaultRequestIdentifier completionBlock:^(id resources, NSError *error) {
        if(error != nil) {
            [_lastError release], _lastError = [error retain];
            if(error.domain != kHPErrorDomain && error.code != kHPRequestConnectionCancelledErrorCode) {
                [self setLoadingState:CETweetViewControllerLoadingFailed];
            } else {
                [self setLoadingState:CETweetViewControllerReady];
            }
            return;
        } 

        NSDictionary *response = (NSDictionary*)resources;
        NSLog(@"%@", response);
        
        NSString *nextPageQuery = (NSString*)[response objectForKey:@"next_page"];
        [_nextPageQuery release], _nextPageQuery = [nextPageQuery copy];
        
        if(_nextPageQuery == nil) {
            _hasNoMore = YES;
        }

        NSString *refreshQuery = (NSString*)[response objectForKey:@"refresh_url"];
        [_refreshQuery release], _refreshQuery = [refreshQuery copy];
        
        NSArray *results = (NSArray*)[response objectForKey:@"results"];
            
        NSMutableArray *tweets =  [[NSMutableArray alloc] initWithArray: _tweets];       
        for(NSDictionary *tweetResult in results) {
            CETweet *tweet = [[CETweet alloc] initWithDictionary:tweetResult];
            [tweets addObject:tweet];
            [tweet release], tweet = nil;
        }
        
        [_tweets release], _tweets = [[NSArray alloc] initWithArray:tweets];
        [tweets release], tweets = nil;
        [__searchDisplayController.searchResultsTableView reloadData];
        [self setLoadingState:CETweetViewControllerReady];
    }];
}

- (void) refreshTweets {
    [self setLoadingState:CETweetViewControllerLoadingMore];
        [CEAPIManager searchTweetsWithQuery:_refreshQuery 
                             withIdentifier:kDefaultRequestIdentifier 
                            completionBlock:^(id resources, NSError *error) {
            if(error != nil) {
                [_lastError release], _lastError = [error retain];
                if(error.domain != kHPErrorDomain && error.code != kHPRequestConnectionCancelledErrorCode) {
                    [self setLoadingState:CETweetViewControllerLoadingFailed];
                } else {
                    [self setLoadingState:CETweetViewControllerReady];
                }
                return;
            }
            NSDictionary *response = (NSDictionary*)resources;
            [_refreshQuery release], _refreshQuery = [(NSString*)[response objectForKey:@"refresh_url"] copy];
            [_nextPageQuery release], _nextPageQuery = [(NSString*)[response objectForKey:@"next_page"] copy];
            if(_nextPageQuery == nil) {
                _hasNoMore = YES;
            }

            NSArray *results = (NSArray*)[response objectForKey:@"results"];
            
            NSMutableArray *tweets = [[NSMutableArray alloc] initWithArray: _tweets];
            for (NSDictionary *tweetResult in results) {
                CETweet *tweet = [[CETweet alloc] initWithDictionary:tweetResult];
                [tweets addObject:tweet];
                [tweet release], tweet = nil;
            }
            
            [_tweets release], _tweets = [[NSArray alloc] initWithArray:tweets];
            [tweets release], tweets = nil;
            [__searchDisplayController.searchResultsTableView reloadData];
            [self setLoadingState:CETweetViewControllerReady];
        }];
}

- (void)setLoadingState:(CETweetViewControllerLoadingState)state {
    static NSInteger activityIndicatorTag = 123;
    if(_loadingLabel == nil) {
        CGFloat activityIndicatorLeftMargin = 20.0;
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator setTag:activityIndicatorTag];
        [activityIndicator sizeToFit];
        [activityIndicator startAnimating];
        [activityIndicator setAutoresizingMask: (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
        [activityIndicator setFrame:CGRectMake(activityIndicatorLeftMargin, 0, activityIndicator.frame.size.width, activityIndicator.frame.size.height)];

        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, activityIndicator.frame.size.height)];
        [_loadingLabel setBackgroundColor: [UIColor clearColor]];
        [_loadingLabel setTextColor: [UIColor grayColor]];
        [_loadingLabel setTextAlignment: UITextAlignmentCenter];
        [_loadingLabel addSubview: activityIndicator];
        [activityIndicator release], activityIndicator = nil;
        [_loadingLabel setFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        [self.tableView setTableFooterView: _loadingLabel];
    }
    
    _state = state;
    switch (state) {
        case CETweetViewControllerLocation:
            [_loadingLabel setText:@"Finding location..."];
            break;
        case CETweetViewControllerLoadingTweets:
            [_loadingLabel setText:@"Loading nearby tweets..."];
            break;
        case CETweetViewControllerLoadingMore:
            [_loadingLabel setText:@"Loading more nearby tweets..."];
        case CETweetViewControllerReady:
            if(_hasNoMore) {
                [_loadingLabel setText:@"That's all."];
                [(UIActivityIndicatorView*)[_loadingLabel viewWithTag:activityIndicatorTag] stopAnimating];
            } else {
                [_loadingLabel setText:@""];
            }
            
            break;
        case CETweetViewControllerRefreshFailed:
        case CETweetViewControllerLoadingFailed:
            [_loadingLabel setText:@"Error while loading tweets!"];
            break;
        case CETweetViewControllerLocationFailed:
            [_loadingLabel setText:@"Error while finding location!"];
            break;
        default:
            break;
    }
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle: @"Tweets Around You"];
    [self endLoadingWithSuccess:YES animated:NO];
    
    [[HPLocationManager sharedManager] getLocationWithExecutionBlock:^(CLLocation *location, NSError *error) {
        if(error == nil && location != nil) {
            _currentLocation = [location retain];
            [self searchTweetsWithQuery:kDefaultSearchQuery withLocation:location];
            [self setLoadingState: CETweetViewControllerLoadingTweets];
        } else if (error != nil) {
            [_lastError release], _lastError = [error retain];
            [self setLoadingState: CETweetViewControllerLocationFailed];
        }
        
        _searchBar = [[UISearchBar alloc] init];
        [_searchBar sizeToFit];
        [_searchBar setDelegate:self];
        [self.tableView setTableHeaderView: _searchBar];
        
        __searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        
        [__searchDisplayController.searchResultsTableView setTableFooterView: _loadingLabel];
        [__searchDisplayController setSearchResultsDataSource:self];
        [__searchDisplayController setSearchResultsDelegate:self];
        [__searchDisplayController setActive: YES];
        [__searchDisplayController.searchBar setText:kDefaultSearchQuery];
    }];
    
    [self setLoadingState: CETweetViewControllerLocation];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tweets == nil ? 0 : [_tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    CETweetCell *cell = (CETweetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CETweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    CETweet *tweet = [_tweets objectAtIndex: indexPath.row];
    [cell setTweet:tweet];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CETweet *tweet = [_tweets objectAtIndex: indexPath.row];
    return [CETweetCell cellHeightForTweet:tweet forTableview:tableView];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL stateCheck = _state != CETweetViewControllerLoadingTweets 
        && _state != CETweetViewControllerLoadingMore && !_hasNoMore;
    
    if(_tweets != nil && [_tweets count] > 0 && stateCheck && indexPath.row == ([_tweets count] - 1)) {
        [self loadMoreTweets];
        }
}

#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searchTweetsWithQuery:searchText withLocation:_currentLocation];
}

#pragma mark - Memory Management

- (void)dealloc {
    [_nextPageQuery release], _nextPageQuery = nil;
    [_refreshQuery release], _refreshQuery = nil;
    [_searchBar release], _searchBar = nil;
    [__searchDisplayController release], __searchDisplayController = nil;
    [_lastError release], _lastError = nil;
    [_loadingLabel release], _currentLocation = nil;
    [_currentLocation release], _currentLocation = nil;
    [_tweets release], _tweets = nil;
    [super dealloc];
}


@end
