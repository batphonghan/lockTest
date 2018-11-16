//
//  Person.m
//  testContact
//
//  Created by East Agile on 9/24/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    self = [super init];
    if (self) {
        _atomic_age = 0;
        _nonatomic_age = 0;
    }
    
    return self;
}

@end
