use w4;


/**
 * 行业类别与表格对应关系
 */
-- 体育行政部门(社会事务管理机构) 103表,114表
insert into cat_doc_relation values(101, 10103, null, '3,14', 2014);

-- 体育组织 ,专业性团体   执行行政、事业单位会计制度   103表,114表
insert into cat_doc_relation values(102, 10105, 10402, '3,14', 2014);
insert into cat_doc_relation values(103, 10105, 10403, '3,14', 2014);
insert into cat_doc_relation values(127, 10111, 10402, '3,14', 2014);
insert into cat_doc_relation values(128, 10111, 10403, '3,14', 2014);

-- 体育组织,专业性团体    执行非营利组织会计制度   104表,114表
insert into cat_doc_relation values(104, 10105, 10404, '4,14', 2014);
insert into cat_doc_relation values(129, 10111, 10404, '4,14', 2014);

-- 体育组织,专业性团体    执行企业会计制度   102表,114表
insert into cat_doc_relation values(105, 10105, 10401, '2,14', 2014);
insert into cat_doc_relation values(130, 10111, 10401, '2,14', 2014);

-- 体育场馆（含高校） 106表
insert into cat_doc_relation values(106, 10118, null, '6', 2014);

-- 各级体育彩票管理中心 103,105表
insert into cat_doc_relation values(107, 10165, null, '3,5', 2014);

-- 中体彩公司、体彩印务公司   102表
insert into cat_doc_relation values(108, 10169, null, '2', 2014);

-- 体育健身休闲企业(休闲健身娱乐活动)  102表,114表
insert into cat_doc_relation values(109, 10129, null, '2,14', 2014);

-- 宾馆饭店  107表
insert into cat_doc_relation values(110, 10142, null, '7', 2014);

-- 体育用品、服装、鞋帽及相关体育产品的制造  111表,115表
insert into cat_doc_relation values(111, 10206, null, '11,15', 2014);

-- 服装鞋帽销售企业(体育用品、服装、鞋帽及相关产品批发,服装零售,鞋帽零售,体育用品零售/体育用品及器材零售,体育产品贸易与代理服务)  110表,116表
insert into cat_doc_relation values(112, 10247, null, '10,16', 2014);
insert into cat_doc_relation values(114, 10270, null, '10,16', 2014);
insert into cat_doc_relation values(115, 10272, null, '10,16', 2014);
insert into cat_doc_relation values(113, 10274, null, '10,16', 2014);
insert into cat_doc_relation values(125, 10275, null, '10,16', 2014);

-- 超级市场、百货公司(超级市场零售、百货零售)  109表
insert into cat_doc_relation values(116, 10266, null, '9', 2014);
insert into cat_doc_relation values(117, 10268, null, '9', 2014);

-- 体育用品销售 个体户会计制度 (体育用品、服装、鞋帽及相关体育产品的销售)  112表
insert into cat_doc_relation values(126, 10246, 10405, '12', 2014);

-- 体育中介活动  108,114表
insert into cat_doc_relation values(118, 10143, null, '8,14', 2014);

-- 体育培训服务  非营利组织会计制度   104,114表
insert into cat_doc_relation values(119, 10157, 10404, '4,14', 2014);

-- 体育培训服务  企业会计制度   102,114表
insert into cat_doc_relation values(120, 10157, 10401, '2,14', 2014);

-- 体育建筑及设计(体育场馆设计服务、体育场馆建筑活动)   113表
insert into cat_doc_relation values(121, 10195, null, '13', 2014);
insert into cat_doc_relation values(122, 10279, null, '13', 2014);

-- 新闻媒体(体育传媒服务)   113表
insert into cat_doc_relation values(124, 10170, null, '13', 2014);