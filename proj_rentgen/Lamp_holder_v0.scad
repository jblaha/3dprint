use <Aloka_303D_model v0.scad>;

module stojan_ingot(){
    translate([0,0,-5]) cube([42,-2+135+10+10,30], center=true);
    translate([0,-10+0.5*(135+10+10),-18.5]) cube([100,20,3], center=true);
    translate([0,10-0.5*(135+10+10),-18.5]) cube([100,20,3], center=true);
}//module


module stojan_raw(){
    difference(){
        stojan_ingot();
        translate([0,0,+4]) mirror([0,45,45]) scale([1.02,1.02,1]) aloka();
    }//diff
}//module


module stojan(){
    difference(){
    //union(){
        stojan_raw();
        union(){
            color("Red") translate([0,0,6]) cube([42,52,41], center=true);
            color("Red") translate([0,-69,22]) cube([9,4,60],center=true);
            color("Red") translate([0,-73,22]) cube([2,9,30],center=true);
            }//union
    }//diff
    
    }//module
stojan();
//stojan_raw();