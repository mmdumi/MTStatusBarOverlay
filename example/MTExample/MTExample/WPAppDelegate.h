//
//  WPAppDelegate.h
//  MTExample
//
//  Created by Mihai Dumitrache on 8/17/12.
//  Copyright (c) 2012 Mihai Dumitrache. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPViewController;

@interface WPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) WPViewController *viewController;

@end
