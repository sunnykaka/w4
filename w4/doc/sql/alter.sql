use w4;

alter table user add column year int;


/* ===7.31=== */
use w4;
ALTER TABLE user DROP INDEX AK_Key_2;

-- source 2014.sql

/* ===8.7=== */
use w4;

SET foreign_key_checks = 0;

delete from document_descriptor;

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

SET foreign_key_checks = 1;

/* ===8.15=== */
use w4;
update document_descriptor set year = 2013;
