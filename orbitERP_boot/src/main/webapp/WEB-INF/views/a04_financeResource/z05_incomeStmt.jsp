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
<div class="col-xl-12 col-lg-12" id="app">
	<div class="card shadow">
		<div class="card-header">
			<div class="form-row align-items-center">
				<div class="col-auto">
				    기준년도 : 
				    <select v-model="basicYear" class="form-control" id="basicYear" name="basicYear">
				        <option v-for="year in years" :key="year" :value="year">{{ year }}</option>
				    </select>
				</div>
				<div class="col-auto">
				    비교년도 :
				    <select v-model="compYear" class="form-control" id="compYear" name="compYear">
				        <option v-for="year in years" :key="year" :value="year">{{ year }}</option>
				    </select>
				</div>
			</div>
		</div>
		<div class="card-body" >
			<h2>손익계산서</h2>
		    <table id="isSheet">
		        <thead>
		            <tr>
		                <th>재무제표표시명</th>
		                <th>{{basicYear}}년 (기준)</th>
		                <th>{{compYear}}년 (비교)</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr>
		                <td>1. 매   출</td>
		                <td class="text-right">{{ totalSales().basic.toLocaleString() }}</td>
		                <td class="text-right">{{ totalSales().comp.toLocaleString() }}</td>
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
		                <td class="text-right">{{ totalCOGS().basic.toLocaleString() }}</td>
		                <td class="text-right">{{ totalCOGS().comp.toLocaleString() }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;상품매출원가 (5069)</td>
		                <td class="text-right">{{ getSum(5069).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(5069).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;강의매출원가 (6039)</td>
		                <td class="text-right">{{ getSum(6039).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(6039).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>3. 매 출 총 이 익</td>
		                <td class="text-right">{{ grossProfit().basic.toLocaleString() }}</td>
    					<td class="text-right">{{ grossProfit().comp.toLocaleString() }}</td>
		            </tr>
		            <tr>
		                <td>4. 판매비 및 일반관리비</td>
		                <td class="text-right">{{ totalSGA().basic.toLocaleString() }}</td>
    					<td class="text-right">{{ totalSGA().comp.toLocaleString() }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;직원급여 (8029)</td>
		                <td class="text-right">{{ getSum(8029).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8029).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;퇴직급여 (8089)</td>
		                <td class="text-right">{{ getSum(8089).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8089).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;복리후생비 (8109)</td>
		                <td class="text-right">{{ getSum(8109).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8109).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;여비교통비 (8119)</td>
		                <td class="text-right">{{ getSum(8119).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8119).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;보험료 (8269)</td>
		                <td class="text-right">{{ getSum(8269).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8269).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;차량유지비 (8279)</td>
		                <td class="text-right">{{ getSum(8279).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8279).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;도서인쇄비 (8329)</td>
		                <td class="text-right">{{ getSum(8329).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8329).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;광고선전비 (8338)</td>
		                <td class="text-right">{{ getSum(8338).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8338).compYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;사무용품비 (8299)</td>
		                <td class="text-right">{{ getSum(8299).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(8299).basicYearSum }}</td>
		            </tr>
		            <tr>
		                <td>5. 영 업 손 익</td>
		                <td class="text-right">{{ opIncome().basic.toLocaleString() }}</td>
    					<td class="text-right">{{ opIncome().comp.toLocaleString() }}</td>
		            </tr>
		            <tr>
		                <td>6. 영 업 외 수 익</td>
		                <td class="text-right">{{ getSum(9199).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(9199).basicYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;잡이익 (9199)</td>
		                <td class="text-right">{{ getSum(9199).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(9199).basicYearSum }}</td>
		            </tr>
		            <tr>
		                <td>7. 영 업 외 비 용</td>
		                <td class="text-right">{{ getSum(9549).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(9549).basicYearSum }}</td>
		            </tr>
		            <tr>
		                <td>&nbsp;&nbsp;잡손실 (9549)</td>
		                <td class="text-right">{{ getSum(9549).basicYearSum }}</td>
		                <td class="text-right">{{ getSum(9549).basicYearSum }}</td>
		            </tr>
		            <tr>
		                <td>8. 법인세비용차감전순손익</td>
		                <td class="text-right">{{ netIncome().basic.toLocaleString() }}</td>
    					<td class="text-right">{{ netIncome().comp.toLocaleString() }}</td>
		            </tr>
		            <tr>
		                <td>9. 당 기 순 이 익</td>
		                <td class="text-right">{{ netIncome().basic.toLocaleString() }}</td>
    					<td class="text-right">{{ netIncome().comp.toLocaleString() }}</td>
		            </tr>
		        </tbody>
		    </table>
		</div>
	</div>
</div>
<script type="text/javascript">
	var vm = Vue.createApp({
		name:"App",
	    data() {
	        return {
	            basicYear: new Date().getFullYear().toString(), // 기본값을 현재 년도로 설정
	            compYear: '2023',
	            incomeStatements: [],
	            years:[]
	        };
	    },
	    created() {
	        this.generateYears();
	    },
	    methods: {
	    	// 현재 날짜의 연도까지 option을 생성하는 함수
	    	generateYears() {
	            const currentYear = new Date().getFullYear();
	            for (let year = 2023; year <= currentYear; year++) {
	                this.years.push(year.toString());
	            }
	        },
	        fetchData() {
	        	const params = {
	        	        basicYear: this.basicYear,
	        	        compYear: this.compYear
	        	    };
	        	
	        	axios.post('${path}/incomeStatement', JSON.stringify(params), {
	                headers: {
	                    'Content-Type': 'application/json'
	                }
	            })
	            .then(response => {
	                this.incomeStatements = response.data;
	            })
	            .catch(error => console.error('Error:', error));
	        },
	        // 개별 계정 코드에 대한 합계를 구하는 메서드
	        getSum(accCode) {
	            const entry = this.incomeStatements.find(item => item.acc_code === accCode);
	            if (entry) {
	                return {
	                    basicYearSum: entry.basicYearSum.toLocaleString(),
	                    compYearSum: entry.compYearSum.toLocaleString()
	                };
	            } else {
	                return { basicYearSum: '0', compYearSum: '0' };
	            }
	        },
	        totalSales() {
	            // 매출 관련 계정 코드 예시: [4019, 4119]
	            return this.sum([4019, 4119]);
	        },
	        totalCOGS() {
	            // 매출원가 관련 계정 코드 예시: [5069, 6039]
	            return this.sum([5069, 6039]);
	        },
	        totalSGA() {
	            // 판매비 및 일반관리비 관련 계정 코드 예시
	            return this.sum([8029, 8089, 8109, 8119, 8269, 8279, 8329, 8338, 8299]);
	        },
	        sum(accCodes) {
	            return accCodes.reduce((acc, code) => {
	                const entry = this.incomeStatements.find(item => item.acc_code === code);
	                if (entry) {
	                    acc.basic += parseInt(entry.basicYearSum, 10);
	                    acc.comp += parseInt(entry.compYearSum, 10);
	                }
	                return acc;
	            }, {basic: 0, comp: 0});
	        },
	        grossProfit() {
	            const sales = this.sum([4019, 4119]);
	            const cogs = this.sum([5069, 6039]);
	            return { basic: sales.basic + cogs.basic, comp: sales.comp + cogs.comp };
	        },
	        opIncome() {
	            const gross = this.grossProfit();
	            const expenses = this.sum([8029, 8089, 8109, 8119, 8269, 8279, 8329, 8338, 8299]);
	            return { basic: gross.basic + expenses.basic, comp: gross.comp + expenses.comp };
	        },
	        netIncome() {
	            const opInc = this.opIncome();
	         	// 영업외 수익 및 영업외 비용을 정수로 변환하여 더하기
	            const otherIncomeBasic = parseInt(this.getSum(9199).basicYearSum.replace(/,/g, ''), 10);
	            const otherIncomeComp = parseInt(this.getSum(9199).compYearSum.replace(/,/g, ''), 10);
	            const otherExpensesBasic = parseInt(this.getSum(9549).basicYearSum.replace(/,/g, ''), 10);
	            const otherExpensesComp = parseInt(this.getSum(9549).compYearSum.replace(/,/g, ''), 10);
	            return {
	            	basic: opInc.basic + otherIncomeBasic + otherExpensesBasic,
	                comp: opInc.comp + otherIncomeComp + otherExpensesComp
	            };
	        }
	    },
	    watch: {
	        basicYear() {
	            this.fetchData();
	        },
	        compYear() {
	            this.fetchData();
	        }
	    },
	    mounted() {
	        this.fetchData();
	    }
	}).mount('#app');
</script>