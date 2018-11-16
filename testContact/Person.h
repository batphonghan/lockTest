//
//  Person.h
//  testContact
//
//  Created by East Agile on 9/24/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (atomic, assign) NSUInteger atomic_age;
@property (nonatomic, assign) NSUInteger nonatomic_age;

@property (nonatomic, strong) NSObject *nonatomic_obj;
@property (atomic, strong) NSObject *atomic_obj;

@end

NS_ASSUME_NONNULL_END
