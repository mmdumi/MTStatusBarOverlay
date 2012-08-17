//
//  WPViewController.m
//  MTExample
//
//  Created by Mihai Dumitrache on 8/17/12.
//  Copyright (c) 2012 Mihai Dumitrache. All rights reserved.
//

#import "WPViewController.h"

#import "MTStatusBarOverlay.h"

@interface WPViewController () {
  float   testProgress ;
  int     progressDir ;
  int no;
}

@end

@implementation WPViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  testProgress = 0.0f ;
  progressDir = 1 ;
  
  MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
  overlay.animation = MTStatusBarOverlayAnimationNone;
  overlay.detailViewMode = MTDetailViewModeHistory;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

- (IBAction)buttonPressed:(id)sender
{
  MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
  [overlay setProgress:0.0];
  [overlay postMessage:[NSString stringWithFormat:@"Synching... %d", no]];
  
  if (no == 0) {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 0.03f target: self selector: @selector(updateProgress) userInfo: nil repeats: YES] ;
    [timer fire];
  }
  
  no+=5;
}

- (void)updateProgress
{
  testProgress += (0.01f * progressDir) ;
  
  if (testProgress > 1 || testProgress < 0) {
    progressDir *= -1 ;
  }
  
  MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
  [overlay setProgress:testProgress];
  
}

@end
