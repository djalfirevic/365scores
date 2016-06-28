//
//  HomeTableViewController.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "HomeTableViewController.h"
#import "WebServiceManager.h"
#import "DataManager.h"
#import "GameTableViewCell.h"
#import "CompetitionTableViewCell.h"
#import "Competition.h"
#import "Country.h"

@interface HomeTableViewController()
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation HomeTableViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

#pragma mark - Private API

- (void)loadData {
    [[WebServiceManager sharedInstance] requestDataFromURL:[NSString stringWithFormat:@"%@%@", MAIN_URL, GAMES_URL]
                                                withLoader:YES
                                            withCompletion:^(BOOL success, NSDictionary *dictionary, NSError *error)
    {
        if (success) {
            
            // Parse countries
            for (NSDictionary *countryDictionary in dictionary[@"Countries"]) {
                Country *country = [[Country alloc] initFromDictionary:countryDictionary];
                [[[DataManager sharedInstance] countriesArray] addObject:country];
            }
            
            NSLog(@"%@", dictionary[@"Games"]);
            //NSLog(@"%@", dictionary[@"Competitions"]);
            
            for (NSDictionary *competitionDictionary in dictionary[@"Competitions"]) {
                Competition *competition = [[Competition alloc] initFromDictionary:competitionDictionary];
                [self.itemsArray addObject:competition];
            }
            
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadData];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseObject *object = [self.itemsArray objectAtIndex:indexPath.row];
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseTableViewCell getReusableIdentifier:[object class]]
                                                              forIndexPath:indexPath];
    cell.baseObject = object;
    
    return cell;
}

@end