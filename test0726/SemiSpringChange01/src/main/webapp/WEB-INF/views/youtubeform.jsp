<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 유튜브 검색 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"
		integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
		crossorigin="anonymous"></script>
	<script>
		function fnGetList(sGetToken) {
			var $getval = $("#search_box").val();
			if ($getval == "") {
				alert("검색어를 입력하세요.");
				$("#search_box").focus();
				return;
			}
			$("#get_view").empty();
			$("#nav_view").empty();
			//https://developers.google.com/youtube/v3/docs/search/list
			var order = "relevance";
			var maxResults = "10";
			var key = "AIzaSyD5ZALqP1e8SkvfWL65oVDCHTUoibbtJGk";
			var sTargetUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&order="
					+ order
					+ "&q="
					+ encodeURIComponent($getval)
					+ "&key="
					+ key
					+ "&maxResults=" + maxResults;

			console.log(sGetToken);
			if (sGetToken != null) {
				sTargetUrl += "&pageToken=" + sGetToken + "";
			}
			console.log(sTargetUrl);
			$.ajax({
				type : "POST",
				url : sTargetUrl,
				dataType : "jsonp",
				success : function(jdata) {
					console.log(jdata);
					$(jdata.items).each(
							function(i) {
								//console.log(this.snippet.channelId);
								$("#get_view").append(
										'<p class="box"><a href="https://youtu.be/'+this.id.videoId+'">'
												+ '<span>' + this.snippet.title
												+ '</span></a></p>');

							}).promise().done(
							function() {
								if (jdata.prevPageToken) {
									$("#nav_view").append(
											'<a href="javascript:fnGetList(\''
													+ jdata.prevPageToken
													+ '\');"><이전페이지></a>');
								}
								if (jdata.nextPageToken) {
									$("#nav_view").append(
											'<a href="javascript:fnGetList(\''
													+ jdata.nextPageToken
													+ '\');"><다음페이지></a>');
								}
							});
				},
				error : function(xhr, textStatus) {
					console.log(xhr.responseText);
					alert("에러");
					return;
				}
			});
		}
	</script>
<!-- 유튜브 플레이어  -->
	<script type="text/javascript">
	//youtube API 불러오는 부분
	var tag = document.createElement('script');
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

	//플레이어 변수 설정
	var player;
	function onYouTubeIframeAPIReady() {
	  player = new YT.Player('player', {
	    //width&height를 설정할 수 있으나, 따로 css영역으로 뺐다.
	    videoId: 'sEOuJ4z5aTc',
	    events: {
	      'onReady': onPlayerReady,//로딩중에 이벤트 실행한다
	      'onStateChange': onPlayerStateChange//플레이어 상태 변화 시 이벤트를 실행한다.
	    }
	  });
	}

	function onPlayerReady(event) {
	 //로딩된 후에 실행될 동작을 작성한다(소리 크기,동영상 속도를 미리 지정하는 것등등...)
	  event.target.playVideo();//자동재생
	 
	}

	var done = false;
	function onPlayerStateChange(event) {
	  if (event.data == YT.PlayerState.PLAYING && !done) {
	    done = true;
	    //플레이어가 재생중일 때 작성한 동작이 실행된다.
	    //(원하는 시간만큼만 재생되고 멈추게 하는 것도 가능하다.)
	  }
	}
	</script>
<body>


	<form name="form1" method="post" onsubmit="return false;">
		<input type="text" id="search_box">
		<button onclick="fnGetList();">가져오기</button>
	</form>
	<div id="get_view"></div>
	<div id="nav_view"></div>










	<div id="player"></div>







<iframe width="56.0" height="31.5"
		src="https://www.youtube.com/"+this.id.videoId
		title="YouTube video player" frameborder="0"
		allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
		allowfullscreen></iframe>

'<p class="box"><a href="https://youtu.be/'+this.id.videoId+'">'
											+ '<span>' + this.snippet.title
											+ '</span></a></p>'



	<iframe width="56.0" height="31.5"
		src="https://www.youtube.com/embed/uXfPLzYMgTE"
		title="YouTube video player" frameborder="0"
		allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
		allowfullscreen></iframe>

	<iframe width="56.0" height="31.5"
		src="https://www.youtube.com/embed/WMweEpGlu_U"
		title="YouTube video player" frameborder="0"
		allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
		allowfullscreen></iframe>

	<iframe width="56.0" height="31.5"
		src="https://www.youtube.com/embed/Eog-6RLvg14"
		title="YouTube video player" frameborder="0"
		allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
		allowfullscreen></iframe>

</body>
</html>