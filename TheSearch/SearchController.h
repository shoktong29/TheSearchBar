//
//  SearchController.h
//  TheSearch
//
//  Created by martin magalong on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchController : UIViewController <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchBar;
    UITableView *_tableSearch;
    NSMutableArray *_arrayData;
    NSMutableArray *_arrayFilteredData;
    NSString *_searchBarPlaceHolder;
}
@end
