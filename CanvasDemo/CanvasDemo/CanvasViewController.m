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
@property CGPoint trayOpenPos;
@property CGPoint trayClosePos;
@property (weak, nonatomic) IBOutlet UILabel *baselineLable;

@end

@implementation CanvasViewController

@synthesize trayView;
@synthesize panGesture;
@synthesize trayOriginalCenter;

@synthesize trayClosePos;
@synthesize trayOpenPos;

-(void) viewDidLoad {
    trayClosePos = CGPointMake(trayView.center.x, trayView.center.y + trayView.bounds.size.height - self.baselineLable.bounds.size.height);
    trayOpenPos = trayView.center;
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            trayOriginalCenter = trayView.center;
            }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [sender translationInView:trayView];
            trayView.center = CGPointMake(trayOriginalCenter.x, trayOriginalCenter.y + translation.y);
            NSLog(@"y= %li", translation.y);
            }
            break;
        case UIGestureRecognizerStateEnded: {
            CGPoint velocity = [sender velocityInView:trayView];
            if(velocity.y > 0) {
                //moving down, close the tray
                trayView.center = trayClosePos;
            } else {
                //moving up, open the tray.
                trayView.center = trayOpenPos;
            }
            
            }
            break;
            
        default:
            break;
    }
}

@end
