//
//  SetCardView.m
//  drawing
//
//  Created by David Gross on 10/29/14.
//  Copyright (c) 2014 GrossProfitEnterprises. All rights reserved.
//

//NOTE don't forget to set the view to inherit this class or it won't pick it up.

//NOTE once we draw a thing we can copy it and move it around. there is a method called applyTransform

/* Transforming the shape
 This code does the 3 diamonds, and we can just use the non-left and non-right diamond for the 1 diamond
 To draw 2 diamonds we need to take the center one and move it over a little and then put in the second diamond
 he is going to leave that to use to do. 
 
 To draw the squiggle
 - (void)addCurveToPoint :(CGPoint)endPoint
            controlPoint1:(CGPoint)controlPoint1
            controlPoint2:(CGPoint)controlPoint2
 
 AND
 
 - (void)addArcWithCenter:(CGPoint)center
                    radius:(CGFloat)radius
                startAngle:(CGFloat)startAngle
                  endAngle:(CGFloat)endAngle
                 clockwise:(BOOL)clockwise
 
 
 */

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - set card methods
- (void)setSymbol:(NSString *)symbol{
    _symbol = symbol;
    //This tells the UI view class that something has changed and it needs to call the
    //drawRec method for us.
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setCount:(NSUInteger)count{
    _count = count;
    [self setNeedsDisplay];
}

- (void)setShade:(NSString *)shade{
    _shade = shade;
    //This tells the UI view class that something has changed and it needs to call the
    //drawRec method for us.
    [self setNeedsDisplay];
}

#pragma mark - DrawRect

#define CORNER_FRONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

//tells you how but the radius of the corner is.
- (CGFloat)cornerScaleFactor{
    return self.bounds.size.height / CORNER_FRONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius{
    return CORNER_RADIUS * [self cornerScaleFactor];
}


//self.bounds tells you the total dimentions of the view.

- (void)drawRect:(CGRect)rect{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];
    //If we draw outside the bounds it will clip it
    [roundedRect addClip];
    //Sets fill color
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    //
    [self drawDiamonds];
    
    
}

#pragma mark - Draw Diamonds
//Need 3 constants
#define DIAMOND_UPPER_VERTEX_OFFSET 0.10
#define DIAMOND_LOWER_VERTEX_OFFSET 0.10
#define DIAMOND_WIDTH 0.20



- (void)drawDiamonds {
    //need to figure out upper, lower and left/right vertext locations
    //A vertex is a point, not a float
    
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    diamond.lineWidth = 2;
    //Move to point means move there but don't draw anything while going there
    [diamond moveToPoint:[self upperVertex]];
    //addLineToPoint moves the point to that location and draws a line along the way
    [diamond addLineToPoint:[self rightVertex]];
    [diamond addLineToPoint:[self lowerVertex]];
    [diamond addLineToPoint:[self leftVertex]];
    [diamond addLineToPoint:[self upperVertex]];
    
    [[UIColor purpleColor] setStroke];
    //creates the left diamond
    UIBezierPath *leftDiamond = [diamond copy];
    CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 * -1.0, 0.0};
    [leftDiamond applyTransform:leftTransform];
    
    //creates the right diamond
    UIBezierPath *rightDiamond = [diamond copy];
    CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30, 0.0};
    [rightDiamond applyTransform:rightTransform];
    
    //adds left and right diamonds
    [diamond appendPath:leftDiamond];
    [diamond appendPath:rightDiamond];
    
    
    //Drawing 1 diamond
    [[UIColor purpleColor] setStroke];
    
    //[[UIColor purpleColor] setFill];
    
    [[UIColor clearColor] setFill];
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
    CGFloat dy = self.bounds.size.height / 15.0;
    [diamond addClip];
    while (start.y <= self.bounds.size.height) {
        [diamond moveToPoint:start];
        [diamond addLineToPoint:end];
        //increments it to draw down the whoel image
        start.y += dy;
        end.y += dy;
    }
    
    //Nothing gets drawn until we call fill and stroke
    [diamond fill];
    [diamond stroke];
    
    
    
}

//CGPoint not a float
//These 4 are our 4 vertecies
- (CGPoint)upperVertex{
    CGPoint upper = CGPointMake(self.bounds.size.width/2.0,
                                self.bounds.size.height * DIAMOND_UPPER_VERTEX_OFFSET);
    return upper;
}

- (CGPoint)lowerVertex{
    CGPoint lower = CGPointMake(self.bounds.size.width / 2.0,
                                self.bounds.size.height - (self.bounds.size.height * DIAMOND_LOWER_VERTEX_OFFSET));
    return lower;
}

- (CGPoint)leftVertex{
    CGPoint left = CGPointMake(self.bounds.size.width / 2.0 - self.bounds.size.width * DIAMOND_WIDTH / 2.0,
                               self.bounds.size.height / 2.0);
    return left;
}

- (CGPoint)rightVertex{
    CGPoint right = CGPointMake(self.bounds.size.width / 2.0 + self.bounds.size.width * DIAMOND_WIDTH / 2.0,
                               self.bounds.size.height / 2.0);
    return right;
}



#pragma mark - Initialization

- (void)setUp{
    //No background color
    self.backgroundColor = nil;
    //Transparant at least for now.
    self.opaque = NO;
    //if my bounds change it will re-draw it.
    self.contentMode = UIViewContentModeRedraw;
}


- (void)awakeFromNib{
    [self setUp];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
