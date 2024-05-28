include <../_lib_/straight_pipe3d.scad>
include <../_lib_/cap3d.scad>
include <redukce-civky-parametry.scad>
include <redukce-civky-common.scad>


$fn= 50;


module barrel_with_sensor_holes() {
    
    //walls_thickness=overlaping_part_r-barrel_inner_r;
    //walls_thickness2=overlaping_part_r-barrel_outer_r;
    
    LED_hole_r = max(1, 0.3333*LED_r);
    barrell_length = (2*barrel_halflength+intercoil_spacing)*2;
    barrel_begin_z = -1*(2*barrel_halflength+intercoil_spacing);
    
    holes_spacing = [2*barrel_halflength+0.5*intercoil_spacing,
                     2*barrel_halflength+0.5*intercoil_spacing+0.5*intercoil_spacing+2*barrel_halflength+0.5*intercoil_spacing];
    
    holes_position = holes_spacing + [barrel_begin_z,barrel_begin_z]; 
    //holes_position = holes_spacing ;
    echo(holes_spacing);
    
    
    difference(){
        color("blue")rotate ([180,0,0]) barrel(length=barrell_length, r_inner=barrel_inner_r, r_outer=barrel_outer_r);
        union(){
            translate([0,0,holes_position[0]]) rotate ([0,90,0]) color("red") cylinder(h=20, r=LED_hole_r, center=true);
            translate([0,0,holes_position[1]]) rotate ([0,90,0]) color("red") cylinder(h=20, r=LED_hole_r, center=true);
            }//union
    
    }//difference
}//module

module LED_section(){
    difference(){
        straight_pipe3d(r_inner=1.1*barrel_outer_r, r_outer=11, length=intercoil_spacing);
        rotate ([0,90,0]) color("red") cylinder(h=120, r=LED_r, center=true);
        }//difference
    }//module

//projection(cut=true) rotate([0,90,0])barrel_with_sensor();
//xray() barrel_with_sensor();
barrel_with_sensor_holes();
//LED_section();
//barrel();

