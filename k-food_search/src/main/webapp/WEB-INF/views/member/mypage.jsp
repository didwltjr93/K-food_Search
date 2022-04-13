<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/mypage.css" type="text/css" />
<link rel="stylesheet" href="/css/memberReview.css" type="text/css" />
<link rel="stylesheet" href="/css/memberFavor.css" type="text/css" />
<link rel="stylesheet" href="/css/memberReserv.css" type="text/css" />
<script>
	function DrDw2(F,b){
		var aCL=F.split("~");
		var iC=aCL.length;
		if(aCL[iC-1]=="")iC--;
		var i=0;
		while(i<iC){
			document.write("<option value=\""+aCL[i]+"\""+(b==aCL[i]?" selected":"")+">"+aCL[i+1]);
			i=i+2;
		}
	};
	// 탭메뉴설정
	$(document).ready(function() {
		$(".mypage_menu>span").click(function() {
			var idx = $(this).index();
			$(".mypage_menu>span").removeClass("on");
			$(".mypage_menu>span").eq(idx).addClass("on");
			$(".mypage_container>div").hide();
			$(".mypage_container>div").eq(idx).show();
		});
		
		$("#pwdChk").click(function() {
			if($('#userpwd1').val()==""){
				alert("비밀번호 입력하세요.");
				return false;
			}
			if($('#userpwd1').val()!="${vo.userpwd}"){
				alert("비밀번호가 틀렸습니다.");
				return false;
			}
			$(".mypage_container>div:nth-child(1)").hide();
			$(".mypage_container>div:nth-child(2)").show();
			return true;
		});
		
		$("#favornation").change(function(){
			//console.log($("#favornation option:selected").val())
			//console.log($("#favornation option:selected").text())
			
			var idx = $("#favornation option").index( $("#favornation option:selected") );
			var state = new Array();
			var target = document.querySelector("#favorstate");
			
			//state[0] = ['테스트1','테스트2','테스트3'];
			state[114] = ['서울', '경기도', '마산'];
			
			target.options.length=1;
			
			for(i in state[idx]){
				var opt = document.createElement("option");
				opt.value = state[idx][i];
				opt.innerHTML = state[idx][i];
				opt.selected;
				target.appendChild(opt);
			}
		});
		
		$("#chgbtn").click(function(){
			if($("#usertype").val() == "owner(jin)"){
				alert("이미 사업주등록을 신청하였습니다.\n수정하기버튼을 눌러주세요.");
				return;
			}
			$("#usertype").val("owner(jin)");
			alert("사업주등록을 신청하였습니다.\n수정하기버튼을 눌러주세요.");
			return true;
		});

		$("#mFrm").submit(function(){
			var regular = /^[a-zA-Z0-9]{6,16}$/;
			if($("#usernation").val()==''){
				alert("국적을 선택해 주세요.")
				$("#usernation").focus();
				return false;
			}
			if($("#favornation").val()==''){
				alert("여행 선호 국가를 선택해주세요.")
				$("#favornation").focus();
				return false;
			}
			if($("#favorstate").val()==''){
				alert("여행 선호 국가를 선택해주세요.")
				$("#favorstate").focus();
				return false;
			}
			if($("#username").val()==''){
				alert("이름을 입력해주세요.")
				$("#username").focus();
				return false;
			}
			if($("#tel2").val()==''){
				alert("전화번호를 입력해주세요.");
				$("#tel2").focus();
				return false;
			}
			regular=/^[0-9]{3,5}$/;
			if(!regular.test($("#tel2").val())){
				alert("전화번호 입력 양식이 잘못되었습니다.\n*3~5자리 숫자만 입력 가능합니다.");
				$("#tel2").focus();
				return false;
			}
			regular=/^[0-9]{3,5}$/;
			if(!regular.test($("#tel3").val())){
				alert("전화번호 입력 양식이 잘못되었습니다.\n*3~5자리 숫자만 입력 가능합니다.");
				$("#tel3").focus();
				return false;
			}
			var data = $("#mFrm").serialize();
			console.log(decodeURIComponent(data))
			return true;
		});
	});	
	$(function(){
		// 리뷰목록
		function memberReview() {
			var url = "/review/memberReviewList";
			$.ajax({
				url: url,
				success: function(result) {
					var $result = $(result);
					
					var tag = "";
					$result.each(function(idx, vo){
						tag += '<div id="memberReviewList">';
						tag += '<img id="resimg" name="resimg" src="/img/noImg.jpg"/>';
						tag += '<span id="a">★'+vo.resgrade+'&nbsp<a href="#">'+vo.resname+'</a><br/></span>';
						tag += '<span id="b">'+vo.writedate+'<br/></span>';
						tag += '<div id="c">★'+vo.grade+'&nbsp'+vo.content+'</div>';
						tag += '</div>'
					});
					
					
					$("#memberReview").html(tag);
				},
				error: function(e) {
					console.log(e.responseText);
				}
			});
		}
		memberReview();
	});
	
	$(function(){
		// 즐겨찾기
		function memberFavor() {
			var url = "/memFavor/memFavorList";
			$.ajax({
				url: url,
				success: function(result) {
					var $result = $(result);
					
					var tag = '<ul class="memFavorList">';
					$result.each(function(idx, vo){
						tag += '<li><a href="#"><img src="/img/noImg.jpg">';
						tag += '<span>'+vo.resname+'<br/></span>';
						tag += '<span>'+vo.resnation+'&nbsp'+vo.resstate+'<br/></span>';
						tag += '<span>★'+vo.resgrade+'</span></a></li>';
					});
					tag += '</ul>';
					
					$("#memberFavor").html(tag);
				},
				error: function(e) {
					console.log(e.responseText);
				}
			});
		}
		memberFavor();
	});
	$(function(){
		// 예약현황
		function memberReserv() {
			var url = "/memReserv/memReservList";
			$.ajax({
				url: url,
				success: function(result) {
					var $result = $(result);
					
					var tag ="";
					$result.each(function(idx, vo){
						tag += '<div id="memberReservList">'; <!-- 반복될부분 -->
						tag += '<div id="memberReserv">'; <!-- 예약정보 -->
						tag += '<ul>';
						if(vo.status == "apply"){
						tag += '<li>예약 가능여부를 확인중 입니다.</li>';
						tag += '<li>['+vo.resname+']에서 확인하는대로 빠른 시간내 결과를 안내해 드리겠습니다.</li>';
						};
						if(vo.status == "reject"){
						tag += '<li>예약이 거부되었습니다.</li>';
						tag += '<li>자세한 문의사항은 아래 문의 이메일로 연락주시길바랍니다.</li>';
						};
						if(vo.status == "cancel"){
						tag += '<li>예약을 취소하셨습니다.</li>';
						tag += '<li>예약 취소가 완료되었습니다.</li>';
						};
						if(vo.status == "ok"){
						tag += '<li>예약이 승인되었습니다.</li>';
						tag += '<li>만약 예약을 취소하시려면 아래 문의 이메일로 연락주시길바랍니다.</li>';
						};
						tag += '<li>'+vo.resname+'</li>';
						tag += '<li><hr/></li>';
						tag += '<li>예약날짜: <span>'+vo.reservdate+'&nbsp'+vo.reservtime+'</span></li>';
						tag += '<li>인원: <span>'+vo.reservp+'명</span></li>';
						tag += '<li>문의: <span>'+vo.website+'</span></li>';
						if(vo.status == "apply"){
						tag += '<li id="btn"><input type="button" value="예약취소"></li>';
						};
						if(vo.status == "cancel" || vo.status == "reject"){
						tag += '<li id="btn"><input type="button" value="삭제"></li>';
						};
						tag += '</ul>';
						tag += '</div>';
						tag += '<div id="writedate">'+vo.writedate+'</div>';
						tag += '</div>';
					});
					$("#memberReserv").html(tag);
				},
				error: function(e) {
					console.log(e.responseText);
				}
			});
		}
		memberReserv();
	});
</script>
<div class='container'>
	<div class="hello">"안녕하세요 <b>${username }</b>님📖 <br/>마이페이지에 오신걸 환영합니다."</div>
	
	<div class='mypage_menu'>
		&nbsp;옛날에 나무꾼 부부가 살았습니다. 나무꾼의 부인은 수다쟁이였습니다. “이봐요! 
		<span>회원정보수정</span>
		개똥이 엄마! 말똥이 엄마가 어쩌고저쩌고..” 어느 날 나무꾼은 평상시와 같이 나무를 하러 산으로 갔습니다. 
		<span style="display:none;">회원정보수정</span>
		그때, 산에서 번쩍거리는 커다란 황금을 발견했습니다. 
		“와! 신난다. 이제 나는 부자가 되는 거야!” 순간 나무꾼은 그의 부인이 수다쟁이라는 사실을 떠올렸습니다. 
		‘아차! 이를 어쩌지? 이 황금덩어리를 보면 부인은 동네방네 떠들 거고…그럼 도둑이 들어와서 이 황금 덩이를 훔쳐 갈지 몰라. 
		이를 어쩌지?’ 나무꾼은 한참을 생각해 봤습니다.
		<span>예약현황</span>
		그러다가 나무꾼에게 좋은 꾀가 떠올랐습니다. 
		‘옳지! 그러면 되겠구나’ 나무꾼은 점심 도시락으로 싸온 주먹밥을 나뭇가지 위에 꽂아두었습니다. 
		그러곤 집으로 쏜살같이 달려갔습니다. “여보! 여보!” “아니 당신이 웬일이에요? 지게는요?” “지금 지게가 문제가 아니야. 
		내가 방금 산에서 주먹밥같이 열리는 나무를 보았다오.” “네? 주먹밥이 열리는 나무요? 세상에 그런 게 어디 있어요?” 
		<span>내리뷰보기</span>
		“그럼 날 따라와 보시오. 내가 보여 줄 테니.” 나무꾼은 그의 부인을 데리고 아까 주먹밥을 꽂아둔 나무로 갔습니다. 
		“아니! 세상에 이럴 수가.. 이제 우리는 나무하지 않아도 평생 먹고 살 수 있어요. 
		가만있자. 내가 지금 이럴 때가 아니지.. 어서 가서 동네 사람들에게 알려야겠다! 
		<span>즐겨찾기</span>
		개똥이 엄마, 소똥이 엄마..” 나무꾼의 부인은 쏜살같이 마을로 내려가서 마을 사람들에게 주먹밥이 열리는 나무에 대해서 말했습니다. 
		그러나 마을 사람들은 아무도 그 말을 믿지 않았습니다. “아니, 수다쟁이 아줌마가 아무래도 어떻게 된 거 아냐?” 
		“그러게 말이에요. 세상에 주먹밥이 열리는 나무가 어디 있어요?” 
		그때를 맞춰서 나무꾼이 부인에게 황금 덩이를 보여주며 말했습니다. 
		“여보 실은 내가 아까 나무를 하다가 산에서 이 황금덩어리를 주었다오.” 
		“어머나! 정말 황금이네? 이젠 우리 부자가 됐어! 부자가! 아니지.. 
		이 기쁜 소식을 나만 알고 있으면 안 되지. 동네 사람들 내 말 좀 들어보세요…”
		나무꾼의 부인은 또다시 마을 가서 마을 사람들에게 산에서 황금 덩이를 주운 얘기를 했습니다. 
		마을 사람들은 이번에도 아무도 그 말을 믿지 않았습니다. 
		“아무래도 저 여자가 좀 미친 것 같아.. 쯧쯧..” 
		“그러게 말이야. 아까는 주먹밥이 열리는 나무가 있다고 하다니 또 지금은 산에서 황금 덩이를 주었다고 하지 않나.” 
		“아이고, 젊은 부인이 안됐구먼.. 쯧쯧..” 그런 일이 있은 후 나무꾼의 부인은 수다쟁이 버릇을 고치게 됐어요. 
		그리고 나무꾼 부부는 그 황금덩어리를 팔아 큰 부자가 돼서 행복하게 살았답니다.
		만약 나무꾼이 아내의 수다쟁이 버릇을 혼내기만 했다면 아내는 그 버릇을 고치지 못했을 것입니다. 
		다행하게도 나무꾼의 현명한 방법으로 아내와 사이가 멀어지지 않고도 버릇을 고칠 수 있었으며 
		금을 가지고 있다는 사실도 도둑들의 귀에 들어가지 않아 부유하게 살 수 있게 되었죠. 
		모든 일이 그르치기만 한다고 해서 해결되는 것이 아니라 어떻게 행동하냐에 따라 결과나 달라질 수 있음을 알 수 있는 동화였습니다.
	</div>
	<div class='mypage_container'>
		<div>
			<h3>회원정보 수정</h3>
			<div id="memberEdit">
				<!-- <form method="post" action="/member/memberEdit2" id="mFrm"> -->
				<ul>
					<li>아이디</li>
					<li><input type="text" name="userid" id="userid1" value="${vo.userid}" readonly></li>
					<li>비밀번호</li>
					<li><input type="text" name="userpwd" id="userpwd1" placeholder="비밀번호입력"></li>
					<li><input type="button" id="pwdChk" value="확인하기"></li>
				</ul>
			</div>
		</div>

		<div style="display: none;">
			<h3>회원정보 수정</h3>
			<div id="memberEdit2">
				<div style="display: block" id="content1">
					<form method="post" action="/member/memberEditOk" id="mFrm">
						<ul>
							<li>아이디
								<input type="text" name="usertype" id="usertype" value="${vo.usertype}" style="display: none">
								<c:if test="${vo.usertype=='owner'}">(사업주)</c:if>
								<c:if test="${vo.usertype=='owner(jin)'}">(사업주 승인대기)</c:if>
								<c:if test="${vo.usertype=='normal'}">(일반회원) <input id="chgbtn"type="button" value="사업주등록신청"></c:if>
							</li>
							<li><input type="text" name="userid" value="${vo.userid}" readonly style="all:none"></li>
							<li>국적</li>
							<li>
     							 <select id="usernation" name="usernation" >
        							 <script>
     									 DrDw2("~국가선택~AF~Afghanistan~AL~Albania~DZ~Algeria~AS~American Samoa~AD~Andorra~AO~Angola~AI~Anguilla~AQ~Antarctica~AG~Antigua and Barbuda~AR~Argentina~AM~Armenia~AW~Aruba~AC~Ascension Island~AU~Australia~AT~Austria~AZ~Azerbaijan~BS~Bahamas~BH~Bahrain~BD~Bangladesh~BB~Barbados~BY~Belarus~BE~Belgium~BZ~Belize~BJ~Benin~BM~Bermuda~BT~Bhutan~BO~Bolivia~BA~Bosnia and Herzegovina~BW~Botswana~BV~Bouvet Island~BR~Brazil~IO~British Indian Ocean Territory~BN~Brunei~BG~Bulgaria~BF~Burkina Faso~BI~Burundi~KH~Cambodia~CM~Cameroon~CA~Canada~CV~Cape Verde~KY~Cayman Islands~CF~Central African Republic~TD~Chad~CL~Chile~CN~China~CX~Christmas Island~CC~Cocos (Keeling) Islands~CO~Colombia~KM~Comoros~CG~Congo~CD~Congo (DRC)~CK~Cook Islands~CR~Costa Rica~HR~Croatia~CU~Cuba~CY~Cyprus~CZ~Czech Republic~DK~Denmark~DJ~Djibouti~DM~Dominica~DO~Dominican Republic~EC~Ecuador~EG~Egypt~SV~El Salvador~GQ~Equatorial Guinea~ER~Eritrea~EE~Estonia~ET~Ethiopia~FK~Falkland Islands (Islas Malvinas)~FO~Faroe Islands~FJ~Fiji Islands~FI~Finland~FR~France~GF~French Guiana~PF~French Polynesia~TF~French Southern and Antarctic Lands~GA~Gabon~GM~Gambia, The~GE~Georgia~DE~Germany~GH~Ghana~GI~Gibraltar~GR~Greece~GL~Greenland~GD~Grenada~GP~Guadeloupe~GU~Guam~GT~Guatemala~GG~Guernsey~GN~Guinea~GW~Guinea-Bissau~GY~Guyana~HT~Haiti~HM~Heard Island and McDonald Islands~HN~Honduras~HK~Hong Kong SAR~HU~Hungary~IS~Iceland~IN~India~ID~Indonesia~IR~Iran~IQ~Iraq~IE~Ireland~IM~Isle of Man~IL~Israel~IT~Italy~JM~Jamaica~JP~Japan~JE~Jersey~JO~Jordan~KZ~Kazakhstan~KE~Kenya~KI~Kiribati~KR~Korea~KW~Kuwait~KG~Kyrgyzstan~LA~Laos~LV~Latvia~LB~Lebanon~LS~Lesotho~LR~Liberia~LY~Libya~LI~Liechtenstein~LT~Lithuania~LU~Luxembourg~MO~Macao SAR~MK~Macedonia, Former Yugoslav Republic of~MG~Madagascar~MW~Malawi~MY~Malaysia~MV~Maldives~ML~Mali~MT~Malta~MH~Marshall Islands~MQ~Martinique~MR~Mauritania~MU~Mauritius~YT~Mayotte~MX~Mexico~FM~Micronesia~MD~Moldova~MC~Monaco~MN~Mongolia~MS~Montserrat~MA~Morocco~MZ~Mozambique~MM~Myanmar~NA~Namibia~NR~Nauru~NP~Nepal~NL~Netherlands~AN~Netherlands Antilles~NC~New Caledonia~NZ~New Zealand~NI~Nicaragua~NE~Niger~NG~Nigeria~NU~Niue~NF~Norfolk Island~KP~North Korea~MP~Northern Mariana Islands~NO~Norway~OM~Oman~PK~Pakistan~PW~Palau~PS~Palestinian Authority~PA~Panama~PG~Papua New Guinea~PY~Paraguay~PE~Peru~PH~Philippines~PN~Pitcairn Islands~PL~Poland~PT~Portugal~PR~Puerto Rico~QA~Qatar~RE~Reunion~RO~Romania~RU~Russia~RW~Rwanda~WS~Samoa~SM~San Marino~ST~S? Tom?and Pr?cipe~SA~Saudi Arabia~SN~Senegal~YU~Serbia and Montenegro~SC~Seychelles~SL~Sierra Leone~SG~Singapore~SK~Slovakia~SI~Slovenia~SB~Solomon Islands~SO~Somalia~ZA~South Africa~GS~South Georgia and the South Sandwich Islands~ES~Spain~LK~Sri Lanka~SH~St. Helena~KN~St. Kitts and Nevis~LC~St. Lucia~PM~St. Pierre and Miquelon~VC~St. Vincent and the Grenadines~SD~Sudan~SR~Suriname~SJ~Svalbard and Jan Mayen~SZ~Swaziland~SE~Sweden~CH~Switzerland~SY~Syria~TW~Taiwan~TJ~Tajikistan~TZ~Tanzania~TH~Thailand~TP~Timor-Leste~TG~Togo~TK~Tokelau~TO~Tonga~TT~Trinidad and Tobago~TA~Tristan da Cunha~TN~Tunisia~TR~Turkey~TM~Turkmenistan~TC~Turks and Caicos Islands~TV~Tuvalu~UG~Uganda~UA~Ukraine~AE~United Arab Emirates~UK~United Kingdom~US~United States~UM~United States Minor Outlying Islands~UY~Uruguay~UZ~Uzbekistan~VU~Vanuatu~VA~Vatican City~VE~Venezuela~VN~Vietnam~VI~Virgin Islands~VG~Virgin Islands, British~WF~Wallis and Futuna~YE~Yemen~ZM~Zambia~ZW~Zimbabwe","${vo.usernation}");
									</script>
     							 </select>
      						</li>
							<li>여행 선호 국가</li>
							<li>
								<select id="favornation" name="favornation" >
        							 <script>
    								  	DrDw2("~국가선택~AF~Afghanistan~AL~Albania~DZ~Algeria~AS~American Samoa~AD~Andorra~AO~Angola~AI~Anguilla~AQ~Antarctica~AG~Antigua and Barbuda~AR~Argentina~AM~Armenia~AW~Aruba~AC~Ascension Island~AU~Australia~AT~Austria~AZ~Azerbaijan~BS~Bahamas~BH~Bahrain~BD~Bangladesh~BB~Barbados~BY~Belarus~BE~Belgium~BZ~Belize~BJ~Benin~BM~Bermuda~BT~Bhutan~BO~Bolivia~BA~Bosnia and Herzegovina~BW~Botswana~BV~Bouvet Island~BR~Brazil~IO~British Indian Ocean Territory~BN~Brunei~BG~Bulgaria~BF~Burkina Faso~BI~Burundi~KH~Cambodia~CM~Cameroon~CA~Canada~CV~Cape Verde~KY~Cayman Islands~CF~Central African Republic~TD~Chad~CL~Chile~CN~China~CX~Christmas Island~CC~Cocos (Keeling) Islands~CO~Colombia~KM~Comoros~CG~Congo~CD~Congo (DRC)~CK~Cook Islands~CR~Costa Rica~HR~Croatia~CU~Cuba~CY~Cyprus~CZ~Czech Republic~DK~Denmark~DJ~Djibouti~DM~Dominica~DO~Dominican Republic~EC~Ecuador~EG~Egypt~SV~El Salvador~GQ~Equatorial Guinea~ER~Eritrea~EE~Estonia~ET~Ethiopia~FK~Falkland Islands (Islas Malvinas)~FO~Faroe Islands~FJ~Fiji Islands~FI~Finland~FR~France~GF~French Guiana~PF~French Polynesia~TF~French Southern and Antarctic Lands~GA~Gabon~GM~Gambia, The~GE~Georgia~DE~Germany~GH~Ghana~GI~Gibraltar~GR~Greece~GL~Greenland~GD~Grenada~GP~Guadeloupe~GU~Guam~GT~Guatemala~GG~Guernsey~GN~Guinea~GW~Guinea-Bissau~GY~Guyana~HT~Haiti~HM~Heard Island and McDonald Islands~HN~Honduras~HK~Hong Kong SAR~HU~Hungary~IS~Iceland~IN~India~ID~Indonesia~IR~Iran~IQ~Iraq~IE~Ireland~IM~Isle of Man~IL~Israel~IT~Italy~JM~Jamaica~JP~Japan~JE~Jersey~JO~Jordan~KZ~Kazakhstan~KE~Kenya~KI~Kiribati~KR~Korea~KW~Kuwait~KG~Kyrgyzstan~LA~Laos~LV~Latvia~LB~Lebanon~LS~Lesotho~LR~Liberia~LY~Libya~LI~Liechtenstein~LT~Lithuania~LU~Luxembourg~MO~Macao SAR~MK~Macedonia, Former Yugoslav Republic of~MG~Madagascar~MW~Malawi~MY~Malaysia~MV~Maldives~ML~Mali~MT~Malta~MH~Marshall Islands~MQ~Martinique~MR~Mauritania~MU~Mauritius~YT~Mayotte~MX~Mexico~FM~Micronesia~MD~Moldova~MC~Monaco~MN~Mongolia~MS~Montserrat~MA~Morocco~MZ~Mozambique~MM~Myanmar~NA~Namibia~NR~Nauru~NP~Nepal~NL~Netherlands~AN~Netherlands Antilles~NC~New Caledonia~NZ~New Zealand~NI~Nicaragua~NE~Niger~NG~Nigeria~NU~Niue~NF~Norfolk Island~KP~North Korea~MP~Northern Mariana Islands~NO~Norway~OM~Oman~PK~Pakistan~PW~Palau~PS~Palestinian Authority~PA~Panama~PG~Papua New Guinea~PY~Paraguay~PE~Peru~PH~Philippines~PN~Pitcairn Islands~PL~Poland~PT~Portugal~PR~Puerto Rico~QA~Qatar~RE~Reunion~RO~Romania~RU~Russia~RW~Rwanda~WS~Samoa~SM~San Marino~ST~S? Tom?and Pr?cipe~SA~Saudi Arabia~SN~Senegal~YU~Serbia and Montenegro~SC~Seychelles~SL~Sierra Leone~SG~Singapore~SK~Slovakia~SI~Slovenia~SB~Solomon Islands~SO~Somalia~ZA~South Africa~GS~South Georgia and the South Sandwich Islands~ES~Spain~LK~Sri Lanka~SH~St. Helena~KN~St. Kitts and Nevis~LC~St. Lucia~PM~St. Pierre and Miquelon~VC~St. Vincent and the Grenadines~SD~Sudan~SR~Suriname~SJ~Svalbard and Jan Mayen~SZ~Swaziland~SE~Sweden~CH~Switzerland~SY~Syria~TW~Taiwan~TJ~Tajikistan~TZ~Tanzania~TH~Thailand~TP~Timor-Leste~TG~Togo~TK~Tokelau~TO~Tonga~TT~Trinidad and Tobago~TA~Tristan da Cunha~TN~Tunisia~TR~Turkey~TM~Turkmenistan~TC~Turks and Caicos Islands~TV~Tuvalu~UG~Uganda~UA~Ukraine~AE~United Arab Emirates~UK~United Kingdom~US~United States~UM~United States Minor Outlying Islands~UY~Uruguay~UZ~Uzbekistan~VU~Vanuatu~VA~Vatican City~VE~Venezuela~VN~Vietnam~VI~Virgin Islands~VG~Virgin Islands, British~WF~Wallis and Futuna~YE~Yemen~ZM~Zambia~ZW~Zimbabwe","${vo.favornation}");
									 </script>
     							</select>
     							<select id="favorstate" name="favorstate">
									<option value='' >지역선택</option>
									<option value='${vo.favorstate}' selected>${vo.favorstate}</option>
								</select>
							</li>
							<li>이름</li>
							<li><input type="text" name="username" value="${vo.username}"></li>
							<li>연락처</li>
							<li>
								<select class="inputStyletel1" name='telArray' id='tel1'>
									<option value="010" <c:if test="${vo.tel1=='010'}">selected</c:if>>010</option>
									<option value="011" <c:if test="${vo.tel1=='011'}">selected</c:if>>011</option>
									<option value="016" <c:if test="${vo.tel1=='016'}">selected</c:if>>016</option>
									<option value="017" <c:if test="${vo.tel1=='017'}">selected</c:if>>017</option>
									<option value="018" <c:if test="${vo.tel1=='018'}">selected</c:if>>018</option>
									<option value="019" <c:if test="${vo.tel1=='019'}">selected</c:if>>019</option>
								</select>
								  &nbsp; - &nbsp;<input class="inputStyletel2" type="text" name="telArray" id="tel2" value='${vo.tel2}'/>
								  &nbsp; - &nbsp;<input class="inputStyletel2" type="text" name="telArray" id="tel3" value='${vo.tel3}'/>
							 </li>
							 <li><input type="submit" value="수정하기"></li>
							</ul>
					</form>
				</div>
			</div>
		</div>

		
		<div>
			<h3>예약현황</h3>
			<div id="memberReserv">
			</div>
		</div>

		<div>
			<h3>내리뷰보기</h3>
			<div id="memberReview">
			</div>
		</div>
		
		<div>
			<h3>즐겨찾기</h3>
			<div id="memberFavor">
			</div>
		</div>
	</div>
</div>
