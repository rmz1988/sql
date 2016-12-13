-- liquibase formatted sql

-- changeset lichen:2016121301
ALTER TABLE active_apply
ADD COLUMN activateUserId VARCHAR(60) COMMENT '激活用户编号';
ALTER TABLE active_apply
DROP COLUMN activatedNo;

ALTER TABLE pet_lifecycle
DROP COLUMN dailyOutputRate;

ALTER TABLE user
ADD COLUMN activateUserId VARCHAR(60) COMMENT '激活用户编号';

-- changeset lichen:2016121302
UPDATE user u1, user u2
SET u1.activateUserId = u2.userId
WHERE u1.activatedNo = u2.activeNo AND u1.userId != '171109';

-- changeset lichen:2016121303
ALTER TABLE user
DROP COLUMN activatedNo;
ALTER TABLE user
DROP COLUMN todayTransferActiveLimitMoney;
ALTER TABLE user
DROP COLUMN isWithdraw;
ALTER TABLE user
DROP COLUMN bank;
ALTER TABLE user
DROP COLUMN bankAccountName;
ALTER TABLE user
DROP COLUMN bankCard;
ALTER TABLE user
ADD COLUMN total VARCHAR(20) DEFAULT '0.00'
COMMENT '累计收益';

ALTER TABLE total_income
DROP COLUMN activeIncome;
ALTER TABLE total_income
DROP COLUMN currentTotal;
ALTER TABLE total_income
DROP COLUMN withdrawOutput;
ALTER TABLE total_income
DROP COLUMN purchaseIncome;
ALTER TABLE total_income
DROP COLUMN purchaseOutput;

DELETE FROM other_rate
WHERE rateKey IN ('redirect_repurchase_rate', 'daily_output_rate', 'active_get_rate', 'daily_output_normal_rate');
UPDATE other_rate
SET rateKey = 'active_decrease_money', rate = '300'
WHERE rateKey = 'active_decrease_rate';
UPDATE other_rate
SET rateKey = 'fee_rate', note = '互转手续费率'
WHERE rateKey = 'withdraw_rate';
UPDATE other_rate
SET rateKey = 'money_limit', rate = '300.00', note = '互转、转激活币最低金额'
WHERE rateKey = 'min_withdraw';
UPDATE other_rate
SET rate = '30'
WHERE rateKey = 'operation_fee';
UPDATE other_rate
SET rate = '1'
WHERE rateKey = 'daily_repurchase_limit';

INSERT INTO other_rate VALUES (NULL, 'pet_initial_output', '20.00', '宠物初始产币量');
INSERT INTO other_rate VALUES (NULL, 'pet_initial_lifecycle', '20', '宠物初始生命周期');
INSERT INTO other_rate VALUES (NULL, 'pet_repurchase_output', '30.00', '宠物复购产币量');
INSERT INTO other_rate VALUES (NULL, 'pet_repurchase_lifecycle', '15', '宠物复购生命周期');

-- changeset lichen:2016121304
CREATE TABLE feed_income (
  id         INT PRIMARY KEY  AUTO_INCREMENT,
  userId     VARCHAR(60) COMMENT '玩家编号',
  petNo      VARCHAR(32) COMMENT '宠物编号',
  output     VARCHAR(20) COMMENT '产币量',
  createTime BIGINT COMMENT '喂养时间'
)
  COMMENT '宠物喂养记录'
  ENGINE = InnoDB;

-- changeset lichen:2016121305
ALTER TABLE user
DROP COLUMN activeNo;

-- changeset lichen:2016121306
UPDATE other_rate
SET rate = '3000'
WHERE rateKey = 'daily_input_limit';

-- changeset lichen:2016121307
ALTER TABLE user
ADD COLUMN activeRecommendCount INT DEFAULT 0
COMMENT '推荐动态用户数量';

UPDATE user uu, (SELECT
                   u.recommendUserId,
                   count(u.userId) c
                 FROM
                   (SELECT
                      u1.userId userId,
                      u2.userId recommendUserId
                    FROM user u1, user u2
                    WHERE u1.recommendUserId = u2.userId AND u1.recommendCount > 0) u
                 GROUP BY u.recommendUserId) uuu
SET uu.activeRecommendCount = uuu.c
WHERE uu.userId = uuu.recommendUserId;

-- changeset lichen:2016121308
TRUNCATE TABLE active_apply;
TRUNCATE TABLE leader_income;
TRUNCATE TABLE pet_lifecycle;
TRUNCATE TABLE total_income;
TRUNCATE TABLE transfer;
TRUNCATE TABLE transfer_to_active;
TRUNCATE TABLE active_income;
TRUNCATE TABLE recharge;
TRUNCATE TABLE recommend_income;
INSERT INTO pet_lifecycle SELECT
                            NULL,
                            userId,
                            petNo,
                            1,
                            20,
                            '300.00',
                            '20.00',
                            '0.00',
                            activateTime,
                            '1',
                            NULL
                          FROM user;

-- changeset lichen:2016121309
UPDATE user
SET money = '0.00', activeMoney = '0.00', todayLimitMoney = '0.00';

-- changeset lichen:2016121310
UPDATE user
SET isFeed = '0', rePurchase = 0, todayRepurchase = 0;

-- changeset lichen:2016121311
UPDATE user
SET todayIncome = '0.00';

