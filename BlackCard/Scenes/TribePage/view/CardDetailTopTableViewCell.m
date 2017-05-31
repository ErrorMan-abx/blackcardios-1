//
//  CardDetailTopTableViewCell.m
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardDetailTopTableViewCell.h"

@implementation CardDetailTopTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10,10 , 41, 41)];
        _levelImageView=[[UIImageView alloc] initWithFrame:CGRectMake(28, 31, 10, 10)];
        [_headerImageView addSubview:_levelImageView];
        //名字
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(56, 10, 100, 20)];
        //日期
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(56, 30, 100, 20)];
        //时间
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(156, 30, 100, 20)];
        //白色区域
        _whiteView=[[UIView alloc] init];
        _whiteView.layer.cornerRadius=5.0f;
        //文章内容
        _titleLabel=[[UILabel alloc] init];
        //图片区域
        _showImageView=[[UIView alloc] init];
        //点赞按钮
        _praiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //点赞数
        _praiseLabel=[[UILabel alloc] init];
        //评论
        _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //评论数
        _commentLabel=[[UILabel alloc] init];
        //更多
        _moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //更多label
        _moreLabel=[[UILabel alloc] init];
        //评论标题
        _listTitle=[[UILabel alloc] init];
        //下划线
        _underLine=[[UILabel alloc] init];
        
        [self.contentView addSubview:_headerImageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_timeLabel];
        [_whiteView addSubview:_titleLabel];
        [_whiteView addSubview:_showImageView];
        [_whiteView addSubview:_praiseBtn];
        [_whiteView addSubview:_commentBtn];
        [_whiteView addSubview:_moreBtn];
        [_whiteView addSubview:_praiseLabel];
        [_whiteView addSubview:_commentLabel];
        [_whiteView addSubview:_moreLabel];
        [self.contentView addSubview:_listTitle];
        [self.contentView addSubview:_underLine];
        [self.contentView addSubview:_whiteView];
        self.backgroundColor=kUIColorWithRGB(0xF8F8F8);
        _whiteView.backgroundColor=kUIColorWithRGB(0xFFFFFF);
        
        
        
    }
    return self;
}
-(void)setModel:(TribeModel *)model{
    //头像
    UIImage *image=[UIImage imageNamed:@"HomePageDefaultCard"];
    image=[UIImage circleImage:image borderColor:[UIColor redColor] borderWidth:1.0f];
    _headerImageView.image=image;
    _levelImageView.image=[UIImage imageNamed:@"goldenAuthenticated"];
    
    //名称
    _nameLabel.text=model.nickName;
    _nameLabel.font=[UIFont systemFontOfSize:14];
    _nameLabel.textAlignment=NSTextAlignmentLeft;
    //日期
    _dateLabel.text=[NSString stringWithFormat:@"%ld",model.yearMonth];
    _dateLabel.font=[UIFont systemFontOfSize:12];
    _dateLabel.textAlignment=NSTextAlignmentLeft;
    _dateLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    //时间
    _timeLabel.text=[NSString stringWithFormat:@"%ld",model.yearMonth];
    _timeLabel.font=[UIFont systemFontOfSize:12];
    _timeLabel.textAlignment=NSTextAlignmentLeft;
    _timeLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    
    
    //文章内容
    NSInteger length=model.message.length;
    if (length<=200)
    {
        _titleLabel.text=model.message;
    }else{
        NSString *string=[NSString stringWithFormat:@"%@...",[model.message substringToIndex:200]];
        _titleLabel.text=string;
    }
    
    _titleLabel.font=[UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines=0;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize maximumLabelSize1 = CGSizeMake(kMainScreenWidth-85, 999);//labelsize的最大值
    CGSize expectSize1 = [_titleLabel sizeThatFits:maximumLabelSize1];
    _titleLabel.frame=CGRectMake(10, 10, kMainScreenWidth-85, expectSize1.height);
    _titleLabel.backgroundColor=[UIColor redColor];
    
    //图片区域
    _showImageView.frame=CGRectMake(10, _titleLabel.frame.size.height+20, kMainScreenWidth-90, 160);
    _showImageView.backgroundColor=[UIColor blueColor];
    
    for (int i=0; i<2; i++) {
        UIImageView *photo=[[UIImageView alloc] initWithFrame:CGRectMake(i*((kMainScreenWidth-90-10)/2+10), 10, (kMainScreenWidth-90-10)/2, (kMainScreenWidth-90-10)/2)];
        photo.image=[UIImage imageNamed:@"HomePageDefaultCard"];
        photo.contentMode=UIViewContentModeScaleAspectFit;
        [_showImageView addSubview:photo];
    }
    
    //点赞按钮
    _praiseBtn.frame=CGRectMake(10, _showImageView.frame.size.height+_showImageView.frame.origin.y+10, 15, 15);
    [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"bottomPraise"] forState:UIControlStateNormal];
    //点赞数目
    _praiseLabel.frame=CGRectMake(28, _praiseBtn.frame.origin.y, 40, 15);
    _praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
    _praiseLabel.font=[UIFont systemFontOfSize:12];
    _praiseLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _praiseLabel.textAlignment=NSTextAlignmentLeft;
    
    
    //评论按钮
    _commentBtn.frame=CGRectMake(80,_praiseBtn.frame.origin.y, 15, 15);
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"bottomComment"] forState:UIControlStateNormal];
    //评论数目
    _commentLabel.frame=CGRectMake(98, _praiseBtn.frame.origin.y, 40, 15);
    _commentLabel.text=[NSString stringWithFormat:@"%d",model.commentNum];
    _commentLabel.font=[UIFont systemFontOfSize:12];
    _commentLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _commentLabel.textAlignment=NSTextAlignmentLeft;
    
    //更多
    _moreBtn.frame=CGRectMake(kMainScreenWidth-70-60, _praiseBtn.frame.origin.y, 15, 15);
    [_moreBtn setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    //更多label
    _moreLabel.frame=CGRectMake(kMainScreenWidth-70-40, _praiseBtn.frame.origin.y, 30, 15);
    _moreLabel.text=@"更多";
    _moreLabel.font=[UIFont systemFontOfSize:12];
    _moreLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _moreLabel.textAlignment=NSTextAlignmentLeft;
    
    _whiteView.frame=CGRectMake(50, _timeLabel.frame.size.height+_timeLabel.frame.origin.y+10, kMainScreenWidth-70, _commentBtn.frame.size.height+_commentBtn.frame.origin.y+10);
    //评论标题
    _listTitle.frame=CGRectMake(23, _whiteView.frame.size.height+_whiteView.frame.origin.y+20, 50, 14) ;
    _listTitle.text=@"评论";
    _listTitle.textColor=kUIColorWithRGB(0x434343);
    _listTitle.font=[UIFont systemFontOfSize:14];
    _listTitle.textAlignment=NSTextAlignmentLeft;
    //下划线
    _underLine.frame=CGRectMake(22,_listTitle.frame.size.height+_listTitle.frame.origin.y+4,31,2);
    _underLine.backgroundColor=kUIColorWithRGB(0xE3A63F);
    
    //cell高度计算
    CGRect frame=self.frame;
    frame.size.height=_underLine.frame.size.height+_underLine.frame.origin.y+20;
    self.frame=frame;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
