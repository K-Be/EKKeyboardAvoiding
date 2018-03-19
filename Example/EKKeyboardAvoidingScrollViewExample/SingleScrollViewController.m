//
//  SingleScrollViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "SingleScrollViewController.h"
#import "MultipleScrollsViewController.h"

#import <EKKeyboardAvoiding/UIScrollView+EKKeyboardAvoiding.h>

@interface SingleScrollViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation SingleScrollViewController

#pragma mark - view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
   
    [self.scrollView setContentSize:[self.scrollView frame].size];
    [self.scrollView ek_setKeyboardAvoidingEnabled:YES];
    
    [self addViewTapGesture];
}

#pragma mark - actions

- (IBAction)showNext
{
    SingleScrollViewController *controller = [[SingleScrollViewController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
}

- (IBAction)showCustom
{
    MultipleScrollsViewController *controller = [[MultipleScrollsViewController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[self view] endEditing:YES];
    return YES;
}

#pragma mark - rotation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationPortrait;
}

#pragma mark - helpers

- (void)addViewTapGesture
{
    UITapGestureRecognizer *singleTap;
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)];

    [singleTap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWasTapped:(UITapGestureRecognizer *) singleTap
{
    [[self view] endEditing:YES];
}


@end
