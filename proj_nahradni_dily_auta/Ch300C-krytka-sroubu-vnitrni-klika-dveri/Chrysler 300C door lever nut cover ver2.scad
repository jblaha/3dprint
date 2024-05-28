// krytka šroubu pod klikou na přednich dveřích Chrysler 300C

$fn=80;
module wedge(x,y,z){
    linear_extrude(z, center=true) polygon(points=[[0,0],[x,0],[x,y]]);
    
    }//module

module small_hook(){
    color("Green") cube([5,2,5],center=true);
    color("Green") translate([0,1,2]) rotate([0,+90,0]) wedge(5,5,5);
    }//module

module big_hook(){
    union(){
    color("Green") cube([8,2,6],center=true);
    color("Green") translate([-1,0,6]) cube([2,2,6],center=true);
    color("Green") translate([+1,0,6]) cube([2,2,6],center=true);
    color("Green") translate([0,-1,3]) rotate([0,+90,180]) wedge(7,7,8);    
        }//union
    }//module

module base(){
    
    difference(){
        color("Blue") cylinder(h=2, d=22, center=true);
        union(){
            color("Red")translate([0,11,0]) cube([10,2,2],center=true);
            color("Red")translate([0,-11,0]) cube([6,2,2],center=true);
            }//union
        }//difference
    }//module
    
module part(){
    translate([0,0,0]) base();
    //translate([0,-9,3]) mirror([0,0,0]) small_hook();
    translate([0,-9,3]) mirror([0,1,-0]) big_hook();
    translate([0,+9,3]) mirror([0,0,0]) big_hook();
    
    }//module
    
    part();
    //wedge(5,5,5);