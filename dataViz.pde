import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

// Press "Space" for switching between visualisations

int vizMode;

// 1) data
Table tableWifi;
String wifiHTML;
String wifiFILE;

//2) viz
//2.a) Map
UnfoldingMap map;

void setup() {
  size(800, 600, P2D);
  smooth();
  vizMode = 0;
  
  // 1) Retrieving data and parsing it
  // CVS, XML, JSON or straight text.
  // In our case, we took the CSV file on the web, and modified it
  // / a bit to fit better the CSV model
  
  wifiHTML = "http://opendata.brussels.be/explore/dataset/wifi0/download/?format=csv";
  wifiFILE = "wifi.csv";  
 
  tableWifi = loadTable( wifiFILE, "header, csv");

  // 2) Init for the various visualisations
  
  // 2.a) Map Visualisation
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(13, new Location(50.841861, 4.352387));
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);

 
}


void draw() {
  
  switch(vizMode) {
  case 0: mapViz(); break;
  case 1: testViz(); break; 
  }
  
}

void keyPressed() {
  
  if (key == ' ') {
    vizMode++;
    if(vizMode > 1)
      vizMode = 0;
  }
}

// ------------------------------
// ------ Code for vizualisations
// ------------------------------

void mapViz() {
  noStroke();
  fill(255, 0, 255, 100);
  
  background(0);  
  map.draw();

  for (TableRow row : tableWifi.rows()) {
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    ScreenPosition pos = map.getScreenPosition( new Location(lat, lng) );
    ellipse(pos.x, pos.y, 10, 10);
  } 
  
}

void testViz() {
  background(0);  

}

void dataDump() {
  
   println(tableWifi.getRowCount() + " total rows in table"); 

  for (TableRow row : tableWifi.rows()) {
    
    String name = row.getString("name");
    String street = row.getString("street");
    int nbr = row.getInt("number");
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    
    println("Sweet sweet wifi at " + name +
            " of adress: " + nbr + ", " + street +
            ". [" + lng +", "+lat+"]." );
  }  
  
}
