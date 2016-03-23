//
//  Public.m
//  TTJian
//
//  Created by iMac on 15/8/26.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "Public.h"

@implementation textinfo



@end

@implementation Public

+ (void)SetNavigationBarText:(UINavigationBar*)bar size:(NSInteger)iFontSize color:(UIColor*)color
{
    static UIFont *font = nil;
    if (font == nil)
    {
//        font = [UIFont fontWithName:@"迷你简瘦金书" size:iFontSize];
        font = [UIFont systemFontOfSize:iFontSize];
    }
    
    [bar setTitleTextAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
}

+ (void)UpdateTabbaritem:(UITabBarItem*)item select:(NSString *)strSelectedImageName unselect:(NSString *)imageName
{
    UIImage* selectedImage = [UIImage imageNamed:strSelectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* unselectedImage = [UIImage imageNamed:imageName];
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setImage:unselectedImage];
    [item setSelectedImage:selectedImage];
}

+ (UIImage*)CreateImageNoRender:(NSString*)strImageName
{
    UIImage* image = [UIImage imageNamed:strImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

/*把url文件路径转化成本地路径*/
+ (NSString *)URLPath2LocalPath:(NSString *)strURLPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *array = [strURLPath componentsSeparatedByString:@"/"];
    
    NSString *strTempImage = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"TempImage"];
    
    NSFileManager *pFileManager = [NSFileManager defaultManager];
    if (![pFileManager fileExistsAtPath:strTempImage])
    {
        [pFileManager createDirectoryAtPath:strTempImage withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
/*    NSString *pLoccalFile = [NSString stringWithFormat:@"%@/%@",strTempImage,strURLPath];
    
    if (![pFileManager fileExistsAtPath:pLoccalFile])
    {
        [pFileManager createDirectoryAtPath:pLoccalFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
 
    return pLoccalFile;
*/
    NSInteger iCount = [array count];
    for (NSInteger i = 0; i < iCount-1; i++)
    {
        strTempImage = [strTempImage stringByAppendingString:@"/"];
        strTempImage = [strTempImage stringByAppendingString:array[i]];
    }
    
    if (![pFileManager fileExistsAtPath:strTempImage])
    {
        [pFileManager createDirectoryAtPath:strTempImage withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    strTempImage = [strTempImage stringByAppendingString:@"/"];
    strTempImage = [strTempImage stringByAppendingString:array[iCount-1]];
    
    return strTempImage;
}

/*保存图像放本地*/
+ (BOOL)SaveImage:(UIImage*)image  imagepath:(NSString*)strImagePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
    
    return [fileManager createFileAtPath:strImagePath contents:dataObj attributes:nil];
}

/*本地是否存在该文件*/
+ (BOOL)ImagePathIsExist:(NSString *)strImagePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:strImagePath];
}

+ (void)ClearStore
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *strTempImage = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"TempImage"];
    
    NSFileManager *pFileManager = [NSFileManager defaultManager];
    [pFileManager removeItemAtPath:strTempImage error:nil];
}

+ (UIImage *)GetMenuImage
{
    static UIImage* imageMenu = nil;
    if (!imageMenu)
    {
        imageMenu = [UIImage imageNamed:@"menu1@2x.png"];
        imageMenu = [imageMenu imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return imageMenu;
}

+ (UIImage *)GetMenuImage2
{
     UIImage* imageMenu2 = nil;
    if (!imageMenu2)
    {
        imageMenu2 = [UIImage imageNamed:@"menu2@2x.png"];
        imageMenu2 = [imageMenu2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return imageMenu2;
}

+ (UIImage *)GetCancelImage
{
    static UIImage* imageCancel = nil;
    if (!imageCancel)
    {
        imageCancel = [UIImage imageNamed:@"Cancel@2x.png"];
        imageCancel = [imageCancel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return imageCancel;
}

+ (UIImage *)GetBaseInfoImage
{
    static UIImage* imageBase = nil;
    if (!imageBase)
    {
        imageBase = [UIImage imageNamed:@"用户@2x.png"];
        imageBase = [imageBase imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return imageBase;
}

+ (UIImage *)GetBackImage
{
    static UIImage* imageBack = nil;
    if (!imageBack)
    {
        imageBack = [UIImage imageNamed:@"backnav@2x.png"];
        imageBack = [imageBack imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return imageBack;
}

+ (UIImage *)GetDiamondImage
{
    static UIImage* imageDiamond = nil;
    if (!imageDiamond)
    {
        imageDiamond = [UIImage imageNamed:@"diamond@2x.png"];
        imageDiamond = [imageDiamond imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return imageDiamond;
}

+ (void)ViewWithDiamonds:(UIView *)view num:(NSInteger)num
{
    for (NSInteger i = 0; i < num; i++)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(i*30, 0, 30, 30)];
        image.image = [Public GetDiamondImage];
        image.contentMode = UIViewContentModeCenter;
        [view addSubview:image];
    }
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])//d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])//d)//d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])//d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189
     22 */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)//d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|//d{3})//d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(147)|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (CGFloat)GetWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)GetHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

/*
 NSFontAttributeName
 字体
 NSParagraphStyleAttributeName
 段落格式
 NSForegroundColorAttributeName
 字体颜色
 NSBackgroundColorAttributeName
 背景颜色
 NSStrikethroughStyleAttributeName
 删除线格式
 NSUnderlineStyleAttributeName
 下划线格式
 NSStrokeColorAttributeName
 删除线颜色
 NSStrokeWidthAttributeName
 删除线宽度
 NSShadowAttributeName
 阴影
 */
+ (NSMutableAttributedString *)CreateRichtext:(NSInteger)iCount arrtext:(NSArray *)texts arrcolor:(NSArray *)colors arrfont:(NSArray *)fonts
{
    NSMutableArray *arrNum = [[NSMutableArray alloc] init];
    NSString *tmp = [[NSString alloc] init];
    NSInteger k = 0;
    for (NSInteger i = 0; i < iCount; i++)
    {
        textinfo *p = [[textinfo alloc] init];
        p.begin = k;
        p.length = [texts[i] length];
        k += p.length;
        tmp = [tmp stringByAppendingString:texts[i]];
        [arrNum addObject:p];
    }
    
    NSMutableAttributedString *tmpAttr = [[NSMutableAttributedString alloc] initWithString:tmp];
    for (NSInteger j = 0; j < iCount; j++)
    {
        textinfo *p1 = arrNum[j];
        [tmpAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[fonts[j] floatValue]] range:NSMakeRange(p1.begin, p1.length)];
        [tmpAttr addAttribute:NSForegroundColorAttributeName value:[self hexStringToColor:colors[j]] range:NSMakeRange(p1.begin, p1.length)];
    }
    
    return tmpAttr;
}

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor*)colorWithHex:(long)hexColor;
{
    return [self colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (NSString *)Number2String:(NSInteger)num
{
    NSInteger one = 0;
    NSInteger two = 0;
    NSInteger three = 0;
    NSInteger four = 0;
    
    one = (num%1000);
    two = (num%1000000)/1000;
    three = num%1000000000/1000000;
    four = num/1000000000;
    
    if (four != 0)
    {
        return [NSString stringWithFormat:@"%ld,%ld,%ld,%.3ld",four,three,two,one];
    }
    
    if (three != 0)
    {
        return [NSString stringWithFormat:@"%ld,%ld,%.3ld",three,two,one];
    }
    
    if (two != 0)
    {
        return [NSString stringWithFormat:@"%ld,%.3ld",two,one];
    }
    
    if (one != 0)
    {
        return [NSString stringWithFormat:@"%ld",one];
    }
    
    return @"0";
}

+ (NSString*)phoneNumToAsterisk:(NSString*)phoneNum
{
    if ([phoneNum isEqual:@""])
    {
        return @"无效手机号码";
    }
    return [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
}
+ (NSString *)acctNoToAsterisk:(NSString *)acctNo
{
    if ([acctNo isEqualToString:@""]) {
        return @"无效手机号码";
    }
    return [acctNo stringByReplacingCharactersInRange:NSMakeRange(4, 8) withString:@"********"];
}
+ (NSString*)idCardToAsterisk:(NSString *)idCardNum
{
    return [idCardNum stringByReplacingCharactersInRange:NSMakeRange(4, 10) withString:@"**********"];
}
+ (NSString *)userNameToAsterisk:(NSString *)realName
{
    NSInteger length = realName.length;
    return [realName stringByReplacingCharactersInRange:NSMakeRange(1, length-1) withString:@"****"];
}
#pragma mark 更换验证码,得到更换的验证码的字符串 
+ (NSString*)RandomString:(NSInteger)iNum
{
    NSArray *arr = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    NSMutableString *tmpstring = [[NSMutableString alloc] initWithCapacity:iNum];
    
    for(int i = 0; i < iNum; i++)
    {
        NSInteger index = arc4random()%([arr count]-1);
        tmpstring = (NSMutableString*)[tmpstring stringByAppendingString:[arr objectAtIndex:index]];
    }
    
    return tmpstring;
}

@end
