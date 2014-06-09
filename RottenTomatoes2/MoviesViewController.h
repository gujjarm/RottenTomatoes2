//
//  MoviesViewController.h
//  RottenTomatoes2
//
//  Created by Manish Gujjar on 6/5/14.
//  Copyright (c) 2014 Manish Gujjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *movieType;


@end
