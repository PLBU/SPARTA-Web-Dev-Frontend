var map;
var pano;
var panoramaService;
var streetView;
 
function initialize() {
  var panoOptions = {
    pano: 'WrCWQzbFpDn4nrck4qIYPQ',
    pov: {
      heading: 0,
      pitch: 0
    },
    zoom: 0
  };
  pano = new google.maps.StreetViewPanorama(document.getElementById('funday'), panoOptions);

  var infowindow = new google.maps.InfoWindow();
  var marker, i;
  var markers = [];
  
  // [Marker's caption, lattitude, longitude, icon location]
  var locations = [
	// Paris
	['<div style="text-align:center"><button onclick="toParis()">MASUK PORTAL</button><br>The Tower of Love</div>', -6.87939, 107.61272, "img/portalzzz.png"], //sadikin
	['<div style="text-align:center"><button onclick="toParis()">MASUK PORTAL</button><br>The Tower of Love</div>', -6.89343, 107.61855, "img/portalzzz.png"], //monju
	['<div style="width: 170px;">https://meet.google.com/tjx-tjma-tps</div>', 48.857931, 2.295467, "img/racmFz.png"],
	['<button onclick="goBack()">BACK TO BANDUNG</button>', 48.855454, 2.301249, "img/portalzzz.png"],
	
	// Italy
	['<div style="text-align:center"><button onclick="toPisa()">MASUK PORTAL</button><br>Pizza ga bisa dimakan</div>', -6.888931, 107.608089, "img/portalzzz.png"], //jeprut
	['<div style="text-align:center"><button onclick="toPisa()">MASUK PORTAL</button><br>Pizza ga bisa dimakan</div>', -6.898178, 107.613641, "img/portalzzz.png"], //upnormal
	['<div style="width: 170px;">https://meet.google.com/ohd-vong-mhf</div>', 43.722897, 10.396467, "img/inZHJh.png"], 
	['<button onclick="goBack()">BACK TO BANDUNG</button>', 43.7215745, 10.3971504, "img/portalzzz.png"],
	
	// Jogja
	['<div style="text-align:center"><button onclick="toJogja()">MASUK PORTAL</button><br>Kamadhatu, Rupadhatu, Arupadhatu</div>', -6.88497, 107.61344, "img/portalzzz.png"], //mcd dago
	['<div style="text-align:center"><button onclick="toJogja()">MASUK PORTAL</button><br>Kamadhatu, Rupadhatu, Arupadhatu</div>', -6.898794, 107.609274, "img/portalzzz.png"], //baltos 
	['<div style="width: 170px;">https://meet.google.com/gjo-agmy-xku</div>', -7.607521, 110.203681, "img/ferZGluYQ.png"], 
	['<button onclick="goBack()">BACK TO BANDUNG</button>', -7.606929, 110.202715, "img/portalzzz.png"],
	
	// Jakarta
	['<div style="text-align:center"><button onclick="toJakarta()">MASUK PORTAL</button><br>Es krim toping emas ala Jakarta</div>', -6.890169, 107.613247, "img/portalzzz.png"], //spbu
	['<div style="text-align:center"><button onclick="toJakarta()">MASUK PORTAL</button><br>Es krim toping emas ala Jakarta</div>', -6.876435, 107.611753, "img/portalzzz.png"], //angcis
	['<div style="width: 170px;">https://meet.google.com/rqa-hoeq-ufb</div>', -6.173288, 106.827659, "img/laWE.png"],
	['<button onclick="goBack()">BACK TO BANDUNG</button>', -6.171659, 106.826946, "img/portalzzz.png"],
	
	// Rio
	['<div style="text-align:center"><button onclick="toRio()">MASUK PORTAL</button><br>Tuhan besar</div>', -6.898686, 107.607746, "img/portalzzz.png"], //taman film
	['<div style="text-align:center"><button onclick="toRio()">MASUK PORTAL</button><br>Tuhan besar</div>', -6.879173, 107.620036, "img/portalzzz.png"], //kanayakan
	['<div style="width: 170px;">https://meet.google.com/jcz-wuka-aic</div>', -22.951827, -43.210497, "img/mudGU.png"],
	['<button onclick="goBack()">BACK TO BANDUNG</button>', -22.951940, -43.210898, "img/portalzzz.png"],
	
	// Kuala Lumpur
	['<div style="text-align:center"><button onclick="toKualaLumpur()">MASUK PORTAL</button><br>Beli bensin di Malaysia</div>', -6.885179, 107.610161, "img/portalzzz.png"], //baksil
	['<div style="text-align:center"><button onclick="toKualaLumpur()">MASUK PORTAL</button><br>Beli bensin di Malaysia</div>', -6.878426, 107.609397, "img/portalzzz.png"], //sangkuriang 	
	['<div style="width: 170px;">https://meet.google.com/obz-kqne-ivh</div>', 3.158228, 101.711308, "img/hacnJ5.png"],
	['<button onclick="goBack()">BACK TO BANDUNG</button>', 3.158845, 101.709261, "img/portalzzz.png"]
  ];


  for (i = 0; i < locations.length; i++) {
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[i][1], locations[i][2]),
      map: pano,
      visible: false,
      zIndex: 999,
      zoomControl: false,
	  icon: locations[i][3]
    });

    google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
      return function() {
        infowindow.setContent(locations[i][0]);
        infowindow.open(pano, marker);
      }
    })(marker, i));
    markers.push(marker); // save all markers
  }

  for (i = 0; i < locations.length; i++) {
    markers[i].setVisible(true);
    markers[i].setMap(pano);
  }

  pano.setPano('WrCWQzbFpDn4nrck4qIYPQ');

  google.maps.event.addDomListener(window, 'load', initialize);
}

function goBack() {
	pano.setPano("WrCWQzbFpDn4nrck4qIYPQ");
}

function toParis() {
	pano.setPano("sTl4iz8yrMDvwZgi6aeFgw");
}

function toPisa() {
	pano.setPano("B2MSxoluho_KlmONMS4zCA");
}

function toJogja() {
	pano.setPano("CyRjGnaBGjIvXiMFP-4jig");
}

function toJakarta() {
	pano.setPano("r18eyTnCRT90PGcqsy-hnQ");
}

function toRio() {
	pano.setPano("PrOCBIKiwp0_AW0ULdmqJA");
}

function toKualaLumpur() {
	pano.setPano("l5GdBeZBIys3jKbp4ijn4w");
}
