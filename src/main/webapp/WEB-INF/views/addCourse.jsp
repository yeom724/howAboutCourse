<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.springproject.domain.Location"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries&libraries=services"></script>
<title>코스 등록</title>
	<style>
        #selectionForm {
            display: none; /* 기본적으로 숨김 */
        }
        #map {
            width: 50%;
            height: 500px;
        }
    </style>
</head>
<body>
 	<nav class="navbar navbar-expand navbar-dark bg-dark">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="./">Home</a>
			</div>
		</div>
	</nav>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
			TITLE
			</h1>
		</div>
	</div> 
	
		<!-- <div class="float-right">
			<form:form action="${pageContext.request.contextPath}/logout" method="POST">
				<input type="submit" class="btn btn-sm btn-success" value="Logout" />
			</form:form>
		</div> 
		
		 -->
		<br><br>
		<form:form modelAttribute="NewCourse"
					action="./add"
		 class="form-horizontal"
		 method="post">
		<fieldset>
		<legend>subtitle</legend>

		<div class="form-group row">
			<label class="col-sm-2 control-label">course_name</label>
			<div class="col-sm-3">
				<form:input path="course_name" class="form-control"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">location_name</label>
			<div id="locationContainer" class="col-sm-3">
				
					<div class="locationGroup">
						<input type="button" class="btn btn-secondary" value="위치 선택" onclick="openSelect(0)"/>
						<form:input path="location_names[0]" class="form-control"  id="selectedLocation0"/>
					</div>		
			</div>
			<div>
				<input type="button" class="btn btn-secondary" value="위치 추가" onclick="addInput()"/>
			</div>
		</div>

		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
			<input type="submit" class="btn btn-primary" value="전송" />
			</div>
		</div>
		</fieldset>
		</form:form>
	<div id="selectionForm">
			<c:if test="${empty sessionScope.locations}">
        		<p>위치가 없습니다.</p> <!-- 위치가 없을 때 메시지 -->
    		</c:if>
		<c:forEach var="location" items="${sessionScope.locations}">
			<div style="cursor: pointer; margin: 5px; padding: 10px; border: 1px solid #ccc;"
			 onclick="selectLocation(this,'${location.data_title}')">
			${location.data_title}
			</div>
		</c:forEach>
		<input type="hidden" name="selectedLocation" id="selectedLocation"/>
	</div>
	<div id="map">나 여기있어요</div>
	<%
		List<Location> locations = (List<Location>)request.getAttribute("locations");
	%>
	
<script>
	var currentIndex = null;
	var locationCount = 1;
	var contextPath = '${pageContext.request.contextPath}';
	// 마커 배열
    const markers = [];
	
	function addInput(){
		var newDiv = document.createElement('div');
		console.log("locationCount : "+locationCount);
		newDiv.innerHTML = '<input type="button" class="btn btn-secondary" value="위치 선택" onclick="openSelect('+locationCount+')"/>' +
        '<input type="text" name="location_names[' + locationCount + ']" class="form-control" id="selectedLocation'+ locationCount +'"/>';

		document.getElementById('locationContainer').appendChild(newDiv);
		locationCount++;
	}
	
	function getSelectList(){
		$.ajax({
			url : '${pageContext.request.contextPath}/course/selectLocation',
			type : 'GET',
			dataType : "json",
			contentType : "application/json",
			success : function(response){
				console.log('Response:', response.locations);
				printSelectList(response.locations);
			},
			error : function(xhr, status, error){
				console.error('Status:', status);
		        console.error('Error:', error);
		        console.error('Response Text:', xhr.responseText);
		        console.error('Response Status:', xhr.status);
			}
		});
	}
	
	function printSelectList(locations){
		var selectData = document.getElementById('selectData');
		if(selectData!=null){
			console.log("selectData가 null이 아님")
			selectionForm.innerHTML = '';
		}
		locations.forEach(function(locations){
			var selectionDiv = document.createElement('div');
			selectionDiv.id = 'selectData';
			selectionDiv.innerHTML = '<div style="cursor: pointer; margin: 5px; padding: 10px; border: 1px solid #ccc;" ' +
		    'onclick="selectLocation(this, \'' + locations.data_title.replace(/'/g, "\\'") + '\'), mapLoad('+locations.latitude+','+ locations.longitude+')">' +
		    locations.data_title +
		    '</div>';
			document.getElementById('selectionForm').appendChild(selectionDiv);
			
		})
	}
	
	function openSelect(index){
		currentIndex = index;
		getSelectList();
		document.getElementById("selectionForm").style.display = "block";
	} 
	
	function closeSelect(){
		document.getElementById("selectionForm").style.display = "none";
	}
	
	function selectLocation(element,title){
		$.ajax({
			url : '${pageContext.request.contextPath}/course/selectReturn',
			type : 'POST',
			data : {selectedLocation: title},
			success : function(response){
				console.log(response);
			},
			error : function(error){
				
				console.error(error);
			}
		});	
		console.log(title);
		document.getElementById('selectedLocation'+ currentIndex).value=title;
		closeSelect();
	}
	
	

    // 목록 아이템 클릭 이벤트
    function mapLoad(lat, lng) {
    	
    	const mapContainer = $('#map')[0];
        const mapOption = {
            center: new kakao.maps.LatLng(35.2345, 128.6936),
            level: 5
        };
        const map = new kakao.maps.Map(mapContainer, mapOption);

        // 지도 중심을 선택한 위치로 이동
        map.setCenter(new kakao.maps.LatLng(lat, lng));

        // 마커 생성 및 추가
        const markerPosition = new kakao.maps.LatLng(lat, lng);
        const marker = new kakao.maps.Marker({
            position: markerPosition
        });
        marker.setMap(map);
        markers.push(marker);
    };
    
    $(document).ready(function() {
        const mapContainer = $('#map')[0];
        const mapOption = {
            center: new kakao.maps.LatLng(35.2345, 128.6936),
            level: 5
        };
        const map = new kakao.maps.Map(mapContainer, mapOption);
        


    });
</script>

</body>
</html>