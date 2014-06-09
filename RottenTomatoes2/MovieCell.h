//
//  MovieCell.h
//  RottenTomatoes2
//
//  Created by Manish Gujjar on 6/5/14.
//  Copyright (c) 2014 Manish Gujjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
