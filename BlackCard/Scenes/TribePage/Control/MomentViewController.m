//
//  MomentViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MomentViewController.h"

@interface MomentViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(strong,nonatomic)UITextView *textView;
@property(strong,nonatomic)UILabel *placeholderLabel;
@property(strong,nonatomic)UILabel *countLabel;
@property(assign,nonatomic)NSInteger selectTag;
@property(strong,nonatomic)NSMutableArray *imageArray;
@property(strong,nonatomic)NSArray *myArray;
@property(strong,nonatomic)NSMutableDictionary *imageDict;
@end

@implementation MomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray=[NSMutableArray array];
    _imageDict=[[NSMutableDictionary alloc] init];
    _myArray=@[@"image1",@"image2",@"image3",@"image4",@"image5",@"image6"];
    // 设置导航条内容
    [self setupNavgationBar];
    
    // 添加底部内容view
    [self setupBottomContentView];
    self.view.backgroundColor=kUIColorWithRGB(0xF8F8F8);
}
#pragma mark -设置导航条内容
-(void)setupNavgationBar{
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    topView.backgroundColor=kUIColorWithRGB(0x434343);
    
    //返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 25, 50, 30) ;
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 40);
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    //视图标题
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-40,25,80 , 30)];
    titleLabel.text=@"此刻";
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    //发布按钮
    UIButton *publishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame=CGRectMake(kMainScreenWidth-50, 25, 40, 30);
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    publishBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [publishBtn addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:publishBtn];
    
    [self.view addSubview:topView];
    
}
#pragma mark -设置视图内容
-(void)setupBottomContentView {
    //输入框
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 74, kMainScreenWidth-20, 150)];
    _textView.delegate=self;
    //placehoder
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    _placeholderLabel.text=@"此刻的想法...300字内";
    _placeholderLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _placeholderLabel.font=[UIFont systemFontOfSize:14];
    _placeholderLabel.textAlignment=NSTextAlignmentLeft;
    [_textView addSubview:_placeholderLabel];
    
    //监控字数
    _countLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100, 225, 80, 25)];
    _countLabel.text=@"0/300";
    _countLabel.font=[UIFont systemFontOfSize:12];
    _countLabel.textAlignment=NSTextAlignmentRight;
    _countLabel.textColor=kUIColorWithRGB(0xE4A63F);
    [self.view addSubview:_countLabel];
    [self.view addSubview:_textView];
    
    //分割线
    UILabel *partingLine=[[UILabel alloc] initWithFrame:CGRectMake(10, 255, kMainScreenWidth-20, 2)];
    partingLine.backgroundColor=kUIColorWithRGB(0xA6A6A6);
    [self.view addSubview:partingLine];
    
    CGFloat width=(kMainScreenWidth-40)/3;
    //上传图片
    for (int i=0; i<6; i++)
    {
        int a= i/3;
        int b= i%3;
        UIButton *photo=[UIButton buttonWithType:UIButtonTypeCustom];
        photo.frame=CGRectMake(10+b*(10+width), 265+a*(10+width), width,width );
        [photo setBackgroundImage:[UIImage imageNamed:@"addPhotos"] forState:UIControlStateNormal];
        [photo addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
        photo.tag=i+1;
            
        UIButton *delete=[UIButton buttonWithType:UIButtonTypeCustom];
        delete.frame=CGRectMake(width-30, 0,30 ,30 );
        [delete setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        delete.hidden=YES;
        delete.tag=100+i+1;
        [photo addSubview:delete];
            
        [self.view addSubview:photo];
    
        
    }
    
}
#pragma mark -返回
-(void)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -发布
-(void)publishBtnClicked {
    NSLog(@"发布作品");
}
#pragma mark -选择图片
-(void)clickImage:(UIButton *)sender{
    _selectTag=sender.tag;
    UIButton *btn=[self.view viewWithTag:100+sender.tag];
    if (btn.hidden) {
        UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"请选择照片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            [self presentViewController:picker animated:YES completion:nil];
        }];
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"从相册中选" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
           
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [self presentViewController:picker animated:YES completion:nil];
        }];
        
        [alertView addAction:cancelAction];
        [alertView addAction:deleteAction];
        [alertView addAction:archiveAction];
       
        
        [self presentViewController:alertView animated:YES completion:nil];
    
    
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //将image压缩
    UIButton *btn=[self.view viewWithTag:_selectTag];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    UIButton *delBtn=[self.view viewWithTag:_selectTag+100];
    delBtn.hidden=NO;
    
    NSData *imageData= UIImageJPEGRepresentation(image, 0.5);//保存图片要以data形式，ios保存图片形式，压缩系数0.5
    //    [self showLoader:@"正在上传头像..."];
    
    [_imageDict setObject:imageData forKey:_myArray[_selectTag-1]];
}
-(void)deleteImage:(UIButton *)sender{
    UIButton *btn=[self.view viewWithTag:sender.tag-100];
    sender.hidden=YES;
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [_imageDict setObject:@"" forKey:_myArray[sender.tag-100-1]];
    [btn setImage:[UIImage imageNamed:@"addPhotos"] forState:UIControlStateNormal];
}
#pragma mark -UITextView代理
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //监控占位符
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeholderLabel.hidden = NO;
    }
    //控制输入字数
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 300 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
    
}
-(void)textViewDidChange:(UITextView *)textView{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > 300)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:300];
        
        [textView setText:s];
    }
    
    //不让显示负数
    _countLabel.text = [NSString stringWithFormat:@"%ld/300",existTextNum];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
