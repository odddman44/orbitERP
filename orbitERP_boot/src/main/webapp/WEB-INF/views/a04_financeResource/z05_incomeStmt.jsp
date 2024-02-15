<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script src="https://unpkg.com/vue"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
    #isSheet {
        width: 100%;
        border-collapse: collapse;
    }
    #isSheet th, #isSheet td {
        border: 1px solid black;
        padding: 8px;
        text-align: left;
    }
    #isSheet th {
        background-color: #f2f2f2;
    }
    #isSheet .text-right {
        text-align: right;
    }
</style>
<div class="col-xl-12 col-lg-12">
	<div class="card shadow">
		<div class="card-header">
			<form id="frm03" class="form">
				<div class="form-row align-items-center">
					<div class="col-auto">
						기준년도 : <input type="text" class="form-control" id="basicYear" name="basicYear" v-model="basicYear"/>
					</div>
					<div class="col-auto">
						비교년도 :<input type="text" class="form-control" id="compYear" name="compYear" v-model="compYear"/>
					</div>
					<div class="col-auto">
						<button type="submit" id="schBtn" class="btn btn-secondary">조회</button>
					</div>
				</div>
			</form>
		</div>
		<div class="card-body" id="app">
			<h2>손익계산서</h2>
		    <table id="isSheet">
		        <thead>
		            <tr>
		                <th>재무제표표시명</th>
		                <th>2024년 (기준)</th>
		                <th>2023년 (비교)</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr>
		                <td>1. 매   출</td>
		                <td class="text-right"></td>
		                <td class="text-right"></td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;상품매출 (4019)</td>
		                <td class="text-right">{{ getSum(4019).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(4019).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;용역매출 (4119)</td>
		                <td class="text-right">{{ getSum(4119).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(4119).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>2. 매 출 원 가</td>
		                <td class="text-right"></td>
		                <td class="text-right"></td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;상품매출원가 (1469)</td>
		                <td class="text-right">44,500,000</td>
		                <td class="text-right">277,282,000</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;강의매출원가 (6039)</td>
		                <td class="text-right">29,300,000</td>
		                <td class="text-right">115,710,000</td>
		            </tr>
		            <tr>
		                <td>3. 매 출 총 이 익</td>
		                <td class="text-right">190,440,000</td>
		                <td class="text-right">556,785,000</td>
		            </tr>
		            <tr>
		                <td>4. 판매비 및 일반관리비</td>
		                <td class="text-right">69,066,000</td>
		                <td class="text-right">69,186,500</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;직원급여 (8029)</td>
		                <td class="text-right">120,000</td>
		                <td class="text-right"></td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;퇴직급여 (5099)</td>
		                <td class="text-right">48,000,000</td>
		                <td class="text-right">48,000,000</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;복리후생비 (8109)</td>
		                <td class="text-right">5,296,000</td>
		                <td class="text-right">5,306,500</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;여비교통비 (8119)</td>
		                <td class="text-right">50,000</td>
		                <td class="text-right"></td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;보험료 (8269)</td>
		                <td class="text-right">1,200,000</td>
		                <td class="text-right">1,200,000</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;차량유지비 (8279)</td>
		                <td class="text-right"></td>
		                <td class="text-right">280,000</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;도서인쇄비 (8329)</td>
		                <td class="text-right">4,000,000</td>
		                <td class="text-right">4,000,000</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;광고선전비 (8338)</td>
		                <td class="text-right">8,000,000</td>
		                <td class="text-right">8,000,000</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;견본비 (8429)</td>
		                <td class="text-right">400,000</td>
		                <td class="text-right">400,000</td>
		            </tr>
		            <tr>
		                <td>5. 영 업 손 익</td>
		                <td class="text-right">121,374,000</td>
		                <td class="text-right">487,598,500</td>
		            </tr>
		            <tr>
		                <td>6. 영 업 외 수 익</td>
		                <td class="text-right"></td>
		                <td class="text-right"></td>
		            </tr>
		            <tr>
		                <td>7. 영 업 외 비 용</td>
		                <td class="text-right">280,000</td>
		                <td class="text-right">280,000</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;잡손실 (9549)</td>
		                <td class="text-right">2,000,000</td>
		                <td class="text-right">2,000,000</td>
		            </tr>
		            <tr>
		                <td>8. 법인세비용차감전순손익</td>
		                <td class="text-right">121,094,000</td>
		                <td class="text-right">487,318,500</td>
		            </tr>
		            <tr>
		                <td>9. 당 기 순 이 익</td>
		                <td class="text-right">121,094,000</td>
		                <td class="text-right">487,318,500</td>
		            </tr>
		        </tbody>
		    </table>
		</div>
	</div>
</div>
<script type="text/javascript">
	const { createApp } = Vue;
	createApp({
	    data() {
	        return {
	            basicYear: '2024',
	            compYear: '2023',
	            incomeStatements: []
	        };
	    },
	    created() {
	        this.fetchData();
	    },
	    methods: {
	        fetchData() {
	        	const url = '${path}/incomeStatement?basicYear='+this.basicYear+'&compYear='+this.compYear;
	        	fetch(url)
	                .then(response => response.json())
	                .then(data => {
	                    this.incomeStatements = data;
	                })
	                .catch(error => console.error('Error:', error));
	        },
	        getSum(accCode) {
	        	const entry = this.incomeStatements.find(item => item.acc_code === accCode);
	            if (entry) {
	                return {
	                    basicYearSum: entry.basicYearSum.toLocaleString(),
	                    compYearSum: entry.compYearSum.toLocaleString()
	                };
	            } else {
	                return { basicYearSum: 0, compYearSum: 0 };
	            }
	        }
	    }
	}).mount('#app');
</script>