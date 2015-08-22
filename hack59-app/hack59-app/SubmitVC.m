//
//  SubmitVC.m
//  hack59-app
//
//  Created by Tank Lin on 2015/8/22.
//  Copyright (c) 2015年 Tank. All rights reserved.
//

#import "SubmitVC.h"
#import "ViewController.h"

@interface SubmitVC ()

@end

@implementation SubmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyHideKeyboard];
    [self textViewPlaceholder];
}

#pragma mark - Finish Submit
- (IBAction)finishSubmit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Cancel Submit
- (IBAction)dismissSubmitView:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"尚未完成投稿，確定離開嗎？" message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:@"取消", nil];    

    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1:
            break;
        default:
            break;
    }
}

#pragma mark - TextView
- (void)textViewPlaceholder
{
    _textView.delegate = self;
    _textView.text = @"你要為城市靠北什麼呢？";
    _textView.textColor = [UIColor lightGrayColor];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([_textView.text isEqualToString:@"你要為城市靠北什麼呢？"]) {
        _textView.text = @"";
        _textView.textColor = [UIColor blackColor];
    }
    [_textView becomeFirstResponder];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([_textView.text isEqualToString:@""]) {
        _textView.text = @"你要為城市靠北什麼呢？";
        _textView.textColor = [UIColor lightGrayColor];
    }
    [_textView resignFirstResponder];
}

#pragma mark - 隱藏鍵盤
- (void)readyHideKeyboard
{
UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];

[gestureRecognizer setDelegate:self];
[self.view addGestureRecognizer:gestureRecognizer];
}
- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

@end
