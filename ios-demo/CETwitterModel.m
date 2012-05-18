//
//  CETwitterModel.m
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETwitterModel.h"
#import "extThree20JSON/extThree20JSON.h"
#import "CETweet.h"

@implementation CETwitterModel

@synthesize query = _query, tweets = _tweets, updatingLocation = _updatingLocation;

#pragma mark Request

- (NSString *) requestUrl {
    return [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@&geocode=%f,%f,%dkm", 
            self.query,
            _currentLocation.coordinate.latitude, 
            _currentLocation.coordinate.longitude, 
            1]; 
}

- (void) sendRequest  {
    TTDINFO(@"Request URL: %@", [self requestUrl]);
    TTURLRequest *request = [TTURLRequest requestWithURL: [self requestUrl] delegate:self];
    [request setResponse: [[[TTURLJSONResponse alloc] init] autorelease]];
    [request setCachePolicy: TTURLRequestCachePolicyNoCache];
    [request send];
    TTDINFO(@"Request sent");
}

- (void) search {
    if(self.updatingLocation) {
        return;
    }
    [self sendRequest];
}

#pragma mark Location 

- (CLLocation*)currentLocation {
    return _currentLocation;
}

- (void) setCurrentLocation: (CLLocation *) location {
    [_currentLocation autorelease];
    _currentLocation = [location retain];
}

- (NSError *)locationUpdateError {
    return _locationUpdateError;
}

- (void)setLocationUpdateError: (NSError *)error {
    [_locationUpdateError autorelease];
    _locationUpdateError = [error retain];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)startLocationUpdates {
    if (nil == _locationManager && !_updatingLocation) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate: self];
        [_locationManager setDesiredAccuracy: kCLLocationAccuracyKilometer];
        [_locationManager setDistanceFilter: 500];
        [_locationManager startUpdatingLocation];
        _updatingLocation = YES;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)stopLocationUpdates {
    if(!!_locationManager) {
        [_locationManager stopUpdatingLocation];
        TT_RELEASE_SAFELY(_locationManager);
    }
    _updatingLocation = NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *) oldLocation {
    
    TTDINFO(@"New Location: %@, Old Location: %@", newLocation, oldLocation);
    
    [self setCurrentLocation: newLocation];
    
    // We found location. Stop tracking to preserve battery power.
    [self stopLocationUpdates];
    [self sendRequest];
    [self didChange];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    _locationUpdateFailed = YES;
    _locationUpdateError = [error retain];
    [self stopLocationUpdates];
    [self request: nil didFailLoadWithError: _locationUpdateError];
    [self didChange];
}

#pragma mark TTModel

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    TTDINFO(@"Model load more: %d", more);
    if(!_currentLocation) {
        [self startLocationUpdates];
    } else {
        _isLoadingMore = more;
        [self sendRequest];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return _updatingLocation || !!_loadingRequest;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
    [self stopLocationUpdates];
    [super cancel];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTDINFO(@"Request did finish load");
    TTURLJSONResponse* response = request.response;
    TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
    
    NSDictionary* feed = response.rootObject;
    TTDASSERT([[feed objectForKey:@"results"] isKindOfClass:[NSArray class]]);
    NSArray* results = [feed objectForKey:@"results"];
    
    NSMutableArray *tweets;
    if(!_isLoadingMore) {
        tweets = [[NSMutableArray alloc] initWithCapacity: [results count]];
    } else {
        tweets = _tweets;
    }
    
    for (NSDictionary* tweetResult in results) {
        CETweet *tweet = [[CETweet alloc] initWithDictionary: tweetResult];
        [tweets addObject: tweet];
        TT_RELEASE_SAFELY(tweet);
    }
    
    if(!_isLoadingMore) {
        TT_RELEASE_SAFELY(_tweets);
        _tweets = tweets;
    } 
    
    [super requestDidFinishLoad:request];
}

#pragma mark initialize 

- (id) init {
    self = [super init];
    
    if(self) {
        _query = @"Istanbul";
        _tweets = [[NSMutableArray array] retain];
        _page = 1;
        _currentLocation = nil;
        _locationManager = nil;
        _updatingLocation = NO;
        _locationUpdateError = NO;
    }
    
    return self;
}

- (void) dealloc {
    TT_RELEASE_SAFELY(_tweets);
    TT_RELEASE_SAFELY(_locationUpdateError);
    TT_RELEASE_SAFELY(_locationManager);
    TT_RELEASE_SAFELY(_currentLocation);
    
    [super dealloc];
}



@end
