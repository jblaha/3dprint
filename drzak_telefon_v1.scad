/*
Držák na mobil IKEA style skládací
*/

module fixer(){
    difference(){
        cube(size=[25,25,16], center=true);
        translate([0,0,-6]) union(){
            color("Red") cube(size=[1.9,26,16], center=true);
            color("Red") cube(size=[26,1.9,16], center=true);
            }//union
        }//diff
    }//module
    
module short_part_extra(width=85, length=120, hole=3.5){
    union(){
        difference(){
            color("Blue", alpha=1) translate([0,0,0]) cube(size=[85,length,2], center=false);
            //color("Red", alpha=1) translate([-0.1,30,-1]) cube(size=[0.5*width,hole,5], center=false);
        }//diff
        color("Blue", alpha=1) rotate([0,90,0]) translate([-5,0,15]) cube(size=[5,length,2], center=false);
        color("Blue", alpha=1) rotate([0,90,0]) translate([-5,0,30]) cube(size=[5,length,2], center=false);
        color("Blue", alpha=1) rotate([0,90,0]) translate([-5,0,42]) cube(size=[5,length,2], center=false);
        color("Blue", alpha=1) rotate([0,90,0]) translate([-5,0,55]) cube(size=[5,length,2], center=false);
        color("Blue", alpha=1) rotate([0,90,0]) translate([-5,0,70]) cube(size=[5,length,2], center=false);
    }//union
    }//module

module short_part(width=85, length=120, hole=3.5){
    
        difference(){
            color("Blue", alpha=1) translate([0,0,0]) cube(size=[85,length,2], center=false);
            union(){
                color("Red", alpha=1) translate([0,61,0]) cube(size=[5,length,4], center=false);
                color("Red", alpha=1) translate([80,61,0]) cube(size=[5,length,4], center=false);
                }//union
            //color("Red", alpha=1) translate([-0.1,30,-1]) cube(size=[0.5*width,hole,5], center=false);
        }//diff
        //color("Blue", alpha=1) rotate([-10,0,0]) translate([0,0,0]) cube(size=[85,length,2], center=false);
    
    }//module
    


module long_part(width=85, length=195){
    
        short_part(width, length,4);
        
        translate([0,0,11]) rotate([-10,0,0]) union(){
        color("Green", alpha=1) translate([5,55,0]) cube(size=[20,4,20], center=false);
        color("Green", alpha=1) translate([width-30-5+10,55,0]) cube(size=[20,5,20], center=false);
        }//union

        translate([0,2,0]) rotate([0,0,0]) union(){
        color("Green", alpha=1) translate([5,55,0]) cube(size=[20,4,17], center=false);
        color("Green", alpha=1) translate([width-30-5+10,55,0]) cube(size=[20,5,17], center=false);
        }//union
    


    }//module
    
//translate ([-90,0,0]) short_part_extra();
long_part();
//fixer();