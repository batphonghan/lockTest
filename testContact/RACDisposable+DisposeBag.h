//
//  RACDisposable+DisposeBag.h
//  Alaska
//
//  Created by woi on 11/29/16.
//  Copyright © 2016 BlackBerry Inc. All rights reserved.
//

#import "RACDisposeBag.h"

@interface RACDisposable (DisposeBag)

-(void)addDisposableTo: (RACDisposeBag*) disposeBag;

@end
