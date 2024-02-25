include <../_lib_/straight_pipe3d.scad>
include <../_lib_/cap3d.scad>

$fn= 50;

barrel_inner_r = 0.5*5;
barrel_outer_r = 0.5*8.7;
intercoil_spacing = 8.8;
barrel_halflength = 15;
LED_r = 3;
LED_length=8;
overlaping_part_length = 1.8;
overlaping_part_r = (11);
overlaping_part_with_LED_length = 7;
barrel_fitting_margin = 0.25;



module barrel(length=barrel_halflength+overlaping_part_length) {
    difference(){
        straight_pipe3d(r_inner=barrel_inner_r, r_outer=barrel_outer_r, length=length);
        translate ([0,0,0.5*(length-2)]) cylinder(h=2,r2 = 0.5*8.7, r1=0.5*5, center=true);
    }//difference
}//module

module barrel_with_sensor() {
    
    walls_thickness=overlaping_part_r-barrel_inner_r;
    walls_thickness2=overlaping_part_r-barrel_outer_r;
    
    LED_cap_offset =-0.5*(barrel_halflength+1.0*overlaping_part_with_LED_length); //poloviny, protoze vsude je center=true;
    thin_cap_offset =-1.0*(0.5*barrel_halflength+1.0*overlaping_part_with_LED_length+0.5*overlaping_part_length);
    
    union(){
    color("black")barrel(length=barrel_halflength);
    
    translate([0,0,LED_cap_offset])
    
    difference(){
        cap3d(outer_radius=overlaping_part_r, 
              height=overlaping_part_with_LED_length, 
              walls_thickness=walls_thickness*1, //DBG
              top_thickness=0);
        translate([0,0,0]) rotate ([90,0,0])cylinder(h=120, r=LED_r, center=true);
    }//difference
    
    translate([0,0,thin_cap_offset])
    cap3d(outer_radius=overlaping_part_r*1.0, 
          height=overlaping_part_length, 
          walls_thickness=(walls_thickness2-barrel_fitting_margin), 
          top_thickness=0);
    }//union
}//module

module xray(){
    difference(){
        //barrel();
        children();
        translate ([0,15,0]) cube([100,30,100],center=true);
    }//diff
}//module

//projection(cut=true) rotate([0,90,0])barrel_with_sensor();
//xray() barrel_with_sensor();
barrel_with_sensor();
//barrel();

//cap3d(outer_radius=overlaping_part_r, height=overlaping_part_with_LED_length, walls_thickness=overlaping_part_r-barrel_inner_r, top_thickness=0);