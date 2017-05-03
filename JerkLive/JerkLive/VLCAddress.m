//
//  VLCAddress.m
//  JerkLive
//
//  Created by YuXiang on 2017/4/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "VLCAddress.h"

@implementation VLCAddress
+(instancetype)sharedInstance {

static VLCAddress * VLC = nil;
static dispatch_once_t onceToken;

dispatch_once(&onceToken, ^{
    VLC = [[VLCAddress alloc] init];
});

return VLC;
}

- (NSDictionary *)loadVLCUrlAddress {
NSDictionary *urlAddress = @{
                        @"C1高清 ":@"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8",
                        @"C5高清":@"http://ivi.bupt.edu.cn/hls/cctv5hd.m3u8",
                        @"浙江高清 ":@"http://ivi.bupt.edu.cn/hls/zjhd.m3u8",
                        @"湖南高清 ":@"http://ivi.bupt.edu.cn/hls/hunanhd.m3u8",
                        @"C6高清":@"http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8",
                        @"C8高清 ":@"http://ivi.bupt.edu.cn/hls/cctv8hd.m3u8",
                        @"广东卫视":@"http://ivi.bupt.edu.cn/hls/gdhd.m3u8",
                        @"北京体育高清 ":@"http://ivi.bupt.edu.cn/hls/btv6hd.m3u8",
                        @"CCTV国防军事":@" http://live.gslb.letv.com/gslb?stream_id=guofangjunshi&tag=live&ext=m3u8&sign=live_ipad",
                        @"世界小姐":@"rtmp://live121.cnlive.com:1935/live/shijiexiaojie",
                        @"广西综艺频道":@"http://222.216.111.87:5100/nn_live.flv?id=1005",
                        @"脱口秀":@"rtmp://112.231.23.27:554/live/tv25",
                        @"湖北体育生活":@"http://tsl5.hls.cutv.com/cutvlive/tjiVQ2w/hls/live_sd.m3u8",
                        @"南京娱乐频道":@"http://live.xwei.tv/channels/njtv/video_yl/flv:500k/live",
                        @"济南影视":@"http://tsl3.hls.cutv.com/cutvlive/kdgtM0l/hls/live_sd.m3u8",
                        @"济南娱乐":@"http://tsl3.hls.cutv.com/cutvlive/xcisTAf/hls/live_sd.m3u8",
                        @"韩国CR1台":@"rtsp://lm02.everyon.tv:1935/ptv2/phd501",
                        @"欧美*CR1":@"rtmp://live190.la3.origin.filmon.com:1935/live/73.high.stream",
                        @"亚洲CR电影1台":@"http://trailers.asiamoviepass.eu/amp/hi/bf-086.flv"
                        
                             };
return urlAddress;
}
@end
