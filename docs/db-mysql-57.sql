/*
 Navicat MySQL Data Transfer

 Source Server         : 101.33.231.129
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : 101.33.231.129:3308
 Source Schema         : jeepaydb

 Target Server Type    : MySQL
 Target Server Version : 50799
 File Encoding         : 65001

 Date: 17/02/2023 12:18:47
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_isv_info
-- ----------------------------
DROP TABLE IF EXISTS `t_isv_info`;
CREATE TABLE `t_isv_info`  (
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务商号',
  `isv_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务商名称',
  `isv_short_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务商简称',
  `contact_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人手机号',
  `contact_email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人邮箱',
  `state` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-停用, 1-正常',
  `remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `created_uid` bigint NULL DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`isv_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务商信息表';

-- ----------------------------
-- Records of t_isv_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_mch_app
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_app`;
CREATE TABLE `t_mch_app`  (
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `app_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '应用名称',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `state` tinyint NOT NULL DEFAULT 1 COMMENT '应用状态: 0-停用, 1-正常',
  `app_secret` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用私钥',
  `remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `created_uid` bigint NULL DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`app_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户应用表';

-- ----------------------------
-- Records of t_mch_app
-- ----------------------------
BEGIN;
INSERT INTO `t_mch_app` (`app_id`, `app_name`, `mch_no`, `state`, `app_secret`, `remark`, `created_uid`, `created_by`, `created_at`, `updated_at`) VALUES ('63eef572e4b09bf64d47f7df', '默认应用', 'M1676604786', 1, '9fr17c09dbql3od13w72jktoj763i70c4qm3gxw2e7yvg5rtoin0qjent7872ykoju07i6ihy4wr67iu4emsnhu4ywe95hr5cj1rz2y7dlbda6x6cyanw768gk3kqwkp', NULL, 100001, '测试商家', '2023-02-17 11:33:06.342261', '2023-02-17 11:33:06.342261');
COMMIT;

-- ----------------------------
-- Table structure for t_mch_division_receiver
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_division_receiver`;
CREATE TABLE `t_mch_division_receiver`  (
  `receiver_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分账接收者ID',
  `receiver_alias` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接收者账号别名',
  `receiver_group_id` bigint NULL DEFAULT NULL COMMENT '组ID（便于商户接口使用）',
  `receiver_group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组名称',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付接口代码',
  `acc_type` tinyint NOT NULL COMMENT '分账接收账号类型: 0-个人(对私) 1-商户(对公)',
  `acc_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分账接收账号',
  `acc_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分账接收账号名称',
  `relation_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分账关系类型（参考微信）， 如： SERVICE_PROVIDER 服务商等',
  `relation_type_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '当选择自定义时，需要录入该字段。 否则为对应的名称',
  `division_profit` decimal(20, 6) NULL DEFAULT NULL COMMENT '分账比例',
  `state` tinyint NOT NULL COMMENT '分账状态（本系统状态，并不调用上游关联关系）: 1-正常分账, 0-暂停分账',
  `channel_bind_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '上游绑定返回信息，一般用作查询账号异常时的记录',
  `channel_ext_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '渠道特殊信息',
  `bind_success_time` datetime NULL DEFAULT NULL COMMENT '绑定成功时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`receiver_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 800001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户分账接收者账号绑定关系表';

-- ----------------------------
-- Records of t_mch_division_receiver
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_mch_division_receiver_group
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_division_receiver_group`;
CREATE TABLE `t_mch_division_receiver_group`  (
  `receiver_group_id` bigint NOT NULL AUTO_INCREMENT COMMENT '组ID',
  `receiver_group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组名称',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `auto_division_flag` tinyint NOT NULL DEFAULT 0 COMMENT '自动分账组（当订单分账模式为自动分账，改组将完成分账逻辑） 0-否 1-是',
  `created_uid` bigint NOT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`receiver_group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分账账号组';

-- ----------------------------
-- Records of t_mch_division_receiver_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_mch_info
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_info`;
CREATE TABLE `t_mch_info`  (
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `mch_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `mch_short_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户简称',
  `type` tinyint NOT NULL DEFAULT 1 COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商号',
  `contact_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人手机号',
  `contact_email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人邮箱',
  `state` tinyint NOT NULL DEFAULT 1 COMMENT '商户状态: 0-停用, 1-正常',
  `remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户备注',
  `init_user_id` bigint NULL DEFAULT NULL COMMENT '初始用户ID（创建商户时，允许商户登录的用户）',
  `created_uid` bigint NULL DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`mch_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户信息表';

-- ----------------------------
-- Records of t_mch_info
-- ----------------------------
BEGIN;
INSERT INTO `t_mch_info` (`mch_no`, `mch_name`, `mch_short_name`, `type`, `isv_no`, `contact_name`, `contact_tel`, `contact_email`, `state`, `remark`, `init_user_id`, `created_uid`, `created_by`, `created_at`, `updated_at`) VALUES ('M1676604786', '测试商家', '测试商家', 1, NULL, '测试商家', '13900139000', NULL, 1, NULL, 100001, 801, '超管', '2023-02-17 11:33:06.178959', '2023-02-17 11:33:06.355681');
COMMIT;

-- ----------------------------
-- Table structure for t_mch_notify_record
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_notify_record`;
CREATE TABLE `t_mch_notify_record`  (
  `notify_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商户通知记录ID',
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单ID',
  `order_type` tinyint NOT NULL COMMENT '订单类型:1-支付,2-退款',
  `mch_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户订单号',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `notify_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知地址',
  `res_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '通知响应结果',
  `notify_count` int NOT NULL DEFAULT 0 COMMENT '通知次数',
  `notify_count_limit` int NOT NULL DEFAULT 6 COMMENT '最大通知次数, 默认6次',
  `state` tinyint NOT NULL DEFAULT 1 COMMENT '通知状态,1-通知中,2-通知成功,3-通知失败',
  `last_notify_time` datetime NULL DEFAULT NULL COMMENT '最后一次通知时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`notify_id`) USING BTREE,
  UNIQUE INDEX `Uni_OrderId_Type`(`order_id`, `order_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户通知记录表';

-- ----------------------------
-- Records of t_mch_notify_record
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_mch_pay_passage
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_pay_passage`;
CREATE TABLE `t_mch_pay_passage`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付接口',
  `way_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付方式',
  `rate` decimal(20, 6) NOT NULL COMMENT '支付方式费率',
  `risk_config` json NULL COMMENT '风控数据',
  `state` tinyint NOT NULL COMMENT '状态: 0-停用, 1-启用',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Uni_AppId_WayCode`(`app_id`, `if_code`, `way_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户支付通道表';

-- ----------------------------
-- Records of t_mch_pay_passage
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_order_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `t_order_snapshot`;
CREATE TABLE `t_order_snapshot`  (
  `order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单ID',
  `order_type` tinyint NOT NULL COMMENT '订单类型: 1-支付, 2-退款',
  `mch_req_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '下游请求数据',
  `mch_req_time` datetime NULL DEFAULT NULL COMMENT '下游请求时间',
  `mch_resp_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '向下游响应数据',
  `mch_resp_time` datetime NULL DEFAULT NULL COMMENT '向下游响应时间',
  `channel_req_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '向上游请求数据',
  `channel_req_time` datetime NULL DEFAULT NULL COMMENT '向上游请求时间',
  `channel_resp_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '上游响应数据',
  `channel_resp_time` datetime NULL DEFAULT NULL COMMENT '上游响应时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`order_id`, `order_type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单接口数据快照';

-- ----------------------------
-- Records of t_order_snapshot
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_pay_interface_config
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_interface_config`;
CREATE TABLE `t_pay_interface_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `info_type` tinyint NOT NULL COMMENT '账号类型:1-服务商 2-商户 3-商户应用',
  `info_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务商号/商户号/应用ID',
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付接口代码',
  `if_params` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口配置参数,json字符串',
  `if_rate` decimal(20, 6) NULL DEFAULT NULL COMMENT '支付接口费率',
  `state` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-停用, 1-启用',
  `remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `created_uid` bigint NULL DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_uid` bigint NULL DEFAULT NULL COMMENT '更新者用户ID',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者姓名',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Uni_InfoType_InfoId_IfCode`(`info_type`, `info_id`, `if_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付接口配置参数表';

-- ----------------------------
-- Records of t_pay_interface_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_pay_interface_define
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_interface_define`;
CREATE TABLE `t_pay_interface_define`  (
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口代码 全小写  wxpay alipay ',
  `if_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口名称',
  `is_mch_mode` tinyint NOT NULL DEFAULT 1 COMMENT '是否支持普通商户模式: 0-不支持, 1-支持',
  `is_isv_mode` tinyint NOT NULL DEFAULT 1 COMMENT '是否支持服务商子商户模式: 0-不支持, 1-支持',
  `config_page_type` tinyint NOT NULL DEFAULT 1 COMMENT '支付参数配置页面类型:1-JSON渲染,2-自定义',
  `isv_params` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ISV接口配置定义描述,json字符串',
  `isvsub_mch_params` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '特约商户接口配置定义描述,json字符串',
  `normal_mch_params` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '普通商户接口配置定义描述,json字符串',
  `way_codes` json NOT NULL COMMENT '支持的支付方式 [\"wxpay_jsapi\", \"wxpay_bar\"]',
  `icon` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面展示：卡片-图标',
  `bg_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面展示：卡片-背景色',
  `state` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-停用, 1-启用',
  `remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`if_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付接口定义表';

-- ----------------------------
-- Records of t_pay_interface_define
-- ----------------------------
BEGIN;
INSERT INTO `t_pay_interface_define` (`if_code`, `if_name`, `is_mch_mode`, `is_isv_mode`, `config_page_type`, `isv_params`, `isvsub_mch_params`, `normal_mch_params`, `way_codes`, `icon`, `bg_color`, `state`, `remark`, `created_at`, `updated_at`) VALUES ('alipay', '支付宝官方', 1, 1, 2, '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"沙箱环境,生产环境\",\"verify\":\"required\"},{\"name\":\"pid\",\"desc\":\"合作伙伴身份（PID）\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"privateKey\", \"desc\":\"应用私钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"alipayPublicKey\", \"desc\":\"支付宝公钥(不使用证书时必填)\", \"type\": \"textarea\",\"star\":\"1\"},{\"name\":\"signType\",\"desc\":\"接口签名方式(推荐使用RSA2)\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"RSA,RSA2\",\"titles\":\"RSA,RSA2\",\"verify\":\"required\"},{\"name\":\"useCert\",\"desc\":\"公钥证书\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"使用证书（请使用RSA2私钥）,不使用证书\"},{\"name\":\"appPublicCert\",\"desc\":\"应用公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayPublicCert\",\"desc\":\"支付宝公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayRootCert\",\"desc\":\"支付宝根证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"}]', '[{\"name\":\"appAuthToken\", \"desc\":\"子商户app_auth_token\", \"type\": \"text\",\"readonly\":\"readonly\"},{\"name\":\"refreshToken\", \"desc\":\"子商户刷新token\", \"type\": \"hidden\",\"readonly\":\"readonly\"},{\"name\":\"expireTimestamp\", \"desc\":\"authToken有效期（13位时间戳）\", \"type\": \"hidden\",\"readonly\":\"readonly\"}]', '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"沙箱环境,生产环境\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"privateKey\", \"desc\":\"应用私钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"alipayPublicKey\", \"desc\":\"支付宝公钥(不使用证书时必填)\", \"type\": \"textarea\",\"star\":\"1\"},{\"name\":\"signType\",\"desc\":\"接口签名方式(推荐使用RSA2)\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"RSA,RSA2\",\"titles\":\"RSA,RSA2\",\"verify\":\"required\"},{\"name\":\"useCert\",\"desc\":\"公钥证书\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"使用证书（请使用RSA2私钥）,不使用证书\"},{\"name\":\"appPublicCert\",\"desc\":\"应用公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayPublicCert\",\"desc\":\"支付宝公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayRootCert\",\"desc\":\"支付宝根证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"}]', '[{\"wayCode\": \"ALI_JSAPI\"}, {\"wayCode\": \"ALI_WAP\"}, {\"wayCode\": \"ALI_BAR\"}, {\"wayCode\": \"ALI_APP\"}, {\"wayCode\": \"ALI_PC\"}, {\"wayCode\": \"ALI_QR\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/alipay.png', '#1779FF', 1, '支付宝官方通道', '2023-02-17 04:33:35.782313', '2023-02-17 04:33:35.782313'), ('plspay', '计全付', 1, 0, 1, NULL, NULL, '[{\"name\":\"signType\",\"desc\":\"签名方式\",\"type\":\"radio\",\"verify\":\"required\",\"values\":\"MD5,RSA2\",\"titles\":\"MD5,RSA2\"},{\"name\":\"merchantNo\",\"desc\":\"计全付商户号\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appSecret\",\"desc\":\"md5秘钥\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"rsa2AppPrivateKey\",\"desc\":\"RSA2: 应用私钥\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"rsa2PayPublicKey\",\"desc\":\"RSA2: 支付网关公钥\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"}]', '[{\"wayCode\": \"ALI_APP\"}, {\"wayCode\": \"ALI_BAR\"}, {\"wayCode\": \"ALI_JSAPI\"}, {\"wayCode\": \"ALI_LITE\"}, {\"wayCode\": \"ALI_PC\"}, {\"wayCode\": \"ALI_QR\"}, {\"wayCode\": \"ALI_WAP\"}, {\"wayCode\": \"WX_APP\"}, {\"wayCode\": \"WX_BAR\"}, {\"wayCode\": \"WX_H5\"}, {\"wayCode\": \"WX_JSAPI\"}, {\"wayCode\": \"WX_LITE\"}, {\"wayCode\": \"WX_NATIVE\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/plspay.svg', '#0CACFF', 1, '计全付', '2023-02-17 04:33:35.811060', '2023-02-17 04:33:35.811060'), ('pppay', 'PayPal支付', 1, 0, 1, NULL, NULL, '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"required\",\"values\":\"1,0\",\"titles\":\"沙箱环境, 生产环境\"},{\"name\":\"clientId\",\"desc\":\"Client ID（客户端ID）\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"secret\",\"desc\":\"Secret（密钥）\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"refundWebhook\",\"desc\":\"退款 Webhook id\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"notifyWebhook\",\"desc\":\"支付 Webhook id\",\"type\":\"text\",\"verify\":\"required\"}]', '[{\"wayCode\": \"PP_PC\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/paypal.png', '#005ea6', 1, 'PayPal官方通道', '2023-02-17 04:33:35.806782', '2023-02-17 04:33:35.806782'), ('wxpay', '微信支付官方', 1, 1, 2, '[{\"name\":\"mchId\", \"desc\":\"微信支付商户号\", \"type\": \"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appSecret\",\"desc\":\"应用AppSecret\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"oauth2Url\", \"desc\":\"oauth2地址（置空将使用官方）\", \"type\": \"text\"},{\"name\":\"apiVersion\", \"desc\":\"微信支付API版本\", \"type\": \"radio\",\"values\":\"V2,V3\",\"titles\":\"V2,V3\",\"verify\":\"required\"},{\"name\":\"key\", \"desc\":\"APIv2密钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"apiV3Key\", \"desc\":\"APIv3密钥（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\"},{\"name\":\"serialNo\", \"desc\":\"序列号（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\"},{\"name\":\"cert\", \"desc\":\"API证书(apiclient_cert.p12)\", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientCert\", \"desc\":\"证书文件(apiclient_cert.pem) \", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientKey\", \"desc\":\"私钥文件(apiclient_key.pem)\", \"type\": \"file\",\"verify\":\"\"}]', '[{\"name\":\"subMchId\",\"desc\":\"子商户ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"subMchAppId\",\"desc\":\"子账户appID(线上支付必填)\",\"type\":\"text\",\"verify\":\"\"}]', '[{\"name\":\"mchId\", \"desc\":\"微信支付商户号\", \"type\": \"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appSecret\",\"desc\":\"应用AppSecret\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"oauth2Url\", \"desc\":\"oauth2地址（置空将使用官方）\", \"type\": \"text\"},{\"name\":\"apiVersion\", \"desc\":\"微信支付API版本\", \"type\": \"radio\",\"values\":\"V2,V3\",\"titles\":\"V2,V3\",\"verify\":\"required\"},{\"name\":\"key\", \"desc\":\"APIv2密钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"apiV3Key\", \"desc\":\"APIv3密钥（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\"},{\"name\":\"serialNo\", \"desc\":\"序列号（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\" },{\"name\":\"cert\", \"desc\":\"API证书(apiclient_cert.p12)\", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientCert\", \"desc\":\"证书文件(apiclient_cert.pem) \", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientKey\", \"desc\":\"私钥文件(apiclient_key.pem)\", \"type\": \"file\",\"verify\":\"\"}]', '[{\"wayCode\": \"WX_APP\"}, {\"wayCode\": \"WX_H5\"}, {\"wayCode\": \"WX_NATIVE\"}, {\"wayCode\": \"WX_JSAPI\"}, {\"wayCode\": \"WX_BAR\"}, {\"wayCode\": \"WX_LITE\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/wxpay.png', '#04BE02', 1, '微信官方通道', '2023-02-17 04:33:35.796412', '2023-02-17 04:33:35.796412'), ('ysfpay', '云闪付官方', 0, 1, 1, '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"沙箱环境,生产环境\",\"verify\":\"required\"},{\"name\":\"serProvId\",\"desc\":\"服务商开发ID[serProvId]\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"isvPrivateCertFile\",\"desc\":\"服务商私钥文件（.pfx格式）\",\"type\":\"file\",\"verify\":\"required\"},{\"name\":\"isvPrivateCertPwd\",\"desc\":\"服务商私钥文件密码\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"ysfpayPublicKey\",\"desc\":\"云闪付开发公钥（证书管理页面可查询）\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"acqOrgCode\",\"desc\":\"可用支付机构编号\",\"type\":\"text\",\"verify\":\"required\"}]', '[{\"name\":\"merId\",\"desc\":\"商户编号\",\"type\":\"text\",\"verify\":\"required\"}]', NULL, '[{\"wayCode\": \"YSF_BAR\"}, {\"wayCode\": \"ALI_JSAPI\"}, {\"wayCode\": \"WX_JSAPI\"}, {\"wayCode\": \"ALI_BAR\"}, {\"wayCode\": \"WX_BAR\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/ysfpay.png', 'red', 1, '云闪付官方通道', '2023-02-17 04:33:35.802732', '2023-02-17 04:33:35.802732');
COMMIT;

-- ----------------------------
-- Table structure for t_pay_order
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_order`;
CREATE TABLE `t_pay_order`  (
  `pay_order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付订单号',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `mch_type` tinyint NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `mch_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户订单号',
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付接口代码',
  `way_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付方式代码',
  `amount` bigint NOT NULL COMMENT '支付金额,单位分',
  `mch_fee_rate` decimal(20, 6) NOT NULL COMMENT '商户手续费费率快照',
  `mch_fee_amount` bigint NOT NULL COMMENT '商户手续费,单位分',
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cny' COMMENT '三位货币代码,人民币:cny',
  `state` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态: 0-订单生成, 1-支付中, 2-支付成功, 3-支付失败, 4-已撤销, 5-已退款, 6-订单关闭',
  `notify_state` tinyint NOT NULL DEFAULT 0 COMMENT '向下游回调状态, 0-未发送,  1-已发送',
  `client_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端IP',
  `subject` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品标题',
  `body` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品描述信息',
  `channel_extra` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '特定渠道发起额外参数',
  `channel_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道用户标识,如微信openId,支付宝账号',
  `channel_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道订单号',
  `refund_state` tinyint NOT NULL DEFAULT 0 COMMENT '退款状态: 0-未发生实际退款, 1-部分退款, 2-全额退款',
  `refund_times` int NOT NULL DEFAULT 0 COMMENT '退款次数',
  `refund_amount` bigint NOT NULL DEFAULT 0 COMMENT '退款总金额,单位分',
  `division_mode` tinyint NULL DEFAULT 0 COMMENT '订单分账模式：0-该笔订单不允许分账, 1-支付成功按配置自动完成分账, 2-商户手动分账(解冻商户金额)',
  `division_state` tinyint NULL DEFAULT 0 COMMENT '订单分账状态：0-未发生分账, 1-等待分账任务处理, 2-分账处理中, 3-分账任务已结束(不体现状态)',
  `division_last_time` datetime NULL DEFAULT NULL COMMENT '最新分账时间',
  `err_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道支付错误码',
  `err_msg` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道支付错误描述',
  `ext_param` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户扩展参数',
  `notify_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '异步通知地址',
  `return_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '页面跳转地址',
  `expired_time` datetime NULL DEFAULT NULL COMMENT '订单失效时间',
  `success_time` datetime NULL DEFAULT NULL COMMENT '订单支付成功时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`pay_order_id`) USING BTREE,
  UNIQUE INDEX `Uni_MchNo_MchOrderNo`(`mch_no`, `mch_order_no`) USING BTREE,
  INDEX `created_at`(`created_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付订单表';

-- ----------------------------
-- Records of t_pay_order
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_pay_order_division_record
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_order_division_record`;
CREATE TABLE `t_pay_order_division_record`  (
  `record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分账记录ID',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `mch_type` tinyint NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付接口代码',
  `pay_order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '系统支付订单号',
  `pay_order_channel_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付订单渠道支付订单号',
  `pay_order_amount` bigint NOT NULL COMMENT '订单金额,单位分',
  `pay_order_division_amount` bigint NOT NULL COMMENT '订单实际分账金额, 单位：分（订单金额 - 商户手续费 - 已退款金额）',
  `batch_order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '系统分账批次号',
  `channel_batch_order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上游分账批次号',
  `state` tinyint NOT NULL COMMENT '状态: 0-待分账 1-分账成功, 2-分账失败',
  `channel_resp_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '上游返回数据包',
  `receiver_id` bigint NOT NULL COMMENT '账号快照》 分账接收者ID',
  `receiver_group_id` bigint NULL DEFAULT NULL COMMENT '账号快照》 组ID（便于商户接口使用）',
  `receiver_alias` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收者账号别名',
  `acc_type` tinyint NOT NULL COMMENT '账号快照》 分账接收账号类型: 0-个人 1-商户',
  `acc_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号快照》 分账接收账号',
  `acc_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '账号快照》 分账接收账号名称',
  `relation_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号快照》 分账关系类型（参考微信）， 如： SERVICE_PROVIDER 服务商等',
  `relation_type_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号快照》 当选择自定义时，需要录入该字段。 否则为对应的名称',
  `division_profit` decimal(20, 6) NOT NULL COMMENT '账号快照》 配置的实际分账比例',
  `cal_division_amount` bigint NOT NULL COMMENT '计算该接收方的分账金额,单位分',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分账记录表';

-- ----------------------------
-- Records of t_pay_order_division_record
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_pay_way
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_way`;
CREATE TABLE `t_pay_way`  (
  `way_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付方式代码  例如： wxpay_jsapi',
  `way_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付方式名称',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`way_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付方式表';

-- ----------------------------
-- Records of t_pay_way
-- ----------------------------
BEGIN;
INSERT INTO `t_pay_way` (`way_code`, `way_name`, `created_at`, `updated_at`) VALUES ('ALI_APP', '支付宝APP', '2023-02-17 04:33:35.719012', '2023-02-17 04:33:35.719012'), ('ALI_BAR', '支付宝条码', '2023-02-17 04:33:35.706966', '2023-02-17 04:33:35.706966'), ('ALI_JSAPI', '支付宝生活号', '2023-02-17 04:33:35.714345', '2023-02-17 04:33:35.714345'), ('ALI_LITE', '支付宝小程序', '2023-02-17 04:33:35.736669', '2023-02-17 04:33:35.736669'), ('ALI_PC', '支付宝PC网站', '2023-02-17 04:33:35.728290', '2023-02-17 04:33:35.728290'), ('ALI_QR', '支付宝二维码', '2023-02-17 04:33:35.732604', '2023-02-17 04:33:35.732604'), ('ALI_WAP', '支付宝WAP', '2023-02-17 04:33:35.724042', '2023-02-17 04:33:35.724042'), ('PP_PC', 'PayPal支付', '2023-02-17 04:33:35.778279', '2023-02-17 04:33:35.778279'), ('WX_APP', '微信APP', '2023-02-17 04:33:35.751135', '2023-02-17 04:33:35.751135'), ('WX_BAR', '微信条码', '2023-02-17 04:33:35.742957', '2023-02-17 04:33:35.742957'), ('WX_H5', '微信H5', '2023-02-17 04:33:35.757882', '2023-02-17 04:33:35.757882'), ('WX_JSAPI', '微信公众号', '2023-02-17 04:33:35.747347', '2023-02-17 04:33:35.747347'), ('WX_LITE', '微信小程序', '2023-02-17 04:33:35.766029', '2023-02-17 04:33:35.766029'), ('WX_NATIVE', '微信扫码', '2023-02-17 04:33:35.761848', '2023-02-17 04:33:35.761848'), ('YSF_BAR', '云闪付条码', '2023-02-17 04:33:35.770447', '2023-02-17 04:33:35.770447'), ('YSF_JSAPI', '云闪付jsapi', '2023-02-17 04:33:35.774297', '2023-02-17 04:33:35.774297');
COMMIT;

-- ----------------------------
-- Table structure for t_refund_order
-- ----------------------------
DROP TABLE IF EXISTS `t_refund_order`;
CREATE TABLE `t_refund_order`  (
  `refund_order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '退款订单号（支付系统生成订单号）',
  `pay_order_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付订单号（与t_pay_order对应）',
  `channel_pay_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道支付单号（与t_pay_order channel_order_no对应）',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `mch_type` tinyint NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `mch_refund_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户退款单号（商户系统的订单号）',
  `way_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付方式代码',
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付接口代码',
  `pay_amount` bigint NOT NULL COMMENT '支付金额,单位分',
  `refund_amount` bigint NOT NULL COMMENT '退款金额,单位分',
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cny' COMMENT '三位货币代码,人民币:cny',
  `state` tinyint NOT NULL DEFAULT 0 COMMENT '退款状态:0-订单生成,1-退款中,2-退款成功,3-退款失败,4-退款任务关闭',
  `client_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端IP',
  `refund_reason` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '退款原因',
  `channel_order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道订单号',
  `err_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误码',
  `err_msg` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误描述',
  `channel_extra` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '特定渠道发起时额外参数',
  `notify_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通知地址',
  `ext_param` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扩展参数',
  `success_time` datetime NULL DEFAULT NULL COMMENT '订单退款成功时间',
  `expired_time` datetime NULL DEFAULT NULL COMMENT '退款失效时间（失效后系统更改为退款任务关闭状态）',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`refund_order_id`) USING BTREE,
  UNIQUE INDEX `Uni_MchNo_MchRefundNo`(`mch_no`, `mch_refund_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退款订单表';

-- ----------------------------
-- Records of t_refund_order
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_config`;
CREATE TABLE `t_sys_config`  (
  `config_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置KEY',
  `config_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置名称',
  `config_desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述信息',
  `group_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组key',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组名称',
  `config_val` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置内容项',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'text' COMMENT '类型: text-输入框, textarea-多行文本, uploadImg-上传图片, switch-开关',
  `sort_num` bigint NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`config_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置表';

-- ----------------------------
-- Records of t_sys_config
-- ----------------------------
BEGIN;
INSERT INTO `t_sys_config` (`config_key`, `config_name`, `config_desc`, `group_key`, `group_name`, `config_val`, `type`, `sort_num`, `updated_at`) VALUES ('mchSiteUrl', '商户平台网址(不包含结尾/)', '商户平台网址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://127.0.0.1:9218', 'text', 0, '2021-05-18 22:46:10.000000'), ('mgrSiteUrl', '运营平台网址(不包含结尾/)', '运营平台网址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://127.0.0.1:9217', 'text', 0, '2021-05-18 22:46:10.000000'), ('ossPublicSiteUrl', '公共oss访问地址(不包含结尾/)', '公共oss访问地址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://127.0.0.1:9217/api/anon/localOssFiles', 'text', 0, '2021-05-18 22:46:10.000000'), ('paySiteUrl', '支付网关地址(不包含结尾/)', '支付网关地址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://127.0.0.1:9216', 'text', 0, '2021-05-18 22:46:10.000000');
COMMIT;

-- ----------------------------
-- Table structure for t_sys_entitlement
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_entitlement`;
CREATE TABLE `t_sys_entitlement`  (
  `ent_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限ID[ENT_功能模块_子模块_操作], eg: ENT_ROLE_LIST_ADD',
  `ent_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限名称',
  `menu_icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `menu_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单uri/路由地址',
  `component_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件Name（前后端分离使用）',
  `ent_type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限类型 ML-左侧显示菜单, MO-其他菜单, PB-页面/按钮',
  `quick_jump` tinyint NOT NULL DEFAULT 0 COMMENT '快速开始菜单 0-否, 1-是',
  `state` tinyint NOT NULL DEFAULT 1 COMMENT '状态 0-停用, 1-启用',
  `pid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '父ID',
  `ent_sort` int NOT NULL DEFAULT 0 COMMENT '排序字段, 规则：正序',
  `sys_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`ent_id`, `sys_type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统权限表';

-- ----------------------------
-- Records of t_sys_entitlement
-- ----------------------------
BEGIN;
INSERT INTO `t_sys_entitlement` (`ent_id`, `ent_name`, `menu_icon`, `menu_uri`, `component_name`, `ent_type`, `quick_jump`, `state`, `pid`, `ent_sort`, `sys_type`, `created_at`, `updated_at`) VALUES ('ENT_C_MAIN', '主页', 'home', '/main', 'MainPage', 'ML', 0, 1, 'ROOT', 1, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_C_MAIN_NUMBER_COUNT', '主页数量总统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_C_MAIN', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_C_MAIN_PAY_AMOUNT_WEEK', '主页周支付统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_C_MAIN', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_C_MAIN_PAY_COUNT', '主页交易统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_C_MAIN', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_C_MAIN_PAY_TYPE_COUNT', '主页交易方式统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_C_MAIN', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_C_USERINFO', '个人中心', 'no-icon', '/current/userinfo', 'CurrentUserInfo', 'MO', 0, 1, 'ENT_COMMONS', -1, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_C_USERINFO', '个人中心', 'no-icon', '/current/userinfo', 'CurrentUserInfo', 'MO', 0, 1, 'ENT_COMMONS', -1, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_COMMONS', '系统通用菜单', 'no-icon', '', 'RouteView', 'MO', 0, 1, 'ROOT', -1, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_COMMONS', '系统通用菜单', 'no-icon', '', 'RouteView', 'MO', 0, 1, 'ROOT', -1, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_DIVISION', '分账管理', 'apartment', '', 'RouteView', 'ML', 0, 1, 'ROOT', 30, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER', '收款账号管理', 'trademark', '/divisionReceiver', 'DivisionReceiverPage', 'ML', 0, 1, 'ENT_DIVISION', 20, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_ADD', '按钮：新增收款账号', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_DELETE', '按钮：删除收款账号', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_EDIT', '按钮：修改账号信息', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_GROUP', '账号组管理', 'team', '/divisionReceiverGroup', 'DivisionReceiverGroupPage', 'ML', 0, 1, 'ENT_DIVISION', 10, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_GROUP_ADD', '按钮：新增', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER_GROUP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_GROUP_DELETE', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER_GROUP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_GROUP_EDIT', '按钮：修改', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER_GROUP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_GROUP_LIST', '页面：数据列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER_GROUP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_GROUP_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER_GROUP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_LIST', '页面：数据列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECEIVER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECEIVER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECORD', '分账记录', 'unordered-list', '/divisionRecord', 'DivisionRecordPage', 'ML', 0, 1, 'ENT_DIVISION', 30, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECORD_LIST', '页面：数据列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECORD', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECORD_RESEND', '按钮：重试', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECORD', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_DIVISION_RECORD_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_DIVISION_RECORD', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_ISV', '服务商管理', 'block', '', 'RouteView', 'ML', 0, 1, 'ROOT', 40, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_INFO', '服务商列表', 'profile', '/isv', 'IsvListPage', 'ML', 0, 1, 'ENT_ISV', 10, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_INFO_ADD', '按钮：新增', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_INFO_DEL', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_INFO_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_INFO_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_LIST', '页面：服务商列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_PAY_CONFIG_ADD', '服务商支付参数配置', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_PAY_CONFIG_LIST', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_PAY_CONFIG_LIST', '服务商支付参数配置列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ISV_PAY_CONFIG_VIEW', '服务商支付参数配置详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_ISV_PAY_CONFIG_LIST', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_LOG_LIST', '页面：系统日志列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_SYS_LOG', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH', '商户管理', 'shop', '', 'RouteView', 'ML', 0, 1, 'ROOT', 30, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_APP', '应用管理', 'appstore', '/apps', 'MchAppPage', 'ML', 0, 1, 'ENT_MCH_CENTER', 10, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_APP', '应用列表', 'appstore', '/apps', 'MchAppPage', 'ML', 0, 1, 'ENT_MCH', 20, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_APP_ADD', '按钮：新增', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_APP_ADD', '按钮：新增', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_APP_CONFIG', '应用配置', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_APP_DEL', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_APP_DEL', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_APP_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_APP_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_APP_LIST', '页面：应用列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_APP_LIST', '页面：应用列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_APP_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_APP_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_CENTER', '商户中心', 'team', '', 'RouteView', 'ML', 0, 1, 'ROOT', 10, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_INFO', '商户列表', 'profile', '/mch', 'MchListPage', 'ML', 0, 1, 'ENT_MCH', 10, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_INFO_ADD', '按钮：新增', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_INFO_DEL', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_INFO_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_INFO_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_LIST', '页面：商户列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_INFO', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_MAIN', '主页', 'home', '/main', 'MainPage', 'ML', 0, 1, 'ROOT', 1, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_MAIN_NUMBER_COUNT', '主页数量总统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_MAIN', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_MAIN_PAY_AMOUNT_WEEK', '主页周支付统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_MAIN', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_MAIN_PAY_COUNT', '主页交易统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_MAIN', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_MAIN_PAY_TYPE_COUNT', '主页交易方式统计', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_MAIN', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_MAIN_USER_INFO', '主页用户信息', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_MAIN', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_NOTIFY', '商户通知', 'notification', '/notify', 'MchNotifyListPage', 'ML', 0, 1, 'ENT_ORDER', 30, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_NOTIFY_RESEND', '按钮：重发通知', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_NOTIFY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_NOTIFY_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_NOTIFY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_CONFIG_ADD', '应用支付参数配置', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_CONFIG_LIST', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_CONFIG_ADD', '应用支付参数配置', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_CONFIG_LIST', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_PAY_CONFIG_LIST', '应用支付参数配置列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_CONFIG_LIST', '应用支付参数配置列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_PAY_CONFIG_VIEW', '应用支付参数配置详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_CONFIG_LIST', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_CONFIG_VIEW', '应用支付参数配置详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_CONFIG_LIST', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_PAY_PASSAGE_ADD', '应用支付通道配置保存', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_PASSAGE_LIST', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_PASSAGE_ADD', '应用支付通道配置保存', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_PASSAGE_LIST', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_PAY_PASSAGE_CONFIG', '应用支付通道配置入口', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_PASSAGE_LIST', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_PASSAGE_CONFIG', '应用支付通道配置入口', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_PASSAGE_LIST', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_PAY_PASSAGE_LIST', '应用支付通道配置列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_PASSAGE_LIST', '应用支付通道配置列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_APP', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_MCH_PAY_TEST', '支付测试', 'transaction', '/paytest', 'PayTestPage', 'ML', 0, 1, 'ENT_MCH_CENTER', 20, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_TEST_DO', '按钮：支付测试', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_TEST', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_PAY_TEST_PAYWAY_LIST', '页面：获取全部支付方式', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_PAY_TEST', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_TRANSFER', '转账', 'property-safety', '/doTransfer', 'MchTransferPage', 'ML', 0, 1, 'ENT_MCH_CENTER', 30, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_TRANSFER_CHANNEL_USER', '按钮：获取渠道用户', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_TRANSFER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_TRANSFER_DO', '按钮：发起转账', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_TRANSFER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_MCH_TRANSFER_IF_CODE_LIST', '页面：获取全部代付通道', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_TRANSFER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_NOTIFY_LIST', '页面：商户通知列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_MCH_NOTIFY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_ORDER', '订单中心', 'transaction', '', 'RouteView', 'ML', 0, 1, 'ROOT', 20, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_ORDER', '订单管理', 'transaction', '', 'RouteView', 'ML', 0, 1, 'ROOT', 50, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_ORDER_LIST', '页面：订单列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_ORDER_LIST', '页面：订单列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_PAY_ORDER', '订单管理', 'account-book', '/pay', 'PayOrderListPage', 'ML', 0, 1, 'ENT_ORDER', 10, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PAY_ORDER', '支付订单', 'account-book', '/pay', 'PayOrderListPage', 'ML', 0, 1, 'ENT_ORDER', 10, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_PAY_ORDER_REFUND', '按钮：订单退款', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PAY_ORDER_REFUND', '按钮：订单退款', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PAY_ORDER_SEARCH_PAY_WAY', '筛选项：支付方式', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PAY_ORDER_SEARCH_PAY_WAY', '筛选项：支付方式', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PAY_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PAY_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PAY_ORDER', 0, 'MGR', '2023-02-17 04:33:34.000000', '2023-02-17 04:33:34.000000'), ('ENT_PC', '支付配置', 'file-done', '', 'RouteView', 'ML', 0, 1, 'ROOT', 60, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_IF_DEFINE', '支付接口', 'interaction', '/ifdefines', 'IfDefinePage', 'ML', 0, 1, 'ENT_PC', 10, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_IF_DEFINE_ADD', '按钮：新增', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_IF_DEFINE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_IF_DEFINE_DEL', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_IF_DEFINE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_IF_DEFINE_EDIT', '按钮：修改', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_IF_DEFINE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_IF_DEFINE_LIST', '页面：支付接口定义列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_IF_DEFINE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_IF_DEFINE_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_IF_DEFINE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_IF_DEFINE_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_IF_DEFINE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_WAY', '支付方式', 'appstore', '/payways', 'PayWayPage', 'ML', 0, 1, 'ENT_PC', 20, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_WAY_ADD', '按钮：新增', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_WAY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_WAY_DEL', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_WAY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_WAY_EDIT', '按钮：修改', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_WAY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_WAY_LIST', '页面：支付方式列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_WAY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_WAY_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_WAY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_PC_WAY_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_PC_WAY', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_REFUND_LIST', '页面：退款订单列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_REFUND_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_REFUND_LIST', '页面：退款订单列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_REFUND_ORDER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_REFUND_ORDER', '退款记录', 'exception', '/refund', 'RefundOrderListPage', 'ML', 0, 1, 'ENT_ORDER', 20, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_REFUND_ORDER', '退款订单', 'exception', '/refund', 'RefundOrderListPage', 'ML', 0, 1, 'ENT_ORDER', 20, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_REFUND_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_REFUND_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_REFUND_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_REFUND_ORDER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_SYS_CONFIG', '系统管理', 'setting', '', 'RouteView', 'ML', 0, 1, 'ROOT', 200, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_SYS_CONFIG', '系统管理', 'setting', '', 'RouteView', 'ML', 0, 1, 'ROOT', 200, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_SYS_CONFIG_EDIT', '按钮： 修改', 'no-icon', '', '', 'PB', 0, 1, 'ENT_SYS_CONFIG_INFO', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_SYS_CONFIG_INFO', '系统配置', 'setting', '/config', 'SysConfigPage', 'ML', 0, 1, 'ENT_SYS_CONFIG', 15, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_SYS_LOG', '系统日志', 'file-text', '/log', 'SysLogPage', 'ML', 0, 1, 'ENT_SYS_CONFIG', 20, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_SYS_LOG_DEL', '按钮：删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_SYS_LOG', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_SYS_LOG_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_SYS_LOG', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_TRANSFER_ORDER', '转账订单', 'property-safety', '/transfer', 'TransferOrderListPage', 'ML', 0, 1, 'ENT_ORDER', 30, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_TRANSFER_ORDER', '转账订单', 'property-safety', '/transfer', 'TransferOrderListPage', 'ML', 0, 1, 'ENT_ORDER', 25, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_TRANSFER_ORDER_LIST', '页面：转账订单列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_TRANSFER_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_TRANSFER_ORDER_LIST', '页面：转账订单列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_TRANSFER_ORDER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_TRANSFER_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_TRANSFER_ORDER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_TRANSFER_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', 0, 1, 'ENT_TRANSFER_ORDER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR', '用户角色管理', 'team', '', 'RouteView', 'ML', 0, 1, 'ENT_SYS_CONFIG', 10, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR', '用户角色管理', 'team', '', 'RouteView', 'ML', 0, 1, 'ENT_SYS_CONFIG', 10, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE', '角色管理', 'user', '/roles', 'RolePage', 'ML', 0, 1, 'ENT_UR', 20, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE', '角色管理', 'user', '/roles', 'RolePage', 'ML', 0, 1, 'ENT_UR', 20, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_ADD', '按钮：添加角色', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_ADD', '按钮：添加角色', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_DEL', '按钮： 删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_DEL', '按钮： 删除', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_DIST', '按钮： 分配权限', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_DIST', '按钮： 分配权限', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_EDIT', '按钮： 修改名称', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_EDIT', '按钮： 修改基本信息', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_ENT', '权限管理', 'apartment', '/ents', 'EntPage', 'ML', 0, 1, 'ENT_UR', 30, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_ENT_EDIT', '按钮： 权限变更', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE_ENT', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_ENT_LIST', '页面： 权限列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE_ENT', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_LIST', '页面：角色列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_LIST', '页面：角色列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_ROLE_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_ROLE', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER', '操作员管理', 'contacts', '/users', 'SysUserPage', 'ML', 0, 1, 'ENT_UR', 10, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER', '操作员管理', 'contacts', '/users', 'SysUserPage', 'ML', 0, 1, 'ENT_UR', 10, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_ADD', '按钮：添加操作员', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_ADD', '按钮：添加操作员', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_DELETE', '按钮： 删除操作员', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_DELETE', '按钮： 删除操作员', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_EDIT', '按钮： 修改基本信息', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_EDIT', '按钮： 修改基本信息', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_LIST', '页面：操作员列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_LIST', '页面：操作员列表', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_SEARCH', '按钮：搜索', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_SEARCH', '按钮：搜索', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_UPD_ROLE', '按钮： 角色分配', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_UPD_ROLE', '按钮： 角色分配', 'no-icon', '', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_VIEW', '按钮： 详情', '', 'no-icon', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MCH', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000'), ('ENT_UR_USER_VIEW', '按钮： 详情', '', 'no-icon', '', 'PB', 0, 1, 'ENT_UR_USER', 0, 'MGR', '2023-02-17 04:33:35.000000', '2023-02-17 04:33:35.000000');
COMMIT;

-- ----------------------------
-- Table structure for t_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_log`;
CREATE TABLE `t_sys_log`  (
  `sys_log_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '系统用户ID',
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `user_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户IP',
  `sys_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `method_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '方法名',
  `method_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '方法描述',
  `req_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '请求地址',
  `opt_req_param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作请求参数',
  `opt_res_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作响应结果',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  PRIMARY KEY (`sys_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统操作日志表';

-- ----------------------------
-- Records of t_sys_log
-- ----------------------------
BEGIN;
INSERT INTO `t_sys_log` (`sys_log_id`, `user_id`, `user_name`, `user_ip`, `sys_type`, `method_name`, `method_remark`, `req_url`, `opt_req_param`, `opt_res_info`, `created_at`) VALUES (1, 801, '超管', '117.182.44.211', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://101.33.231.129/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"YjJnZw==\",\"vt\":\"ZTk4YzNkOWYtNDA1OC00OGZhLTljODUtYzU0NjcyN2RmOWMw\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV8zN2NiZWZlMC0zOGNmLTRjY2QtYTlhZC0zZDExNzk2YjNlNTAiLCJjcmVhdGVkIjoxNjc2NjA0NDgzOTAzLCJzeXNVc2VySWQiOjgwMX0.X9_ftODPAqcLhAkJ7WmCaKaiz7rribAUcsT79YaVnquCe_J-aDt-ppKH0jHbMMqkzPOlBNEMQgY1JgZ8hZD1aQ\"}}', '2023-02-17 11:28:03.993000'), (2, 801, '超管', '117.182.44.211', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.CurrentUserController.modifyPwd', '修改密码', 'http://101.33.231.129/api/current/modifyPwd', '{\"recordId\":801,\"confirmPwd\":\"MTIzNDU2\",\"originalPwd\":\"amVlcGF5MTIz\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-02-17 11:30:09.363000'), (3, NULL, NULL, '117.182.44.211', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://101.33.231.129/api/anon/auth/validate', '{\"ip\":\"MTIzNDU2\",\"ia\":\"YWRtaW4=\",\"vc\":\"bzF4Mw==\",\"vt\":\"NGJlYTJjMTUtZTcyNi00ZGRlLWIwYWItZGIwYTIzY2EyODJi\"}', '用户名/密码错误！', '2023-02-17 11:30:31.716000'), (4, 801, '超管', '117.182.44.211', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://101.33.231.129/api/anon/auth/validate', '{\"ip\":\"MTIzNDU2\",\"ia\":\"amVlcGF5\",\"vc\":\"bzF4Mw==\",\"vt\":\"NGJlYTJjMTUtZTcyNi00ZGRlLWIwYWItZGIwYTIzY2EyODJi\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV84NWE0MzRmMy0xZTE4LTQwNzItYTU3My04ODkwMGZhYmJhN2YiLCJjcmVhdGVkIjoxNjc2NjA0NjQ1NDc0LCJzeXNVc2VySWQiOjgwMX0.nm5jkmBDS9zxujGuZcZeuxqW1vSzaFWxGEJuxoPnu9YTm2TG2d8HOhY1RAjlVaL-Z24yM8qaLEFw8WN2pa8pkA\"}}', '2023-02-17 11:30:45.476000'), (5, 801, '超管', '117.182.44.211', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchInfoController.add', '新增商户', 'http://101.33.231.129/api/mchInfo', '{\"loginUserName\":\"htwmall\",\"contactName\":\"海淘网\",\"mchName\":\"海淘网\",\"state\":1,\"type\":1,\"mchShortName\":\"海淘网\",\"contactTel\":\"13900139000\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-02-17 11:33:06.361000'), (6, 100001, '测试商家', '117.182.44.211', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://101.33.231.129/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"aHR3bWFsbA==\",\"vc\":\"MG5zaQ==\",\"vt\":\"YWY5NTMwOWEtMThlZi00YjYyLThmYTctMzJhNjI5MDEyNjVk\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMV83ZjMyZjljNC00YzgxLTRiOTgtODgxOS05MTQzM2M2NjUxZjAiLCJjcmVhdGVkIjoxNjc2NjA0ODE4Njk2LCJzeXNVc2VySWQiOjEwMDAwMX0.fzng7n4dA56YZLFPBMQDS3i09w5emmMu4RI-xb0nW3uK-6kz6r80n7VL_EOyWRb6z5GH5n5vSzhKCsu2dllycA\"}}', '2023-02-17 11:33:38.836000'), (7, 100001, '测试商家', '117.182.44.211', 'MCH', 'com.jeequan.jeepay.mch.ctrl.CurrentUserController.modifyPwd', '修改密码', 'http://101.33.231.129/api/current/modifyPwd', '{\"recordId\":100001,\"confirmPwd\":\"MTIzNDU2\",\"originalPwd\":\"amVlcGF5NjY2\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-02-17 11:33:58.701000'), (8, 100001, '测试商家', '117.182.44.211', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://101.33.231.129/api/anon/auth/validate', '{\"ip\":\"MTIzNDU2\",\"ia\":\"aHR3bWFsbA==\",\"vc\":\"b2g4Mw==\",\"vt\":\"M2Q1ZTJhZTYtZjYxOC00ODBkLTgwYWYtMWRmZmI0ZTExODJl\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMV85ZWI3ZTcwZS0yZDJjLTQ0OWItODhjMC03MWRiZWRkYmYwNzIiLCJjcmVhdGVkIjoxNjc2NjA0ODQ5MzU4LCJzeXNVc2VySWQiOjEwMDAwMX0.72aHG3efLtnIFs27kFlVlDaN75rKVX1BfYUU_71EZGsVc54ImBWhwwp5zDSCo4BcOScMrVzerQMI5smHnRGmSQ\"}}', '2023-02-17 11:34:09.360000');
COMMIT;

-- ----------------------------
-- Table structure for t_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role`  (
  `role_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色ID, ROLE_开头',
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `sys_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `belong_info_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '所属商户ID / 0(平台)',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统角色表';

-- ----------------------------
-- Records of t_sys_role
-- ----------------------------
BEGIN;
INSERT INTO `t_sys_role` (`role_id`, `role_name`, `sys_type`, `belong_info_id`, `updated_at`) VALUES ('ROLE_ADMIN', '系统管理员', 'MGR', '0', '2021-05-01 08:00:00.000000'), ('ROLE_OP', '普通操作员', 'MGR', '0', '2021-05-01 08:00:00.000000');
COMMIT;

-- ----------------------------
-- Table structure for t_sys_role_ent_rela
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role_ent_rela`;
CREATE TABLE `t_sys_role_ent_rela`  (
  `role_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色ID',
  `ent_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`, `ent_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统角色权限关联表';

-- ----------------------------
-- Records of t_sys_role_ent_rela
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user`  (
  `sys_user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '系统用户ID',
  `login_username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录用户名',
  `realname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '真实姓名',
  `telphone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `sex` tinyint NOT NULL DEFAULT 0 COMMENT '性别 0-未知, 1-男, 2-女',
  `avatar_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `user_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '员工编号',
  `is_admin` tinyint NOT NULL DEFAULT 0 COMMENT '是否超管（超管拥有全部权限） 0-否 1-是',
  `state` tinyint NOT NULL DEFAULT 0 COMMENT '状态 0-停用 1-启用',
  `sys_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `belong_info_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '所属商户ID / 0(平台)',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`sys_user_id`) USING BTREE,
  UNIQUE INDEX `sys_type`(`sys_type`, `login_username`) USING BTREE,
  UNIQUE INDEX `sys_type_2`(`sys_type`, `telphone`) USING BTREE,
  UNIQUE INDEX `sys_type_3`(`sys_type`, `user_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统用户表';

-- ----------------------------
-- Records of t_sys_user
-- ----------------------------
BEGIN;
INSERT INTO `t_sys_user` (`sys_user_id`, `login_username`, `realname`, `telphone`, `sex`, `avatar_url`, `user_no`, `is_admin`, `state`, `sys_type`, `belong_info_id`, `created_at`, `updated_at`) VALUES (801, 'admin', '超管', '13000000001', 1, 'https://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/defava_m.png', 'D0001', 1, 1, 'MGR', '0', '2020-06-13 08:00:00.000000', '2023-02-17 11:30:40.832905'), (100001, 'test', '测试商家', '13900139000', 1, 'https://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/defava_m.png', 'M1676604786', 1, 1, 'MCH', 'M1676604786', '2023-02-17 11:33:06.233326', '2023-02-17 11:33:06.233326');
COMMIT;

-- ----------------------------
-- Table structure for t_sys_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_auth`;
CREATE TABLE `t_sys_user_auth`  (
  `auth_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT 'user_id',
  `identity_type` tinyint NOT NULL DEFAULT 0 COMMENT '登录类型  1-登录账号 2-手机号 3-邮箱  10-微信  11-QQ 12-支付宝 13-微博',
  `identifier` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '认证标识 ( 用户名 | open_id )',
  `credential` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码凭证',
  `salt` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'salt',
  `sys_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1003 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统用户认证表';

-- ----------------------------
-- Records of t_sys_user_auth
-- ----------------------------
BEGIN;
INSERT INTO `t_sys_user_auth` (`auth_id`, `user_id`, `identity_type`, `identifier`, `credential`, `salt`, `sys_type`) VALUES (801, 801, 1, 'admin', '$2a$10$2m6UPmL9qtJdXZXy8e4vMeg24bKrzc4Doa25wfKwHOc6q.kTMNWxa', 'testkey', 'MGR'), (1001, 100001, 1, 'test', '$2a$10$0p/J5dWvysPVsbKwAKTZmurzGnr6yUe0CuuHnarYkxnt2WKFer0Uq', '4b37c5', 'MCH'), (1002, 100001, 2, '13900139000', '$2a$10$uMebssF/TrfO.q4.LSIhG.aoPysmgfNmECbvQRqYscWl0WHCYmjCK', '4b37c5', 'MCH');
COMMIT;

-- ----------------------------
-- Table structure for t_sys_user_role_rela
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_role_rela`;
CREATE TABLE `t_sys_user_role_rela`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作员<->角色 关联表';

-- ----------------------------
-- Records of t_sys_user_role_rela
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_transfer_order
-- ----------------------------
DROP TABLE IF EXISTS `t_transfer_order`;
CREATE TABLE `t_transfer_order`  (
  `transfer_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '转账订单号',
  `mch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `mch_type` tinyint NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `mch_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户订单号',
  `if_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付接口代码',
  `entry_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入账方式： WX_CASH-微信零钱; ALIPAY_CASH-支付宝转账; BANK_CARD-银行卡',
  `amount` bigint NOT NULL COMMENT '转账金额,单位分',
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cny' COMMENT '三位货币代码,人民币:cny',
  `account_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收款账号',
  `account_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款人姓名',
  `bank_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款人开户行名称',
  `transfer_desc` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '转账备注信息',
  `client_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端IP',
  `state` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态: 0-订单生成, 1-转账中, 2-转账成功, 3-转账失败, 4-订单关闭',
  `channel_extra` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '特定渠道发起额外参数',
  `channel_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道订单号',
  `err_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道支付错误码',
  `err_msg` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道支付错误描述',
  `ext_param` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户扩展参数',
  `notify_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '异步通知地址',
  `success_time` datetime NULL DEFAULT NULL COMMENT '转账成功时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`transfer_id`) USING BTREE,
  UNIQUE INDEX `Uni_MchNo_MchOrderNo`(`mch_no`, `mch_order_no`) USING BTREE,
  INDEX `created_at`(`created_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '转账订单表';

-- ----------------------------
-- Records of t_transfer_order
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
