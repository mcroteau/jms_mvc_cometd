<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="/web-common/bootstrap/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
<!-- <link href="/web-common/bootstrap/css/bootstrap-responsive.css" media="screen" rel="stylesheet" type="text/css" /> -->

<%--
	The reason to use a JSP is that it is very easy to obtain server-side configuration
	information (such as the contextPath) and pass it to the JavaScript environment on the client.
--%>

<script type="text/javascript">
	
    var config = {
        contextPath: '${pageContext.request.contextPath}'
    };

</script>

<style type="text/css">
.order{
}	
</style>
	
</head>
<body>

<div class="container">	

	<div class="row">
		<div class="span6">
			
			<h3>JMS Subscriber</h3>
			
			<p>JMS Messages are being received and pushed to the view via CometD</p>
		
		</div>
	</div>

	<div class="row">
		<div class="span4">
			
			<h4>Orders Received</h4>
			
			<div id="orders"></div>
			
		</div>

		<div class="span2">
			
			<div>
				<h4>Total <code>$ <span id="grandTotal">0</span></code></h4> 
					
			</div>
			
			<div id="log">
			</div>
		</div>

	</div>

</div>



<script type="text/javascript" src="/web-common/js/jquery.js"></script>
<script type="text/javascript" src="/web-common/js/json2.js"></script>
<script type="text/javascript" src="/web-common/js/cometd.js"></script>
<script type="text/javascript" src="/web-common/js/jquery.cometd.js"></script>
<script type="text/javascript" src="/web-common/js/mustache.js"></script>

<script type="text/mustache" id="orderTemplate">
<blockquote class="order">
	<small><strong>Order Total : </strong>{{total}}</small>
	<small><strong>customerId : </strong>{{customerId}}</small>
	<small><strong>guid : </strong>{{uuid}}</small><br/>
</blockquote>
</script>

<script type="text/javascript">

   var cometd = $.cometd;


    $(document).ready(function() {
		
		var grandTotal = 0;
		
		var $log = $('#log'),
			$orders = $('#orders'),
			$template = $('#orderTemplate').text(),
			$grandTotal = $('#grandTotal');

		function _connectionEstablished() {
            $log.append('<small>CometD Connection Established</small>');
        }

        function _connectionBroken() {
            $log.append('<small>CometD Connection Broken</small>');
        }

        function _connectionClosed() {
            $log.append('<small>CometD Connection Closed</small>');
        }

        // Function that manages the connection status with the Bayeux server
        var _connected = false;
        function _metaConnect(message) {

            if (cometd.isDisconnected()) {
                _connected = false;
                _connectionClosed();
                return;
            }

            var wasConnected = _connected;
            _connected = message.successful === true;
            if (!wasConnected && _connected) {
                _connectionEstablished();
            } else if (wasConnected && !_connected) {
                _connectionBroken();
            }

        }

        // Function invoked when first contacting the server and
        // when the server has lost the state of this client
        function _metaHandshake(handshake) {

            if (handshake.successful === true) {
                cometd.batch(function() {
                    cometd.subscribe('/hello', function(message) {
						console.log(arguments);
						if(message.data.message){
                    		$log.append('<small>' + message.data.message + '</small><br/>');
						}else{
							var orderData = JSON.parse(message.data.orderGson);
							var html = Mustache.to_html($template, orderData);
							console.log(orderData);
	                        $orders.append(html);
							
							grandTotal+= parseInt(orderData.total);
							$grandTotal.html(grandTotal);
						}
                    });
                    // sayHello();
                });
            }
        }


        // Disconnect when the page unloads
        $(window).unload(function() {
            cometd.disconnect(true);
        });

        var cometURL = location.protocol + "//" + location.host + config.contextPath + "/cometd";
        cometd.configure({
            url      : cometURL,
            logLevel : 'warn'
        });



		function helloSaid(){
			console.warn('hello said');
		}
		
		function sayHello(){
			// Publish on a service channel since the message is for the server only
            cometd.publish('/service/hello', { name: 'World' });
		}
		
		$('.btn').click(function(){
			console.log('say hello');
			sayHello();
		});
		
		
		
        cometd.addListener('/meta/handshake', _metaHandshake);
        cometd.addListener('/meta/connect', _metaConnect);

		
        cometd.handshake();

		
    });	
	
</script>

</body>
</html>
