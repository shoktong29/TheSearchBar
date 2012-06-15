//
//  SearchController.m
//  TheSearch
//
//  Created by martin magalong on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchController.h"

@implementation SearchController

- (id)init
{
    self = [super init];
    if (self) {
        _arrayData = [[NSMutableArray alloc]initWithObjects:@"Red",@"Blue",@"Yellow",@"Green",@"Orange",@"Black", nil];
        _arrayFilteredData = [[NSMutableArray alloc]init];
        
        //Create searchBar
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,20,320,43)];
        _searchBar.delegate = self;
        if ( !_searchBarPlaceHolder ) {
            _searchBarPlaceHolder = @"What are you looking for?";
        }
        _searchBar.placeholder = _searchBarPlaceHolder;
        _searchBar.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_searchBar];
    }
    return self;
}

#pragma mark - SearchBar Delegates
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    //Enables the searchBar cancel button
    for (id subview in [_searchBar subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setEnabled:TRUE];
        }
    } 
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = YES;
    
    //Enables the search button even if searchText is empty
    UITextField *searchTextField ; 
    for(id view in [_searchBar subviews])
    {
        if([[view description] hasPrefix:@"<UISearchBarTextField"])
        {
            searchTextField = view;
            searchTextField.enablesReturnKeyAutomatically = NO ;
        }
    }
    
    //create table if its not created yet
    if(!_tableSearch){
        _tableSearch = [[UITableView alloc]initWithFrame:CGRectMake(0,63,320,400)];
        _tableSearch.delegate = self;
        _tableSearch.dataSource = self;
        [self.view addSubview:_tableSearch];
        [self searchBar:_searchBar textDidChange:@""];
    }
}

- (void)resignSearchController
{
    [_searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    [_tableSearch removeFromSuperview];
    _tableSearch = nil;   
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray *resultData = [[NSMutableArray alloc]initWithArray:_arrayData];
    
    [_arrayFilteredData removeAllObjects];
    if([searchText isEqualToString:@""]||searchText==nil){
        for (int index=0;index<resultData.count;index++)
        {
            [_arrayFilteredData addObject:[resultData objectAtIndex:index]];
        }
    }
    else {
        for (int index=0;index<resultData.count;index++)
        {
            NSRange titleRange = [[resultData objectAtIndex:index] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(titleRange.location != NSNotFound)
            {
                [_arrayFilteredData addObject:[resultData objectAtIndex:index]];
            }
        }
    }
    [_tableSearch reloadData];
}


#pragma mark - Table Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _arrayFilteredData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    int row = [indexPath row];
    cell.textLabel.text = [_arrayFilteredData objectAtIndex:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
