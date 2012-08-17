//
//  DDProgressView.h
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Modified by Mihai Dumitrache on 08/16/12
//

#import "WPProgressView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WPProgressView()

@property (nonatomic, retain) NSMutableArray *progressArray;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WPProgressView


////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
    
		self.outerColor = [UIColor lightGrayColor];
		self.emptyColor = [UIColor clearColor];
    
    self.innerColors = [NSArray arrayWithObject:[UIColor lightGrayColor]];
    self.progressArray = [NSMutableArray arrayWithObject:@0];
	}
	return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
  self.progressArray = nil;
	self.innerColors = nil;
  
  self.outerColor = nil;
  self.emptyColor = nil;
  
	[super dealloc];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setProgress:(float)newProgress
{
  [self setProgress:newProgress forIndicator:0];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setProgress:(float)newProgress forIndicator:(NSInteger)index
{
  newProgress = MAX(newProgress, 0.0);
  newProgress = MIN(newProgress, 1.0);
  
  if (index < [_progressArray count]) {
    [_progressArray replaceObjectAtIndex:index
                              withObject:[NSNumber numberWithFloat:newProgress]];
  }
  [self setNeedsDisplay];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setInnerColors:(NSArray *)innerColors
{
  [innerColors retain];
  [_innerColors release];
  _innerColors = innerColors;
  
  NSMutableArray *array = [NSMutableArray array];
  for (int i = 0; i < [innerColors count]; i++) {
    [array addObject:@0];
  }

  self.progressArray = array;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRoundedRect:(CGRect)rect withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
  CGContextBeginPath(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect),
                         CGRectGetMidX(rect), CGRectGetMinY(rect), radius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect),
                         CGRectGetMaxX(rect), CGRectGetMidY(rect), radius);
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect),
                         CGRectGetMidX(rect), CGRectGetMaxY(rect), radius);
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect),
                         CGRectGetMinX(rect), CGRectGetMidY(rect), radius);
	CGContextClosePath(context);
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Save the context
	CGContextSaveGState(context);
	
	// Sllow antialiasing
	CGContextSetAllowsAntialiasing(context, YES);
	
	// Draw outter rounded rectangle
	rect = CGRectInset(rect, 1.0f, 1.0f);
	CGFloat radius = 0.5f * rect.size.height;
  
	CGContextSetLineWidth(context, 2.0f);
	[self drawRoundedRect:rect withRadius:radius inContext:context];
  
  [_outerColor setStroke];
	CGContextDrawPath(context, kCGPathStroke);
  
  // Draw the empty rounded rectangle
  rect = CGRectInset(rect, 3.0f, 3.0f);
	radius = 0.5f * rect.size.height;
	
	[self drawRoundedRect:rect withRadius:radius inContext:context];
	
  [_emptyColor setFill];
  CGContextFillPath(context);
  
	// Draw the inside moving filled rounded rectangle
	radius = 0.5f * rect.size.height;
	
	for (int i = [_progressArray count]-1; i >= 0; i--) {
    float progress = [[_progressArray objectAtIndex:i] floatValue];
    UIColor *color = [_innerColors objectAtIndex:i];
    
    // Make sure the filled rounded rectangle is not smaller than 2 times the radius
    rect.size.width *= progress;
    if (rect.size.width < 2 * radius) {
      rect.size.width = 2 * radius;
    }
    
    [self drawRoundedRect:rect withRadius:radius inContext:context];
    
    [color setFill];
    CGContextFillPath(context);
  }
  	
	// Restore the context
	CGContextRestoreGState(context);
}

@end
