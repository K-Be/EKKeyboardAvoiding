//
//  ScrollPageViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "MultipleScrollsViewController.h"

#import <EKKeyboardAvoiding/UIScrollView+EKKeyboardAvoiding.h>

static NSString *const kCellIdentifier = @"CellIdentifier";

@interface MultipleScrollsViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation MultipleScrollsViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setContentSize:[self.scrollView frame].size];
    [self.scrollView ek_setKeyboardAvoidingEnabled:YES];
    
    [self.textView ek_setKeyboardAvoidingEnabled:YES];

    [self.tableView ek_setKeyboardAvoidingEnabled:YES];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    [self addViewTap];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIEdgeInsets autoInset = [self.scrollView contentInset];
    autoInset.bottom = 0;
    self.scrollView.contentInset = autoInset;
    self.scrollView.scrollIndicatorInsets = autoInset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	[cell.textLabel setText:[NSString stringWithFormat:@"Cell #%ld",(long)indexPath.row]];
    
    return cell;
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
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

- (void)addViewTap
{
    UITapGestureRecognizer *singleTap;
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)];

    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWasTapped:(UITapGestureRecognizer *)singleTap
{
    [self.view endEditing:YES];
}

@end
