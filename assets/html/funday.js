var map;
var pano;
var panoramaService;
var streetView;

function initialize() {
  var depanGerbangITBPanoId = 'XhBZcEx30ydVFFxtUm7NjQ'
  var panoOptions = {
    pano: 'czc8aA0q5ppaMqdaiUwyzQ',
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
	// McD Dago
	['<div style="width: 170px;">"Selamat, kamu berhasil menemukan sebuah pos!<br><br>https://meet.google.com/qcy-etzr-djd</div>', -6.8850286, 107.613365, "img/pos 1.png"],
	
	// SansCo
	['<div style="width: 170px;">"Selamat, kamu berhasil menemukan sebuah pos!<br><br>https://meet.google.com/yhp-xtah-tot</div>', -6.8746285, 107.6185988, "img/pos 2.png"], 
	
	// Rektorat
	['<div style="width: 170px;">"Selamat, kamu berhasil menemukan sebuah pos!<br><br>https://meet.google.com/cij-hfod-kvd</div>', -6.8991961, 107.6093933, "img/pos 3.png"], 
	
	// Boromeus
	['<div style="width: 170px;">"Selamat, kamu berhasil menemukan sebuah pos!<br><br>https://meet.google.com/rcq-hbvn-xrh</div>', -6.8940635, 107.6130451, "img/pos 4.png"],
	
	// Borma
	['<div style="width: 170px;">"Selamat, kamu berhasil menemukan sebuah pos!<br><br>https://meet.google.com/hoi-wpck-xuj</div>', -6.8768636,107.6177492, "img/pos 5.png"],
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

  pano.setPano('czc8aA0q5ppaMqdaiUwyzQ');

  google.maps.event.addDomListener(window, 'load', initialize);
}