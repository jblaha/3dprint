// krytka šroubu pod klikou na přednich dveřích Chrysler 300C

$fn=80;

module small_hook(){
    color("Green") cube([5,2,5],center=true);
    color("Green") translate([0,0.7,-1.2]) rotate([30,0,0]) cube([3,2,3],center=true);
    }//module

module big_hook(){
    union(){
    color("Green") cube([8,2,6],center=true);
    color("Green") translate([-2,0,6]) cube([2,2,6],center=true);
    color("Green") translate([+2,0,6]) cube([2,2,6],center=true);
        
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
    translate([0,-9,3]) mirror([0,0,0]) small_hook();
    translate([0,+9,3]) mirror([0,0,0]) big_hook();
    
    }//module
    
    part();