//
//  HomeTableViewController.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "HomeTableViewController.h"
#import "DataManager.h"
#import "GameTableViewCell.h"
#import "CompetitionTableViewCell.h"

@interface HomeTableViewController() <DataManagerDelegate>
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation HomeTableViewController

#pragma mark - Private API

- (void)loadData {
    [[DataManager sharedInstance] prepareDataWithCompletion:^(NSMutableArray *itemsArray) {
        self.itemsArray = itemsArray;
        
        [self.tableView reloadData];
    }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[DataManager sharedInstance] setDelegate:self];
    
    [self loadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseObject *object = [self.itemsArray objectAtIndex:indexPath.row];
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[object cellIdentifier]
                                                              forIndexPath:indexPath];
    cell.baseObject = object;
    
    return cell;
}

#pragma mark - DataManagerDelegate

- (void)dataUpdatedAtIndex:(NSInteger)index {
    NSLog(@"Index for update: %ld", (long)index);
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];

}

@end