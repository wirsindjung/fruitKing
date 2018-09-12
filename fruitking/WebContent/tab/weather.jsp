<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	ul, li {margin:0; padding:0;}
	#main_menu {list-style: none;}
	#main_menu>li {display:inline-block; width:200px; background:#f4f4f4; text-align: center; padding:10px 0;}
	#main_menu>li>ul {list-style:none;display:none;position:absolute; background:#000; width:200px; margin-top:10px;}
	#main_menu>li>ul>li {color:#fff; padding:10px 0;}
	
	/* 오버액션 */
	#main_menu>li:hover>ul {display:block;}
	.weatherInfo{
		display: inline;
	}
	.weatherInfo{
		display: inline;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	function initialize(name, x, y, zoom) {
		/*
		http://openapi.map.naver.com/api/geocode.php?key=f32441ebcd3cc9de474f8081df1e54e3&encoding=euc-kr&coord=LatLng&query=서울특별시 노원구 섬밭로 258
		위의 링크에서 뒤에 주소를 적으면 x,y 값을 구할수 있습니다.
		*/
		var zoomLevel = zoom; // 첫 로딩시 보일 지도의 확대 레벨
		var markerTitle = name; // 현재 위치 마커에 마우스를 올렸을때 나타나는 이름
		var markerMaxWidth = 300; // 마커를 클릭했을때 나타나는 말풍선의 최대 크기
		
		
		var myLatlng = new google.maps.LatLng(x, y);
		var mapOptions = {
			zoom: zoomLevel,
			center: myLatlng,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		}
		var map = new google.maps.Map(document.getElementById('map_view'), mapOptions);
		
		var marker = new google.maps.Marker({
			position: myLatlng,
			map: map,
			title: markerTitle
		});
		
	}
</script>
</head>
<body>

	<h1>버튼으로 구현</h1>
	<button onclick="weatherCall(seoul)">서울</button>
	<button onclick="weatherCall(daegu)">대구</button>
	<button onclick="weatherCall(busan)">부산</button>
	<button onclick="weatherCall(florida)">플로리다</button>
	<button onclick="weatherCall(newyork)">뉴욕</button>
	<button onclick="weatherCall(sanfrancisco)">샌프란시스코</button><br>
	<h1>셀렉트 박스로 구현</h1>
	<select name="selectWeather" onchange="weatherCall(this.options[this.selectedIndex].value)">
		<option value="" selected disabled>도시를 선택하세요.</option>
		<option value=seoul>서울</option>
		<option value=daegu>대구</option>
		<option value=florida>플로리다</option>
	</select>
	<h1></h1>
	나라 : <div class="weatherInfo" id="country"></div><br>
	도시 : <div class="weatherInfo" id="name"></div><br>
	현재 온도 : <div class="weatherInfo" id="temp"></div><br>
	현재 습도 : <div class="weatherInfo" id="humidity"></div><br>
	날씨 : <div class="weatherInfo" id="weather"></div><br>
	상세 날씨 : <div class="weatherInfo" id="description"></div><br>
	풍속 : <div class="weatherInfo" id="windSpeed"></div><br>
	운량 : <div class="weatherInfo" id="clouds"></div><br>
	<img class="weatherInfo" id="weatherIcon"><p><br>
	<div id="map_view" style="width:500px; height:500px;"></div>
	
	<script type="text/javascript">
		var seoul = {name:"seoul", x:"37.556817", y:"126.989516", zoom:7};
		var daegu = {name:"daegu", x:"35.835504", y:"128.551723", zoom:7};
		var busan = {name:"busan", x:"35.161796", y:"129.041613", zoom:7};
		var florida = {name:"florida", x:"27.760675", y:"-81.416535", zoom:5};
		var newyork = {name:"new york", x:"40.688927", y:"-74.003385", zoom:6};
		var sanfrancisco = {name:"san francisco", x:"37.768852", y:"-122.422174", zoom:5};
		
		var weatherIconImgURL;
		function weatherCall(city){
			name = city.name;
			x = city.x;
			y = city.y;
			zoom = city.zoom;
			initialize(name, x, y, zoom);
			var key = "1042afb6d0833b90b43ecbaccad5b137";
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+name+"&appid="+key;
			$.ajax({
				url: apiURI,
				success: function(result) {
				   
					weatherIconImgURL = "http://openweathermap.org/img/w/" + result.weather[0].icon + ".png";
					document.getElementById("temp").innerHTML=(result.main.temp - 273.15).toFixed(2);
					document.getElementById("humidity").innerHTML=result.main.humidity;
					document.getElementById("weather").innerHTML=result.weather[0].main;
					document.getElementById("description").innerHTML=result.weather[0].description;
					document.getElementById("windSpeed").innerHTML=result.wind.speed;
					document.getElementById("country").innerHTML=result.sys.country;
					document.getElementById("name").innerHTML=result.name;
					document.getElementById("clouds").innerHTML=result.clouds.all + "%";
					document.getElementById("weatherIcon").src=weatherIconImgURL;
				}
			});
		};
	</script>
</body>
</html>