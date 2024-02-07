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
    
module short_part(width=85, length=120, hole=3.5){
    difference(){
        color("Blue", alpha=1) translate([0,0,0]) cube(size=[85,length,2], center=false);
        color("Red", alpha=1) translate([-0.1,30,-1]) cube(size=[0.5*width,hole,5], center=false);
    }//diff
    }//module


module long_part(width=85, length=210){
    
        short_part(width, length,4);
        
        translate([0,0,17]) rotate([-15,0,0])union(){
        color("Green", alpha=1) translate([5,55,0]) cube(size=[30,3,20], center=false);
        color("Green", alpha=1) translate([width-30-5,55,0]) cube(size=[30,3,20], center=false);
        }//union
    


    }//module
    
//translate ([-90,0,0]) short_part();
//long_part();
fixer();