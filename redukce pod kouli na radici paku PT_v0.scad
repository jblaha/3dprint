$fn=100;

module mezikruzi(h_in, d1_in, d2_in){
    difference(){
        cylinder(h=h_in, d=d2_in, center=true);
        cylinder(h=h_in, d=d1_in, center=true);
        }//diff
    }//module
    
difference(){
    mezikruzi(30,14,28);
    color("Red") cube([2,30,30],center=true);
    }//difference