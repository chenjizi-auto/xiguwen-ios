# Cache Strategy

## 目标

为 `xiguwen` 项目建立一套统一的本地缓存策略，优先解决以下问题：

- 基础字典接口重复请求
- 弱网或接口失败时页面不可用
- 页面各自维护缓存，逻辑分散
- 后续新接口接入缓存时缺少统一规范

当前项目已经按这套策略落地了地区、商品类目、婚礼类型/环境、热门城市/城市字典等基础数据缓存。

## 总体设计

当前缓存采用两层结构：

1. 内存缓存
2. SQLite 持久化缓存

读取顺序：

1. 先读内存
2. 内存没有则读 SQLite
3. SQLite 命中则直接返回
4. 如果缓存已过期，后台静默刷新
5. SQLite 未命中再请求网络
6. 网络成功后更新内存和 SQLite
7. 网络失败但本地有旧数据时，继续返回旧数据

## 缓存分层

### 1. 结构化缓存

适用于具备明显层级关系、需要按父子节点查询的数据。

当前已接入：

- `appapi/System/huoqudiqu`

实现方式：

- 独立 `region` 表
- 省市区三级扁平化存储
- 查询时再恢复成 `ProvinceBean -> CityBean -> CountyBean` 树结构

### 2. JSON 缓存

适用于字典、筛选项、类目等整包读取的数据。

当前已接入：

- 商品父类目
- 商品子类目
- 婚礼类型
- 婚礼环境
- 案例搜索婚礼类型
- 案例搜索婚礼环境
- 热门城市 + 城市字典
- 城市区域列表
- 城市名称转城市对象

实现方式：

- 通用 `api_cache` 表
- 使用 `Gson` 序列化/反序列化
- 按接口和参数生成缓存 key

## 数据库设计

### region 表

用于缓存地区树：

- `id`
- `parent_id`
- `region_code`
- `name`
- `level`
- `initial`
- `pinyin`
- `status`
- `weigh`
- `is_new`
- `sort_index`
- `updated_at`

说明：

- `level = 1` 表示省
- `level = 2` 表示市
- `level = 3` 表示区县
- `parent_id = 0` 表示顶级省份

### api_cache 表

用于缓存通用 JSON 数据：

- `cache_key`
- `api_path`
- `params_hash`
- `user_scope`
- `data_json`
- `data_version`
- `expired_at`
- `last_success_at`
- `created_at`
- `updated_at`

说明：

- 当前公共字典统一使用 `user_scope = 0`
- `expired_at` 控制过期时间
- `data_json` 保存序列化后的对象或列表

## 代码结构

### 基础类

- [CacheDbHelper.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/CacheDbHelper.java)
- [CachePolicy.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/CachePolicy.java)
- [OnCacheRequestFinish.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/OnCacheRequestFinish.java)

### DAO

- [RegionDao.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/dao/RegionDao.java)
- [ApiCacheDao.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/dao/ApiCacheDao.java)

### Repository

- [RegionRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/RegionRepository.java)
- [CommodityTypeRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/CommodityTypeRepository.java)
- [WeddingDictionaryRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/WeddingDictionaryRepository.java)
- [CityDictionaryRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/CityDictionaryRepository.java)

## 已落地接口

### 1. 地区接口

接口：

- `appapi/System/huoqudiqu`

仓库：

- [RegionRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/RegionRepository.java)

已接入页面：

- [AddMineCommodityActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/AddMineCommodityActivity.java)
- [DianPuMsgActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/DianPuMsgActivity.java)

策略：

- 本地优先
- 过期后台刷新
- 网络成功后全量替换 `region` 表

### 2. 商品类目

接口：

- 商品父类目
- 商品子类目

仓库：

- [CommodityTypeRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/CommodityTypeRepository.java)

已接入页面：

- [AddMineCommodityActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/AddMineCommodityActivity.java)

策略：

- `api_cache` JSON 缓存
- 父类目固定 key
- 子类目按 `pid` 分 key 缓存

### 3. 婚礼类型 / 环境

接口：

- `weddingtype`
- `weddingenvironment`
- 案例搜索类型接口
- 案例搜索环境接口

仓库：

- [WeddingDictionaryRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/WeddingDictionaryRepository.java)

已接入页面：

- [AddExampleActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/AddExampleActivity.java)
- [MineExampleDetailsActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/MineExampleDetailsActivity.java)
- [SearchExampleActivty.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/SearchExampleActivty.java)
- [SearchCaseFragment.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/fragment/search/SearchCaseFragment.java)

策略：

- `api_cache` JSON 缓存
- 本地命中直接返回
- 过期后台刷新

### 4. 热门城市 / 城市字典 / 区域列表

接口：

- `cityList()`
- `getCiteListeNew(cityId)`
- `getCityIdNew(cityName)`

仓库：

- [CityDictionaryRepository.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/repository/CityDictionaryRepository.java)

已接入页面：

- [CityListActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/fragment/city/CityListActivity.java)
- [MallListActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/MallListActivity.java)
- [MallListByMenuActivity.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/ui/MallListByMenuActivity.java)
- [SearchMerchantsFragment.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/fragment/search/SearchMerchantsFragment.java)

策略：

- 城市总字典和热门城市共用一个缓存 key
- 区域列表按 `cityId` 分 key 缓存
- 城市名转对象按 `cityName` 分 key 缓存

## TTL 规则

定义在 [CachePolicy.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/CachePolicy.java)：

- `TTL_REGION = 7天`
- `TTL_DICT = 3天`
- `TTL_CONFIG = 1天`

建议使用规范：

- 地区：7天
- 基础字典：3天
- 配置类：1天
- 强实时数据：不要直接套当前缓存方案

## 统一接入规范

后续新接口接缓存，优先按下面规则判断：

### 适合缓存

- 地区
- 城市字典
- 类目
- 婚礼类型
- 婚礼环境
- 职业、筛选项、枚举项
- 不依赖登录态的公共字典

### 不建议直接缓存

- 支付状态
- 订单状态
- 实时库存
- 提交结果
- 审核状态

## 新接口如何接入

### 方案一：结构化表

适用：

- 树结构
- 父子关系强
- 需要按层级查询

做法：

1. 新建表
2. 新建 DAO
3. 新建 Repository
4. 页面改为调 Repository

### 方案二：通用 JSON 缓存

适用：

- 列表型字典
- 整包读取
- 不需要复杂查询

做法：

1. 在对应 Repository 中定义 `cacheKey`
2. 指定 `apiPath`
3. 使用 `TypeToken` 定义反序列化类型
4. 统一走 `api_cache` 表

## 页面调用规范

页面不再直接做缓存判断，也不自己写过期逻辑。

推荐调用方式：

1. 页面调用 Repository
2. Repository 内部决定：
   - 读内存
   - 读 SQLite
   - 是否请求网络
   - 是否静默刷新

回调统一使用：

- [OnCacheRequestFinish.java](/Users/cjz/android_project/xiguwen/xiguwen/src/main/java/com/linzi/xiguwen/cache/OnCacheRequestFinish.java)

其中：

- `onSuccess(data, true)` 表示本地缓存返回
- `onSuccess(data, false)` 表示网络返回

## 当前策略总结

当前项目缓存已经形成以下统一规范：

- 基础数据优先走 Repository
- 结构数据走结构表
- 普通字典走 `api_cache`
- 页面不直接处理缓存细节
- 本地命中优先返回
- 过期后台刷新
- 网络失败时尽量使用旧缓存兜底

## 后续建议

可以继续按这套方案接入：

- 运费模板
- 职业列表
- 更多筛选项字典
- 城市定位相关旧调用统一改到 `CityDictionaryRepository`

不建议把订单、支付、审核这类强实时接口直接纳入当前这套基础缓存方案。
