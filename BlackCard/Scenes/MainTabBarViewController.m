//
//  MainTabBarViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "WaiterViewController.h"
#import <QYSDK.h>
#define kChatIndex  1
@interface MainTabBarViewController ()<UITabBarControllerDelegate,CurrentUserActionDelegate,QYConversationManagerDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [[CurrentUserActionHelper shared] registerDelegate:self];
    // Do any additional setup after loading the view.
    
   
    [self settingTabBarImage];
   
   
   [self unReadCount:[QYSDK sharedSDK].conversationManager.allUnreadCount];
    [[QYSDK sharedSDK].conversationManager setDelegate:self];
   
   

   
}





-(void)unReadCount:(NSInteger)count {
  
   if (count == 0) {
      self.tabBar.items[kChatIndex].badgeValue = nil;
   }else {
      
     self.tabBar.items[kChatIndex].badgeValue = count > 99 ? @"99+" : @(count).stringValue;
   }
   
   
}


- (void)sender:(id)sender didLogin:(id)user {
    
}


- (void)didLogoutSender:(id)sender {
    [[QYSDK sharedSDK]logout:^{
        
    }];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedIndex == kChatIndex) {
        
        WaiterViewController *waiter = ((UINavigationController *)viewController).viewControllers.firstObject;
        if (waiter.isViewLoaded) {
             [waiter goToChatController];
        }

    }
   
    
    
    
}


- (void)settingTabBarImage {
    
    
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:3];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:2];
    // 对item设置相应地图片
    item0.selectedImage = [[UIImage imageNamed:@"tabbarBalckCardSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item0.image = [[UIImage imageNamed:@"tabbarBalckCardNone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item1.selectedImage = [[UIImage imageNamed:@"tabbarWaiterSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item1.image = [[UIImage imageNamed:@"tabbarWaiterNone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.selectedImage = [[UIImage imageNamed:@"tabbarMySel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item2.image = [[UIImage imageNamed:@"tabbarMySel-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item3.selectedImage = [[UIImage imageNamed:@"tabbarTribeSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item3.image = [[UIImage imageNamed:@"tabbarTribeNon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIColor *titleHighlightedColor = kUIColorWithRGB(0x070707);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: titleHighlightedColor,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    titleHighlightedColor = kUIColorWithRGB(0x434343);
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
   
   
   item1.badgeColor = [UIColor redColor];
    
}


- (void)onUnreadCountChanged:(NSInteger)count{
    
   [self unReadCount:count];
   
    
}


@end
