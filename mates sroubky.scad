use <threads-library-by-cuiso-v1.scad>
use <MCAD/lego_compatibility.scad>

//a list of examples of use for library threads-library-by-cuiso-v1.scad


//EXAMPLE, a simple SCREW with hexagonal head:

srandasroub_f();
translate ([45,0,2]) srandasroub_m();
/*
difference(){
color ("blue", alpha=0.3) cylinder(d=30, h=10, $fn=16, center=true);
color ("red", alpha=0.6) cylinder(d=19, h=11, $fn=16, center=true);
}
*/

module srandasroub_f(){
difference(){
union(){
thread_for_screw_fullparm(diameter=8, length=14+5, pitch=1.8); 
cylinder(d=19, h=5, $fn=16);
}

    union(){
    /*rotate([0,0,90])cube([1.7,15,4], center=true);
    rotate([0,0,0]) cube([1.7,15,4],center=true);*/
        translate ([0,0,-3.2]) mirror([0,0,0]) block(2,2,1/3,reinforcement=false, center=true);
    }
}
}//module

module srandasroub_m(){

difference(){
    union(){
        thread_for_screw_fullparm(diameter=8, length=14+5+5, pitch=1.8); 
        cylinder(d=19, h=5, $fn=16);
        translate ([0,0,+3.2]) mirror([0,0,-1]) block(2,2,1/3,reinforcement=false, center=true);
    }//union

    
        difference(){
            color ("blue", alpha=0.4) cylinder(d=30, h=10, $fn=16, center=true);
            color ("red", alpha=0.6) cylinder(d=19, h=11, $fn=16, center=true);
        }//diff
    
}//diff
}//module


/*
translate([0,20,0])
translate([0,10,0]){
    thread_for_screw(diameter=10, length=20); 
    cylinder(d=22, h=6, $fn=6);
}
//EXAMPLE, a simple hexagonal NUT:

translate([20,0,0])
difference(){
    cylinder(d=17, h=16, $fn = 6); 
    translate([0,0,2])
        thread_for_nut(diameter=10, length=25); 
}


//EXAMPLE, a nut with 0.1 extra clearance:

translate([20,20,0])
difference(){
    cylinder(d=17, h=15, $fn = 6); 
    thread_for_nut(diameter=10, length=65, usrclearance=0.1); 
}


//EXAMPLE, a cube with two treads:
/*
translate([-20,0,0])
difference(){

translate([0,0,15/2]) cube([15,15,15], center=true);

thread_for_nut(diameter=6, length=15); 

translate([0,15/2,15/2]) rotate([90,0,0]) 
thread_for_nut(diameter=6, length=15); 
}
*/

/*
//EXAMPLE, a rod with no standard pitch:
translate([0,20,0])
thread_for_screw_fullparm(diameter=20, length=30, pitch=6); 
*/
/*
//EXAMPLE, a rod with no standard diameter:
translate([0,-20,0])
thread_for_screw(diameter=6.5, length=10); ; 
*/