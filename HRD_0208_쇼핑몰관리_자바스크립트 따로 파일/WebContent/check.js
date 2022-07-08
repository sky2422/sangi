//유효성 검사 - 비어있는지
function check(){ //function=함수=메서드
	/*** [방법-1] type="submit"이든 "button"이든 관계없이 실행됨 ***/	
	//if(f.memno.value == ''){//if(!f.memno.value){
	if(f.memno.value == ""){ //javascript "" '' 둘다 문자열 취급함
		alert("회원번호를 입력해주세요.");//알림창			
		return f.memno.focus();
	}
	if(f.name.value == ""){ 
		alert("회원이름을 입력해주세요.");			
		return f.name.focus();
	}
	if(f.address.value == ""){ 
		alert("주소를 입력해주세요.");			
		return f.address.focus();
	}
	if(f.hiredate.value == ""){
		alert("가입일을 입력해주세요.");			
		return f.hiredate.focus();
	}
	//★주의 : radio, checkbox
	if(f.gender[0].checked == false && f.gender[1].checked == false){ 
		alert("성별을 선택해주세요.");			
		//return false;//★주의
		return;
	}
	if(f.tel1.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		return f.tel1.focus();
	}
	if(f.tel2.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		return f.tel2.focus();
	}
	if(f.tel3.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		return f.tel3.focus();
	}
	
	f.submit();
	
	
	/**** [방법-2] type="submit"인 경우 ******/
	/*
	if(f.memno.value == ""){ //javascript "" '' 둘다 문자열 취급함
		alert("회원번호를 입력해주세요.");//알림창			
		//return f.memno.focus();
		f.memno.focus();
		return false;//return값을 false로 주면 데이터 전송이 안됨
	}
	else if(f.name.value == ""){ 
		alert("회원이름을 입력해주세요.");			
		//return f.name.focus();
		f.name.focus();
		return false;
	}
	else if(f.address.value == ""){ 
		alert("주소를 입력해주세요.");			
		//return f.address.focus();
		f.address.focus();
		return false;
	}
	else if(f.hiredate.value == ""){
		alert("가입일을 입력해주세요.");			
		//return f.hiredate.focus();
		f.hiredate.focus();
		return false;
	}
	//★주의 : radio, checkbox
	else if(f.gender[0].checked == false && f.gender[1].checked == false){ 
		alert("성별을 선택해주세요.");
		//return;
		return false;//★주의			
	}
	else if(f.tel1.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		//return f.tel1.focus();
		f.tel1.focus();
		return false;
	}
	else if(f.tel2.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		//return f.tel2.focus();
		f.tel2.focus();
		return false;
	}
	else if(f.tel3.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		//return f.tel3.focus();
		f.tel3.focus();
		return false;
	}
	else{		
		//f.submit(); //생략 가능
		return true;//type="submit" 또는 "reset"인 경우 : true값을 리턴하면 데이터 전송됨(=submit됨)
		//즉, return값을 false로 주면 데이터 전송이 안되고 true를 줘야 전송됨
	}
	*/
	
	/**** [방법-3] type="button"인 경우 ******/
	/*
	if(f.memno.value == ""){ //javascript "" '' 둘다 문자열 취급함
		alert("회원번호를 입력해주세요.");//알림창			
		return f.memno.focus();
		//f.memno.focus();
		//return false;
	}
	else if(f.name.value == ""){ 
		alert("회원이름을 입력해주세요.");			
		return f.name.focus();
		//f.name.focus();
		//return false;
	}
	else if(f.address.value == ""){ 
		alert("주소를 입력해주세요.");			
		return f.address.focus();
		//f.address.focus();
		//return false;
	}
	else if(f.hiredate.value == ""){
		alert("가입일을 입력해주세요.");			
		return f.hiredate.focus();
		//f.hiredate.focus();
		//return false;
	}
	//★주의 : radio, checkbox
	else if(f.gender[0].checked == false && f.gender[1].checked == false){ 
		alert("성별을 선택해주세요.");			
		//return false;//★주의
		return;
	}
	else if(f.tel1.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		return f.tel1.focus();
		//f.tel1.focus();
		//return false;
	}
	else if(f.tel2.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		return f.tel2.focus();
		//f.tel2.focus();
		//return false;
	}
	else if(f.tel3.value == ""){ 
		alert("전화번호를 입력해주세요.");			
		return f.tel3.focus();
		//f.tel3.focus();
		//return false;
	}
	else{		
		f.submit(); //반드시 존재 : submit()으로 데이터 전송
		//return true;//type="submit" 또는 "reset"인 경우 : true값을 리턴하면 데이터 전송됨(=submit됨)
	}
	*/
}