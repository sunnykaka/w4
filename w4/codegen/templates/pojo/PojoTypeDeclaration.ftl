/**
${pojo.getClassJavaDoc(pojo.getDeclarationName() + " generated by hbm2java", 0)}
 */
<#include "Ejb3TypeDeclaration.ftl"/>
${pojo.getClassModifiers()} ${pojo.getDeclarationType()} ${pojo.getDeclarationName()} ${pojo.getExtendsDeclaration()} <#if pojo.getImplementsDeclaration()??>${pojo.getImplementsDeclaration()},com.rootrip.platform.common.dao.Entity<Long><#else> implements com.rootrip.platform.common.dao.Entity<Long></#if>  