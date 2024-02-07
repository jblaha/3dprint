$fn=85;

module lozisko(){
    difference(){
        cylinder(d=7, h=4,center=true);
        cube([4.0,4.0,15],center=true);
        
        }//diff
    }//module

module osa(){
    cube([3.8,3.8,16],center=true);
}//module
module pin(){
    union(){
        color(alpha=0.5)rotate([0,0,0])cylinder(d=3.3,h=5.25, center=true);
        translate([0,0,2.90])sphere(d=3.41);   
        }//union
}//module

module kolecko(){
    
    difference(){
        cylinder(d=30,h=4.5, center=true,$fn=150);
        union(){
            for(angle=[0:45:359]) { rotate([0,0,angle])translate([4+9.5,0,0])rotate([0,90,0])cylinder(d=3.5,h=3.0, center=true);}//for
            cube([4,4,10], center=true);
            }//union
        }//diff
    }//module
    
translate([15,15,8])osa();
//translate([15,-15,2])lozisko();
//translate([-15,-15,2])lozisko();
//translate([-15,15,3.5])pin();
//translate([0,0,4.5/2]) kolecko();
/*
difference(){
    kolecko();
    //cube(50, center=false);
}
    */