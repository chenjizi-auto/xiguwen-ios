package com.linzi.xiguwen.network;

/**
 * Created by linzi on 2017/6/6.
 */

public class Constans {

    public static String HOST = "https://www.xiguwen520.com";//正式服务器地址
    //public static String HOST = "http://boyi.qanlian.com";//测试服务器地址
    //public static String HOST = "http://boyi.qanlian.com";//测试服务器地址
    public static final boolean SHOW_MALL_CATEGORY = false;
    public static final boolean SHOW_MESSAGE_ENTRY = false;

    public static String SERVER_HOST = HOST + "/wapapi";
    public static String SERVER_HOST2 = HOST + "/appapi";
    public static String HEAD_URL = "http://img.boyitongcheng.com/";
    public static String RMB = "¥";

    /**
     * 接口类型
     */
    public static class Type {
        public static String LOGIN = "/index";
        public static String HOME = "/home";
        public static String HOME2 = "/Home";
        public static String FOLLOW = "/Follow";
        public static String NEED = "/Demand";
        public static String INVITATION = "/Invitation";
        public static String HOME_SHOP = "/Hmoeshops";
        public static String HOME_HOT = "/Homehot";
        public static String USER = "/User";
        public static String SYSTEM = "/System";
        public static String SYSTEM2 = "/system";
        public static String MYHOME = "/Myhome";
        public static String SHETUAN = "/Shetuan";
        public static String AUTHENTICATION = "/Authentication";
        public static String BAOJIA = "/Baojia";
        public static String ATLAS = "/Atlas";
        public static String VIDEO = "/Video";
        public static String CASES = "/Cases";
        public static String FOUND = "/Found";
        public static String SHOPING = "/Shoping";
        public static String SMALLTOOLS = "/Smalltools";
        public static String MESSAGE = "/information";
        public static String SHOPPINGMALL = "/Shoppingmall";
        public static String CART = "/cart";
        public static String INVITED = "/invited";
        public static String WEDDINGCART = "/carthq";
        public static String EXAMPLE = "/example";
        public static String SHOPS = "/Shops";
        public static String NOWWEDDINGORDER = "/ordershq";
        public static String NOWMALLORDER = "/orders";
        public static String BANKROLL = "/Bankroll";
        public static String ADDRESS = "/Address";
        public static String ASSOCIATION = "/Association";
        public static String SHARE = "/share";
        public static String MEMBER = "/member";
        public static String INTEGRAL = "/integral";
        public static String ACTIVITY = "/activity";
        public static String FINANCE = "/finance";
    }

    /**
     * 接口操作
     */
    public static class Action {
        public static String CITY = "/sitelist";
        public static String LOGIN = "/login";
        public static String COMPLAINT = "/usercomplaint";
        public static String UserCancel = "/usercancel";
        public static String LOGIN_OTHER = "/registerThirdPart";
        public static String GETSMS = "/getverifycode";
        public static String RIGIST = "/registerPhone";
        public static String FORGOT = "/retrievepwds";
        public static String INDEX = "/index";
        public static String DEL_FOLLOW = "/qgzshop";
        public static String ADD_FOLLOW = "/gzshop";
        public static String DEL_SJ_FOLLOW = "/qgzuser";
        public static String ADD_SJ_FOLLOW = "/gzuser";
        public static String DEL_BJ_FOLLOW = "/qgzbaojia";
        public static String ADD_BJ_FOLLOW = "/gzbaojia";
        public static String DEL_AL_FOLLOW = "/qgzcases";
        public static String ADD_AL_FOLLOW = "/gzcases";
        public static String ADD_NEED = "/DemandRelease";
        //编辑需求
        public static String EDIT_NEED = "/editdemand";
        public static String MINE_INVITATION = "/myinvitations";
        public static String GET_INVITATION_URL = "/getmyqin";
        public static String GET_HUNQIN_MENU = "/Classificationlist";
        public static String GET_BUSINESS = "/businessapp";
        //获取首页案例
        public static String GET_CASE = "/indexcaseapp";
        //获取案例详情
        public static String GET_CASS_DETAILS = "/casedetails";
        //查档
        public static String WHTHIN = "/chadang";
        //区县列表
        public static String GET_CITY = "/getcity";
        //职业列表
        public static String CLASSIFICATION_LIST = "/Classificationlist";
        public static String CLASSIFICATION_LIST2 = "/Classificationlistyou";



        //热门搜索
        public static String WHTHIN2 = "/searchrecord";
        //案例明细
        public static String CASE_DETAILS = "/baojiaminxi";
        //获取人数
        public static String GET_PEOPLE_NUMBER = "/GetProgrammeNumber";
        //提交免费获取方案
        public static String POST_CASE = "/AddWeddingPlan";
        //社团列表
        static String ASSOCIATION = "/association";
        // 店铺详情
        static String STOREINFORMATION = "/storeinformation";
        // 修改店铺详情
        static String CHANGE_STORE_INFORMATION = "/storeinformationedit";
        // 认证信息
        static String SHOP_MYAUTH = "/shopmyauth";
        // 查看认证资料
        static String GET_RENZHENG_SUBMIT_INFO = "/seerenzhen";
        // 提交认证资料
        static String SUBMIT_RENZHENG_INFO = "/rzdata";
        // 重新提交认证资料
        static String RESUBMIT_RENZHENG_INFO = "/crzdata";
        // 认证列表
        static String RENZHENG_LIST = "/gettype";
        //提交认证
        static String SUBMIT_RENZHENG = "/flowsheet";
        // 退保证金
        static String REFUND_RENZHENG = "/getouj";
        // 获取档期列表
        static String GET_GRADE_LIST = "/gradelist";
        // 添加档期
        static String ADD_GRADE = "/addmygradeapi";
        // 删除档期
        static String DEL_GRADE = "/delmygrade";
        // 修改档期
        static String EDIT_GRADE = "/updatemygrade";
        // 生成档期卡
        static String CREATE_GRADE_CARD = "/dangqi";
        // 设置接单数量
        static String SET_TAKING_ORDER_NUM = "/addsetnumberapi";
        // 获取接单数量
        static String GET_TAKING_ORDER_NUM = "/getsetnumberapi";
        // 获取报价列表
        static String GET_BAOJIA_LIST = "/serverlistapi";
        // 添加报价
        static String ADD_BAOJIA = "/addserverapi";
        // 修改报价
        static String EDIT_BAOJIA = "/saveserverapi";
        // 删除报价
        static String DEL_BAOJIA = "/delSsrver";
        // 获取报价失败原因
        static String GET_BAOJIA_REASON = "/seewei";
        // 设置报价上下架
        static String SET_BAOJIA_STATUS = "/setSsrverStatus";
        // 报价提交审核
        static String SUBMIT_BAOJIA = "/setservarstate";
        // 获取报价详情
        static String GET_BAOJIA_DETAIL = "/baojiadetails";
        // 添加我的商品
        static String ADD_MY_COMMODITY = "/addshoping";
        // 删除我的商品
        static String DEL_MY_COMMODITY = "/delShop";
        // 修改我的商品
        static String EDIT_MY_COMMODITY = "/saveshopingapi";
        // 获取我的商品一级类目
        static String GET_MY_COMMODITY_TYPE_PARENT = "/getyiclounm";
        // 获取我的商品二级类目
        static String GET_MY_COMMODITY_TYPE_CHILD = "/geterclounm";
        // 获取我的商品运费模板
        static String GET_MY_COMMODITY_FREIGHT_TEMPLATE = "/freightm";
        // 我的商品上下架
        static String SET_MY_COMMODITY_STATUS = "/setShopStatus";
        // 获取我的商品审核失败原因
        static String GET_MY_COMMODITY_REASON = "/seeweitongg";
        // 获取我的商品详情
        static String GET_MY_COMMODITY_DETAIL = "/seedanshops";
        // 获取我的商品列表
        static String GET_MY_COMMODITY_LIST = "/shoplist";
        //上传无水映图片
        static String UPLOAD_FILE = "/uploadimg";
        // 获取婚礼类型列表
        static String GET_WEDDING_TYPE_LIST = "/weddingtype";
        // 获取婚礼环境列表
        static String GET_WEDDING_ENVIRONMENT_LIST = "/weddingenvironment";
        // 上传视频
        static String UPLOAD_VIDEO = "/videoupload";
        //上传图片base64编码
        public static String UPLOAD_IMG_GBA = "/uploadimgba";

        public static String UPLOAD_IMG_NIU = "/uploadimgqiniu";
        public static String UPLOAD_IMG_OSS = "/uploadimg_oss";
        //商家详情 资料
        static String MERCHANTDATA = "/merchantdata";
        //商家详情 档期
        static String DANGQI = "/dangqi";
        //商家详情 报价
        static String BAOJIALIST = "/baojialist";
        //商家详情 作品
        static String ZUOPING = "/zuopinlistapp";
        // 获取所有地区
        static String GET_PROVINCES = "/huoqudiqu";
        // 获取图册列表
        static String GET_ATLAS = "/atlaslist";
        // 删除图册
        static String DEL_ATLAS = "/delatlas";
        // 查看图册失败原因
        static String GET_ATLAS_REASON = "/atlassee";
        // 设置图册上下架
        static String SET_ATLAS_STATUS = "/setAtlasStatus";
        // 图册提交审核
        static String SUBMIT_ATLAS = "/atlasexamine";
        // 获取单个图册详情
        static String GET_ATLAS_DETAIL = "/Atlasdetails";
        // 添加图册
        static String ADD_ATLAS = "/addAtlas";
        // 修改图册
        static String EDIT_ATLAS = "/editatlasios";
        // 获取视频列表
        static String GET_VIDEO_LIST = "/videolistapi";
        // 获取单个视频详情
        static String GET_VIDEO_DETAIL = "/seevideo";
        // 添加视频
        static String ADD_VIDEO = "/addvideoapi";
        // 编辑视频
        static String EDIT_VIDEO = "/updatevideo";
        // 删除视频
        static String DEL_VIDEO = "/delvideo";
        // 查看视频审核失败原因
        static String GET_VIDEO_REASON = "/videosee";
        // 视频提交审核
        static String SUBMIT_VIDEO = "/videoexamine";
        // 设置视频上下架
        static String SET_VIDEO_STATUS = "/setVideoStatus";
        // 获取我的案例列表
        static String GET_MY_EXAMPLE_LIST = "/mycaselistapi";
        //查看我的案例详情
        static String GET_MY_EXAMPLE_DETAIL = "/seecase";
        // 添加案例
        static String ADD_MY_EXAMPLE = "/addmycaseapi";
        // 编辑案例
        static String EDIT_MY_EXAMPLE = "/updatemycaseios";
        // 删除案例
        static String DEL_MY_EXAMPLE = "/delmycase";
        // 获取案例审核失败原因
        static String GET_EXAMPLE_REASON = "/mycasesee";
        // 案例提交审核
        static String SUBMIT_EXAMPLE = "/mycaseexamine";
        // 设置视频上下架
        static String SET_CASES_STATUS = "/setMycaseStatus";
        // 获取我的城市服务列表
        static String GET_MY_SERVICE_CITY_LIST = "/servicecitylistapi";
        // 删除我的服务城市
        static String DEL_MY_SERVICE_CITY = "/delservicecity";
        // 添加服务城市
        static String ADD_MY_SERVICE_CITY = "/addservicecityapi";
        // 获取推荐团队列表
        static String GET_RECOMMENDED_TEAM_LIST = "/recommendedteamlist";
        // 删除推荐团队
        static String DEL_RECOMMENDED_TEAM_LIST = "/delrecommendedteam";
        // 添加推荐团队
        static String ADD_RECOMMENDED_TEAM = "/addrecommendedteamapi";
        // 获取动态详情
        static String DYNAMICDETAILS = "/dynamicdetails";

        // 发布动态评论
        static String DYNAMIC_COMMENT = "/addcomment";

        //发现 婚庆圈
        public static String HUNQINGQUAN = "/wedding";
        //发现 商城圈
        public static String SHOPQUAN = "/shops";
        // 成员列表
        static String MEMBER = "/member";
        // 获取推广广告位剩余数量
        static String GET_POPULARIZE_REMAIN_NUM = "/popularizingquantity";
        // 抢推广
        static String ROB_POPULARIZE = "/flowsheet";
        // 推广支付
        static String ROB_POPULARIZE_PAY = "/flowsheetapp";
        // 商户vip pay
        static String ROB_POPULARIZE_MALL_PAY = "/flowsheetshopapp";

        // 作品列表
        static String ZUOPIN = "/zuopin";
        // 联系方式
        static String CONTACT = "/contact";
        //商家详情 评价
        static String EVALUTE = "/businesscommentapp";
        //商家详情 动态
        static String DONGTAI = "/dongtaiapp";
        //动态点赞
        static String LIKE = "/likes";
        //动态取消点赞
        static String DISLIKE = "/qxlikes";

        //发布动态
        static String PUBLISH_DYNAMICS = "/publishingdynamicsd";

        //报价详情
        static String OFFOER = "/baojiaxq";
        // 获取发言稿列表
        static String GET_FAYANGAO_LIST = "/fayangaolist";
        // 删除发言稿
        static String DEL_FAYANGAO = "/delfayangao";
        // 新增发言稿
        static String ADD_FAYANGAO = "/addfayan";
        // 修改发言稿
        static String EDIT_FAYANGAO = "/editfayan";
        // 首页热门
        static String GET_INDEX_HOT = "/indexapp";
        // 首页商城
        static String GET_INDEX_SHOP = "/index";
        // 首页商城 分类
        static String GET_INDEX_SHOP_FENLEI = "/indexfenlei";
        // 新增婚礼流程
        static String ADD_WEDDING_FLOW = "/addliucheng";
        // 删除婚礼流程
        static String DEL_WEDDING_FLOW = "/delhliucheng";
        // 修改婚礼流程
        static String EDIT_WEDDING_FLOW = "/editliucheng";
        // 婚礼流程列表
        static String GET_WEDDING_FLOW_LIST = "/hliuchenglist";
        // 添加记账
        static String ADD_BILL = "/jizhangadd";
        // 删除记账
        static String DEL_BILL = "/deljizhang";
        // 修改记账
        static String EDIT_BILL = "/editjizhang";
        // 查询记账
        static String GET_BILL_LIST = "/jizhanglist";
        // 首页全部分类列表（婚庆）
        static String GET_WEDDING_TYPE_MENU = "/AllClassificationlist";
        // 首页全部分类列表（商城）
        static String GET_MALL_TYPE_MENU = "/allfenlei";
        // 广告二级数据获取
        static String GET_AD_SEC = "/recommends";
        // 新增日程安排
        static String ADD_SCHEDULE = "/addricheng";
        // 删除日程安排
        static String DEL_SCHEDULE = "/delricheng";
        // 修改日程安排
        static String EDIT_SCHEDULE = "/editricheng";
        //完成获取未完成日程
        static String EDIT_TYPE = "/setwricheng";
        // 获取日程安排列表
        static String GET_SCHEDULE_LIST = "/richenglist";
        //日程小红点
        static String GET_SCHEDULE_DOT = "/richengdian";
        // 获取宾客祝福和赴宴的接口
        static String GET_BINGKE_ZHUFU = "/zhufu";

        // 获取商品详情
        static String GET_GOODS_DETAILS = "/commoditydetailsappa";
        // 获取商城商家详情 - 热门商品
        static String GET_HOT_GOODS = "/remenapp";
        // 获取商城商家详情 - 全部商品
        static String GET_ALL_GOODS = "/allshopapp";
        // 获取商城商家详情 - 评价
        static String GET_SHOP_MALL_PINGJIA = "/businesscommentapp";
        // 获取商城商家详情 - 动态
        static String GET_SHOP_MALL_DONGTAI = "/dongtaiapp";

        //优惠列表
        static String MESSAGE_PREFERENTIAL = "/preferential_information";
        static String MESSAGE_TRADE = "/trading_message";
        static String MESSAGE_MOTICE = "/notification_message";

        // 请求请柬模板类型列表
        static String GET_INVITATIONS_TEMPLATE_TYPE_LIST = "/invitationstype";
        // 获取请柬模板列表
        static String GET_INVITATIONS_TEMPLATE_LIST = "/invitationslist";
        // 获取制作请柬预览url
        static String GET_MAKE_INVITATIONS_TEMPLATE_URL = "/invitationscreateyi";
        // 设置制作请柬信息
        static String SET_MAKE_INVITATIONS_INFOS = "/invitationscreateer";
        // 设置制作请柬信息
        static String SET_MAKE_INVITATIONS_INFOS2 = "/setinvitationsmcapp";
        // 修改请柬信息
        static String EDIT_INVITATIONS_INFOS = "/setinvitationsmc";
        // 获取音乐类别
        static String GET_MUSIC_TYPE_LIST = "/invitationsyinyuett";
        // 获取音乐列表
        static String GET_MUSIC_LIST = "/invitationsyinyue";
        // 设置模板音乐
        static String SET_TEMPLATE_MUSIC = "/setinvitationsyinyue";
        // 删除请柬
        static String DEL_INVITATIONS = "/delinvitations";
        // 个人实名认证
        static String SUBMIT_PERSON_CERTIFICATION = "/gerenrz";
        // 获取个人实名认证状态
        static String GET_PERSON_CERTIFICATION = "/seegerenrz";
        // 企业实名认证
        static String SUBMIT_COMPANY_CERTIFICATION = "/qiyerenz";
        // 获取企业实名认证状态
        static String GET_COMPANY_CERTIFICATION = "/seeqiyerz";

        //获取我的需求列表
        static String GET_MYNEED_LIST = "/mydemand";
        // 查看需求列表
        static String GET_OTHER_NEED_LIST = "/bierenxuqiu";
        // 关闭需求
        static String CLOSE_MYNEED = "/enddemand";
        // 删除需求
        static String DEL_MYNEED = "/delmydemand";
        // 获取我的需求详情
        static String GET_MYNEED_DETAIL = "/demanddetails";
        // 接单
        static String TAKE_NEED_ORDER = "/addwolaijd";
        // 参与详情
        static String GET_NEED_JOIN_DETAIL = "/canyudetails";
        // 与参与者合作
        static String NEED_COOPERATION = "/cooperation";
        // 获取婚礼新闻
        static String GET_WEDDING_NEWS = "/journalism";
        // 购物车信息
        static String GET_CART = "/indexsapp";

        /**
         * 婚庆圈
         */
        static String DISCOVER_WEDDING_LIST = "/wedding";
        // 获取我的邀请信息
        static String GET_MINE_INVITATION_INFO = "/index";
        // 根据定位城市名获取id
        static String GET_CITY_ID = "/dingweiid";
        // 删除购物车商品
        static String REMOVECART = "/drop";
        // 修改购物车商品数量
        static String UPDATE = "/update";

        // 订单结算
        static String SUREORDER = "/confirm_orders";
        // 订单结算信息提交
        static String SUBMITORDER = "/carttoorder";
        // 商城订单结算信息提交
        static String SUBMITMALLORDER = "/cartoorder";
        // 婚庆订单支付
        static String PAY_WEDDING_ORDER = "/hunqindindanapps";
        // 商城订单支付
        static String PAY_MALL_ORDER = "/zhifudindanapps";
        // 获取婚姻登记处列表
        static String GET_REGISTRYO_OF_MARRIAGE_LIST = "/registryofmarriage";
        //添加婚庆商品到购物车
        static String WEDDING_ADD = "/add";
        //获取购物车数量
        static String CART_NUM = "/getcartnumber";
        //婚庆立即购买 获取订单数据
        static String BUYNOW_WEDDING = "/getweddingmoneyapp";
        //商城立即购买 获取订单数据
        static String BUYNOW_MALL = "/getordermoney";
        //婚庆立即购买 提交订单数据
        static String SUBMIT_BUYNOW_WEDDING = "/buyweddingapp";
        //商城立即购买 提交订单数据
        static String SUBMIT_BUYNOW_MALL = "/createorderapp";
        //婚庆余额支付
        static String WEDDINGBLANCE = "/moneypaywedding";
        //商城余额支付
        static String SHOPBLANCE = "/shopmoneypay";
        //获取热门搜索
        static String SEARCH_HOT = "/searchrecordss";
        //搜索
        static String SEARCH = "/searchss";
        //动态关注
        static String DISCOVIER_ATTENTION = "/gzuser";
        //动态取消关注
        static String DISCOVIER_ATTENTION_CANCEL = "/qgzuser";
        //粉丝列表
        static String MY_FENSI = "/mfensi";
        //我的关注
        static String ATTENTION_LIST = "/follow";
        //余额
        static String BANK_BALANCE = "/balance";
        //收支明细
        static String BANK_SCHEDULE = "/balanceofpayments";
        //提现详情
        static String BANK_TIXIAN_DETAIL = "/tixian";
        //提交提现
        static String BANK_TIXIAN_SUBMIT = "/addtixian";
        //提交提现
        static String ALIPAY_TIXIAN_SUBMIT = "/apply_put_forward_ali";
        //银行卡删除
        static String BANK_CARDS_DELETE = "/delcard";
        //支付宝账户删除
        static String ALIPAY_DELETE = "/del_ali_pay";
        //银行卡列表
        static String BANK_CARDS_LIST = "/blacklist";
        //支付宝列表
        static String ALIPAY_LIST = "/ali_list";
        //添加银行卡第一步
        static String BANK_CARD_ADD1 = "/chabankcardapp";
        //添加支付宝账户
        static String ALI_PAY_ADD = "/add_ali_pay";
        //添加银行卡提交
        static String BANK_CARD_ADD3 = "/addbank";
        //婚庆订单详情
        static String DETAILS = "/detailsapp";
        //商城订单详情
        static String MALL_DETAILS = "/getorderbyidapp";
        //个人信息获取
        static String USER_INFO = "/personaldata";

        //个人信息获取
        static String USER_INFO_UPDATE = "/setPersonal";
        //收货地址列表
        static String ADDRESS_LIST = "/addresslist";
        //收货地址修改
        static String ADDRESS_UPDATE = "/updateAddsite";
        //收货地址删除
        static String ADDRESS_DELETE = "/delsite";
        //收货地址新增
        static String ADDRESS_ADD = "/addsite";
        //设置默认地址
        static String ADDRESS_DEFAULT = "/shemoren";
        //修改登录密码1
        public static String PASSWORD_UPDATE_ONE = "/retrievepwd";
        //修改登录密码2
        static String PASSWORD_UPDATE_TWO = "/retrievepwds";

        //修改支付密码1
        public static String PASSWORD_UPDATE_ONE_PAY = "/retrievepwd";
        //修改支付密码2
        static String PASSWORD_UPDATE_TWO_PAY = "/repaypwd";

        //修改手机1
        static String PHONE_UPDATE_ONE = "/upmobile";
        //修改手机2
        static String PHONE_UPDATE_TWO = "/upmobiles";
        //取消婚庆订单
        static String CANCEL_ORDER = "/cancelorder";
        //婚庆接单列表
        static String JIEDAN = "/saleorder";
        //商城接单列表
        static String MALLJIEDAN = "/saleorderapp";
        //第三方注册后绑定手机号码
        static String BIND_OTHER_PHONE = "/setmobilepass";
        //直接绑定第三方
        static String BIND_OTHER = "/threeparties";
        //用户协议
        static String AGREEMENT = "/useragreement";
        //婚庆订单退款详情
        static String WEDDING_REFUND = "/yonghutuikuan";
        //婚庆接单退款详情
        static String WEDDING_JIEDAN_REFUND = "/shangjiatuikuanchuli";
        //商城接单退款详情
        static String MALL_JIEDAN_REFUND = "/spyhtuikuan";
        //婚庆订单协商历史
        static String WEDDING_XIESHANG_HISTORY = "/xieshangapp";
        //商城订单协商历史
        static String MALL_XIESHANG_HISTORY = "/xieshang";
        //婚庆用户撤销退款
        static String WEDDING_CANLE_TUIKUAN = "/yonghuchexiao";
        //商城用户撤销退款
        static String MALL_CANLE_TUIKUAN = "/clearrefundsh";
        //婚庆申请退款
        static String WEDDING_SHENQINGTUIKUAN = "/tuikuantijiao";
        //创建社团
        static String COMMUNITY_CREATE = "/addshetuanapi";
        //加入社团列表
        static String COMMUNITY_ADD_LIST = "/shetuanlistapi";
        //申请加入
        public static final String COMMUNITY_ADD_APPLY = "/inassociation";
        //同意加入社团
        public static final String COMMUNITY_ADD_AGREED = "/tongyijiaru";
        //拒绝加入
        public static final String COMMUNITY_ADD_FEFUSE = "/jujuejiaru";
        //退出社团
        public static final String COMMUNITY_OUT = "/outassociation";
        //团队中心
        public static final String COMMUNITY_CENTER = "/teamcenter";
        //团队成员管理列表
        public static final String COMMUNITY_USER_MAMAGER_LIST = "/shetuanmemberlistapi";
        //团队设置管理员
        public static final String COMMUNITY_USER_MAMAGER_ADMIN_ADD = "/setguanli";
        //团队取消管理员
        public static final String COMMUNITY_USER_MAMAGER_ADMIN_CANCEL = "/unguanli";
        //删除成员
        public static final String COMMUNITY_USER_MAMAGER_ADMIN_DELETE = "/yichushetuan";
        //待通过成员列表
        public static final String COMMUNITY_USER_WAITING_LIST = "/waitthroughapi";
        //待通过成员同意
        public static final String COMMUNITY_USER_WAITING_AGREE = "/sagree";
        //待通过成员拒绝
        public static final String COMMUNITY_USER_WAITING_REFUSE = "/srefuse";
        //成员档期
        public static final String COMMUNITY_SCHEDULE = "/cydangqi";
        //今日新增
        public static final String COMMUNITY_TODAY_ADD_NEW = "/jrxingzen";
        //今日有单
        public static final String COMMUNITY_TODAY_ADD_HAOS = "/jryoudan";
        //邀请新成员列表
        public static final String COMMUNITY_INVITATION_LIST = "/invitationapi";
        //邀请新成员
        public static final String COMMUNITY_INVITATION_SEND = "/yaoqing";
        //邀请好友
        public static final String INVITATION_FRIEND = "/yaoqing";
        //尾款支付  三方支付
        public static final String WEIKUAN_PAY = "/weikuanzhifuapps";
        //尾款支付  余额支付
        public static final String WEIKUAN_PAY_YUE = "/moneypayweddingwk";
        //婚庆用户确认完成订单
        public static final String FINISH_WEDDING_ORDER = "/sureok";
        //婚庆商户接单
        public static final String AGREE_WEDDING_ORDER = "/jiedan";
        //婚庆商户拒绝接单
        public static final String CANEL_WEDDING_ORDER = "/jujuejiedan";
        //婚庆商户点击订单完成
        public static final String FINISH_WEDDING_ORDER_SHOP = "/paypartfinishorder";
        //婚庆商户点击订单完成
        public static final String FINISH_WEDDING_ORDER_SHOP2 = "/paypartfinishorder_shop";
        //婚庆用户选择线下支付
        public static final String FINISH_WEDDING_ORDER_SHOP3 = "/paypartfinishorder_user";
        //婚庆商户同意退款
        public static final String AGREE_WEDDING_ORDER_TUIKUAN = "/shangjiatongyiapp ";
        //婚庆商户拒绝退款
        public static final String CANEL_WEDDING_ORDER_TUIKUAN = "/shangjiajujueapp";
        //商城用户取消订单
        public static final String CANEL_MALL_ORDER = "/cancelorder";
        //商城用户确认收货
        public static final String SURE_GET_MALL_GOODS = "/sureorder";
        //商城商户发货
        public static final String POST_MALL_GOODS = "/fahuo";
        //查看物流
        public static final String CHAKANWULIU = "/chakanwuliuapp";
        //获取快递列表
        public static final String GET_KUAIDI_LIST = "/getkuaidilist";
        //订单添加评论
        public static final String ADD_PINGJIA = "/evaluate";
        //婚庆 修改价格
        public static final String MODIWEDDINGPRICE = "/modiprice";
        //商城 修改价格
        public static final String MODIMALLPRICE = "/modiorderprice";
        //获取分享内容
        public static final String SHARECONTENT = "/fenxiangjiekou";
        //店铺认证支付
        public static final String DIANPURENZHENG_PAY = "/zhifu";
        //用户开通VIP
        public static final String OPEN_VIP = "/openvip";
        //商户开通VIP
        public static final String OPEN_MALL_VIP = "/shopvip";
        //未发货退款
        public static final String TUIHUOKUAN = "/tuihuokuan";
        //【已发货退款】商品用户退款第一步，填写信息获取信息
        public static final String YIFAHUOTUIHUOKUAN = "/spyhtuikuansh";
        //【已发货退款】商品用户退款第二步，提交信息
        public static final String TUIHUOKUANFAHUO = "/tuihuokuanfahuo";
        //申请成为商家
        public static final String SHENQINGBESHOP = "/chengweishangjia";
        //邀请商家
        public static final String YAOQINGSJ = "/yaoqingsj";
        //APP更新
        public static final String ISEDITION = "/isedition";
        //【商家】同意退款【未发货退款】
        public static final String TONGYITUIKUAN = "/tongyituikuan";
        //【商家】拒绝退款【未发货退款】
        public static final String JUJUETUIKUAN = "/juejuetuikuan";
        //【商家】同意退款【已发货退款】
        public static final String TONGYYITUIHUIKUAN = "/tongyituihuikuan";
        //【商家】拒绝退款【已发货退款】
        public static final String REFUSERTURNGOODSSH = "/refusereturngoodssh";
        //【已发货退款】【商家】买家发货后商家确认收货
        public static final String FAHUOQUERENSHOUHUO = "/fahuoquerenshouhuo";
        //【已发货退款】【商家】买家发货后商家拒绝收货
        public static final String FAHUOJUJUESHOU = "/fahuojujueshou";
        //删除动态
        public static final String DELDYNAMICS = "/deldynamics";
        //积分商城首页
        public static final String INTEGRALINDEX = "/integralindex";
        //积分商城签到
        public static final String SIGNIN = "/signin";
        //查看全部商品
        public static final String SEEINTEGRALSHOP = "/seeintegralshop";
        //查看全部红包
        public static final String CHAKANHONGBAO = "/chakanhongbao";
        //积分明细
        public static final String INTEGRALDETAIL = "/integraldetail";
        //兑换记录
        public static final String DUIHUANJILU = "/duihuanjilu";
        //积分商城商品详情
        public static final String JIFENXIANGQING = "/jifenxiangqing";
        //积分商城红包详情
        public static final String HONGBAOXIANGQING = "/hongbaoxiangqing";
        //积分商城确认订单
        public static final String QUERENDINGDAN = "/querendingdan";
        //积分商城提交订单
        public static final String JIFENDINGDANZHIFU = "/jifendingdanzhifu";
        //[积分商品订单]有现金的支付
        public static final String XUXIANJINZHIFU = "/xuxianjinzhifu";
        // [积分商品订单]余额支付
        public static final String YUEZHIFU = "/yuezhifu";
        // [积分商品订单]单积分支付
        public static final String DANJIFENZHIFU = "/danjifenzhifu";
        // 兑换红包支付
        public static final String HONGBAODUIHUAN = "/hongbaoduihuan";
        // 积分商城商品订单详情
        public static final String JIFENDINGDANXQ = "/jifendingdanxq";
        // 积分商城取消订单
        public static final String QUXIAODINGDAN = "/quxiaodingdan";
        // 积分商城确认收货
        public static final String CONFIRMRECEIPT = "/confirmreceipt";
        // 积分商城查看物流
        public static final String CHAKANWULIUJIFEN = "/chakanwuliu";
        // 检查婚庆商城报价档期是否满足要求
        public static final String CHADANGQI = "/chadangqi";
        // 删除宾客祝福，赴宴，待定
        public static final String DELZHUFU = "/delzhufu";
        // 礼金列表
        public static final String LIJING = "/lijing";
        // 从选择模板获取模板信息
        public static final String INVITATIONSCREATEYI = "/invitationscreateyi";
        // 从我的请柬获取模板信息
        public static final String EDITINVITATION = "/editinvitation";
        // 电子请柬制作保存
        public static final String INVITATIONSCREATEER = "/invitationscreateer";
        // 电子请柬分享保存标题等
        public static final String SAVESHARE = "/saveshare";
        // 活动投票
        public static final String HUODONG = "/index_list";
        // 店铺是否上线
        public static final String SHOPONLINESTATUS = "/shop_online_status";
        // 店铺上线
        public static final String SHOPONLINE = "/shop_online";
    }

    //错误码
    public static class CODE {
        public static int SUCCESS = 200;
        public static int ERR = -1;
    }

    public static class Case_Type {

    }
}
