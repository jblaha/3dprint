$fn=110;

module mezikruzi(h_in, d1_in, d2_in){
    difference(){
        cylinder(h=h_in, d=d2_in, center=true);
        cylinder(h=h_in, d=d1_in, center=true);
        }//diff
    }//module
    
    
difference(){
    mezikruzi(8.7,37,45);
    union(){
        color("Red") mezikruzi(7.2,44,45);
        
        color("Red") cube([2,48,10],center=true);
    }//union
}//diff
