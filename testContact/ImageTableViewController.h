//
//  ImageTableViewController.h
//  testContact
//
//  Created by East Agile on 8/28/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Avatar: NSObject

@property (strong, nonatomic) NSArray *imagesURL;
@property (strong, nonatomic) UIImage *image;

@end

@interface ImageTableViewController : UITableViewController

@end

NS_ASSUME_NONNULL_END
