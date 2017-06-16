//
//  ImagePickerTableViewController.h
//  magicbean
//
//  Created by cwytm on 16/3/21.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SCImagePickerObject.h"


//查看照片

@protocol SCImagePickerViewControllerDelegate <NSObject>

- (void) sendMuArrayPic:(NSMutableArray<SCImagePickerObject *>*)sendPhotos;//相册选择照片

- (void) sendTakePic:(UIImage*)sendTakePhoto;//拍摄照片(单张)


@end


@interface ImagePickerTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray  *sendPhotos;//发送照片 对象SCImagePickerObject(image+path)

@property (nonatomic) BOOL onlyOne;             // 是否只可以选择一张照片 （比如选择投降时）

@property (nonatomic, assign) NSInteger maxPicCout;

@property (nonatomic, weak)id<SCImagePickerViewControllerDelegate> delegate;

@end


@interface CustomImagePickerController : UIImagePickerController

@end
