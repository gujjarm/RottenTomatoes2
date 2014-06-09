//
//  MoviesViewController.m
//  RottenTomatoes2
//
//  Created by Manish Gujjar on 6/5/14.
//  Copyright (c) 2014 Manish Gujjar. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"



@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSArray *movies;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Movies";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    NSString *url;
    
    if ([self.movieType isEqualToString:@"Box Office"]) {
        url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    } else {
        url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", object);
        self.movies = object[@"movies"];
        [self.tableView reloadData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil]forCellReuseIdentifier:@"MovieCell"];
    
    self.tableView.rowHeight = 150;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View methods

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.movies.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie =self.movies[indexPath.row];
    
    cell.movieTitleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    
    NSURL *posterUrl = [NSURL URLWithString:[movie valueForKeyPath:@"posters.detailed"]];
   [cell.posterView setImageWithURL:posterUrl];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    MovieDetailsViewController *vc = [[MovieDetailsViewController alloc] init];
    vc.movie = movie;
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
