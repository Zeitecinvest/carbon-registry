<%@page import="com.sudan.model.ghg.waste.GHGInputWasteWater"%>
<%@page import="com.sudan.model.ghg.*"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>GHG Inventory</title>
	<!-- Global stylesheets -->
	<link rel="shortcut icon" href="global_assets/images/ssudan.png">
<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
<link href="global_assets/css/icons/icomoon/styles.min.css" rel="stylesheet" type="text/css">
<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="assets/css/bootstrap_limitless.min.css" rel="stylesheet" type="text/css">
<link href="assets/css/layout.min.css" rel="stylesheet" type="text/css">
<link href="assets/css/components.min.css" rel="stylesheet" type="text/css">
<link href="assets/css/colors.min.css" rel="stylesheet" type="text/css">
<!-- /global stylesheets -->

<!-- Core JS files -->
<script src="global_assets/js/main/jquery.min.js"></script>
<script src="global_assets/js/main/bootstrap.bundle.min.js"></script>
<script src="global_assets/js/plugins/loaders/blockui.min.js"></script>
<!-- /core JS files -->

<!-- Theme JS files -->
<script src="global_assets/js/plugins/forms/selects/select2.min.js"></script>
<script src="global_assets/js/plugins/forms/styling/uniform.min.js"></script>
<script src="global_assets/js/plugins/extensions/jquery_ui/interactions.min.js"></script>

<script src="assets/js/app.js"></script>

<script src="global_assets/js/demo_pages/form_select2.js"></script>
<script src="global_assets/js/demo_pages/form_layouts.js"></script>
<!-- /theme JS files -->

</head>
<jsp:include page="Menu.jsp" />
<jsp:include page="common.jsp" />
<%
String selectedYear = (String)request.getAttribute("selectedYear");

if(request.getAttribute("ghgMapping") !=null){
	session.setAttribute("ghgMapping", request.getAttribute("ghgMapping"));
}

if(request.getAttribute("years") !=null){
	session.setAttribute("years", request.getAttribute("years"));
}

List<GHGInputWasteWater> existingGHGInputWasteWater = null;

if(request.getAttribute("ghgInputWasteWater")!=null){
	existingGHGInputWasteWater = (List<GHGInputWasteWater>)request.getAttribute("ghgInputWasteWater");
	
}


String fromApprovalDashboard = request.getParameter("fromApprovalDashboard"); 
%>

<body>
	<!-- Page content -->

	<!-- Main content -->
<div class="content-wrapper">
	
	<!-- Content area -->
<div class="content">

	<!-- 2 columns form -->
<div class="card border-pink">
	<div class="card-header bg-pink-600">
		<h5 class="card-title text-uppercase text-center">GHG Inventory - Wastewater Treatment and Discharge</h5>
	</div>

	<div class="card-body">
	<form action="saveGHGInputWasteWater" method="post" onsubmit="return setValues();" class="form-horizontal bordered-row" id="ghgInputForm" data-parsley-validate="">
                    <input type="hidden" name = "fourEyesStatus" id = "fourEyesStatus" value="">
                   <input type="hidden" name = "ghgInput.dataId" id = "dataId" value="">
                    
<div class="card-body font-size-lg">
    <div class="form-group row">
    <label class="col-lg-2 col-form-label text-right">Inventory Year</label>
    <div class="col-lg-4">
  	<select name="ghgInput.year" required onchange="getData();" data-placeholder="--Select--" class="form-control select" id="yearId"  data-fouc>
  	<c:if test = "${selectedYear eq null }">
   <option></option>
   </c:if>
   							<option value="${selectedYear}">${selectedYear}</option>
   							<c:forEach var="listValue" items="${years}">
							<c:if test = "${listValue ne selectedYear }">
							<option value="${listValue}">${listValue}</option>
							</c:if>
							</c:forEach>
    </select>
    </div>
    <label class="col-lg-2 col-form-label text-right">Sector</label>
   <div class="col-lg-4">
     <select name="ghgInput.sector" id="sector" class="form-control select">
     <option value="${ghgMapping.sector}">${ghgMapping.sector}</option>
     </select>
   </div>
   </div>
   <div class="form-group row">
   <label class="col-lg-2 col-form-label text-right">Category</label>
   <div class="col-lg-4">
   <select name="ghgInput.category" id="category" class="form-control select">
    <option value="${ghgMapping.category}">${ghgMapping.category}</option>
     </select>
   </div>
   <label class="col-lg-2 col-form-label text-right">Sub Sector</label>
   <div class="col-lg-4">
   <select name="ghgInput.subSector" id="subSector" class="form-control select">
   <option value="${ghgMapping.subSector}">${ghgMapping.subSector}</option>
     </select>
   </div>
  </div>
  <div class="form-group row">
   <label class="col-lg-2 col-form-label text-right">Calculation Approach</label>
   <div class="col-lg-4">
   <select name="ghgInput.calcApproach" required data-placeholder="--Select--" class="form-control select" id="calcApproach">
      <option></option>
	  <option value="Tier I">Tier I</option>
	  <option value="Tier II">Tier II</option>
	</select>  
   </div>
  </div>
  <hr>            
                

<div class="form-group">
<div class="tab-container">
<ul class="nav nav-tabs justify-content-center nav-fill "  role="tablist">
    <li class="nav-item">
        <a class="nav-link active" data-toggle="tab" href="#domestic" role="tab">Domestic Waste Water</a>
</li>
<li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#industrial" role="tab">Industrial Waste Water</a>
</li>
</ul>
<div class="tab-content">
      <div class="tab-pane active fade show" id="domestic" role="tabpanel">
      				<div class="card">
                    <div class="card-body">
      <h6 class="card-title">Wastewater Treatment and Discharge - CH<sub>4</sub> Emissions</h6>
					<div class="table-responsive">
						<table id="co2Table" class="table table-bordered table-striped">
                            <thead>
                            <tr class="bg-pink-600 text-center">
                                <th>Population</th>
                                <th>Degradable Organic Component (kgBOD/capita/year)</th>
                                <th>Correction Factor for Industrial BOD Discharged in Sewers</th>
                                <th>Methane Producing Capacity (kgCH<sub>4</sub>/kgBOD)</th>
                                <th>Reference</th>
                                </tr>
                            </thead>
                            <tbody>
                            <tr>
                            	<td>${ghgPopulation.getTotalPopulation()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getBod()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getCorrectionFactor()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getMethaneCapacity()}</td>
                                <td contenteditable='true'>${ghgInputWasteWater[0].getReferencech4()}</td>    
								    
                            </tr>
                            </tbody>
                           </table> 
						</div><br>
					 <h6 class="card-title">Wastewater Treatment and Discharge - N<sub>2</sub>O Emissions</h6>
					<div class="table-responsive">
						<table id="n2oTable" class="table table-bordered table-striped">
                            <thead>
                            <tr class="bg-pink-600 text-center">
                                <th>Population</th>
                                <th>Per capita Protein Consumption (kg/person/year)</th>
                                <th>Nitrogen Fraction in Protein</th>
                                <th>Emission factor (kgN<sub>2</sub>O-N/kgN)</th>
                                <th>Reference</th>
                                </tr>
                            </thead>
                            <tbody>
                            <tr>
                            
                            	<td>${ghgPopulation.getTotalPopulation()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getProteinConsumption()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getNitrogenFraction()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getEmissionFactor()}</td>
                                <td contenteditable='true'>${ghgInputWasteWater[0].getReferencen2o()}</td>
								    
                            </tr>
                            </tbody>
                           </table> 
						</div>
						<br>                       
                        		
						</div></div></div>
						
						<div class="tab-pane fade" id="industrial" role="tabpanel">
      				<div class="card">
                    <div class="card-body">
      				<h6 class="card-title">Industrial Wastewater Treatment and Discharge</h6>
					<div class="table-responsive">
						<table id="industrialTable" class="table table-bordered table-striped">
                            <thead>
                            <tr class="bg-pink-600 text-center">
                                <th>Industry Sector</th>
                                <th>Treatment Type</th>
                                <th>Production (tonnes/year)</th>
                                <th>Waste Water Generated (m<sup>3</sup>/tonne)</th>
                                <th>COD (kgCOD/m<sup>3</sup>)</th>
                                <th>Maximum Methane Producing Capacity (kgCH<sub>4</sub>/kgCOD)</th>
                                <th>Methane Correction Factor (fraction)</th>
                                <th>Sludge Removed (kgCOD/year)</th>
                                <th>Methane Recovered (kgCH<sub>4</sub>/year)</th>
                                <th>Reference</th>
                                </tr>
                            </thead>
                            <tbody>
                            <tr>
                            	<td contenteditable='true'>${ghgInputWasteWater[0].getIndustrialSector()}</td>
                            	<td contenteditable='true'>${ghgInputWasteWater[0].getTreatmentType()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getProduction()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getWasteWater()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getCod()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getIndustrialMethaneCapacity()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getIndustrialCorrectionFactor()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getSludge()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${ghgInputWasteWater[0].getMethaneRemoved()}</td>
                                <td contenteditable='true'>${ghgInputWasteWater[0].getReferenceIndustrial()}</td>    
								    
                            </tr>
                            </tbody>
                           </table> 
						</div><br>
					    		
						</div></div></div>
						</div>
						
						
						</div></div>
				
	     <div class="form-group">
                <span class="col-sm-3 control-label">Remarks</span>
<div class="col-sm-12">
<textarea class="form-control" id="remarks" name="remarks">${ghgInputWasteWater[0].getRemarks()}</textarea>
     </div>
</div>

<div id = "commentButton" style="display: none">
<div class="form-group">
<span class="col-sm-3 control-label">Approver Comments</span>
<div class="col-sm-12">
<textarea class="form-control" id="approverRemarks" name="approverRemarks"> </textarea>
</div>
</div>
</div>



<div class="bg-default content-box text-center pad20A mrg25T">
    <button  id = "submitButton"  class="btn bg-pink-600">Save/Submit</button>
</div>

<div class="row">
<div class="col-md-3">
</div>
          
<div class="col-md-5">
<div class="form-group ">
<b><span class="col-sm-6 control-label" style="float:left"></span></b>
<div class="col-sm-6">
<div id = "approvalButton" style="display: none">
<button id = "Approved" onclick="setStatus(this.id);" class="btn bg-pink-600">Approve</button>
</div>
</div>
</div>
</div>
 

<div class="col-md-4">
<div class="form-group">
<div class="col-sm-6">
<div id = "rejectionButton" style="display: none">
<button id = "Rejected" onclick="setStatus(this.id);"  class="btn bg-pink-600">Reject</button>
</div> 
</div>
</div>
</div></div></div></form></div></div></div></div></body>

<script>

function setValues(){
    var table = document.getElementById('co2Table');
    var rowLength = table.rows.length;
   
     var cells = table.rows.item(1).cells;
     var cellLength = cells.length;
     
     var x = 0;
     for(var j = 0; j < cellLength; j++){
         var cell = cells.item(j);
         var cellVal = cell.innerHTML;
         var name ;
       
         if(j==0){
       	   name = "ghgInputWasteWaterList["+x+"].totalPopulation";
         }
        
         if(j==1){
      	   name = "ghgInputWasteWaterList["+x+"].bod";
    	   
         }
         if(j==2){
      	   name = "ghgInputWasteWaterList["+x+"].correctionFactor";
    	   
         }
         if(j==3){
       	   name = "ghgInputWasteWaterList["+x+"].methaneCapacity";
   	   	 }
         if(j==4){
       	   name = "ghgInputWasteWaterList["+x+"].referencech4";
         }
         createHiddenField(name,cellVal); 
        
      }
     return setN2oValues();
}

function setN2oValues(){
    var table = document.getElementById('n2oTable');
    var rowLength = table.rows.length;
   
     var cells = table.rows.item(1).cells;
     var cellLength = cells.length;
     
     var x = 0;
     for(var j = 0; j < cellLength; j++){
         var cell = cells.item(j);
         var cellVal = cell.innerHTML;
         var name ;
       
         if(j==1){
        	name = "ghgInputWasteWaterList["+x+"].proteinConsumption";
   	   }
         if(j==2){
           name = "ghgInputWasteWaterList["+x+"].nitrogenFraction";
    	}
         if(j==3){
      	   name = "ghgInputWasteWaterList["+x+"].emissionFactor";
    	}
         if(j==4){
       	   name = "ghgInputWasteWaterList["+x+"].referencen2o";
         }
         createHiddenField(name,cellVal); 
        
      }
     return setIndustrialValues();
}

function setIndustrialValues(){
    var table = document.getElementById('industrialTable');
    var rowLength = table.rows.length;
   
     var cells = table.rows.item(1).cells;
     var cellLength = cells.length;
     
     var x = 0;
     for(var j = 0; j < cellLength; j++){
         var cell = cells.item(j);
         var cellVal = cell.innerHTML;
         var name ;
       
         if(j==0){
      	   name = "ghgInputWasteWaterList["+x+"].industrialSector";
   	   }
         if(j==1){
           name = "ghgInputWasteWaterList["+x+"].treatmentType";
    	}
         if(j==2){
      	   name = "ghgInputWasteWaterList["+x+"].production";
    	}
         if(j==3){
       	   name = "ghgInputWasteWaterList["+x+"].wasteWater";
         }
         if(j==4){
         	   name = "ghgInputWasteWaterList["+x+"].cod";
           }
         if(j==5){
       	   name = "ghgInputWasteWaterList["+x+"].IndustrialMethaneCapacity";
         }
         
         if(j==6){
       	   name = "ghgInputWasteWaterList["+x+"].IndustrialCorrectionFactor";
         }
         if(j==7){
         	   name = "ghgInputWasteWaterList["+x+"].sludge";
           }
         if(j==8){
         	   name = "ghgInputWasteWaterList["+x+"].methaneRemoved";
           }
         
         if(j==9){
       	   name = "ghgInputWasteWaterList["+x+"].referenceIndustrial";
         }
         createHiddenField(name,cellVal); 
        
      }
     return true;
}

function createHiddenField(name, value){
if(document.getElementsByName(name).length != 0) { //already exist
		
	}else{
	var input = document.createElement("input");
	input.setAttribute("type", "hidden");
	input.setAttribute("name", name);
	input.setAttribute("value", value); 
	document.getElementById("ghgInputForm").appendChild(input);
	}
}

function getData(){
	var sector = document.getElementById("sector").value;
	var subSector = document.getElementById("subSector").value;
	var category = document.getElementById("category").value;
	var subCategory = document.getElementById("subSector").value;
	var year = document.getElementById("yearId").value;
	
	var url = '/getGHGInputWasteWater?sector=' + sector + '&subSector='+subSector  + '&category='+category + '&subCategory='+subCategory + '&year='+year + '&status=ANY';
	window.location.href = url;

}
var fromApproval = "<%=fromApprovalDashboard%>";
handleButtonsGHG2(fromApproval);

function setStatus(id){
	document.getElementById('fourEyesStatus').value = id;
	<% if(existingGHGInputWasteWater!=null && !existingGHGInputWasteWater.isEmpty()) { %>
	document.getElementById('dataId').value = "<%=existingGHGInputWasteWater.get(0).getDataId()%>";
	<% } %>
}

<% if(existingGHGInputWasteWater!=null && !existingGHGInputWasteWater.isEmpty()) {
	%>
		document.getElementById('fourEyesStatus').value = 'Pending_Update';
		document.getElementById('calcApproach').value = "<%=existingGHGInputWasteWater.get(0).getCalcApproach()%>";
	<%
		} else {
	%>
		document.getElementById('fourEyesStatus').value = 'Pending_Insert';
	<%
		}
	%>
</script>                   
<script src="global_assets/input-mask.js"></script>
   <script src="global_assets/js/input-mask.js"></script>
</html>