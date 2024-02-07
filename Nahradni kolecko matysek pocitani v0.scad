// ***** nahradni kolecko do pocitaci stavebnice pro Matese *****
$fn=90;

module ring() {
    difference(){
        cylinder(h=4.8, d=24, center=true);
        cylinder(h=4.8, d=16, center=true);
        }//diff
    }//module
    
    
translate ([0,0,0])  ring();
translate ([30,0,0]) ring();
translate ([60,0,0]) ring();    

translate ([0,30,0]) ring();    
translate ([30,30,0]) ring();    
translate ([60,30,0]) ring();    
    
translate ([0,60,0]) ring();    
translate ([30,60,0]) ring();    
translate ([60,60,0]) ring();    