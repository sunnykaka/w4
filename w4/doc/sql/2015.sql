use w4;


/**
 * 行业类别与表格对应关系
 */
-- 体育行政部门(社会事务管理机构) 103表,114表
insert into cat_doc_relation values(201, 10103, null, '3,14', 2015);

-- 体育组织 ,专业性团体   执行行政、事业单位会计制度   103表,114表
insert into cat_doc_relation values(202, 10105, 10402, '3,14', 2015);
insert into cat_doc_relation values(203, 10105, 10403, '3,14', 2015);
insert into cat_doc_relation values(227, 10111, 10402, '3,14', 2015);
insert into cat_doc_relation values(228, 10111, 10403, '3,14', 2015);

-- 体育组织,专业性团体    执行非营利组织会计制度   104表,114表
insert into cat_doc_relation values(204, 10105, 10404, '4,14', 2015);
insert into cat_doc_relation values(229, 10111, 10404, '4,14', 2015);

-- 体育组织,专业性团体    执行企业会计制度   102表,114表
insert into cat_doc_relation values(205, 10105, 10401, '2,14', 2015);
insert into cat_doc_relation values(230, 10111, 10401, '2,14', 2015);

-- 体育场馆（含高校） 106表
insert into cat_doc_relation values(206, 10118, null, '6', 2015);

-- 各级体育彩票管理中心 103,105表
insert into cat_doc_relation values(207, 10165, null, '3,5', 2015);

-- 中体彩公司、体彩印务公司   102表
insert into cat_doc_relation values(208, 10169, null, '2', 2015);

-- 体育健身休闲企业(休闲健身娱乐活动)  102表,114表
insert into cat_doc_relation values(209, 10129, null, '2,14', 2015);

-- 宾馆饭店  107表
insert into cat_doc_relation values(210, 10142, null, '7', 2015);

-- 体育用品、服装、鞋帽及相关体育产品的制造  111表,115表
insert into cat_doc_relation values(211, 10206, null, '11,15', 2015);

-- 服装鞋帽销售企业(体育用品、服装、鞋帽及相关产品批发,服装零售,鞋帽零售,体育用品零售/体育用品及器材零售,体育产品贸易与代理服务)  110表,116表
insert into cat_doc_relation values(212, 10247, null, '10,16', 2015);
insert into cat_doc_relation values(214, 10270, null, '10,16', 2015);
insert into cat_doc_relation values(215, 10272, null, '10,16', 2015);
insert into cat_doc_relation values(213, 10274, null, '10,16', 2015);
insert into cat_doc_relation values(225, 10275, null, '10,16', 2015);

-- 超级市场、百货公司(超级市场零售、百货零售)  109表
insert into cat_doc_relation values(216, 10266, null, '9', 2015);
insert into cat_doc_relation values(217, 10268, null, '9', 2015);

-- 体育用品销售 个体户会计制度 (体育用品、服装、鞋帽及相关体育产品的销售)  112表
insert into cat_doc_relation values(226, 10246, 10405, '12', 2015);

-- 体育中介活动  108,114表
insert into cat_doc_relation values(218, 10143, null, '8,14', 2015);

-- 体育培训服务  非营利组织会计制度   104,114表
insert into cat_doc_relation values(219, 10157, 10404, '4,14', 2015);

-- 体育培训服务  企业会计制度   102,114表
insert into cat_doc_relation values(220, 10157, 10401, '2,14', 2015);

-- 体育建筑及设计(体育场馆设计服务、体育场馆建筑活动)   113表
insert into cat_doc_relation values(221, 10195, null, '13', 2015);
insert into cat_doc_relation values(222, 10279, null, '13', 2015);

-- 新闻媒体(体育传媒服务)   113表
insert into cat_doc_relation values(224, 10170, null, '13', 2015);