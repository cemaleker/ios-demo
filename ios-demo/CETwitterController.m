//
//  CeTwitterController.m
//  ios-demo
//
//  Created by Bal on 5/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CETwitterController.h"
#import "CETwitterDataSource.h"
#import "CETwitterModel.h"


@implementation CETwitterController



///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Twitter";
        self.variableHeightRows = YES;
        self.showTableShadows = YES;
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
    [self setDataSource: [[[CETwitterDataSource alloc] init] autorelease]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewNetworkEnabledDelegate alloc] initWithController:self withDragRefresh:YES withInfiniteScroll:YES] autorelease];
}
                                

@end
