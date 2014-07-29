//
//  UniversityCell.m
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/25/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "UniversityCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface UniversityCell()
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *programNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;

@end

@implementation UniversityCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUniversity:(University *)university {
    _university = university;
    _nameLabel.text = university.name;
    _locationLabel.text = [NSString stringWithFormat:@"%@, %@", university.city, university.state];
    _programNameLabel.text = [university programTypeString];
    _gpaLabel.text = [NSString stringWithFormat:@"%.1f", university.minimumGPA];
    if (university.logoUrl && (university.logoUrl.length > 0)) {
        NSURL *url = [NSURL URLWithString:university.logoUrl];
        [_logoImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"university"]];
    } else {
        _logoImage.image = [UIImage imageNamed:@"university"];
    }
}

@end
