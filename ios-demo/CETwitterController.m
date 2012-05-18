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
    if(![self.superController isKindOfClass: [CETwitterController class]]) {
        TTTableViewController* searchController = [[[CETwitterController alloc] init] autorelease];
        searchController.dataSource = [[[CETwitterDataSource alloc] init] autorelease];
        self.searchViewController = searchController;
        self.tableView.tableHeaderView = _searchController.searchBar;
        _searchController.searchBar.text = @"Istanbul";
    }
}

//- (void) modelDidFinishLoad:(id<TTModel>)model {
//    if(![self.superController isKindOfClass: [CETwitterController class]]) {
//        TTTableViewController* searchController = [[[CETwitterController alloc] init] autorelease];
//        searchController.dataSource = [[[CETwitterDataSource alloc] init] autorelease];
//        self.searchViewController = searchController;
//        self.tableView.tableHeaderView = _searchController.searchBar;
//        _searchController.searchBar.text = @"Istanbul";
//    }
//
//}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewNetworkEnabledDelegate alloc] initWithController:self withDragRefresh:YES withInfiniteScroll:YES] autorelease];
}
                                

@end
