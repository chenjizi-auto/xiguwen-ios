//
//  APIMacro.h
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/5.
//  Copyright © 2017年 fuyou. All rights reserved.
//

/**
 *  本文件可放请求API 拼接的路径
 */
#pragma mark - 接口地址 ------------ ------------ ------------ ------------ ------------ ------------

#define HOMEURL @"http://www.xiguwen520.com/"//测试   http://www.xiguwen520.com/
//#define HOMEURL  @"http://121.196.204.11/"//正式   http://www.xiguwen520.com/
//#define HOMEURL  @"http://rapapi.org/"//正式


#define URI_HOME(url) [HOMEURL stringByAppendingString:url]

#define ImageHomeURL @"http://img.xiguwen520.com/"//image
#define ImageAppendURL(url) [NSString stringWithFormat:@"http://img.xiguwen520.com/%@",url]//image

#pragma mark - 登录接口 ------------ ------------ ------------ ------------ ------------ ------------

/**
 *  发送验证码
 */
#define URL_New_getcode                          [HOMEURL stringByAppendingString:@"appapi/index/getverifycode"]
/**
 *  注册
 */
#define URL_New_register                          [HOMEURL stringByAppendingString:@"appapi/Index/registerPhone"]
/**
 *  登录
 */
#define URL_New_login                          [HOMEURL stringByAppendingString:@"appapi/Index/login"]
/**
 *  三方注册
 */
#define URL_New_registerThree                          [HOMEURL stringByAppendingString:@"appapi/index/registerThirdPart"]
/**
 *  忘记密码
 */
#define URL_New_findpassone                          [HOMEURL stringByAppendingString:@"appapi/index/retrievepwd"]

/**
 *  忘记密码第二步
 */
#define URL_New_findpasstwo                          [HOMEURL stringByAppendingString:@"appapi/index/retrievepwds"]
/**
 *  首页数据展示
 */
#define URL_New_indexData                        [HOMEURL stringByAppendingString:@"appapi/Home/index"]

/**
 *  首页分类列表
 */
#define URL_New_indexfenleilist                       [HOMEURL stringByAppendingString:@"appapi/Home/Classificationlistyou"]
/**
 *  首页全部分类hunqin
 */
#define URL_New_allfenleilist                     [HOMEURL stringByAppendingString:@"appapi/Home/AllClassificationlist"]
/**
 *  首页全部分类shangcheng
 */
#define URL_New_allfenleilistSC                     [HOMEURL stringByAppendingString:@"appapi/Hmoeshops/allfenlei"]
/**
 *  获取案例环境
 */
#define URL_New_anliehuanjin                     [HOMEURL stringByAppendingString:@"appapi/System/other"]
/**
 *  获取案例类型
 */
#define URL_New_anlieleixin                     [HOMEURL stringByAppendingString:@"appapi/System/wedding"]
/**
 *  查看婚礼案例
 */
#define URL_New_lookAnlie                     [HOMEURL stringByAppendingString:@"appapi/Home/Weddingcase"]
/**
 *  查看婚礼案例
 */
#define URL_New_getNumber                     [HOMEURL stringByAppendingString:@"appapi/Home/GetProgrammeNumber"]

/**
 *  提交婚礼
 */
#define URL_New_jubaohunli                     [HOMEURL stringByAppendingString:@"appapi/Home/AddWeddingPlan"]

/**
 *  城市id转换
 */
#define URL_New_citychange                    [HOMEURL stringByAppendingString:@"appapi/system/dingweiid"]
/**
 *  婚庆列表
 */
#define URL_New_hunqinlist                    [HOMEURL stringByAppendingString:@"appapi/Home/business"]

/**
 *  我的粉丝
 */
#define URL_New_myfans                    [HOMEURL stringByAppendingString:@"appapi/Myhome/mfensi"]

/**
 *  我的区域
 */
#define URL_New_getquyu                    [HOMEURL stringByAppendingString:@"appapi/system/getcity"]
/**
 *  商家详情
 */
#define URL_New_shangjiadetil                    [HOMEURL stringByAppendingString:@"appapi/User/index"]
/**
 *  报价列表
 */
#define URL_New_baojialist                  [HOMEURL stringByAppendingString:@"appapi/User/baojialist"]
/**
 *  报价列表
 */
#define URL_New_zuopinlist                  [HOMEURL stringByAppendingString:@"appapi/User/zuopinlist"]
/**
 *  动态列表
 */
#define URL_New_dongtailist                  [HOMEURL stringByAppendingString:@"appapi/User/dongtai"]
/**
 *  档期
 */
#define URL_New_dangqi                 [HOMEURL stringByAppendingString:@"appapi/User/dangqi"]

/**
 *  资料
 */
#define URL_New_shangjiaziliao                [HOMEURL stringByAppendingString:@"appapi/User/merchantdata"]

/**
 *  案例详情
 */
#define URL_New_anliedetails               [HOMEURL stringByAppendingString:@"appapi/User/casedetails"]
/**
 *  广告详情
 */
#define URL_New_guanggaoDetil               [HOMEURL stringByAppendingString:@"appapi/system/recommends"]

/**
 *  报价详情
 */
#define URL_New_baojiaDetil               [HOMEURL stringByAppendingString:@"appapi/User/baojiaxq"]
/**
 *  商品详情
 */
#define URL_New_shangpinDetil               [HOMEURL stringByAppendingString:@"appapi/User/commoditydetails"]
/**
 *  发布需求
 */
#define URL_New_fabuxuqiu               [HOMEURL stringByAppendingString:@"appapi/Demand/DemandRelease"]
/**
 *  祝福赴宴
 */
#define URL_New_zhufufuyan               [HOMEURL stringByAppendingString:@"appapi/Invitation/zhufu"]
/**
 *  电子请柬模版列表
 */
#define URL_New_qingjianList               [HOMEURL stringByAppendingString:@"appapi/invitation/invitationslist"]
/**
 *  日程返回
 */
#define URL_New_richengList               [HOMEURL stringByAppendingString:@"appapi/Smalltools/richenglist"]
/**
 *  增加日程
 */
#define URL_New_addricheng               [HOMEURL stringByAppendingString:@"appapi/Smalltools/addricheng"]
/**
 *  发言稿列表
 */
#define URL_New_fayangaoList               [HOMEURL stringByAppendingString:@"appapi/Smalltools/fayangaolist"]

/**
 *  修改发言稿
 */
#define URL_New_xiugaifayangao              [HOMEURL stringByAppendingString:@"appapi/Smalltools/editfayan"]

/**
 *  增加稿列表
 */
#define URL_New_addfayangao               [HOMEURL stringByAppendingString:@"appapi/Smalltools/addfayan"]
/**
 *  删除稿列表
 */
#define URL_New_shanchufayangao               [HOMEURL stringByAppendingString:@"appapi/Smalltools/delfayangao"]

/**
 *  查询档案
 */
#define URL_New_chadang               [HOMEURL stringByAppendingString:@"appapi/System/chadang"]

/**
 *  历史热门搜索
 */
#define URL_New_search               [HOMEURL stringByAppendingString:@"appapi/Myhome/searchrecord"]
/**
 *  搜索
 */
#define URL_New_searchwu               [HOMEURL stringByAppendingString:@"appapi/Myhome/searchss"]
/**
 *  记账助手
 */
#define URL_New_JIzhangzhushoulist               [HOMEURL stringByAppendingString:@"appapi/Smalltools/jizhanglist"]
/**
 *  添加记账
 */
#define URL_New_addJIzhangzhushou              [HOMEURL stringByAppendingString:@"appapi/Smalltools/jizhangadd"]
/**
 *  商城index
 */
#define URL_New_shangchengIndex              [HOMEURL stringByAppendingString:@"appapi/Hmoeshops/index"]

/**
 *  商城类别
 */
#define URL_New_shangchengLeibieList              [HOMEURL stringByAppendingString:@"appapi/Hmoeshops/indexfenlei"]
/**
 *  商城liebiao
 */
#define URL_New_shangchenglistnew             [HOMEURL stringByAppendingString:@"appapi/Hmoeshops/shoplist"]
/**
 *  商城商家主页详情
 */
#define URL_New_shangchengshangjiaDetial             [HOMEURL stringByAppendingString:@"appapi/Shoppingmall/index"]

/**
 *  商城商家主页全部列表
 */
#define URL_New_shangchengshangjiazhuyelist             [HOMEURL stringByAppendingString:@"appapi/Shoppingmall/allshop"]
/**
 *  商城商家主页热门列表
 */
#define URL_New_shangchengshangjiarenmenlist             [HOMEURL stringByAppendingString:@"appapi/Shoppingmall/remen"]
/**
 *  热门列表
 */
#define URL_New_hotlist             [HOMEURL stringByAppendingString:@"appapi/Homehot/index"]
/**
 *  社团列表
 */
#define URL_New_shetuanlist            [HOMEURL stringByAppendingString:@"appapi/Homehot/association"]

/**
 *  社团详情index
 */
#define URL_New_shetuanDetilindex            [HOMEURL stringByAppendingString:@"appapi/Shetuan/index"]
/**
 *  社团详情联系方式
 */
#define URL_New_shetuanDetillianxifangshi            [HOMEURL stringByAppendingString:@"appapi/Shetuan/contact"]
/**
 *  社团详情成员
 */
#define URL_New_shetuanDetilchengyuan            [HOMEURL stringByAppendingString:@"appapi/Shetuan/member"]

/**
 *  社团详情作品
 */
#define URL_New_shetuanDetilzuopin            [HOMEURL stringByAppendingString:@"appapi/Shetuan/zuopin"]
/**
 *  首页案列list
 */
#define URL_New_indexanlielist            [HOMEURL stringByAppendingString:@"appapi/Homehot/indexcase"]

/**
 *  发现婚庆圈
 */
#define URL_New_faxianhunqin            [HOMEURL stringByAppendingString:@"appapi/Found/wedding"]
/**
 *  发现商城圈
 */
#define URL_New_faxianshangcheng            [HOMEURL stringByAppendingString:@"appapi/Found/shops"]
/**
 *  我的关注
 */
#define URL_New_myguanzhu           [HOMEURL stringByAppendingString:@"appapi/myhome/follow"]
/**
 *  动态详情
 */
#define URL_New_dongtaiDetil          [HOMEURL stringByAppendingString:@"appapi/Found/dynamicdetails"]

/**
 *  案列关注
 */
#define URL_New_anlieguanzhu          [HOMEURL stringByAppendingString:@"appapi/Follow/gzcases"]
/**
 *  案列取消关注
 */
#define URL_New_anliequxiaoguanzhu          [HOMEURL stringByAppendingString:@"appapi/Follow/qgzcases"]

/**
 *  商家评论
 */
#define URL_New_shangjiapinglun          [HOMEURL stringByAppendingString:@"appapi/User/businesscomment"]

/**
 *  点赞动态
 */
#define URL_New_dianzan          [HOMEURL stringByAppendingString:@"appapi/Found/likes"]

/**
 *  lookmingxi
 */
#define URL_New_lookmingxi          [HOMEURL stringByAppendingString:@"appapi/User/baojiaminxi"]

/**
 *  删除日程
 */
#define URL_New_delericheng             [HOMEURL stringByAppendingString:@"appapi/Smalltools/deljizhang"]

/**
 *  商城分类
 */
#define URL_New_shangchengfenlei             [HOMEURL stringByAppendingString:@"appapi/Hmoeshops/allfenlei"]
/**
 *  商品关注
 */
#define URL_New_shangpinGuanzhu             [HOMEURL stringByAppendingString:@"appapi/Follow/gzshop"]

/**
 *  商品取消关注
 */
#define URL_New_shangpinquxiaoGuanzhu             [HOMEURL stringByAppendingString:@"appapi/Follow/qgzshop"]

/**
 *  动态评论
 */
#define URL_New_dongtaipinglun             [HOMEURL stringByAppendingString:@"appapi/Found/addcomment"]

/**
 * 婚庆加入购物车
 */
#define URL_New_hunqinaddCar            [HOMEURL stringByAppendingString:@"appapi/carthq/add"]

/**
 * 婚庆立即购买第2步
 */
#define URL_New_hunqinbuyFrist            [HOMEURL stringByAppendingString:@"appapi/ordershq/buywedding"]





/**
 * 模版类别
 */
#define URL_New_MobanType            [HOMEURL stringByAppendingString:@"appapi/invitation/invitationstype"]
/**
 * 模版列表
 */
#define URL_New_MobanList            [HOMEURL stringByAppendingString:@"appapi/invitation/invitationslist"]

/**
 * 模版制作第一步
 */
#define URL_New_MobanFrist           [HOMEURL stringByAppendingString:@"appapi/Invitation/invitationscreateyi"]
/**
 * 模版制作第二步
 */
#define URL_New_Mobansecsond           [HOMEURL stringByAppendingString:@"appapi/Invitation/invitationscreateer"]

/**
 * 编辑我的请柬模版
 */
#define URL_editMyInvitationTemp          [HOMEURL stringByAppendingString:@"appapi/Invitation/setinvitationsmc"]


/**
 * 删除请柬
 */
#define URL_New_shanchuqingjian           [HOMEURL stringByAppendingString:@"appapi/Invitation/delinvitations"]
/**
 * 我的请柬
 */
#define URL_New_wozhizuoqingjian           [HOMEURL stringByAppendingString:@"appapi/Invitation/myinvitations"]
/**
 * 音乐类别
 */
#define URL_New_musicleibie          [HOMEURL stringByAppendingString:@"appapi/invitation/invitationsyinyuett"]
/**
 * 音乐list
 */
#define URL_New_musiclist          [HOMEURL stringByAppendingString:@"appapi/invitation/invitationsyinyue"]
/**
 * 设置音乐
 */
#define URL_New_musicshezhi          [HOMEURL stringByAppendingString:@"appapi/Invitation/setinvitationsyinyue"]



/**
 * 婚庆购物车列表
 */
#define URL_New_hunqincarlist            [HOMEURL stringByAppendingString:@"appapi/carthq/indexsapp"]

/**
 * 商城购物车列表
 */
#define URL_New_shangchengcarlist            [HOMEURL stringByAppendingString:@"appapi/cart/indexsapp"]
/**
 * 分享
 */
#define URL_New_share            [HOMEURL stringByAppendingString:@"appapi/share/fenxiangshangping"]







/**
 *  登录
 */
#define URL_LOGIN_ACCOUNT_LOGIN                          [HOMEURL stringByAppendingString:@"appApiLogin/login.json"]
/**
 *  获取支付宝签名
 */
#define URL_GET_ALIPAY_SIGNCODE                               [HOMEURL stringByAppendingString:@"alipay/sign"]
/**
 *  修改密码
 */
#define URL_LOGIN_EDIT_PASSWORD                  [HOMEURL stringByAppendingString:@"appApiLogin/editPassWord.json"]
/**
 *  注册
 */
#define URL_LOGIN_ACCOUNT_REGISTER                  [HOMEURL stringByAppendingString:@"appApiLogin/register.json"]
/**
 *  注册详细资料
 */
#define URL_REGISTER_Detail                    [HOMEURL stringByAppendingString:@"appApiLogin/tenants.json"]
/**
 *  发送验证码给手机
 */
#define URL_LOGIN_ACCOUNT_GETSMSCODE                  [HOMEURL stringByAppendingString:@"registerWeb/sendValidMsgWeb.json"]

/**
 *  附近商家
 */
#define URL_SHOP_NEARSHOP                                       [HOMEURL stringByAppendingString:@"shop/near"]
/**
 *  附近Code
 */
#define URL_SHOP_CODESHOP                                       [HOMEURL stringByAppendingString:@"code/near"]
/**
 *  附近Code状态
 */
#define URL_CODE_STATUS                                       [HOMEURL stringByAppendingString:@"code/status/latest"]
/**
 *  发布Code
 */
#define URL_PUBLISH_CODE                                       [HOMEURL stringByAppendingString:@"code"]

/**
 *  Code详情
 */
#define URL_CODE_DETAIL                                       [HOMEURL stringByAppendingString:@"code/"]
/**
 *  答案点赞
 */
#define URL_CODE_ANSWER                                       [HOMEURL stringByAppendingString:@"answer"]
/**
 *  我发布的
 */
#define URL_WALL_MYCODE                                      [HOMEURL stringByAppendingString:@"code/myCode/index/"]
/**
 *  我参与的
 */
#define URL_WALL_participated                                 [HOMEURL stringByAppendingString:@"code/participated/index/"]
/**
 *  验证支付成功与否
 */
#define URL_PAY_IS_SUCCESS                                 [HOMEURL stringByAppendingString:@"pay/status/"]
/**
 *  code答案
 */
#define URL_CODE_ANSWER_DETAIL                                 [HOMEURL stringByAppendingString:@"code/answer/"]
/**
 *  关注
 */
#define URL_FOLLOW_USER                                    [HOMEURL stringByAppendingString:@"follow/"]
/**
 *  分享
 */
#define URL_SHARE_CODE                                      [HOMEURL stringByAppendingString:@"share"]
/**
 *  发布朋友圈
 */
#define URL_Publish_moments                                [HOMEURL stringByAppendingString:@"moments"]
/**
 *  用户订单
 */
#define URL_ORDER_USER                                   [HOMEURL stringByAppendingString:@"order/buyer/index/"]
/**
 *  礼品订单
 */
#define URL_ORDER_receiver                                 [HOMEURL stringByAppendingString:@"order/receiver/index/"]
/**
 *  商家订单
 */
#define URL_ORDER_MerChant                                 [HOMEURL stringByAppendingString:@"order/merchant/"]
/**
 *  订单详情
 */
#define URL_ORDER_DETILE                                 [HOMEURL stringByAppendingString:@"order/"]
/**
 *  商品列表
 */
#define URL_SHOP_GOODS                                     [HOMEURL stringByAppendingString:@"shop/goods"]
/**
 *  商家
 */
#define URL_SHOP_INFO                                     [HOMEURL stringByAppendingString:@"shop/"]
/**
 *  绑定三方信息
 */
#define URL_BIND_THIRD_INFO                                   [HOMEURL stringByAppendingString:@"user/withdraw"]
/**
 *  订单操作
 */
#define URL_ORDER_CHNAGE                                    [HOMEURL stringByAppendingString:@"order/"]
/**
 *  修改个人信息
 */
#define URL_updateUser                                    [HOMEURL stringByAppendingString:@"appApiUser/updateUser.json"]
/**
 *  校验支付密码接口
 */
#define URL_SELF_checkPayPwd                                    [HOMEURL stringByAppendingString:@"user/checkPayPwd"]
/**
 *  意见反馈
 */
#define URL_FEED_BACK                                      [HOMEURL stringByAppendingString:@"feedback"]
/**
 *  广告页
 */
#define URL_welcome                                         [HOMEURL stringByAppendingString:@"welcome"]
/**
 *  banner
 */
#define URL_banner                                         [HOMEURL stringByAppendingString:@"appApiIndex/getCenterBottom.json"]
/**
 *  CH
 */
#define URL_CH                                         [HOMEURL stringByAppendingString:@"appApiIndex/getPlanList.json"]
/**
 *  ZC
 */
#define URL_ZC                                         [HOMEURL stringByAppendingString:@"appApiIndex/getHostList.json"]
/**
 *  SY
 */
#define URL_SY                                         [HOMEURL stringByAppendingString:@"appApiIndex/getPhotographerList.json"]
/**
 *  SX
 */
#define URL_SX                                       [HOMEURL stringByAppendingString:@"appApiIndex/getCameraList.json"]
/**
 *  HZ
 */
#define URL_HZ                                       [HOMEURL stringByAppendingString:@"appApiIndex/getMakeupList.json"]
/**
 *  CITY
 */
#define URL_CITY                                       [HOMEURL stringByAppendingString:@"appapi/System/sitelist"]
/**
 *  区域
 */
#define URL_CITY_QY                                       [HOMEURL stringByAppendingString:@"appApiCity/findAreaByCity.json"]
/**
 *  列表
 */
#define URL_LIST                                      [HOMEURL stringByAppendingString:@"appApiUser/findAllUserList.json"]

/**
 *  详情
 */
#define URL_DETAIL                                      [HOMEURL stringByAppendingString:@"by/detailData"]


/**
 *  案例查询条件
 */
#define URL_ANLIECHAXUN                                      [HOMEURL stringByAppendingString:@"appApiExample/getDictList"]


/**
 *  商家接单/我的订单
 */
#define URL_GET_MY_ORDER                            [HOMEURL stringByAppendingString:@"appApiOrder/getMyOrder.json"]
/**
 *  查询我的案例
 */
#define URL_GET_MY_CASE                           [HOMEURL stringByAppendingString:@"appApiExample/getMyExamplePageList.json"]

/**
 *  案例主页
 */
#define URL_ANLIE_LIST                          [HOMEURL stringByAppendingString:@"appApiExample/getExamplePageList"]

/**
 *  案例在线咨询
 */
#define URL_ANLIE_ASK                          [HOMEURL stringByAppendingString:@"app/content/valid_code"]

/**
 *  案例信息
 */
#define URL_ANLIE_XINXI                          [HOMEURL stringByAppendingString:@"appApiExample/getExampleInfo"]

/**
 *  根据userid查询全部银行卡
 */
#define URL_FIND_ALL_CARD                          [HOMEURL stringByAppendingString:@"appApiUser/findAllCard.json"]
/**
 *  添加提现接口
 */
#define URL_insertCardLog                          [HOMEURL stringByAppendingString:@"appApiUser/insertCardLog.json"]
/**
 *  提现审核接口
 */
#define URL_updateCardLogById                        [HOMEURL stringByAppendingString:@"appApiUser/updateCardLogById.json"]
/**
 *  查询提现记录接口
 */
#define URL_findAllCardLogByCreateTime                        [HOMEURL stringByAppendingString:@"appApiUser/findAllCardLogByCreateTime.json"]
/**
 *  银行卡添加接口
 */
#define URL_INSERT_CARD                          [HOMEURL stringByAppendingString:@"appApiUser/insertCard.json"]
/**
 *  修改银行卡信息接口
 */
#define URL_updateCardById                          [HOMEURL stringByAppendingString:@"appApiUser/updateCardById.json"]
/**
 *  案例图片
 */
#define URL_ANLIE_TP                          [HOMEURL stringByAppendingString:@"appApiExample/getMyExamplePicList"]

/**
 *  案例推荐
 */
#define URL_ANLIE_TJ                          [HOMEURL stringByAppendingString:@"appApiExample/getRecommendUserList"]

/**
 *  案例评价
 */
#define URL_ANLIE_PJ                          [HOMEURL stringByAppendingString:@"appApiExample/getExampleDiscussListByPage"]
/**
 *  查询用户关注的商家接口
 */
#define URL_findAllUserFollowByTypeOfUser       [HOMEURL stringByAppendingString:@"appApiFollow/findAllUserFollowByTypeOfUser.json"]
/**
 *  查询用户关注的案例
 */
#define URLfindAllUserFollowByTypeOfExample      [HOMEURL stringByAppendingString:@"appApiFollow/findAllUserFollowByTypeOfExample.json"]

/**
 *  案列费用列表
 */
#define URL_ANLIE_FY      [HOMEURL stringByAppendingString:@"appApiExample/getExampleBudgetListByPage"]
/**
 *  评论管理
 */
#define URL_orderEvaluationList      [HOMEURL stringByAppendingString:@"appApiOrder/orderEvaluationList"]
/**
 *  我的报价
 */
#define URL_getMyProductList      [HOMEURL stringByAppendingString:@"appApiProduct/getMyProductList"]
/**
 *  取消关注接口
 */
#define URL_deleteUserFollowById      [HOMEURL stringByAppendingString:@"appApiFollow/deleteUserFollowById.json"]
/**
 *  添加关注接口
 */
#define URL_ADDUserFollowById      [HOMEURL stringByAppendingString:@"appapi/Follow/gzuser"]

/**
 *  取消报价关注接口
 */
#define URL_new_deleguanzhubaojia      [HOMEURL stringByAppendingString:@"appapi/Follow/qgzbaojia"]
/**
 *  添加报价关注
 */
#define URL_new_addguanzhubaojia     [HOMEURL stringByAppendingString:@"appapi/Follow/gzbaojia"]

/**
 *  个人信息接口
 */
#define URL_myPersonal            [HOMEURL stringByAppendingString:@"appApiUser/myPersonal.json"]


/**
 *  添加订单评论接口
 */
#define URL_submitOrderComment            [HOMEURL stringByAppendingString:@"appApiOrder/submitOrderComment"]
/**
 *  用户注册接口
 */
#define URL_updateProductStatus            [HOMEURL stringByAppendingString:@"appApiProduct/updateProductStatus"]
/**
 *  更改我的案例状态接口
 */
#define URL_updateExampleView            [HOMEURL stringByAppendingString:@"appApiExample/updateExampleView"]
/**
 *  服务项目
 */
#define URL_FUwuXIANGMU            [HOMEURL stringByAppendingString:@"appApiProduct/getBizProductList"]

/**
 *  添加购物车
 */
#define URL_ADDSHOPCAR           [HOMEURL stringByAppendingString:@"appApiTrolley/addTrolley"]
/**
 *  购物车列表
 */
#define URL_SHOPCARLIST           [HOMEURL stringByAppendingString:@"appApiTrolley/getTrolleylist"]
/**
 *  删除购物车
 */
#define URL_DELESHOPCAR          [HOMEURL stringByAppendingString:@"appApiTrolley/deleteTrolley"]
/**
 *  查询档期接口
 */
#define URL_findScheduleByUserIdDate           [HOMEURL stringByAppendingString:@"appApiUser/findScheduleByUserIdDate.json"]
/**
 *  查询日程接口
 */
#define URL_findScheduleByWhere           [HOMEURL stringByAppendingString:@"appApiUser/findScheduleByWhere.json"]
/**
 *  关闭档期
 */
#define URL_udpateStatusById           [HOMEURL stringByAppendingString:@"appApiUser/udpateStatusById.json"]
/**
 *  档期添加接口
 */
#define URL_insertStatusById           [HOMEURL stringByAppendingString:@"appApiUser/insertStatusById.json"]
/**
 *  查询消息接口
 */
#define URL_getUserMessagePage          [HOMEURL stringByAppendingString:@"appApiOrder/getUserMessagePage.json"]
/**
 *  删除消息接口
 */
#define URL_deleteUserMessage          [HOMEURL stringByAppendingString:@"appApiOrder/deleteUserMessage.json"]
/**
 *  系统请柬模板列表
 */
#define URL_findInvitation          [HOMEURL stringByAppendingString:@"appApiInvitation/findInvitation.json"]
/**
 *  添加请柬接口
 */
#define URL_insertUserInvitation          [HOMEURL stringByAppendingString:@"appApiInvitation/insertUserInvitation.json"]
/**
 *  查询请柬模板接口
 */
#define URL_findInvitaionByUserId          [HOMEURL stringByAppendingString:@"appApiInvitation/findInvitaionByUserId.json"]
/**
 *  查询我的请柬列表接口
 */
#define URL_findUserInvitaiton         [HOMEURL stringByAppendingString:@"appApiInvitation/findUserInvitaiton.json"]
/**
 *  添加我的请柬模板接口
 */
#define URL_insertMyInvitation         [HOMEURL stringByAppendingString:@"appApiInvitation/insertMyInvitation.json"]
/**
 *  查询系统请柬模板详情接口
 */
#define URL_findInvitationById         [HOMEURL stringByAppendingString:@"appApiInvitation/findInvitationById.json"]
/**
 *  修改请柬接口
 */
#define URL_updateUserInvitation          [HOMEURL stringByAppendingString:@"appApiInvitation/updateUserInvitation.json"]
/**
 *  删除请柬接口
 */
#define URL_deleteUserInvitation          [HOMEURL stringByAppendingString:@"appApiInvitation/deleteUserInvitation.json"]
/**
 *  结算
 */
#define URL_ZHIFU          [HOMEURL stringByAppendingString:@"appApiTrolley/submitOrder"]
/**
 *  查看退款详情
 */
#define URL_getRefund         [HOMEURL stringByAppendingString:@"appApiOrder/getRefund"]
/**
 *  取消订单、确认订单等订单操作接口
 */
#define URL_updateOrderStatus        [HOMEURL stringByAppendingString:@"appApiOrder/updateOrderStatus"]
/**
 *  评论列表/查看朋友婚礼
 */
#define URL_orderEvaluationList        [HOMEURL stringByAppendingString:@"appApiOrder/orderEvaluationList"]
/**
 *  添加日程接口
 */
#define URL_insertSchedule        [HOMEURL stringByAppendingString:@"appApiUser/insertSchedule.json"]
/**
 *  删除日程接口
 */
#define URL_deleteScheduleByid        [HOMEURL stringByAppendingString:@"appApiUser/deleteScheduleByid.json"]
/**
 *  修改日程接口
 */
#define URL_updateSchedule        [HOMEURL stringByAppendingString:@"appApiUser/updateSchedule.json"]
/**
 *  关键字查询
 */
#define URL_wordLook        [HOMEURL stringByAppendingString:@"appApiIndex/findUserByKey"]

/**
 *  三级广告
 */
#define URL_sanjiGG        [HOMEURL stringByAppendingString:@"appApiIndex/getAdvThreeData"]

/**
 *  退款及原因提交接口
 */
#define URL_submitRefund        [HOMEURL stringByAppendingString:@"appApiOrder/submitRefund"]
/**
 *  订单支付接口
 */
#define URL_orderPay        [HOMEURL stringByAppendingString:@"appApiOrder/orderPay"]
/**
 *  添加订单评论接口
 */
#define URL_submitOrderComment        [HOMEURL stringByAppendingString:@"appApiOrder/submitOrderComment"]
/**
 *  顶部搜索
 */
#define URL_searchAnlie       [HOMEURL stringByAppendingString:@"appApiExample/getExamplePageList"]
/**
 *  关注查询
 */
#define URL_lookguanzhu       [HOMEURL stringByAppendingString:@"appApiFollow/findUserFollowByUserFollowUserId.json"]
/**
 *  取消关注
 */
#define URL_deleGuanzhu       [HOMEURL stringByAppendingString:@"appapi/Follow/qgzuser"]


/**
 *婚礼流程
 */
#define URL_liuCheng               [HOMEURL stringByAppendingString:@"appapi/Smalltools/hliuchenglist"]

/**
 *  删除婚礼流程
 */
#define URL_deleteFlow               [HOMEURL stringByAppendingString:@"appapi/Smalltools/delhliucheng"]

/**
 *  编辑婚礼流程
 */
#define URL_editFlow               [HOMEURL stringByAppendingString:@"appapi/Smalltools/editliucheng"]

/**
 *  添加婚礼流程
 */
#define URL_addFlow               [HOMEURL stringByAppendingString:@"appapi/Smalltools/addliucheng"]


/**
 *  用base64上传图片返回图片地址的请求
 */
#define URL_base64Upload               [HOMEURL stringByAppendingString:@"appapi/System/uploadimgba"]

/**
 *  个人实名认证修改/添加信息
 */
#define URL_PersonalAuth               [HOMEURL stringByAppendingString:@"appapi/Myhome/gerenrz"]

/**
 *  企业实名认证修改/添加信息
 */
#define URL_CompanyAuth               [HOMEURL stringByAppendingString:@"appapi/Myhome/qiyerenz"]

/**
 *  我的邀请列表
 */
#define URL_myInvitation               [HOMEURL stringByAppendingString:@"appapi/invited/index"]


/**
 *  婚礼新闻列表
 */
#define URL_newsList             [HOMEURL stringByAppendingString:@"appapi/Myhome/journalism"]

/**
 *  推广名额剩余数量
 */
#define URL_promoteNum             [HOMEURL stringByAppendingString:@"appapi/Myhome/popularizingquantity"]

/**
 *  请求推广支付信息
 */
#define URL_promotePay             [HOMEURL stringByAppendingString:@"appapi/myhome/flowsheet"]

/**
 *  邀请朋友链接
 */
#define URL_invitation             [HOMEURL stringByAppendingString:@"appapi/invited/yaoqing"]

/**
 *  认证信心查询接口
 */
#define URL_certification             [HOMEURL stringByAppendingString:@"appapi/Authentication/shopmyauth"]

/**
 *  学院认证资料提交接口
 */
#define URL_submitCertification             [HOMEURL stringByAppendingString:@"appapi/Authentication/rzdata"]

/**
 *  我的档期列表请求
 */
#define URL_mySchedule             [HOMEURL stringByAppendingString:@"appapi/myhome/gradelist"]


/**
 *  我的档期设置（修改某一天的单数）
 */
#define URL_scheduleSettings             [HOMEURL stringByAppendingString:@"appapi/myhome/addsetnumberapi"]

/**
 *  生成档期卡接口
 */
#define URL_scheduleCard            [HOMEURL stringByAppendingString:@"appapi/myhome/dangqi"]

/**
 *  新建档期接口
 */
#define URL_addSchedule           [HOMEURL stringByAppendingString:@"appapi/myhome/addmygradeapi"]

/**
 *  修改档期接口
 */
#define URL_editSchedule           [HOMEURL stringByAppendingString:@"appapi/myhome/updatemygrade"]

/**
 *  删除档期接口
 */
#define URL_deleteSchedule           [HOMEURL stringByAppendingString:@"appapi/myhome/delmygrade"]

/**
 *  我的报价列表接口
 */
#define URL_myOfferList          [HOMEURL stringByAppendingString:@"appapi/baojia/serverlistapi"]


/**
 *  我的报价删除报价接口
 */
#define URL_deleteOffer         [HOMEURL stringByAppendingString:@"appapi/Baojia/delSsrver"]


/**
 *  新增报价接口
 */
#define URL_addOffer         [HOMEURL stringByAppendingString:@"appapi/Baojia/addserverapi"]


/**
 *  修改报价接口
 */
#define URL_editOffer         [HOMEURL stringByAppendingString:@"appapi/Baojia/saveserverapi"]

/**
 *  我的报价上下架接口
 */
#define URL_editOfferStatus         [HOMEURL stringByAppendingString:@"appapi/Baojia/setSsrverStatus"]


/**
 *  查看报价未通过原因
 */
#define URL_checkReason         [HOMEURL stringByAppendingString:@"appapi/Baojia/seewei"]


/**
 *  我的图册列表
 */
#define URL_myAtlasList        [HOMEURL stringByAppendingString:@"appapi/atlas/atlaslistios"]

/**
 *  删除我的图册
 */
#define URL_deleteAtlas       [HOMEURL stringByAppendingString:@"appapi/Atlas/delatlas"]

/**
 *  我的图册上下架接口
 */
#define URL_editAtlasStatus       [HOMEURL stringByAppendingString:@"appapi/atlas/setAtlasStatus"]

/**
 *  查看图册未通过原因
 */
#define URL_checkAtlasReason      [HOMEURL stringByAppendingString:@"appapi/atlas/atlassee"]

/**
 *  我的图册添加接口
 */
#define URL_addTuce     [HOMEURL stringByAppendingString:@"appapi/Atlas/addAtlas"]

/**
 *  我的图册编辑接口
 */
#define URL_editTuce      [HOMEURL stringByAppendingString:@"appapi/atlas/editatlasios"]

/**
 *  我的案例列表接口
 */
#define URL_casesList      [HOMEURL stringByAppendingString:@"appapi/cases/mycaselistapi"]

/**
 *  删除我的案例接口
 */
#define URL_deleteCases     [HOMEURL stringByAppendingString:@"appapi/Cases/delmycase"]

/**
 *  查看案例审核失败接口
 */
#define URL_casesFailure     [HOMEURL stringByAppendingString:@"appapi/Cases/mycasesee"]

/**
 *  调整案例上下架接口
 */
#define URL_casesEditStatus     [HOMEURL stringByAppendingString:@"appapi/Cases/setMycaseStatus"]

/**
 *  我的案例添加接口
 */
#define URL_casesAdd     [HOMEURL stringByAppendingString:@"appapi/cases/addmycaseapi"]

/**
 *  我的案例修改接口
 */
#define URL_EditCases    [HOMEURL stringByAppendingString:@"appapi/cases/updatemycaseios"]

/**
 *  我的视频列表接口
 */
#define URL_videoList   [HOMEURL stringByAppendingString:@"appapi/Video/videolistapi"]


/**
 *  删除我的视频
 */
#define URL_deleteVideo   [HOMEURL stringByAppendingString:@"appapi/Video/delvideo"]

/**
 *  我的视频上下架
 */
#define URL_setVideoStatus   [HOMEURL stringByAppendingString:@"appapi/Video/setVideoStatus"]


/**
 *  查看视频未通过原因
 */
#define URL_checkVideoReason   [HOMEURL stringByAppendingString:@"appapi/Video/videosee"]

/**
 *  添加视频接口
 */
#define URL_addVideo  [HOMEURL stringByAppendingString:@"appapi/Video/addvideoapi"]


/**
 *  修改视频接口
 */
#define URL_editVideo  [HOMEURL stringByAppendingString:@"appapi/Video/updatevideo"]


/**
 *  用datata上传视频返回视频地址的请求
 */
#define URL_videoUpload     [HOMEURL stringByAppendingString:@"appapi/System/videoupload"]

/**
 *  城市服务列表
 */
#define URL_citiesService     [HOMEURL stringByAppendingString:@"appapi/myhome/servicecitylistapi"]


/**
 *  添加城市服务
 */
#define URL_addCitiesService     [HOMEURL stringByAppendingString:@"appapi/myhome/addservicecityapi"]

/**
 *  删除城市服务
 */
#define URL_deleteCitiesService     [HOMEURL stringByAppendingString:@"appapi/myhome/delservicecity"]


/**
 *  推荐团度列表
 */
#define URL_teamList     [HOMEURL stringByAppendingString:@"appapi/Myhome/recommendedteamlist"]

/**
 *  删除推荐团队
 */
#define URL_deleteTeam     [HOMEURL stringByAppendingString:@"appapi/myhome/delrecommendedteam"]

/**
 *  添加推荐团队
 */
#define URL_addTeam     [HOMEURL stringByAppendingString:@"appapi/Myhome/addrecommendedteamapi"]


/**
 *  我的需求列表
 */
#define URL_myDemandList     [HOMEURL stringByAppendingString:@"appapi/Demand/mydemand"]


/**
 *  关闭我的需求
 */
#define URL_closeMyDemand    [HOMEURL stringByAppendingString:@"appapi/Demand/enddemand"]

/**
 *  删除我的需求
 */
#define URL_deleteMyDemand    [HOMEURL stringByAppendingString:@"appapi/Demand/delmydemand"]


/**
 *  编辑我的需求
 */
#define URL_editMyDemand    [HOMEURL stringByAppendingString:@"appapi/Demand/editdemand"]

/**
 *  我的需求详情
 */
#define URL_myDemandDetails    [HOMEURL stringByAppendingString:@"appapi/Demand/demanddetails"]


/**
 *  获取我的需求参与者详情
 */
#define URL_myDemandJoinDetails    [HOMEURL stringByAppendingString:@"appapi/demand/canyudetails"]


/**
 *  我的需求合作接口
 */
#define URL_myDemandCooperation   [HOMEURL stringByAppendingString:@"appapi/demand/cooperation"]


/**
 *  查看需求同城/全国列表接口
 */
#define URL_checkDemandList   [HOMEURL stringByAppendingString:@"appapi/demand/bierenxuqiu"]

/**
 *  查看他人需求/我来接单接口
 */
#define URL_takeDemandOrder   [HOMEURL stringByAppendingString:@"appapi/demand/addwolaijd"]


/**
 *  我的商品商品列表
 */
#define URL_myGoodsList   [HOMEURL stringByAppendingString:@"appapi/Shops/shoplist"]

/**
 *  删除我的商品
 */
#define URL_deleteMyGoods   [HOMEURL stringByAppendingString:@"appapi/shops/delshop"]

/**
 *  上下架我的商品
 */
#define URL_editMyGoodsStatus   [HOMEURL stringByAppendingString:@"appapi/Shops/setShopStatus"]

/**
 *  查看我的商品未通过原因
 */
#define URL_checkMyGoodsReason   [HOMEURL stringByAppendingString:@"appapi/Shops/seeweitongg"]


/**
 *  查看余额接口
 */
#define URL_myAccountBalance   [HOMEURL stringByAppendingString:@"appapi/Bankroll/balance"]

/**
 *  查看收支明细列表接口
 */
#define URL_myBalanceList   [HOMEURL stringByAppendingString:@"appapi/Bankroll/balanceofpayments"]

/**
 *  我的银行卡列表
 */
#define URL_myBankList   [HOMEURL stringByAppendingString:@"appapi/Bankroll/blacklist"]

/**
 *  提现提交接口
 */
#define URL_withdrawal   [HOMEURL stringByAppendingString:@"appapi/Bankroll/addtixian"]


/**
 *  根据银行卡号来查找银行名称
 */
#define URL_checkBankName   [HOMEURL stringByAppendingString:@"appapi/Bankroll/chabankcard"]


/**
 *  添加银行卡提交步骤
 */
#define URL_submitBankCard  [HOMEURL stringByAppendingString:@"appapi/Bankroll/addbank"]

/**
 *  删除银行卡
 */
#define URL_deleteBankCard  [HOMEURL stringByAppendingString:@"appapi/bankroll/delcard"]

/**
 *  选择银行卡列表
 */
#define URL_bankCardList  [HOMEURL stringByAppendingString:@"appapi/bankroll/banklist"]

/**
 *  获取商品一级类目
 */
#define URL_goodsCategory  [HOMEURL stringByAppendingString:@"appapi/Shops/getyiclounm"]


/**
 *  获取商品二级类目
 */
#define URL_goodsSubclass  [HOMEURL stringByAppendingString:@"appapi/Shops/geterclounm"]


/**
 *  获取商品运费模版
 */
#define URL_goodsTemplate  [HOMEURL stringByAppendingString:@"appapi/shops/freightm"]

 /**
 *  修改支付密码第二步
 */
#define URL_repaypwd  [HOMEURL stringByAppendingString:@"appapi/index/repaypwd"]


/**
 *  个人实名认证状态查看
 */
#define URL_checkPersonalAuth  [HOMEURL stringByAppendingString:@"appapi/Myhome/seegerenrz"]

/**
 *  企业实名认证状态查看
 */
#define URL_checkCompanyAuth  [HOMEURL stringByAppendingString:@"appapi/Myhome/seeqiyerz"]

/**
 *  获取认证类型和价格
 */
#define URL_getAuthInfo  [HOMEURL stringByAppendingString:@"appapi/Authentication/gettype"]


/**
 *  诚信认证退保证金
 */
#define URL_refundMoney  [HOMEURL stringByAppendingString:@"appapi/Authentication/getouj"]


/**
 *  查看是否是商家会员状态
 */
#define URL_checkShopVip  [HOMEURL stringByAppendingString:@"appapi/member/shopvip"]


/**
 *  查看是否是用户会员状态
 */
#define URL_checkMemeberVip  [HOMEURL stringByAppendingString:@"appapi/member/openvip"]

/**
 *  各种认证支付请求支付信息接口
 */
#define URL_paymentInfo  [HOMEURL stringByAppendingString:@"appapi/Authentication/flowsheet"]


/**
 *  我的商品提交接口
 */
#define URL_submitMyGoods  [HOMEURL stringByAppendingString:@"appapi/Shops/addshoping"]

/**
 *  我的商品修改接口
 */
#define URL_editMyGoods  [HOMEURL stringByAppendingString:@"appapi/Shops/saveshopingapi"]


/**
 *  获取婚礼类型
 */
#define URL_weddingType  [HOMEURL stringByAppendingString:@"appapi/system/weddingtype"]


/**
 *  获取婚礼环境类型
 */
#define URL_weddingPlaceType  [HOMEURL stringByAppendingString:@"appapi/system/weddingenvironment"]


/**
 *  代理招募
 */
#define URL_recruitAgency  [HOMEURL stringByAppendingString:@"appapi/Myhome/agencyrecruitment"]


/**
 *  更新用户数据重新请求接口
 */
#define URL_getNewUserInfo  [HOMEURL stringByAppendingString:@"appapi/myhome/personaldatas"]


/**
 *  请求用户协议
 */
#define URL_userAgreement  [HOMEURL stringByAppendingString:@"appapi/system/useragreement"]


/**
 *  请求用户协议
 */
#define URL_privacyPolicy  [HOMEURL stringByAppendingString:@"appapi/system/useriprivacypolicy"]

/**
 *  我的日程安排删除
 */
#define URL_deleteMyRicheng  [HOMEURL stringByAppendingString:@"appapi/Smalltools/delricheng"]


/**
 *  我的日程安排修改状态
 */
#define URL_editMyRichengStatus  [HOMEURL stringByAppendingString:@"appapi/Smalltools/setwricheng"]


/**
 *  我的日程安编辑日程
 */
#define URL_editMyRicheng  [HOMEURL stringByAppendingString:@"appapi/Smalltools/editricheng"]

/**
 *  我的社团创建社团
 */
#define URL_creatAssociations  [HOMEURL stringByAppendingString:@"appapi/Myhome/addshetuanapi"]

/**
 *  我的社团加入社团列表
 */
#define URL_associationsList  [HOMEURL stringByAppendingString:@"appapi/Myhome/shetuanlistapi"]

/**
 *  我的社团列表拒绝加入邀请社团
 */
#define URL_refusedAssociations  [HOMEURL stringByAppendingString:@"appapi/Association/jujuejiaru"]

/**
 *  我的社团列表同意加入邀请社团
 */
#define URL_agreeAssociations  [HOMEURL stringByAppendingString:@"appapi/Association/tongyijiaru"]

/**
 *  我的社团列表申请加入社团
 */
#define URL_applyAssociations  [HOMEURL stringByAppendingString:@"appapi/Association/inassociation"]

/**
 *  我的社团列表退出加入社团
 */
#define URL_exitAssociations  [HOMEURL stringByAppendingString:@"appapi/Association/outassociation"]




/**
 *  我的社团团队中心
 */
#define URL_associationsCenter  [HOMEURL stringByAppendingString:@"appapi/Association/teamcenter"]

/**
 *  我的社团团队中心退出团队
 */
#define URL_associationsCenterOut  [HOMEURL stringByAppendingString:@"appapi/Association/outasso"]


/**
 *  我的社团团队中心成员管理列表
 */
#define URL_associationsCenterManagerList  [HOMEURL stringByAppendingString:@"appapi/Association/shetuanmemberlistapi"]


/**
 *  我的社团团队中心成员管理列表设置管理员
 */
#define URL_associationsCenterSetManager  [HOMEURL stringByAppendingString:@"appapi/Association/setguanli"]

/**
 *  我的社团团队中心成员管理列表取消管理员
 */
#define URL_associationsCenterCancelManager  [HOMEURL stringByAppendingString:@"appapi/Association/unguanli"]

/**
 *  我的社团团队中心成员管理列表移除社团成员
 */
#define URL_associationsCenterRemoveMember  [HOMEURL stringByAppendingString:@"appapi/Association/yichushetuan"]

/**
 *  我的社团团队中心待通过成员列表
 */
#define URL_associationsCenterPendingMemberList  [HOMEURL stringByAppendingString:@"appapi/Association/waitthroughapi"]

/**
 *  我的社团团队中心待通过成员列表通过请求
 */
#define URL_associationsCenterAgreeMember  [HOMEURL stringByAppendingString:@"appapi/Association/sagree"]

/**
 *  我的社团团队中心待通过成员列表拒绝请求
 */
#define URL_associationsCenterRefuseMember  [HOMEURL stringByAppendingString:@"appapi/Association/srefuse"]


/**
 *  我的社团团队中心要邀请新成员列表
 */
#define URL_associationsCenterInviteMemberList  [HOMEURL stringByAppendingString:@"appapi/Association/invitationapi"]

/**
 *  我的社团团队中心要邀请新成员列表进行邀请
 */
#define URL_associationsCenterInviteMember  [HOMEURL stringByAppendingString:@"appapi/Association/yaoqing"]


/**
 *  我的社团团队中心今日新增列表
 */
#define URL_associationsCenterAddedList  [HOMEURL stringByAppendingString:@"appapi/Association/jrxingzen"]

/**
 *  我的社团团队中心今日有单列表
 */
#define URL_associationsCenterOrderNumList  [HOMEURL stringByAppendingString:@"appapi/Association/jryoudan"]


/**
 *  我的社团团队中心成员档期列表
 */
#define URL_associationsCenterMemberScheduleList  [HOMEURL stringByAppendingString:@"appapi/Association/cydangqi"]


/**
 *  查看需求详情分享接口
 */
#define URL_xuqiuDetailsShare  [HOMEURL stringByAppendingString:@"appapi/share/fenxiangxuqiu"]


