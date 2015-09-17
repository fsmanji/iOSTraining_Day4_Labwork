//
//  CanvasViewController.m
//  CanvasDemo
//
//  Created by Cristan Zhang on 9/17/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;
@property (weak, nonatomic) IBOutlet UIView *trayView;

@property CGPoint trayOriginalCenter;

@end

@implementation CanvasViewController

@synthesize trayView;
@synthesize panGesture;
@synthesize trayOriginalCenter;


- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            trayOriginalCenter = trayView.center;
            }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [sender translationInView:trayView];
            trayView.center = CGPointMake(trayOriginalCenter.x, trayOriginalCenter.y + translation.y);
            }
            break;
        case UIGestureRecognizerStateEnded: {
            
            }
            break;
            
        default:
            break;
    }
}

@end
