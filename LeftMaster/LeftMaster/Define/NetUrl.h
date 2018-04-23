
//
//  NetUrl.h
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#ifndef NetUrl_h
#define NetUrl_h

//用户
#define net_user_login @"system/UserMobileTran.do?login"                      //用户登录
#define net_user_customer @"shop/CustomerInfoMobileTran.do?getUserCustomer"   //当前业务员列表
#define net_user_cart_list @"system/UserMobileTran.do?queryMyCar"              //获取购物车
#define net_user_cart_add @"system/UserMobileTran.do?addGoodsToMyCar"              //添加购物车
#define net_user_msg @"system/UserMobileTran.do?queryMessagesUnreadNum"              //获取消息
#define net_user_msg_list @"system/UserMobileTran.do?queryMessages"              //获取消息列表
#define net_user_sms_send @"system/UserMobileTran.do?sendSms"              //发送验证码
#define net_user_update_password @"system/UserMobileTran.do?updatePass"              //修改密码


//商品
#define net_goods_category @"shop/GoodsMobileTran.do?getGoodsTypeList"  //获取分类列表
#define net_goods_list @"shop/GoodsMobileTran.do?getGoodsList"          //获取商品列表
#define net_user_alwaysbuy_goods @"shop/GoodsMobileTran.do?getEchoGoodsList"          //获取常购商品列表
#define net_goods_detail @"shop/GoodsMobileTran.do?getGoodsInfo"       //获取商品详情
#define net_goods_carouse_list @"shop/GoodsCarouselMobileTran.do?getGoodsCarouselList"       //获取轮播图
#define net_goods_guide_list @"shop/GoodsCarouselMobileTran.do?getBaseSlidePicList"       //获取引导图
#define net_user_query_order @"shop/OrderMobileTran.do?queryMyOrder"       //获取订单

#endif /* NetUrl_h */
