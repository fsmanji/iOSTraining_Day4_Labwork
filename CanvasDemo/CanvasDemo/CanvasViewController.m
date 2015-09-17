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

@property CGPoint newFaceOriginalCenter;

@property (weak, nonatomic) IBOutlet UILabel *baselineLable;

@property (strong, nonatomic) UIImageView *newlyCreatedFace;

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

- (IBAction)onPanNewSmiley:(UIPanGestureRecognizer *)sender {
    UIImageView *imageView = (UIImageView *)sender.view;
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            _newFaceOriginalCenter = imageView.center;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [sender translationInView:_newlyCreatedFace];
            imageView.center = CGPointMake(_newFaceOriginalCenter.x + translation.x, _newFaceOriginalCenter.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded: {
            
            
        }
            break;
            
        default:
            break;
    }
}

-(void)setupNewFace:(UIImageView *)imageView {
    _newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];
    [self.view addSubview:_newlyCreatedFace];
    
    //reposition the view inside its grandparent view
    _newlyCreatedFace.center = CGPointMake(imageView.center.x, imageView.center.y + trayView.frame.origin.y);

    //add gesture handler
    UIPanGestureRecognizer* panHandler = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanNewSmiley:)];
    //bind gesture handler
    [_newlyCreatedFace addGestureRecognizer:panHandler];
    //enable touch event
    [_newlyCreatedFace setUserInteractionEnabled:YES];
}

- (IBAction)onPanSmiley:(UIPanGestureRecognizer *)sender {
    

    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            UIImageView *imageView = (UIImageView *)sender.view;
            [self setupNewFace:imageView];
            _newFaceOriginalCenter = _newlyCreatedFace.center;
            
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [sender translationInView:_newlyCreatedFace];
            _newlyCreatedFace.center = CGPointMake(_newFaceOriginalCenter.x + translation.x, _newFaceOriginalCenter.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded: {

            
        }
            break;
            
        default:
            break;
    }
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
