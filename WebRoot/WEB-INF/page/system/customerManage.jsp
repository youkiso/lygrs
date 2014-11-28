<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css?v=1'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=2'/>" rel="stylesheet" />

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- 日期控件 start -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css?v=1'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js?v=1'/>"></script>
    <!-- 日期控件 end -->
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">客户资料管理&nbsp;</h3>
   	<form name="form1" action="<c:url value='/customer-query.action'/>" method="post">
   	<input type="hidden" id="pageflag" name="pageflag" value=""/>
	<div class="queryDiv_h80">
	   	<ul class="queryWrap_ul">
			<li><label>批次：</label><input type="text" name="q_pino" class="ipt100 inputDefault" value="${q_pino }" maxlength="20"/></li>
			<li><label>车龄：</label><input type="text" name="q_caryear" class="ipt50 inputDefault" value="${q_caryear }" maxlength="3"/></li>
	        <li><label>出险次数：</label><input type="text" name="q_chuxcs" class="ipt50 inputDefault" value="${q_chuxcs }" maxlength="4"/></li>
	        <li><label>车牌号码：</label><input type="text" name="q_chephm" class="ipt100 inputDefault" value="${q_chephm }" maxlength="20"/></li>
	        <li>
	        	<c:if test="${sessionScope.vts.roleID eq 1 or sessionScope.vts.roleID eq 2}">
		        	<label>选择分配话务员：</label>
					<s:select list="alist" onchange="selectAgent(this)"  cssStyle="height:22px;" headerKey="" headerValue="--请选择话务员--" listKey="telnum" listValue="telagt" value="#session.vts.dfagt"></s:select>
					<input type="hidden" name="defaultAgent" id="selected_agt" value="${sessionScope.vts.dfagt }"/>
				</c:if>
	        </li>
		</ul>
		<ul class="queryWrap_ul" style="margin-top:-4px;">
			<li>
	        	<label>客户姓名：</label>
	        	<input type="text" name="q_uname" class="ipt100 inputDefault" value="${q_uname }" maxlength="20"/>
	        </li>	       
	        <li>
	        	<label>手机：</label>
	        	<input type="text" name="q_mobile" class="ipt100 inputDefault" value="${q_mobile }" maxlength="11"/>
	        </li>
	        <li>
	        	 <c:choose>
		        	<c:when test="${sessionScope.vts.roleID eq 1 or sessionScope.vts.roleID eq 2}">
						<label>所属话务员：</label>
						<input type="text" name="q_agtacc" class="ipt100 inputDefault" value="${q_agtacc }" maxlength="10"/>
		        	</c:when>
		        	<c:otherwise>
		        		<input type="hidden" name="q_agtacc" value="${q_agtacc }"/>
		        	</c:otherwise>
		        </c:choose>
	        </li>
	        
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
	        <li>
	        	<c:if test="${sessionScope.vts.roleID eq 1 or sessionScope.vts.roleID eq 2}">
	        		<input type="button" onclick="location.href='${pageContext.request.contextPath }/customer-exportAll.action?q_pino=${q_pino }&q_caryear=${q_caryear }&q_chuxcs=${q_chuxcs }&q_chephm=${q_chephm }&q_uname=${q_uname }&q_mobile=${q_mobile }&q_agtacc=${q_agtacc }'" class="btn4" value="导&nbsp;&nbsp;出"/>
	        	</c:if>
	        </li>
		</ul>
	</div>
    </form>
	<div class="content_List528">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="3%">批次</th>
                     <th width="6%">车牌号码</th>
                     <th width="4%">车龄</th>
                     <th width="6%">出险次数</th>
                     <c:if test="${sessionScope.vts.roleID eq 3 }">
                     <th width="8%">预约时间</th>
                     </c:if>
                     <th width="6%">客户姓名</th>
                     <th width="6%">手机</th>
                     <th width="8%">备注信息</th>
                     <c:if test="${sessionScope.vts.roleID eq 1 or sessionScope.vts.roleID eq 2 }">
                     <th width="6%">所属话务员</th>
                     </c:if>
                     <th width="14%">操作</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${cList }" var="ls" varStatus="status">
				<tr>
					<c:if test="${ls.pdt_l eq 2}">
						<c:set var="ispdt" value="color:#DC143C; font-weight:bold;"></c:set>
						<c:set var="gqtxt" value="已过期"></c:set>
					</c:if>
					<c:if test="${ls.pdt_l eq 1}">
						<c:set var="ispdt" value=""></c:set>
						<c:set var="gqtxt" value="未过期"></c:set>
					</c:if>
					<c:if test="${ls.pdt_l eq 0}">
						<c:set var="ispdt" value=""></c:set>
						<c:set var="gqtxt" value="未设置"></c:set>
					</c:if>
					
					<td>${ls.ids }</td>
					<td>${ls.cp }</td>
					<td>${ls.byear }</td>
					<td>${ls.ot }</td>
					<c:if test="${sessionScope.vts.roleID eq 3 }">
						<c:set var="cd" value="${fn:substring(ls.pdt,0,10) }"></c:set>
						<c:set var="ct" value="${fn:substring(ls.pdt,10,19) }"></c:set>
						<c:set var="pdtlen" value="${fn:length(ls.pdt) }"></c:set>
						<c:choose>
							<c:when test="${cd eq curDate }">
								<td title="${gqtxt }:${fn:substring(ls.pdt,0,19) }">${ct }</td>
							</c:when>
							<c:otherwise>
								<td title="${gqtxt }:${fn:substring(ls.pdt,0,19) }" style="${ispdt }">${fn:substring(ls.pdt,0,10) }</td>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<td title="${ls.uname }">
						<c:set var="unlen" value="${fn:length(ls.uname) }"/>
						<c:choose>
							<c:when test="${unlen gt 3 }">${fn:substring(ls.uname,0,3) }..</c:when>
							<c:otherwise>${ls.uname }</c:otherwise>
						</c:choose>
					</td>
					<td>${ls.mobile }</td>
					<td title="${ls.noteinfo }">
						<c:set var="nilen" value="${fn:length(ls.noteinfo) }"/>
						<c:choose>
							<c:when test="${nilen gt 7 }">${fn:substring(ls.noteinfo,0,7) }..</c:when>
							<c:otherwise>${ls.noteinfo }</c:otherwise>
						</c:choose>
					</td>
					<c:if test="${sessionScope.vts.roleID eq 1 or sessionScope.vts.roleID eq 2 }">
					<td id="td_agtacc${status.count }">${ls.agtacc }</td>
					</c:if>
					<td>
						<c:if test="${sessionScope.vts.roleID eq 1 or sessionScope.vts.roleID eq 2 }">
							<a href="javascript:deleteCustomerInfo('${ls.cid }')">删除</a>&nbsp;&nbsp;
							<a href="javascript:fenPeiAgt('${ls.cid }','${status.count }')">分配</a>&nbsp;&nbsp;
						</c:if>
						<c:if test="${sessionScope.vts.roleID eq 3 }">						
						<a href="#">呼叫</a>&nbsp;&nbsp;
						</c:if>
						<a href="<c:url value='customer-viewDetail.action?pino=${ls.ids }&cid=${ls.cid }&caryear=${ls.byear }&chuxcs=${ls.ot }&chudrq=${ls.odt }&baoxdq=${ls.edt }&changphm=${ls.pp }&chephm=${ls.cp }&chejh=${ls.cfif }&fadjbh=${ls.eid }&uname=${ls.uname }&idcard=${ls.crid }&mobile=${ls.mobile }&hometel=${ls.home }&officetel=${ls.office }&address=${ls.addr }&noteinfo=${ls.noteinfo }&hideflag=${ls.hideflag }&yuydate=${fn:substring(ls.pdt,0,10) }&yuytime=${fn:substring(ls.pdt,10,16) }&q_pino=${q_pino }&q_caryear=${q_caryear }&q_chuxcs=${q_chuxcs }&q_chephm=${q_chephm }&q_uname=${q_uname }&q_mobile=${q_mobile }&q_agtacc=${q_agtacc }'/>">查看</a>&nbsp;&nbsp;
						<!--  
						<a href="<c:url value='customer-tanpin.action'/>">弹屏</a>
						-->
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- jPage start -->
   	<div class="holder left"></div>
   	<div id="legend1" class="holder left"></div>
    <!-- Item oriented legend -->
    <div id="legend2" class="holder left"></div>
    <div class="left">
	    <input type="text" id="tzval" value="1" class="ipt20 inputDefault"/>
 		<button id="tiaozhuan" class="btn btn-primary">跳转</button>
	</div>
    <!-- jPage end -->
    
    <!-- 分配客户资料给话务员 -->
    <form id="form2" action="<c:url value='/customer-setAgtAlloc.action'/>" method="post">
		<input type="hidden" id="cidx" name="cid"/>
	</form>
	
    <%-- 删除客户资料 --%>
    <form id="form3" action="<c:url value='/customer-deleteCustomerInfo.action'/>" method="post">
		<input type="hidden" id="del_cidx" name="cid"/>
	</form>
    
</div>
<script type="text/javascript">
//split page task
$(function(){
	var nowPage = parent.document.getElementById("curCusManagePage").value;
	var pflag = "${pageflag }";
	if(!pflag)
	{
		nowPage = 1;
	}
	$("div.holder").jPages({
		containerID : "movies",
        first : "首页",
        previous : "上一页",
        next : "下一页",
        last : "尾页",
        startPage : nowPage,
        perPage : 24,
        keyBrowse:true,
        delay : 0,
        callback : function( pages, items ){
			parent.document.getElementById("curCusManagePage").value = pages.current;
	        $("#legend1").html("&nbsp;&nbsp;当前第"+pages.current+"页 ,&nbsp;&nbsp;总共"+pages.count+"页,&nbsp;&nbsp;");
	        $("#legend2").html("当前显示第"+items.range.start+" - "+items.range.end+"条记录,&nbsp;&nbsp;总共"+items.count+"条记录&nbsp;&nbsp;");
	    }
	});
      /* when button is clicked */
	$("#tiaozhuan").click(function(){
  		/* get given page */
		var page = parseInt( $("#tzval").val() );

  		/* jump to that page */
  		$("div.holder").jPages( page );
	});
});
</script>
<script type="text/javascript">
	function deleteCustomerInfo(cid)
	{
		layer.confirm("确定要删除吗？",function(){
			$("#del_cidx").val(cid);
			$("#form3").ajaxSubmit({ 
				success:function(data){ //提交成功的回调函数
					$("#pageflag").val("update");
					document.form1.submit();		
		        }  
			}); 
		    return false;
		});
	}
	function selectAgent(obj)
	{
		$.ajax({
			cache:false,
			async:false,
			type:"post",
			data:{defaultAgent:obj.value},
			url:"setDefaultAgent.action",
			success: function(data) {
    			$("#selected_agt").val(obj.value);
			}
		});
	}
	function fenPeiAgt(cid, c)
	{
		var a = $("#selected_agt").val();
		if(a){
			$("#cidx").val(cid);
			$("#form2").ajaxSubmit({ 
				success:function(data){ //提交成功的回调函数
					$("#td_agtacc"+c)[0].innerHTML=a;
		        }  
			});
		}
		else
		{
			alert("请选择话务员！");
		}
	}
	
</script>
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!--POP PLAYER START-->
<div id="popMusicDiv" style="display:none;"></div>
<!--POP PLAYER END-->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js?v=5'/>"></script>
<script type="text/javascript" src="<c:url value='js/cts.js?v=2'/>"></script>
</body>
</html>