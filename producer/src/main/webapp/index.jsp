<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
	
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="/web-common/bootstrap/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
<!-- <link href="/web-common/bootstrap/css/bootstrap-responsive.css" media="screen" rel="stylesheet" type="text/css" /> -->

	
</head>
<body>

<div class="container">	
	
	<div class="row">
		<div class="span6">
			<h3 style="margin-bottom:5px;">JMS Producer/Publisher</h3>
			
			<div class="messageContainer" style="height:40px; position:relative;">
				<div class="alert alert-error" id="error" style="display:none; position:absolute; width:100%">
				  <strong>Error </strong> Customer Id &amp; Order Total need numeric values
				</div>
				
				<div class="alert alert-error" id="failed" style="display:none; position:absolute; width:100%">
				  <strong>Failed </strong> Something went wrong processing order
				</div>
							
				<div class="alert alert-success" id="success" style="display:none; position:absolute; width:100%">
				  <strong>Success </strong> Successfully placed order.
				</div>
				
				<div class="alert alert-info" id="loading" style="display:none; position:absolute; width:100%">
				  <strong>Processing </strong> placing order.. 
				</div>
				
			</div>
			
			
		</div>
	</div>
	
	<div class="row">
		
		<div class="span4">
			
			<h4>Orders Placed</h4>
			
			<div id="orders"></div>
			
		</div>
		
		<div class="span2">
			
			<div>
				<h4>Total <code>$ <span id="grandTotal">0</span></code></h4> 
			</div>
			
			<div class="well" style="padding-top:0px; padding-bottom:0px;">
				<h5>Mock Order</h5>
				<form >
					<label class="control-label">Customer Id</label>
				    <div class="controls">
						<input type="text" class="input-mini" name="customerId" id="customerId" size="10" placeholder=""/>
					</div>
					<label class="control-label">Order Total</label>
					<div class="controls">
						<div class="input-prepend input-append">
						  	<span class="add-on">$</span>
							<input class="input-mini" id="total" size="10"  type="text" placeholder="00">
							<!--<span class="add-on">.00</span>-->
						</div>
					</div>
					<br/>
					<div class="control-group">
						<div class="controls">
							<button class="btn btn-small publish">Place Order (Topic)</button><br/><br/>
							<button class="btn btn-small produce">Place Order (Queue)</button>
						</div>
					</div>  
				</form>
			</div>
		</div>
		
		<!--
		<div class="span3">
			<p class="lead">Orders Migrated</p>
			<div class="well" id="placedOrders">
			</div>
		</div>
		-->
		
	</div>
	
</div>


<script type="text/javascript" src="/web-common/js/jquery.js"></script>
<script type="text/javascript" src="/web-common/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="/web-common/js/util.js"></script>
<script type="text/javascript" src="/web-common/js/mustache.js"></script>

<script type="text/mustache" id="orderTemplate">
<blockquote class="order">
	<small><strong>Order Total : </strong>{{total}}</small>
	<small><strong>customerId : </strong>{{customerId}}</small>
	<small><strong>guid : </strong>{{uuid}}</small><br/>
</blockquote>
</script>

	
<script type="text/javascript">

    $(document).ready(function() {
	
		var grandTotal = 0;
		
		var $button       = $('.btn'),
			$total        = $('#total'),
			$customerId   = $('#customerId'),
			$loading      = $('#loading'),
			$error        = $('#error'),
			$failed       = $('#failed'),
			$success      = $('#success'),
			$orders       = $('#orders'),
			$template     = $('#orderTemplate').text()
			$grandTotal   = $('#grandTotal');
			
			
		$button.click(checkPlaceOrder);
		
		
		function checkPlaceOrder(event){
			event.preventDefault();
			
			var action = $(event.target).hasClass('produce') ? 'produce' : 'publish';
			
			if($total.val() != "" && 
				$customerId.val() != "" && 
				isNumeric($total.val()) && 
				isNumeric($customerId.val())){
					
				placeOrder(action, {	
					uuid       : util.guid(),
					total      : $total.val(),
					customerId : $customerId.val()
				});
				
			}else{
				console.warn('no order data');
				$error.show();
				setTimeout(function(){
					$error.fadeOut(200);
				}, 2000);
			}
		}
		
		var placeOrder = function(action, order){
			$loading.fadeIn(100);
			console.log(JSON.stringify(order))
			$.ajax({
				type        : 'post',
				url         : 'app/' + action,
				data        : JSON.stringify(order),
				dataType    : "text",
				contentType : "application/json", 
				success     : success(order),
				error       : error
			});
			
		}
		
		function error(){
			console.warn('failed');
			$loading.fadeOut(100);
			$failed.show();
			setTimeout(function(){
				$failed.fadeOut(200);
			}, 2000);
		}
		
		
		function success(order){
			return function(){
				console.info('success');
				$loading.fadeOut(100);
				$success.show();
				$customerId.val("");
				$total.val("");
				
				var html = Mustache.to_html($template, order)
				$orders.append(html);
				
				
				grandTotal+= parseInt(order.total);
				$grandTotal.html(grandTotal);
				
				setTimeout(function(){
					$success.fadeOut(200);
				}, 2000);				
			}
		}
		
		
		function isNumeric(data){
		    return parseFloat(data)==data;
		}
		
    });	
	
</script>

</body>
</html>
