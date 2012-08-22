<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
	
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="web-common/bootstrap/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
<link href="web-common/bootstrap/css/bootstrap-responsive.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
.frame-container{
	border: 1px solid #DDD;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .075);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.075);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .075);
}	
iframe{
	border:none;
	width:100%;
	height:100%;
}
</style>
	
</head>
<body>



<div class="container">
	
	<div class="row">
		<div class="span10">
			<h2>Spring MVC, JMS, Active MQ &amp; CometD</h2>
		</div>
	</div>
	
	
	<div class="row">
		
		<div class="span6">
			<div class="frame-container">
				<iframe src="http://localhost:8080/jms-producer"></iframe>
			</div>
		</div>
		
		<div class="span6 ">
			<div class="frame-container">
				<iframe src="http://localhost:8080/jms-subscriber"/></iframe>
			</div>
		</div>
		
	</div>
	
</div>


<script type="text/javascript" src="web-common/js/jquery.js"></script>
	
<script type="text/javascript">


    $(document).ready(function() {
		console.warn('here...');
    });	
	
</script>

</body>
</html>
