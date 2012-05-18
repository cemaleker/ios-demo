//
//  CETwitterModel.h
//  ios-demo
//
//  Created by Bal on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Three20/Three20.h"
#import "CoreLocation/CoreLocation.h"

@interface CETwitterModel : TTURLRequestModel <CLLocationManagerDelegate> {
    NSMutableArray *_tweets;
    NSInteger _page;
    BOOL _updatingLocation;
    BOOL _locationUpdateFailed;
    NSError *_locationUpdateError;
    CLLocationManager *_locationManager;
    CLLocation  *_currentLocation;
}

@property (nonatomic, readonly) NSArray* tweets;
@property (nonatomic, readonly) BOOL updatingLocation;

@end
