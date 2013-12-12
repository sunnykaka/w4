use w4;

CREATE TABLE `xproxy_id_server` (
  `idxname` varchar(64) NOT NULL,
  `curid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idxname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `xproxy_id_server` VALUES ('Code',20001);
INSERT INTO `xproxy_id_server` VALUES ('Area',10001);
INSERT INTO `xproxy_id_server` VALUES ('User',10001);
INSERT INTO `xproxy_id_server` VALUES ('DocumentDescriptor',10001);
INSERT INTO `xproxy_id_server` VALUES ('PropertyDescriptor',10001);
INSERT INTO `xproxy_id_server` VALUES ('CatDocRelation',10001);
INSERT INTO `xproxy_id_server` VALUES ('NoticeType',10001);

insert into notice_type values(1, '通知公告', 255);
insert into notice_type values(2, '政策法规', 254);
insert into notice_type values(3, '系统说明', 253);
insert into notice_type values(4, '联系我们', 252);

insert into area values(1, 2, '深圳市', null, null, null),(2, 3, '罗湖区', null, 1, null),(3, 3, '福田区', null, 1, null),
	(4, 3, '南山区', null, 1, null),(5, 3, '宝安区', null, 1, null),(6, 3, '龙岗区', null, 1, null),(7, 3, '盐田区', null, 1, null),
	(8, 3, '光明新区', null, 1, null),(9, 3, '坪山新区', null, 1, null),(10, 3, '龙华新区', null, 1, null),(11, 3, '大鹏新区', null, 1, null);

-- 登记注册类型
insert into code values(10001, null, '内资企业', 'company_register', null, null, false, false, null, false),(10002, null, '国有企业', 'company_register', null, null, false, false, '/10001', true),
	(10003, null, '集体企业', 'company_register', null, null, false, false, '/10001', true),(10004, null, '股份合作企业', 'company_register', null, null, false, false, '/10001', true),
	(10005, null, '联营企业', 'company_register', null, null, false, false, '/10001', false),(10006, null, '国有联营企业', 'company_register', null, null, false, false, '/10001/10005', true),
	(10007, null, '集体联营企业', 'company_register', null, null, false, false, '/10001/10005', true),(10008, null, '国有与集体联营企业', 'company_register', null, null, false, false, '/10001/10005', true),
	(10009, null, '其他联营企业', 'company_register', null, null, false, false, '/10001/10005', true),(10010, null, '有限责任公司', 'company_register', null, null, false, false, '/10001', false),
	(10011, null, '国有独资公司', 'company_register', null, null, false, false, '/10001/10010', true),(10012, null, '其他有限责任公司', 'company_register', null, null, false, false, '/10001/10010', true),
	(10013, null, '股份有限公司', 'company_register', null, null, false, false, '/10001', true),(10014, null, '私营企业', 'company_register', null, null, false, false, '/10001', false),
	(10015, null, '私营独资企业', 'company_register', null, null, false, false, '/10001/10014', true),(10016, null, '私营合伙企业', 'company_register', null, null, false, false, '/10001/10014', true),
	(10017, null, '私营有限责任公司', 'company_register', null, null, false, false, '/10001/10014', true),(10018, null, '私营股份有限公司', 'company_register', null, null, false, false, '/10001/10014', true),
	(10019, null, '其他内资企业', 'company_register', null, null, false, false, '/10001', true),(10020, null, '港、澳、台商投资企业', 'company_register', null, null, false, false, null, false),
	(10021, null, '合资经营企业（港或澳、台资）', 'company_register', null, null, false, false, '/10020', true),(10022, null, '合作经营企业（港或澳、台资）', 'company_register', null, null, false, false, '/10020', true),
	(10023, null, '港或澳、台商独资经营企业', 'company_register', null, null, false, false, '/10020', true),(10024, null, '港或澳、台商投资股份有限公司', 'company_register', null, null, false, false, '/10020', true),
	(10025, null, '外商投资企业', 'company_register', null, null, false, false, null, false),(10026, null, '中外合资经营企业', 'company_register', null, null, false, false, '/10025', true),
	(10027, null, '中外合作经营企业', 'company_register', null, null, false, false, '/10025', true),(10028, null, '外资企业', 'company_register', null, null, false, false, '/10025', true),
	(10029, null, '外商投资股份有限公司', 'company_register', null, null, false, false, '/10025', true),(10030, null, '非企业单位', 'company_register', null, null, false, false, null, false),
	(10031, null, '国家机关', 'company_register', null, null, false, false, '/10030', true),(10032, null, '政党机关', 'company_register', null, null, false, false, '/10030', true),
	(10033, null, '社会团体', 'company_register', null, null, false, false, '/10030', true),(10034, null, '基层群众自治组织', 'company_register', null, null, false, false, '/10030', true),
	(10035, null, '事业单位', 'company_register', null, null, false, false, '/10030', true),(10036, null, '民办非企业单位', 'company_register', null, null, false, false, null, false),
	(10037, null, '民办非企业单位（法人）', 'company_register', null, null, false, false, '/10036', true),(10038, null, '民办非企业单位（合伙）', 'company_register', null, null, false, false, '/10036', true),
	(10039, null, '民办非企业单位（个人）', 'company_register', null, null, false, false, '/10036', true),(10040, null, '其他非企业单位', 'company_register', null, null, false, false, null, true);


-- 执行会计制度类别
insert into code values(10401, null, '企业会计制度', 'accounting', null, null, false, false, null, true),(10402, null, '事业单位会计制度', 'accounting', null, null, false, false, null, true),
	(10403, null, '行政单位会计制度', 'accounting', null, null, false, false, null, true),(10404, null, '民间非营利组织会计制度', 'accounting', null, null, false, false, null, true),
	(10405, null, '个体户会计制度', 'accounting', null, null, false, false, null, true), (10406, null, '其他会计制度', 'accounting', null, null, false, false, null, true);

-- 机构类型
insert into code values(10501, null, '企业', 'organization', null, null, false, false, null, true),(10502, null, '事业单位', 'organization', null, null, false, false, null, true),
	(10503, null, '机关', 'organization', null, null, false, false, null, true),(10504, null, '社会团体', 'organization', null, null, false, false, null, true),
	(10505, null, '民办非企业单位', 'organization', null, null, false, false, null, true),(10506, null, '其他组织机构', 'organization', null, null, false, false, null, true);

-- 直报年度
insert into code values(10601, null, '2013', 'declaration_year', 'current', 'opening', false, false, null, true),(10602, null, '2014', 'declaration_year', null, 'closed', false, false, null, true),
	(10603, null, '2015', 'declaration_year', null, null, false, false, null, true);

-- 是否开启重点调查
insert into code values(10611, null, '', 'major_inquiry', 'false', null, false, false, null, true);


-- 销售站类型
insert into code values(10701, null, '只销售体育彩票', 'sales_place_type', null, null, false, false, null, true),(10702, null, '只销售体育彩票和福利彩票', 'sales_place_type', null, null, false, false, null, true),
	(10703, null, '除彩票外还销售其他商品', 'sales_place_type', null, null, false, false, null, true);

-- 酒店级别
insert into code values(10801, null, '三星', 'hotel_star', null, null, false, false, null, true),(10802, null, '四星', 'hotel_star', null, null, false, false, null, true),
	(10803, null, '五星', 'hotel_star', null, null, false, false, null, true);

-- 表格109业态
insert into code values(10901, null, '百货公司', 't109_option', null, null, false, false, null, true),(10902, null, '超级市场', 't109_option', null, null, false, false, null, true);

-- 表格110所属行业
insert into code values(11001, null, '服装批发', 't110_option', null, null, false, false, null, true),(11002, null, '鞋帽批发', 't110_option', null, null, false, false, null, true),
	(11003, null, '服装零售', 't110_option', null, null, false, false, null, true),(11004, null, '鞋帽零售', 't110_option', null, null, false, false, null, true),
	(11005, null, '体育用品批发', 't110_option', null, null, false, false, null, true),(11006, null, '体育用品零售', 't110_option', null, null, false, false, null, true),
	(11007, null, '其他体育相关产品批发', 't110_option', null, null, false, false, null, true),(11008, null, '其他体育相关产品零售', 't110_option', null, null, false, false, null, true);

-- 表格111所属行业
insert into code values(11101, null, '纺织服装制造', 't111_option', null, null, false, false, null, true),(11102, null, '制帽', 't111_option', null, null, false, false, null, true),
	(11103, null, '皮鞋制造', 't111_option', null, null, false, false, null, true),(11104, null, '橡胶靴鞋制造', 't111_option', null, null, false, false, null, true),
	(11105, null, '体育用品', 't111_option', null, null, false, false, null, true),(11106, null, '其他体育相关产品', 't111_option', null, null, false, false, null, true);


-- 企业资料经营体育类型
insert into code values(11201, null, '主营', 'company_business_type', null, null, false, false, null, true),(11202, null, '兼营', 'company_business_type', null, null, false, false, null, true);

-- 表格106场馆类型
insert into code values(11301, null, '综合体育场', 'stadium_type', null, null, false, false, null, true),(11302, null, '综合体育馆', 'stadium_type', null, null, false, false, null, true),
	(11303, null, '体育训练基地', 'stadium_type', null, null, false, false, null, true),(11304, null, '游泳比赛场馆', 'stadium_type', null, null, false, false, null, true),
	(11305, null, '足、蓝、排球馆', 'stadium_type', null, null, false, false, null, true),(11306, null, '网球、羽毛球、乒乓球场馆', 'stadium_type', null, null, false, false, null, true),
	(11307, null, '棋牌比赛场馆', 'stadium_type', null, null, false, false, null, true),(11308, null, '其他未列明比赛场馆', 'stadium_type', null, null, false, false, null, true);

-- 表格114体育健身休闲类别
insert into code values(11401, null, '综合体育娱乐场所', 'fitness_type', null, null, false, false, null, true),(11402, null, '保龄球馆', 'fitness_type', null, null, false, false, null, true),
	(11403, null, '健身中心（馆）', 'fitness_type', null, null, false, false, null, true),(11404, null, '台球室、飞镖室', 'fitness_type', null, null, false, false, null, true),
	(11405, null, '高尔夫球场', 'fitness_type', null, null, false, false, null, true),(11406, null, '射击、射箭馆（场）', 'fitness_type', null, null, false, false, null, true),
	(11407, null, '滑沙、滑雪以及模拟滑雪场所的活动', 'fitness_type', null, null, false, false, null, true),(11408, null, '惊险娱乐活动场所', 'fitness_type', null, null, false, false, null, true),
	(11409, null, '娱乐性军事训练', 'fitness_type', null, null, false, false, null, true),(11410, null, '体能训练场所', 'fitness_type', null, null, false, false, null, true),
	(11411, null, '其他未列明的休闲娱乐健身娱乐活动', 'fitness_type', null, null, false, false, null, true);

-- 技术支持联系方式
insert into code values(11501, '1', '', 'support_contact', null, null, false, false, null, true),(11502, '2', '', 'support_contact', null, null, false, false, null, true);
insert into code values(11503, '3', '', 'support_contact', null, null, false, false, null, true),(11504, '4', '', 'support_contact', null, null, false, false, null, true);

-- 页脚联系方式和版权
insert into code values(11601, 'contact', '', 'footer_info', null, null, false, false, null, true),(11602, 'copyright', '', 'footer_info', null, null, false, false, null, true);

/**
 * 表格
 */
insert into document_descriptor values(2, '深体102表', '体育服务业企业财务状况', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(3, '深体103表', '体育服务业行政、事业单位财务状况', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(4, '深体104表', '体育服务业民间非营利组织单位财务状况', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(5, '深体105表', '体育彩票销售调查表（市体彩中心填写）', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(6, '深体106表', '体育场馆（含高校）调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(7, '深体107表', '三星级及以上宾馆饭店调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(8, '深体108表', '体育中介服务企业调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(9, '深体109表', '百货公司、超级市场中体育用品、体育服装鞋帽销售情况调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(10, '深体110表', '体育用品、体育服装鞋帽、体育相关产品销售情况调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(11, '深体111表', '制造企业中体育用品、体育服装鞋帽、体育相关产品产值情况调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(12, '深体112表', '个体户（经营体育用品、体育服装鞋帽销售等）情况调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(13, '深体113表', '其他企业体育业务活动调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(14, '深体114表', '业务活动调查表', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, null, '义务调查', false);
insert into document_descriptor values(15, '深体115表', '体育用品、体育服装鞋帽、体育相关产品制造企业财务状况及产值', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, '万元', '义务调查', true);
insert into document_descriptor values(16, '深体116表', '体育用品、体育服装鞋帽、体育相关产品批发和零售企业财务状况', 2013, '深圳市文体旅游局', '深圳市统计局', '深统法字[2013]2号', '2015年6月13日', null, '万元', '义务调查', true);


/**
 * 行业类别与表格对应关系
 */
-- 体育行政部门(社会事务管理机构) 103表,114表
insert into cat_doc_relation values(1, 10103, null, '3,14', 2013);

-- 体育组织 ,专业性团体   执行行政、事业单位会计制度   103表,114表
insert into cat_doc_relation values(2, 10105, 10402, '3,14', 2013);
insert into cat_doc_relation values(3, 10105, 10403, '3,14', 2013);
insert into cat_doc_relation values(27, 10111, 10402, '3,14', 2013);
insert into cat_doc_relation values(28, 10111, 10403, '3,14', 2013);

-- 体育组织,专业性团体    执行非营利组织会计制度   104表,114表
insert into cat_doc_relation values(4, 10105, 10404, '4,14', 2013);
insert into cat_doc_relation values(29, 10111, 10404, '4,14', 2013);

-- 体育组织,专业性团体    执行企业会计制度   102表,114表
insert into cat_doc_relation values(5, 10105, 10401, '2,14', 2013);
insert into cat_doc_relation values(30, 10111, 10401, '2,14', 2013);

-- 体育场馆（含高校） 106表
insert into cat_doc_relation values(6, 10118, null, '6', 2013);

-- 各级体育彩票管理中心 103,105表
insert into cat_doc_relation values(7, 10165, null, '3,5', 2013);

-- 中体彩公司、体彩印务公司   102表
insert into cat_doc_relation values(8, 10169, null, '2', 2013);

-- 体育健身休闲企业(休闲健身娱乐活动)  102表,114表
insert into cat_doc_relation values(9, 10129, null, '2,14', 2013);

-- 宾馆饭店  107表
insert into cat_doc_relation values(10, 10142, null, '7', 2013);

-- 体育用品、服装、鞋帽及相关体育产品的制造  111表,115表
insert into cat_doc_relation values(11, 10206, null, '11,15', 2013);

-- 服装鞋帽销售企业(体育用品、服装、鞋帽及相关产品批发,服装零售,鞋帽零售,体育用品零售/体育用品及器材零售,体育产品贸易与代理服务)  110表,116表
insert into cat_doc_relation values(12, 10247, null, '10,16', 2013);
insert into cat_doc_relation values(14, 10270, null, '10,16', 2013);
insert into cat_doc_relation values(15, 10272, null, '10,16', 2013);
insert into cat_doc_relation values(13, 10274, null, '10,16', 2013);
insert into cat_doc_relation values(25, 10275, null, '10,16', 2013);

-- 超级市场、百货公司(超级市场零售、百货零售)  109表
insert into cat_doc_relation values(16, 10266, null, '9', 2013);
insert into cat_doc_relation values(17, 10268, null, '9', 2013);

-- 体育用品销售 个体户会计制度 (体育用品、服装、鞋帽及相关体育产品的销售)  112表
insert into cat_doc_relation values(26, 10246, 10405, '12', 2013);

-- 体育中介活动  108,114表
insert into cat_doc_relation values(18, 10143, null, '8,14', 2013);

-- 体育培训服务  非营利组织会计制度   104,114表
insert into cat_doc_relation values(19, 10157, 10404, '4,14', 2013);

-- 体育培训服务  企业会计制度   102,114表
insert into cat_doc_relation values(20, 10157, 10401, '2,14', 2013);

-- 体育建筑及设计(体育场馆设计服务、体育场馆建筑活动)   113表
insert into cat_doc_relation values(21, 10195, null, '13', 2013);
insert into cat_doc_relation values(22, 10279, null, '13', 2013);

-- 新闻媒体(体育传媒服务)   113表
insert into cat_doc_relation values(24, 10170, null, '13', 2013);