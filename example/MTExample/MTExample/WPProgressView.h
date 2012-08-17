//
//  DDProgressView.h
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Modified by Mihai Dumitrache on 08/16/12
//

@interface WPProgressView : UIView

@property (nonatomic, retain) UIColor *outerColor;
@property (nonatomic, retain) UIColor *emptyColor;

// Progress value for the first progress indicator
@property (nonatomic, assign) float progress;

// Array of inner colors. You can have multiple progress indicators, with different colors
@property (nonatomic, retain) NSArray *innerColors;

// Sets the progress for the given progress indicator
- (void)setProgress:(float)progress forIndicator:(NSInteger)index;

@end
