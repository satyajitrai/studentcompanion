//
//  SettingsViewController.h
//  StudentCompanion
//
//  Created by Satyajit Rai on 7/21/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogoutProtocolDelegate<NSObject>
- (void) onLogout;
@end


@interface SettingsViewController : UIViewController
@property (retain, nonatomic) id<LogoutProtocolDelegate> delegate;
@end
