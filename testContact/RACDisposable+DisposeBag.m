//
//  RACDisposable+DisposeBag.m
//  Alaska
//
//  Created by woi on 11/29/16.
//  Copyright © 2016 BlackBerry Inc. All rights reserved.
//
#import "RACDisposable+DisposeBag.h"

@implementation RACDisposable (DisposeBag)

-(void)addDisposableTo:(RACDisposeBag *)disposeBag {
    [disposeBag addDisposable:self];
}

@end
