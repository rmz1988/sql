-- liquibase formatted sql

-- changeset lichen:2016102601
CREATE TABLE user (
  id              INT PRIMARY KEY AUTO_INCREMENT,
  userId          VARCHAR(60) UNIQUE
  COMMENT '用户编号，6位以上数字',
  idCard          VARCHAR(512) UNIQUE
  COMMENT '身份证号，AES',
  name            VARCHAR(128) COMMENT '姓名',
  mobile          VARCHAR(20) COMMENT '电话',
  bank            VARCHAR(3) COMMENT '开户行',
  bankAccountName VARCHAR(128) COMMENT '开户名或支付宝昵称',
  bankCard        VARCHAR(512) COMMENT '银行卡号或支付宝账号,AES加密',
  loginPwd        VARCHAR(32) COMMENT '登录密码',
  tradePwd        VARCHAR(32) COMMENT '交易密码',
  activatedNo     VARCHAR(3) COMMENT '被激活中心编号',
  recommendUserId VARCHAR(60) COMMENT '推荐人编号',
  petNo           VARCHAR(32) COMMENT '领养宠物编号',
  money           VARCHAR(20)     DEFAULT '0.00'
  COMMENT '金币总额',
  rePurchase      INT             DEFAULT 0
  COMMENT '复购次数',
  registerTime    BIGINT COMMENT '注册时间',
  activateTime    BIGINT COMMENT '激活时间',
  status          CHAR(1)         DEFAULT '1'
  COMMENT '0:停用，1：未激活，2：激活',
  recommendCount  INT             DEFAULT 0
  COMMENT '推荐人数',
  activeNo        VARCHAR(3) COMMENT '激活中心编号，有用户激活权限',
  lastLoginTime   BIGINT COMMENT '最后登录时间',
  isFeed          CHAR(1)         DEFAULT '0'
  COMMENT '今天是否已喂养宠物，0：否，1：是',
  isWithdraw      CHAR(1)         DEFAULT '0'
  COMMENT '今日是否已提现，0：否，1：是',
  todayIncome     VARCHAR(20)     DEFAULT '0.00'
  COMMENT '用户今天收益'
)
  COMMENT '玩家表'
  ENGINE = InnoDB;

CREATE TABLE pet (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  petNo       VARCHAR(32) UNIQUE
  COMMENT '宠物编号',
  name        VARCHAR(20) COMMENT '宠物名称',
  dailyOutput VARCHAR(20)     DEFAULT '30'
  COMMENT '金币日产量',
  lifecycle   INT             DEFAULT 15
  COMMENT '生命周期',
  price       VARCHAR(20)     DEFAULT '300'
  COMMENT '售价',
  img         VARCHAR(60) COMMENT '图片名称'
)
  COMMENT '宠物表'
  ENGINE = InnoDB;

INSERT INTO pet VALUES (NULL, 'tiane', '天鹅', 30, 15, 300, 'tiane.gif');
INSERT INTO pet VALUES (NULL, 'kongque', '孔雀', 30, 15, 300, 'kongque.gif');
INSERT INTO pet VALUES (NULL, 'qilin', '麒麟', 30, 15, 300, 'qilin.gif');

CREATE TABLE leader_rate (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  rateNo INT COMMENT '代次，即第几代,999代表无限代',
  rate   INT COMMENT '比例，默认%'
)
  COMMENT '领导奖提成比例'
  ENGINE =InnoDB;

INSERT INTO leader_rate VALUES (NULL, 1, 10);
INSERT INTO leader_rate VALUES (NULL, 2, 8);
INSERT INTO leader_rate VALUES (NULL, 3, 6);
INSERT INTO leader_rate VALUES (NULL, 4, 4);
INSERT INTO leader_rate VALUES (NULL, 5, 2);
INSERT INTO leader_rate VALUES (NULL, 6, 1);
INSERT INTO leader_rate VALUES (NULL, 7, 1);
INSERT INTO leader_rate VALUES (NULL, 999, 1);

CREATE TABLE other_rate (
  id      INT PRIMARY KEY AUTO_INCREMENT,
  rateKey VARCHAR(128) COMMENT '提成项',
  rate    VARCHAR(20) COMMENT '提成比例或提成值',
  note    TEXT COMMENT '说明'
)
  COMMENT '其他设置'
  ENGINE =InnoDB;

INSERT INTO other_rate VALUES (NULL, 'redirect_recommend_rate', '10', '直推用户按购买额的比例提成');
INSERT INTO other_rate VALUES (NULL, 'redirect_repurchase_rate', '10', '直推用户复购提成比例');
INSERT INTO other_rate VALUES (NULL, 'daily_output_rate', '13', '推荐4位玩家及以上再次复购后每日享受的购买额比例');
INSERT INTO other_rate VALUES (NULL, 'active_decrease_rate', '300', '激活一位玩家扣除金币数');
INSERT INTO other_rate VALUES (NULL, 'active_get_rate', '10', '激活一位玩家获得奖励金币数');
INSERT INTO other_rate VALUES (NULL, 'withdraw_rate', '10', '提现手续费率');
INSERT INTO other_rate VALUES (NULL, 'min_withdraw', '100', '最低提现金额');
INSERT INTO other_rate VALUES (NULL, 'operation_fee', '10', '每月扣除系统维护费');
INSERT INTO other_rate VALUES (NULL, 'qq', '100000', 'QQ号');
INSERT INTO other_rate VALUES (NULL, 'img_url', 'http://localhost:8080/images/', '图片访问地址');
INSERT INTO other_rate VALUES (NULL, 'img_path', '/images', '图片目录服务器地址');
INSERT INTO other_rate VALUES (NULL, 'daily_input_limit', '6000', '每天收入最大值');

CREATE TABLE dict (
  id        INT PRIMARY KEY AUTO_INCREMENT,
  dictGroup VARCHAR(60) COMMENT '字典组',
  dictName  VARCHAR(60) COMMENT '字典名称',
  dictValue VARCHAR(60) COMMENT '字典值'
)
  COMMENT '字典表'
  ENGINE = InnoDB;

INSERT INTO dict VALUES (NULL, 'bank', '0', '中国银行');
INSERT INTO dict VALUES (NULL, 'bank', '1', '中国农业银行');
INSERT INTO dict VALUES (NULL, 'bank', '2', '中国工商银行');
INSERT INTO dict VALUES (NULL, 'bank', '3', '中国建设银行');
INSERT INTO dict VALUES (NULL, 'bank', '4', '招商银行');
INSERT INTO dict VALUES (NULL, 'bank', '5', '交通银行');
INSERT INTO dict VALUES (NULL, 'bank', '6', '中信银行');
INSERT INTO dict VALUES (NULL, 'bank', '7', '华夏银行');
INSERT INTO dict VALUES (NULL, 'bank', '8', '兴业银行');
INSERT INTO dict VALUES (NULL, 'bank', '9', '民生银行');
INSERT INTO dict VALUES (NULL, 'bank', '10', '邮政储蓄银行');
INSERT INTO dict VALUES (NULL, 'bank', '11', '支付宝');
INSERT INTO dict VALUES (NULL, 'withdrawStatus', '0', '待审核');
INSERT INTO dict VALUES (NULL, 'withdrawStatus', '1', '已到账');
INSERT INTO dict VALUES (NULL, 'withdrawStatus', '2', '失败');
INSERT INTO dict VALUES (NULL, 'transferStatus', '1', '成功');
INSERT INTO dict VALUES (NULL, 'transferStatus', '0', '失败');
INSERT INTO dict VALUES (NULL, 'userStatus', '0', '停用');
INSERT INTO dict VALUES (NULL, 'userStatus', '1', '未激活');
INSERT INTO dict VALUES (NULL, 'userStatus', '2', '已激活');
INSERT INTO dict VALUES (NULL, 'petStatus', '0', '出局');
INSERT INTO dict VALUES (NULL, 'petStatus', '1', '有效');
INSERT INTO dict VALUES (NULL, 'activeApplyStatus', '0', '待审核');
INSERT INTO dict VALUES (NULL, 'activeApplyStatus', '1', '通过');
INSERT INTO dict VALUES (NULL, 'activeApplyStatus', '2', '拒绝');
INSERT INTO dict VALUES (NULL, 'activatedApplyStatus', '0', '等待激活');
INSERT INTO dict VALUES (NULL, 'activatedApplyStatus', '1', '已激活');
INSERT INTO dict VALUES (NULL, 'transferType', '0', '转出');
INSERT INTO dict VALUES (NULL, 'transferType', '1', '转入');

CREATE TABLE active_auth_apply (
  id             INT PRIMARY KEY AUTO_INCREMENT,
  applyId        VARCHAR(32) UNIQUE
  COMMENT '申请Id',
  userId         VARCHAR(60) COMMENT '玩家编号',
  name           VARCHAR(128) COMMENT '玩家姓名',
  recommendCount INT COMMENT '玩家推荐人数',
  activeNo       VARCHAR(3) UNIQUE
  COMMENT '激活中心号',
  applyTime      BIGINT COMMENT '申请时间',
  status         CHAR(1)         DEFAULT '0'
  COMMENT '0:待审核，1：通过，2：驳回',
  statusTime     BIGINT COMMENT '操作时间'
)
  COMMENT '激活中心权限申请'
  ENGINE =InnoDB;

CREATE TABLE pet_lifecycle (
  id              INT PRIMARY KEY AUTO_INCREMENT,
  userId          VARCHAR(60) COMMENT '玩家编号',
  petNo           VARCHAR(32) COMMENT '宠物编号',
  liveDays        INT             DEFAULT 1
  COMMENT '宠物生存天数',
  overtimeDays    INT             DEFAULT 15
  COMMENT '生命周期天数',
  price           VARCHAR(20) COMMENT '宠物售价',
  dailyOutput     VARCHAR(20) COMMENT '每日产币量',
  dailyOutputRate VARCHAR(10) COMMENT '每日产币比例',
  totalOutput     VARCHAR(20) COMMENT '累计产币量',
  createTime      BIGINT COMMENT '购买时间',
  status          CHAR(1) COMMENT '0:出局，1：有效',
  outTime         BIGINT COMMENT '出局时间'
)
  COMMENT '玩家宠物周期表'
  ENGINE =InnoDB;

CREATE TABLE goods (
  id      INT PRIMARY KEY AUTO_INCREMENT,
  goodsId VARCHAR(32) UNIQUE
  COMMENT '商品Id',
  name    VARCHAR(256) COMMENT '商品名称',
  img     VARCHAR(60) COMMENT '商品图片',
  price   VARCHAR(20) COMMENT '价格'
)
  COMMENT '商品表'
  ENGINE = InnoDB;

CREATE TABLE manager (
  id       INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(60) UNIQUE
  COMMENT '用户名',
  password VARCHAR(32) COMMENT '密码'
)
  COMMENT '后台管理员'
  ENGINE = InnoDB;

CREATE TABLE active_apply (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  applyId     VARCHAR(32) UNIQUE
  COMMENT '激活Id',
  userId      VARCHAR(60) COMMENT '玩家Id',
  name        VARCHAR(126) COMMENT '用户姓名',
  petName     VARCHAR(60) COMMENT '宠物名称',
  activatedNo VARCHAR(3) COMMENT '激活中心号',
  status      CHAR(1) COMMENT '0:等待激活，1：已激活',
  applyTime   BIGINT COMMENT '申请时间',
  statusTime  BIGINT COMMENT '操作时间'
)
  COMMENT '激活申请表'
  ENGINE = InnoDB;

CREATE TABLE active_income (
  id              INT PRIMARY KEY AUTO_INCREMENT,
  activatedUserId VARCHAR(60) COMMENT '被激活用户Id',
  name            VARCHAR(60) COMMENT '用户名称',
  income          VARCHAR(20) COMMENT '激活奖励',
  createTime      BIGINT COMMENT '激活时间',
  userId          VARCHAR(60) COMMENT '用户Id'
)
  COMMENT '激活收益'
  ENGINE = InnoDB;

# CREATE TABLE daily_income (
#   userId     VARCHAR(60) COMMENT '玩家Id',
#   createTime VARCHAR(10) COMMENT '日期',
#   output     VARCHAR(20) COMMENT '产币数',
#   teamIncome VARCHAR(20) COMMENT '团队所得金币'
# )
#   COMMENT '每日收入明细'
#   ENGINE = InnoDB;

CREATE TABLE recommend_income (
  id              INT PRIMARY KEY AUTO_INCREMENT,
  recommendUserId VARCHAR(60) COMMENT '推荐用户编号',
  name            VARCHAR(126) COMMENT '用户姓名',
  income          VARCHAR(20) COMMENT '奖励收入',
  createTime      BIGINT COMMENT '创建时间',
  userId          VARCHAR(20) COMMENT '玩家编号'
)
  COMMENT '推荐奖'
  ENGINE =InnoDB;

CREATE TABLE total_income (
  id              INT PRIMARY KEY AUTO_INCREMENT,
  output          VARCHAR(20) COMMENT '静态产币',
  recommendIncome VARCHAR(20) COMMENT '推荐奖励',
  leaderIncome    VARCHAR(20) COMMENT '领导奖',
  activeIncome    VARCHAR(20) COMMENT '激活奖',
  currentTotal    VARCHAR(20) COMMENT '当前余额',
  createTime      VARCHAR(10) COMMENT '日期',
  userId          VARCHAR(60) COMMENT '用户Id'
)
  COMMENT '总收入明细'
  ENGINE = InnoDB;

CREATE TABLE withdraw (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  withdrawId VARCHAR(32) UNIQUE
  COMMENT '提现Id',
  userId     VARCHAR(60) COMMENT '用户编号',
  money      VARCHAR(20) COMMENT '提现金额',
  bankName   VARCHAR(128) COMMENT '银行名称',
  cardNo     VARCHAR(60) COMMENT '卡号',
  status     CHAR(1)         DEFAULT '0'
  COMMENT '0:待审核,1:成功，2：失败',
  createTime BIGINT COMMENT '申请时间',
  statusTime BIGINT COMMENT '审核时间'
)
  COMMENT '提现'
  ENGINE = InnoDB;

CREATE TABLE transfer (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  transferId VARCHAR(32) UNIQUE
  COMMENT '转账编号',
  outUserId  VARCHAR(60) COMMENT '转出编号',
  inUserId   VARCHAR(60) COMMENT '转入编号',
  money      VARCHAR(20) COMMENT '金额',
  type       CHAR(1) COMMENT '0：转出，1：转入',
  status     CHAR(1) COMMENT '0:失败，1：成功',
  createTime BIGINT COMMENT '时间'
)
  COMMENT '转账'
  ENGINE =InnoDB;