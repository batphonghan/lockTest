//
//  ImageTableViewController.m
//  testContact
//
//  Created by East Agile on 8/28/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import "ImageTableViewController.h"
#import "ImageTableViewCell.h"
@implementation Avatar

@end

@interface ImageTableViewController ()

@property (strong, nonatomic) NSArray<Avatar *> *images;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ImageTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UINib *nib = [UINib nibWithNibName:@"ImageTableViewCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"ImageTableViewCell"];
//    NSMutableArray<Avatar *> *mutableImage = [NSMutableArray new];
//    for (int i = 1; i < 600; i++) {
//        Avatar *avatar = [Avatar new];
//        avatar.imagesURL = @[[NSString stringWithFormat:@"https://picsum.photos/200/300?image=%d",i],
//                             [NSString stringWithFormat:@"https://picsum.photos/200/300?image=%d",i+1],
//                             [NSString stringWithFormat:@"https://picsum.photos/200/300?image=%d",i+2]
//                             ];
//        [mutableImage addObject:avatar];
//    }
//    self.images = mutableImage;
//    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTableViewCell" forIndexPath:indexPath];
    Avatar *avatar = self.images[indexPath.row];
    
    if ((avatar.image)) {
        cell.avatarImageView.image = avatar.image;
    } else {
        [self loadImages:avatar.imagesURL completion:^(UIImage *image) {
                 ImageTableViewCell *_cell = [self.tableView cellForRowAtIndexPath:indexPath];
                 Avatar *avatar = self.images[indexPath.row];
                 avatar.image = image;
                 _cell.avatarImageView.image = avatar.image;
             }];
    }
    
    return cell;
}

- (UIImage *)renderImage:(NSArray<UIImage *> *)images withsize:(CGRect)rect {
    CGSize size = rect.size;
    UIGraphicsBeginImageContext(size);
    for (long i = images.count - 1; i >= 0 ; i--) {
        UIImage *image = images[i];
        CGRect rect = CGRectMake(0 + 8 * i, 0, size.height, size.height);
        
        CGFloat margin = size.width * 0.08;
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextFillEllipseInRect(context, rect);
        CGRect avatarRect = CGRectMake(rect.origin.x + margin,
                                       rect.origin.y + margin,
                                       rect.size.width - margin * 2,
                                       rect.size.height - margin * 2);
        CGContextAddEllipseInRect(context, avatarRect);
        CGContextClip(context);
        [image drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    }
    
    UIImage *renderedImage =  UIGraphicsGetImageFromCurrentImageContext();
    
    return renderedImage;
}

- (void)loadImages:(NSArray<NSString *> *)strs completion:(void (^) (UIImage *))handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray<UIImage *> *images = [NSMutableArray new];
        for (NSString *str in strs) {
            NSURL *url = [NSURL URLWithString:str];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            if (image) {
                [images addObject:image];
            }
        }
        CGRect rect = CGRectMake(0, 0, 160, 160);
        
        UIImage *renderImage = [self renderImage:images withsize:rect];
        NSURL *documentURL = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        NSString *imagesURL = [documentURL.path stringByAppendingString:@"/abc.png"];
        
        NSData *imageData = UIImagePNGRepresentation(renderImage);
        [imageData writeToFile:imagesURL atomically:YES];
        dispatch_async(dispatch_get_main_queue(), ^{

            handler(renderImage);
        });
    });
}


- (void)loadImagesURL:(NSArray<NSString *> *)strs completion:(void (^) (NSString *))handler {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSMutableArray<UIImage *> *images = [NSMutableArray new];
//        for (NSString *str in strs) {
//            NSURL *url = [NSURL URLWithString:str];
//            NSData *imageData = [NSData dataWithContentsOfURL:url];
//            
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            handler(renderImage);
//        });
//    });
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
