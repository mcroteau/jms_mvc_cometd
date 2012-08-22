<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/json2.js"></script>
    <script type="text/javascript" src="js/cometd.js"></script>
    <script type="text/javascript" src="js/jquery.cometd.js"></script>
    
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
		.content{
			width:400px;
			margin:10px auto;
			padding:15px;
		}
	</style>
	
</head>
<body>

    <div class="content">
	
		<button class="btn">Say Hello</button>
	
	</div>



<script type="text/javascript">

   var cometd = $.cometd;

    $(document).ready(function() {

		function _connectionEstablished() {
			
			var subscription2 = cometd.subscribe('/hello', function(){
				console.warn('server responded hello');
			});
			console.warn('publishing message');
			cometd.publish('/service/hello',  { mydata: { foo: 'bar' } })
			
            $('.content').append('<div>CometD Connection Established</div>');
        }

        function _connectionBroken() {
            $('.content').append('<div>CometD Connection Broken</div>');
        }

        function _connectionClosed() {
            $('.content').append('<div>CometD Connection Closed</div>');
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
                        $('#body').append('<div>Server Says: ' + message.data.greeting + '</div>');
                    });
                    // Publish on a service channel since the message is for the server only
                    cometd.publish('/service/hello', { name: 'World' });
                });
            }
        }


        // Disconnect when the page unloads
        $(window).unload(function() {
            cometd.disconnect(true);
        });

        var cometURL = location.protocol + "//" + location.host + config.contextPath + "/cometd";
        cometd.configure({
            url: cometURL,
            logLevel: 'warn'
        });



		function helloSaid(){
			console.warn('hello said');
		}
		
		function sayHello(){
			cometd.publish('/service/hello',  { mydata: { foo: 'bar' } })
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
