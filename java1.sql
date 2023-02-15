/*
 Navicat Premium Data Transfer

 Source Server         : 本地Mysql
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : java

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 29/01/2023 18:59:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adm_login
-- ----------------------------
DROP TABLE IF EXISTS `adm_login`;
CREATE TABLE `adm_login`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of adm_login
-- ----------------------------
INSERT INTO `adm_login` VALUES (1, '0000000', '0000000');

-- ----------------------------
-- Table structure for department_info
-- ----------------------------
DROP TABLE IF EXISTS `department_info`;
CREATE TABLE `department_info`  (
  `Dno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Dname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Dduty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Dhead` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Dno`) USING BTREE,
  INDEX `D_t`(`Dhead` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department_info
-- ----------------------------
INSERT INTO `department_info` VALUES ('11100', '教务处', '负责学校的教学组织管理、教学运行管理、教学质量管理、教学建设管理、实践教学管理、教学改革研究等业务', '杨雪');
INSERT INTO `department_info` VALUES ('22200', '体育部', '学生体育活动的先锋队和带头人', '刘勇');
INSERT INTO `department_info` VALUES ('33300', '学生处', '负责全校普通本科学生招生、就业、教育管理、资助、军训、国防教育、社区管理、和心理健康教育工作', '刘强');
INSERT INTO `department_info` VALUES ('44400', '科研处', '负责学校研究机构、科研基地、科研联合体的管理,以及各级政府部门设立的重点实验室、研究基地和工程研究中心等的申报、管理和服务', '胡乐');
INSERT INTO `department_info` VALUES ('55500', '保卫处', '保护校内人员安全', '张东');
INSERT INTO `department_info` VALUES ('66600', '党委办', '负责学校党的建设', '张二');
INSERT INTO `department_info` VALUES ('77700', '国资处', '管理学校固有资产', '李小鹏');

-- ----------------------------
-- Table structure for student_grade
-- ----------------------------
DROP TABLE IF EXISTS `student_grade`;
CREATE TABLE `student_grade`  (
  `id` int NOT NULL COMMENT '学生学号',
  `namestudent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `numcourse` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `namecourse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nameteacher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `classroom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `credit` int NULL DEFAULT 4,
  PRIMARY KEY (`id`, `numcourse`) USING BTREE,
  INDEX `classroom`(`classroom` ASC) USING BTREE,
  INDEX `classroom_2`(`classroom` ASC, `id` ASC) USING BTREE,
  INDEX `up2`(`namecourse` ASC) USING BTREE,
  INDEX `up1`(`classroom` ASC, `namestudent` ASC) USING BTREE,
  INDEX `studentgrade_ibfk_2`(`numcourse` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student_grade
-- ----------------------------
INSERT INTO `student_grade` VALUES (123, '田明华', '001', 'java', '李迎', '80', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (123, '田明华', '002', '高等数学', '杨阿莉', '94', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (123, '田明华', '004', '计算机组成原理', '黄国兵', '92', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (123, '田明华', '006', 'C#', '刘枫', '70', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (125, '蒲益', '001', 'java', '李迎', '99', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (125, '蒲益', '002', '高等数学', '杨阿莉', '94', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (125, '蒲益', '004', '计算机组成原理', '黄国兵', '90', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (125, '蒲益', '006', 'C#', '刘枫', '75', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (127, '常墨涵', '001', 'java', '李迎', '100', '计卓2002班', 4);
INSERT INTO `student_grade` VALUES (127, '常墨涵', '002', '高等数学', '杨阿莉', '95', '计卓2002班', 4);
INSERT INTO `student_grade` VALUES (127, '常墨涵', '004', '计算机组成原理', '黄国兵', '91', '计卓2002班', 4);
INSERT INTO `student_grade` VALUES (127, '常墨涵', '006', 'C#', '刘枫', '80', '计卓2002班', 4);
INSERT INTO `student_grade` VALUES (130, '张三', '001', 'java', '李迎', '55', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (130, '张三', '002', '高等数学', '杨阿莉', '86', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (130, '张三', '004', '计算机组成原理', '黄国兵', '85', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (130, '张三', '006', 'C#', '刘枫', '60', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (131, '芦亦然', '001', 'java', '李迎', '80', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (131, '芦亦然', '002', '高等数学', '杨阿莉', '75', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (131, '芦亦然', '004', '计算机组成原理', '黄国兵', '90', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (131, '芦亦然', '006', 'C#', '刘枫', '81', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (132, '张一飞', '001', 'java', '李迎', '96', '计卓2004班', 4);
INSERT INTO `student_grade` VALUES (132, '张一飞', '002', '高等数学', '杨阿莉', '86', '计卓2004班', 4);
INSERT INTO `student_grade` VALUES (132, '张一飞', '004', '计算机组成原理', '黄国兵', '92', '计卓2004班', 4);
INSERT INTO `student_grade` VALUES (132, '张一飞', '006', 'C#', '刘枫', '86', '计卓2004班', 4);
INSERT INTO `student_grade` VALUES (135, '李四', '001', 'java', '李迎', '7', '计卓2004班', 0);
INSERT INTO `student_grade` VALUES (135, '李四', '002', '高等数学', '杨阿莉', '35', '计卓2004班', 4);
INSERT INTO `student_grade` VALUES (135, '李四', '004', '计算机组成原理', '黄国兵', '51', '计卓2004班', 4);
INSERT INTO `student_grade` VALUES (135, '李四', '006', 'C#', '刘枫', '63', '计卓2004班', 4);
INSERT INTO `student_grade` VALUES (136, '蒋娟', '001', 'java', '李迎', '96', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (136, '蒋娟', '002', '高等数学', '杨阿莉', '89', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (136, '蒋娟', '004', '计算机组成原理', '黄国兵', '91', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (136, '蒋娟', '006', 'C#', '刘枫', '96', '计卓2001班', 4);
INSERT INTO `student_grade` VALUES (138, '夏慧怡', '001', 'java', '李迎', '87', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (138, '夏慧怡', '002', '高等数学', '杨阿莉', '90', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (138, '夏慧怡', '004', '计算机组成原理', '黄国兵', '94', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (138, '夏慧怡', '006', 'C#', '刘枫', '85', '计卓2003班', 4);
INSERT INTO `student_grade` VALUES (140, '陈星宇', '005', '几何代数', '高斯', '81', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (140, '陈星宇', '007', '数学分析', '陈小平', '84', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (140, '陈星宇', '008', '概率论', '欧拉', '90', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (140, '陈星宇', '009', '抽样调查', '阿基米德', '90', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (140, '陈星宇', '011', '神学', '牛顿', '75', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (141, '吴沛轩', '005', '几何代数', '高斯', '89', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (141, '吴沛轩', '007', '数学分析', '陈小平', '90', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (141, '吴沛轩', '008', '概率论', '欧拉', '95', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (141, '吴沛轩', '009', '抽样调查', '阿基米德', '90', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (141, '吴沛轩', '011', '神学', '牛顿', '80', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (142, '厄加特', '005', '几何代数', '高斯', '76', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (142, '厄加特', '007', '数学分析', '陈小平', '86', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (142, '厄加特', '008', '概率论', '欧拉', '70', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (142, '厄加特', '009', '抽样调查', '阿基米德', '75', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (142, '厄加特', '011', '高等数学', '牛顿', '60', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (143, '德莱厄斯', '005', '几何代数', '高斯', '58', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (143, '德莱厄斯', '007', '数学分析', '陈小平', '56', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (143, '德莱厄斯', '008', '概率论', '欧拉', '43', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (143, '德莱厄斯', '009', '抽样调查', '阿基米德', '35', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (143, '德莱厄斯', '011', '神学', '牛顿', '59', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (144, '德莱文', '005', '几何代数', '高斯', '69', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (144, '德莱文', '007', '数学分析', '陈小平', '63', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (144, '德莱文', '008', '概率论', '欧拉', '70', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (144, '德莱文', '009', '抽样调查', '阿基米德', '75', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (144, '德莱文', '011', '神学', '牛顿', '63', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (145, '钟离', '005', '几何代数', '高斯', '85', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (145, '钟离', '007', '数学分析', '陈小平', '80', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (145, '钟离', '008', '概率论', '欧拉', '96', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (145, '钟离', '009', '抽样调查', '阿基米德', '90', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (145, '钟离', '011', '神学', '牛顿', '96', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (146, '万叶', '005', '几何代数', '高斯', '90', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (146, '万叶', '007', '数学分析', '陈小平', '85', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (146, '万叶', '008', '概率论', '欧拉', '86', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (146, '万叶', '009', '抽样调查', '阿基米德', '99', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (146, '万叶', '011', '神学', '牛顿', '91', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (147, '托马', '005', '几何代数', '高斯', '89', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (147, '托马', '007', '数学分析', '陈小平', '84', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (147, '托马', '008', '概率论', '欧拉', '91', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (147, '托马', '009', '抽样调查', '阿基米德', '93', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (147, '托马', '011', '神学', '牛顿', '90', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (148, '甘雨', '005', '几何代数', '高斯', '81', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (148, '甘雨', '007', '数学分析', '陈小平', '86', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (148, '甘雨', '008', '概率论', '欧拉', '80', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (148, '甘雨', '009', '抽样调查', '阿基米德', '85', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (148, '甘雨', '011', '神学', '牛顿', '73', '统计2001班', 4);
INSERT INTO `student_grade` VALUES (149, '刻晴', '005', '几何代数', '高斯', '85', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (149, '刻晴', '007', '数学分析', '陈小平', '90', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (149, '刻晴', '008', '概率论', '欧拉', '91', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (149, '刻晴', '009', '抽样调查', '阿基米德', '80', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (149, '刻晴', '011', '神学', '牛顿', '90', '统计2002班', 4);
INSERT INTO `student_grade` VALUES (150, '宵宫', '005', '几何代数', '高斯', '65', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (150, '宵宫', '007', '数学分析', '陈小平', '80', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (150, '宵宫', '008', '概率论', '欧拉', '70', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (150, '宵宫', '009', '抽样调查', '阿基米德', '76', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (150, '宵宫', '011', '神学', '牛顿', '75', '统计2003班', 4);
INSERT INTO `student_grade` VALUES (151, '卡莎', '005', '几何代数', '高斯', '90', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (151, '卡莎', '007', '数学分析', '陈小平', '96', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (151, '卡莎', '008', '概率论', '欧拉', '90', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (151, '卡莎', '009', '抽样调查', '阿基米德', '91', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (151, '卡莎', '011', '神学', '牛顿', '86', '统计2004班', 4);
INSERT INTO `student_grade` VALUES (152, '阿克尚', '010', '中国古代史', '陈寿', '63', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (152, '阿克尚', '013', '中国近代史', '左丘明', '65', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (152, '阿克尚', '014', '中国现代史', '司马迁', '67', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (152, '阿克尚', '015', '文献学', '班固', '69', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (153, '佛耶戈', '010', '中国古代史', '陈寿', '86', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (153, '佛耶戈', '013', '中国近代史', '左丘明', '85', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (153, '佛耶戈', '014', '中国现代史', '司马迁', '81', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (153, '佛耶戈', '015', '文献学', '班固', '87', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (154, '永恩', '010', '中国古代史', '陈寿', '87', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (154, '永恩', '013', '中国近代史', '左丘明', '90', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (154, '永恩', '014', '中国现代史', '司马迁', '90', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (154, '永恩', '015', '文献学', '班固', '86', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (155, '瑟提', '010', '中国古代史', '陈寿', '75', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (155, '瑟提', '013', '中国近代史', '左丘明', '71', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (155, '瑟提', '014', '中国现代史', '司马迁', '73', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (155, '瑟提', '015', '文献学', '班固', '75', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (156, '琪亚娜', '010', '中国古代史', '陈寿', '86', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (156, '琪亚娜', '013', '中国近代史', '左丘明', '90', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (156, '琪亚娜', '014', '中国现代史', '司马迁', '85', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (156, '琪亚娜', '015', '文献学', '班固', '87', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (157, '佐伊', '010', '中国古代史', '陈寿', '63', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (157, '佐伊', '013', '中国近代史', '左丘明', '45', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (157, '佐伊', '014', '中国现代史', '司马迁', '59', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (157, '佐伊', '015', '文献学', '班固', '36', '历史2001班', 4);
INSERT INTO `student_grade` VALUES (158, '卡密尔', '010', '中国古代史', '陈寿', '76', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (158, '卡密尔', '013', '中国近代史', '左丘明', '78', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (158, '卡密尔', '014', '中国现代史', '司马迁', '80', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (158, '卡密尔', '015', '文献学', '班固', '82', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (159, '塔莉亚', '010', '中国古代史', '陈寿', '80', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (159, '塔莉亚', '013', '中国近代史', '左丘明', '85', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (159, '塔莉亚', '014', '中国现代史', '司马迁', '81', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (159, '塔莉亚', '015', '文献学', '班固', '80', '历史2002班', 4);
INSERT INTO `student_grade` VALUES (160, '俄洛依', '010', '中国古代史', '陈寿', '75', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (160, '俄洛依', '013', '中国近代史', '左丘明', '73', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (160, '俄洛依', '014', '中国现代史', '司马迁', '71', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (160, '俄洛依', '015', '文献学', '班固', '79', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (161, '金克丝', '010', '中国古代史', '陈寿', '92', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (161, '金克丝', '013', '中国近代史', '左丘明', '89', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (161, '金克丝', '014', '中国现代史', '司马迁', '90', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (161, '金克丝', '015', '文献学', '班固', '96', '历史2003班', 4);
INSERT INTO `student_grade` VALUES (162, '伊莉丝', '010', '中国古代史', '陈寿', '60', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (162, '伊莉丝', '013', '中国近代史', '左丘明', '51', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (162, '伊莉丝', '014', '中国现代史', '司马迁', '40', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (162, '伊莉丝', '015', '文献学', '班固', '50', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (163, '辛德拉', '010', '中国古代史', '陈寿', '60', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (163, '辛德拉', '013', '中国近代史', '左丘明', '80', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (163, '辛德拉', '014', '中国现代史', '司马迁', '90', '历史2004班', 4);
INSERT INTO `student_grade` VALUES (163, '辛德拉', '015', '文献学', '班固', '50', '历史2004班', 4);

-- ----------------------------
-- Table structure for student_info
-- ----------------------------
DROP TABLE IF EXISTS `student_info`;
CREATE TABLE `student_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `age` int NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Classroom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `college` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hotel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Classroom`(`Classroom` ASC, `id` ASC) USING BTREE,
  INDEX `Classroom_2`(`Classroom` ASC, `name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 169 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student_info
-- ----------------------------
INSERT INTO `student_info` VALUES (122, '宋张文哲', 21, '男', '计卓2002班', '计算机科学学院', '2020年', '2-A607');
INSERT INTO `student_info` VALUES (123, '田明华', 20, '男', '计卓2001班', '计算机科学学院', '2020年', '2-A607');
INSERT INTO `student_info` VALUES (125, '蒲益', 19, '女', '计卓2001班', '计算机科学学院', '2020年', '2-A607');
INSERT INTO `student_info` VALUES (127, '常墨涵', 21, '女', '计卓2002班', '计算机科学学院', '2020年', '2-A607');
INSERT INTO `student_info` VALUES (130, '张三', 17, '女', '计卓2003班', '计算机科学学院', '2020年', '2-A608');
INSERT INTO `student_info` VALUES (131, '芦亦然', 20, '男', '计卓2003班', '计算机科学学院', '2020年', '2-A608');
INSERT INTO `student_info` VALUES (132, '张一飞', 20, '男', '计卓2004班', '计算机科学学院', '2020年', '2-A608');
INSERT INTO `student_info` VALUES (135, '李四', 20, '男', '计卓2004班', '计算机科学学院', '2020年', '2-A609');
INSERT INTO `student_info` VALUES (136, '蒋娟', 20, '女', '计卓2001班', '计算机科学学院', '2020年', '6-A119');
INSERT INTO `student_info` VALUES (138, '夏慧怡', 20, '女 ', '计卓2003班', '计算机科学学院', '2020年', '6-A119');
INSERT INTO `student_info` VALUES (140, '陈星宇', 20, '男', '统计2001班', '理学院', '2020年', '2-A609');
INSERT INTO `student_info` VALUES (141, '吴沛轩', 20, '男', '统计2001班', '理学院', '2020年', '2-A201');
INSERT INTO `student_info` VALUES (142, '厄加特', 21, '男', '统计2002班', '理学院', '2020年', '2-A201');
INSERT INTO `student_info` VALUES (143, '德莱厄斯', 20, '男', '统计2002班', '理学院', '2020年', '2-A201');
INSERT INTO `student_info` VALUES (144, '德莱文', 19, '男', '统计2003班', '理学院', '2020年', '2-A201');
INSERT INTO `student_info` VALUES (145, '钟离', 22, '男', '统计2003班', '理学院', '2020年', '2-A202');
INSERT INTO `student_info` VALUES (146, '万叶', 19, '男', '统计2004班', '理学院', '2020年', '2-A202');
INSERT INTO `student_info` VALUES (147, '托马', 21, '男', '统计2004班', '理学院', '2020年', '2-A202');
INSERT INTO `student_info` VALUES (148, '甘雨', 19, '女', '统计2001班', '理学院', '2020年', '6-A120');
INSERT INTO `student_info` VALUES (149, '刻晴', 20, '女', '统计2002班', '理学院', '2020年', '6-A120');
INSERT INTO `student_info` VALUES (150, '宵宫', 20, '女', '统计2003班', '理学院', '2020年', '6-A120');
INSERT INTO `student_info` VALUES (151, '卡莎', 20, '女', '统计2004班', '理学院', '2020年', '6-A120');
INSERT INTO `student_info` VALUES (152, '阿克尚', 21, '男', '历史2001班', '人文学院', '2020年', '2-A301');
INSERT INTO `student_info` VALUES (153, '佛耶戈', 20, '男', '历史2002班', '人文学院', '2020年', '2-A301');
INSERT INTO `student_info` VALUES (154, '永恩', 19, '男', '历史2003班', '人文学院', '2020年', '2-A301');
INSERT INTO `student_info` VALUES (155, '瑟提', 22, '男', '历史2004班', '人文学院', '2020年', '2-A301');
INSERT INTO `student_info` VALUES (156, '琪亚娜', 21, '女', '历史2001班', '人文学院', '2020年', '6-A210');
INSERT INTO `student_info` VALUES (157, '佐伊', 20, '女', '历史2001班', '人文学院', '2020年', '6-A210');
INSERT INTO `student_info` VALUES (158, '卡密尔', 20, '女', '历史2002班', '人文学院', '2020年', '6-A210');
INSERT INTO `student_info` VALUES (160, '俄洛依', 22, '女', '历史2003班', '人文学院', '2020年', '6-A211');
INSERT INTO `student_info` VALUES (161, '金克丝', 20, '女', '历史2003班', '人文学院', '2020年', '6-A211');
INSERT INTO `student_info` VALUES (162, '伊莉丝', 21, '女', '历史2004班', '人文学院', '2020年', '6-A211');
INSERT INTO `student_info` VALUES (163, '辛德拉', 22, '女', '历史2004班', '人文学院', '2020年', '6-A211');
INSERT INTO `student_info` VALUES (164, '宋张文哲', 21, '男', '计卓2002班', '计算机科学学院', '2020年', '2-A607');
INSERT INTO `student_info` VALUES (165, '常小涵', 20, '男', '计卓2001班', '计算机科学学院', '2020年', '2-A607');
INSERT INTO `student_info` VALUES (166, '塔莉亚', 19, '女', '历史2002班', '人文学院', '2020年', '6-A210');

-- ----------------------------
-- Table structure for teacher_info
-- ----------------------------
DROP TABLE IF EXISTS `teacher_info`;
CREATE TABLE `teacher_info`  (
  `numteacher` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `numcourse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `course` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `college` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `salary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`numteacher`) USING BTREE,
  INDEX `course`(`course` ASC) USING BTREE,
  INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher_info
-- ----------------------------
INSERT INTO `teacher_info` VALUES (11101, '杨雪', 40, '女', '-1', '无', '教务处', '教务处负责人', '￥20000');
INSERT INTO `teacher_info` VALUES (11102, '杨阿莉', 40, '女', '002', '高等数学', '教务处', '讲师职工', '￥15000');
INSERT INTO `teacher_info` VALUES (12311, '李迎', 30, '女', '001', 'java', '计算机科学学院', '讲师', '￥17504');
INSERT INTO `teacher_info` VALUES (12601, '陈小平', 44, '男', '007', '数学分析', '理学院', '讲师', '￥10000');
INSERT INTO `teacher_info` VALUES (12602, '高斯', 46, '男', '005', '几何代数', '理学院', '讲师', '￥15000');
INSERT INTO `teacher_info` VALUES (12603, '牛顿', 50, '男', '011', '神学', '理学院', '教授', '￥15000');
INSERT INTO `teacher_info` VALUES (12604, '欧拉', 45, '男', '008', '概率论', '理学院', '讲师', '￥15000');
INSERT INTO `teacher_info` VALUES (12605, '阿基米德', 50, '男', '009', '抽样调查', '理学院', '讲师', '￥15000');
INSERT INTO `teacher_info` VALUES (12644, '刘枫', 30, '男', '006', 'C#', '计算机科学学院', '合同工', '￥10');
INSERT INTO `teacher_info` VALUES (12701, '陈寿', 45, '男', '010', '中国古代史', '人文学院', '讲师', '￥15000');
INSERT INTO `teacher_info` VALUES (12702, '左丘明', 41, '女', '013', '中国近代史', '人文学院', '讲师', '￥15000');
INSERT INTO `teacher_info` VALUES (12703, '司马迁', 55, '男', '014', '中国现代史', '人文学院', '讲师', '￥15000');
INSERT INTO `teacher_info` VALUES (12705, '班固', 51, '女', '015', '文献学', '人文学院', '讲师', '￥15000');
INSERT INTO `teacher_info` VALUES (12755, '黄国兵', 40, '男', '004', '计算机组成原理', '计算机科学学院', '讲师', '￥15001');
INSERT INTO `teacher_info` VALUES (22201, '刘勇', 45, '男', '-1', '无', '体育部', '体育部负责人', '￥20000');
INSERT INTO `teacher_info` VALUES (33301, '刘强', 42, '男', '-1', '无', '学生处', '学生处负责人', '￥20000');
INSERT INTO `teacher_info` VALUES (44401, '胡乐', 35, '女', '-1', '无', '科研处', '科研处负责人', '￥20000');
INSERT INTO `teacher_info` VALUES (55501, '张东', 40, '男', '-1', '无', '保卫处', '保卫处负责人', '￥20000');
INSERT INTO `teacher_info` VALUES (66601, '张二', 45, '男', '-1', '无', '党委办', '党委办负责人', '￥20000');
INSERT INTO `teacher_info` VALUES (77701, '李小鹏', 43, '男', '-1', '无', '国资处', '国资处负责人', '￥20000');

-- ----------------------------
-- Table structure for user_student_login
-- ----------------------------
DROP TABLE IF EXISTS `user_student_login`;
CREATE TABLE `user_student_login`  (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_student_login
-- ----------------------------
INSERT INTO `user_student_login` VALUES ('1111', '1111');
INSERT INTO `user_student_login` VALUES ('123', '123');
INSERT INTO `user_student_login` VALUES ('125', '125');
INSERT INTO `user_student_login` VALUES ('126', '126');

-- ----------------------------
-- Table structure for user_teacher_login
-- ----------------------------
DROP TABLE IF EXISTS `user_teacher_login`;
CREATE TABLE `user_teacher_login`  (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_teacher_login
-- ----------------------------
INSERT INTO `user_teacher_login` VALUES ('123', '123');
INSERT INTO `user_teacher_login` VALUES ('12311', '12311');
INSERT INTO `user_teacher_login` VALUES ('12422', '12422');
INSERT INTO `user_teacher_login` VALUES ('12533', '12533');
INSERT INTO `user_teacher_login` VALUES ('12604', '12604');

SET FOREIGN_KEY_CHECKS = 1;
