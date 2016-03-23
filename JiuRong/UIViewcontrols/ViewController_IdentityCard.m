//
//  ViewController_IdentityCard.m
//  JiuRong
//
//  Created by iMac on 15/9/23.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_IdentityCard.h"
#import "Public.h"
#import "UserInfo.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "BorrowCertifyInfo.h"
#import "ViewController_CertifyInfo.h"
#import <SDWebImage/SDWebImageManager.h>
#import <AVFoundation/AVFoundation.h>
#include <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController_IdentityCard ()<UIActionSheetDelegate>
{
    UIImagePickerController *m_pCamera;
    NSURL * videoUrl;
    BOOL getFile;
}
@end

@implementation ViewController_IdentityCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:_info.name];
    _labelName.text = _info.name;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _btnCheck.layer.borderColor = [RGBCOLOR(150, 206, 234) CGColor];
    _btnCheck.layer.borderWidth = 1.0f;
    _btnCheck.layer.cornerRadius = 3.0f;
    
    _btnSelected.layer.borderColor = [RGBCOLOR(150, 206, 234) CGColor];
    _btnSelected.layer.borderWidth = 1.0f;
    _btnSelected.layer.cornerRadius = 3.0f;
    
    _imageviewPhoto.layer.borderColor = [[UIColor grayColor] CGColor];
    _imageviewPhoto.layer.borderWidth = 1.0f;
    
    _btnCommit.layer.cornerRadius = 5.0f;
    _Description.text = _info.Description;
//    if ([_info.name isEqualToString:@"申请视频"]) {
//        _info_additional.text = @"提示:如无法选择视频文件或者上传失败出现异常,请选择以手机文件管理器方式打开并在图库目录下选择相应视频文件";
//    }
    [self SetupCamera];
    // _info.status 2 审核通过
    if (_info.status == 0 || _info.status == 3 || _info.status == -1)
    {
        _btnCommit.hidden = NO;
        _btnCheck.hidden = YES;
        _btnSelected.hidden = NO;
        _info_additional.hidden = YES;
    }
    else
    {
        _btnCommit.hidden = YES;
        _btnCheck.hidden = NO;
        _btnSelected.hidden = YES;
        _info_additional.hidden = YES;
        NSString *imageURL = [JiuRongHttp JRGetImagePath:_info.imageURL];
        [_imageviewPhoto sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"无记录.png"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NSLog(@"%ld --- %ld",receivedSize,expectedSize);
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"completed");
        }];
    
        
/*        [JiuRongHttp JRLoadImage:imageURL finished:^(UIImage *pImage) {
            _imageviewPhoto.image = pImage;
        }];*/
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//选择按钮点击事件
- (IBAction)ClickBtnSelected:(id)sender
{
    //加入sheetview进行用户选择
    

    if (_info.uid == 45) {
    
       m_pCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        m_pCamera.videoQuality = UIImagePickerControllerQualityTypeIFrame960x540;//视频质量设置
        m_pCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        m_pCamera.delegate = self;
        m_pCamera.allowsEditing = YES;
        m_pCamera.videoMaximumDuration = 300.0f;//设置最长录制5分钟
        m_pCamera.mediaTypes = [NSArray arrayWithObject:@"public.movie"];
//        UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相簿中选取",@"照相机拍摄", nil];
//        [sheet showInView:self.view];
        [self presentViewController:m_pCamera animated:YES completion:nil];
    }
    else
    {
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相簿中选取",@"照相机拍摄", nil];
    [sheet showInView:self.view];
       
    }
//
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED
{
    if(buttonIndex == 2)
    {
        
        m_pCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
        NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
        [m_pCamera setMediaTypes:arrMediaTypes];
        [self presentViewController:m_pCamera animated:YES completion:nil];
    }
    if(buttonIndex == 1)
    {
         m_pCamera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:m_pCamera animated:YES completion:nil];
    }
}
- (IBAction)ClickBtnCommit:(id)sender
{
    if (!getFile) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"请先选择文件上传" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    if (_info.uid == 45)// 75  45
    {

            [JiuRongHttp JRPostFile:nil orFileURL:videoUrl fileName:@"test0001.mov" type:@"3" finish:^(NSInteger iStatus, NSString *error) {
                if (iStatus == 1)
                {
                    [JiuRongHttp JRCertifyInfo:[UserInfo GetUserInfo].uid mark:_info.mark imagepath:error success:^(NSInteger iStatus, NSString *strErrorCode) {
                        [SVProgressHUD dismiss];
                        if (iStatus == 1)
                        {
                            _btnCommit.hidden = YES;
                            _btnCheck.hidden = NO;
                            _btnSelected.hidden = YES;
                            
                            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"资料提交成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                            [alter show];
                        }
                        else
                        {
                            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                            [alter show];
                        }
                    } failure:^(NSError *error) {
                        [SVProgressHUD dismiss];
                    }];
                }
                else
                {
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:error delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                    [alter show];
                }

            } failure:^(NSUInteger bytesWritten, long long totalBytesWritten, long long expectedBytes) {
                
            }];
        
    }
    else
    {
        
    [JiuRongHttp JRProUploadImage:_imageviewPhoto.image name:@"test00001.png" type:@"image/png" finish:^(NSInteger iStatus, NSString *strErrorCode) {
        if (iStatus == 1)
        {
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [JiuRongHttp JRCertifyInfo:[UserInfo GetUserInfo].uid mark:_info.mark imagepath:strErrorCode success:^(NSInteger iStatus, NSString *strErrorCode) {
                [SVProgressHUD dismiss];
                if (iStatus == 1)
                {
                    _btnCommit.hidden = YES;
                    _btnCheck.hidden = NO;
                    _btnSelected.hidden = YES;
                    
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"资料提交成功" delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                    [alter show];
                }
                else
                {
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                    [alter show];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
            }];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
    } progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"%llu",bytesWritten/totalBytesWritten);
    }];
    }
}

- (IBAction)ClickBtnCheck:(id)sender
{
    ViewController_CertifyInfo* pResult = (ViewController_CertifyInfo*)[self.storyboard instantiateViewControllerWithIdentifier:@"certifyinfoResult"];
    pResult.mark = _info.mark;
    pResult.subject = _info.name;
    [self.navigationController pushViewController:pResult animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //如果是 来自照相机的image，那么先保存
    //    UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //    UIImageWriteToSavedPhotosAlbum(original_image, self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
    
    //获得编辑过的图片
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
        if (image) {
             _imageviewPhoto.image = image;
            getFile = YES;
        }
       
    }
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        
        videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:videoUrl] ;
        UIImage  *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        if (thumbnail) {
            _imageviewPhoto.image = thumbnail;
            getFile = YES;
        }
        
        player = nil;//释放player
    }
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
        switch (exportSession.status)
        {
            case AVAssetExportSessionStatusUnknown:
                NSLog(@"1");
                break;
            case AVAssetExportSessionStatusWaiting:
                NSLog(@"2");
                break;
            case AVAssetExportSessionStatusExporting:
                NSLog(@"3");
                break;
            case AVAssetExportSessionStatusCompleted: {
                handler(exportSession);
                break;
            }
            case AVAssetExportSessionStatusFailed:
                 NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                break;
        }
    }];
}

// 用户选择取消
- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)SetupCamera
{
    m_pCamera = [[UIImagePickerController alloc] init];
    m_pCamera.delegate = self;
    m_pCamera.allowsEditing = YES;
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
   
}
@end
