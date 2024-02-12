package com.web.orbitERP.util;



import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

// 컨테이너에서 사용할 수행 시간 측정 프로파일러 advice
@Aspect		// advice로 해당 포인트 컷으로 실행 시점을 정의해서 처리할 수 있게 처리..
@Component	// 객체가 container에 등록
public class Profiler {
	@Around("execution(* com.web.orbitERP.dao..*.*(..))")
	public Object trace(ProceedingJoinPoint jointPoint) {
		Object obj = null;
		// 1. 수행 정보 출력
		String signatureStr = jointPoint.getSignature().toShortString();
		System.out.println(signatureStr + "시작!");
		//	1) 처리하는 수행의 부하를 파악하는 시작/마지막 시간 check
		long start =System.currentTimeMillis();
		
		try {
			obj = jointPoint.proceed();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("수행시 예외 발생:"+e.getMessage());
		}finally {
			long end = System.currentTimeMillis();
			System.out.println(signatureStr+"종료");
			System.out.println("수행 시간:"+(end-start)+"밀리 세컨드(millis)");
		}
		return obj;
	}
	
}
