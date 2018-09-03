<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js";></script>
<style>
	.weatherInfo{
		display: inline;
	}
</style>
</head>
<body>
	<script type="text/javascript">
		var weatherIconImgURL;
		function weatherCall(city){
			var key = "1042afb6d0833b90b43ecbaccad5b137";
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+key;
			$.ajax({
				url: apiURI,
				//dataType: "json",
				//type: "GET",
				//async: "false",
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
	<script>
		weatherCall();
		var seoul = "seoul";
		var daegu = "daegu";
		var florida = "florida";
	</script>
	<h1>버튼으로 구현</h1>
	<button onclick="weatherCall(seoul)">서울</button>
	<button onclick="weatherCall(daegu)">대구</button><br>
	<h1>셀렉트 박스로 구현</h1>
	<select name="selectWeather" onchange="weatherCall(this.options[this.selectedIndex].value)">
		<option value="" selected disabled>도시를 선택하세요.</option>
		<option value=seoul>서울</option>
		<option value=daegu>대구</option>
		<option value=florida>플로리다</option>
	</select>
	<h1></h1>
	현재 온도 : <div class="weatherInfo" id="temp"></div><br>
	현재 습도 : <div class="weatherInfo" id="humidity"></div><br>
	날씨 : <div class="weatherInfo" id="weather"></div><br>
	상세 날씨 : <div class="weatherInfo" id="description"></div><br>
	풍속 : <div class="weatherInfo" id="windSpeed"></div><br>
	나라 : <div class="weatherInfo" id="country"></div><br>
	도시 : <div class="weatherInfo" id="name"></div><br>
	운량 : <div class="weatherInfo" id="clouds"></div><br>
	<img class="weatherInfo" id="weatherIcon"><p><br>
</body>
</html>