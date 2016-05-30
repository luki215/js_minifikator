$(function(){

	$(window).on('load', function(){ 
		var a = 5, b = 3, x=function(aa, aaa, aaaa){ return aaa; }, c  = 4;
		var d = 8;
		
		var ahoj = { mami: "mami" };
		
		var superPromennaKterouNechciPrejmenovat = 3,
			superPromennaKterouNechciPrejmenovat2 = 4;

		var fib = function(c){
			{

			if( c == 1)
				return 1;
			if ( c == 2)
				return 1;
			else 
				return (fib(c-1) + fib(c-2) );

			}
		};


		function udelej_cervenou_obrazovku(a){
			$('h1').prepend("<p>" + a + "</p>" );
		};

		

		var text;

		text = "";
		for( var i = 1; i < 20; i++){
			text += fib(i) + " ";
		}
		udelej_cervenou_obrazovku(6);

		$("body").append(ahoj.mami);

		$("#asd").text( text );
		
	});
});
