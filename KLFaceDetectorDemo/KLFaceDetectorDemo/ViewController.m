//
//  ViewController.m
//  KLFaceDetectorDemo
//
//  Created by kinglonghuang on 7/1/13.
/*
 * https://github.com/kinglonghuang/KLFaceDetector
 *
 * BSD license follows (http://www.opensource.org/licenses/bsd-license.php)
 *
 * Copyright (c) 2013 KLStudio.(kinglong.huang) All Rights Reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of  source code  must retain  the above  copyright notice,
 * this list of  conditions and the following  disclaimer. Redistributions in
 * binary  form must  reproduce  the  above copyright  notice,  this list  of
 * conditions and the following disclaimer  in the documentation and/or other
 * materials  provided with  the distribution.  Neither the  name of  Wei
 * Wang nor the names of its contributors may be used to endorse or promote
 * products  derived  from  this  software  without  specific  prior  written
 * permission.  THIS  SOFTWARE  IS  PROVIDED BY  THE  COPYRIGHT  HOLDERS  AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A  PARTICULAR PURPOSE  ARE DISCLAIMED.  IN  NO EVENT  SHALL THE  COPYRIGHT
 * HOLDER OR  CONTRIBUTORS BE  LIABLE FOR  ANY DIRECT,  INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY,  OR CONSEQUENTIAL DAMAGES (INCLUDING,  BUT NOT LIMITED
 * TO, PROCUREMENT  OF SUBSTITUTE GOODS  OR SERVICES;  LOSS OF USE,  DATA, OR
 * PROFITS; OR  BUSINESS INTERRUPTION)  HOWEVER CAUSED AND  ON ANY  THEORY OF
 * LIABILITY,  WHETHER  IN CONTRACT,  STRICT  LIABILITY,  OR TORT  (INCLUDING
 * NEGLIGENCE  OR OTHERWISE)  ARISING  IN ANY  WAY  OUT OF  THE  USE OF  THIS
 * SOFTWARE,   EVEN  IF   ADVISED  OF   THE  POSSIBILITY   OF  SUCH   DAMAGE.
 *
 */

#import "ViewController.h"
#import "KLFaceDetector.h"

#define FACEIMGVIEW_TAG     100001

@interface ViewController ()

@property (nonatomic, strong) UIImageView * faceImgView;

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIView * view = [[UIView alloc] initWithFrame:bounds];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage * img = [UIImage imageNamed:@"Test.jpg"];
    CGSize imgSize = [img size];
    CGSize imgViewSize = CGSizeMake(self.view.frame.size.height/2.0*imgSize.width/imgSize.height, self.view.frame.size.height/2.0);
    self.faceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, imgViewSize.width, imgViewSize.height)];
    [self.faceImgView setImage:img];
    [self.view addSubview:self.faceImgView];
    
    UIButton * getFaceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getFaceBtn setBackgroundColor:[UIColor lightGrayColor]];
    [getFaceBtn setFrame:CGRectMake(10, CGRectGetMaxY(self.faceImgView.frame)+10, 90, 30)];
    [getFaceBtn setTitle:@"GetFace" forState:UIControlStateNormal];
    [getFaceBtn addTarget:self action:@selector(getFace:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getFaceBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)getFace:(UIButton *)btn {
    //remove the previous face imageView first
    [[self.view viewWithTag:FACEIMGVIEW_TAG] removeFromSuperview];
    
    CGSize imgSize = CGSizeMake(100, 200); // you can change this size to whatever you like
    [btn setTitle:@"Working..." forState:UIControlStateNormal];
    [KLFaceDetector getFaceFromImage:self.faceImgView.image faceSize:imgSize shouldFast:YES completionHandler:^(UIImage * faceImg) {
        [btn setTitle:@"GetFace" forState:UIControlStateNormal];
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+15, CGRectGetMaxY(self.faceImgView.frame)+25, imgSize.width, imgSize.height)];
        [imgView setBackgroundColor:[UIColor darkGrayColor]];
        [imgView setTag:FACEIMGVIEW_TAG];
        [imgView setImage:faceImg];
        [self.view addSubview:imgView];
    }];
}

@end
