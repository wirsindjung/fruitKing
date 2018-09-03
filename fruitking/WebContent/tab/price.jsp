<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../css/price.css"/>
</head>
<body>
	<h1>Vertical Bar Graph</h1>
	<div class="vGraph">
		<ul>
			<li><span class="gTerm">SUN</span><span class="gBar" style="height:0%"><span>0%</span></span></li>
			<li><span class="gTerm">MON</span><span class="gBar" style="height:20%"><span>20%</span></span></li>
			<li><span class="gTerm">TUE</span><span class="gBar" style="height:30%"><span>30%</span></span></li>
			<li><span class="gTerm">WED</span><span class="gBar" style="height:40%"><span>40%</span></span></li>
			<li><span class="gTerm">THU</span><span class="gBar" style="height:50%"><span>50%</span></span></li>
			<li><span class="gTerm">FRI</span><span class="gBar" style="height:60%"><span>60%</span></span></li>
			<li><span class="gTerm">SAT</span><span class="gBar" style="height:100%"><span>100%</span></span></li>
		</ul>
	</div>
	<div id="wrap">
		<nav class="left">
			<div class="tab">
				<button class="tablinks active" onclick="openTab(event, 'tab1')">탭1</button>
				<button class="tablinks" onclick="openTab(event, 'tab2')">탭2</button>
				<button class="tablinks" onclick="openTab(event, 'tab3')">탭3</button>
			</div>
		</nav>
		
		<div class="right">
			<div id="tab1" class="tabcontent" style="display: block;">탭 1의 내용입니다. Lorem, ipsum dolor sit amet consectetur adipisicing elit. Cupiditate, porro officia dolorum minus quae saepe quo a modi eligendi est reiciendis vel corporis voluptatum possimus quas fuga doloribus. Quo, tenetur.</div>
			<div id="tab2" class="tabcontent" style="display: none;">탭 2의 내용입니다. Lorem ipsum dolor sit, amet consectetur adipisicing elit. Fugiat excepturi, similique mollitia eius esse placeat libero adipisci omnis consequuntur quas vel dolor voluptate labore debitis sit nostrum natus necessitatibus quod!</div>
			<div id="tab3" class="tabcontent" style="display: none;">탭 3의 내용입니다. Lorem ipsum dolor sit amet consectetur, adipisicing elit. Molestiae maxime optio, corporis recusandae mollitia soluta facere, iure culpa eveniet atque nihil sunt. Omnis adipisci quas maiores sequi cumque magnam ducimus!</div>
			<!-- <button type="button" onclick="$('link').attr('href', '')">CSS(X)</button> -->
			<!-- <button type="button" onclick="$('link').attr('href', 'vGraph.css')">CSS(O)</button> -->
		</div>
	</div>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
		function openTab(evt, tabName) { 
			var i, tabcontent, tablinks; tabcontent = document.getElementsByClassName("tabcontent");// 컨텐츠를 불러옵니다.
			for (i = 0; i < tabcontent.length; i++) { 
				tabcontent[i].style.display = "none"; //컨텐츠를 모두 숨깁니다. 
			}
			tablinks = document.getElementsByClassName("tablinks"); //탭을 불러옵니다. 
			for (i = 0; i < tablinks.length; i++) { 
				tablinks[i].className = tablinks[i].className.replace(" active", ""); //탭을 초기화시킵니다.
			}
			document.getElementById(tabName).style.display = "block"; //해당되는 컨텐츠만 보여줍니다.
			evt.currentTarget.className += " active"; //클릭한 탭을 활성화시킵니다.
		}
	</script>
</body>
</html>