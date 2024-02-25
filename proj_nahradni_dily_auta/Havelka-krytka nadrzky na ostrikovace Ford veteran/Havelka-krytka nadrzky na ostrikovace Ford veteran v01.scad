module cap3d(outer_radius=20, height=10, walls_thickness=2, top_thickness=-1){
    /* module for round lid cap*/
    top_thickness = top_thickness <=0 ? walls_thickness : top_thickness;
    r_outer = outer_radius;
    h_outer = height;
    r_inner = outer_radius - walls_thickness;
    h_inner = height - top_thickness;
    inner_z_offset = top_thickness;
    
    difference(){
        color("blue")cylinder(h=h_outer ,r=r_outer ,center=true); //outer
        translate([0,0,top_thickness]) color("red")cylinder(h=h_inner ,r=r_inner ,center=true); //inner
        }//difference
    } //module
  
module cup(){
    difference(){
        union(){
            cap3d(outer_radius=57/2, height=11, walls_thickness=2, top_thickness=3);
            translate([57/2,0,-11/2+2/1-0.5]) cap3d(outer_radius=12, height=3, walls_thickness=12, top_thickness=3);
        }//union
    cylinder(20,3, center=true);
    }//difference
}//module

module suction_piping_housing(){
        union(){
            translate([0,0,0]) color("blue") cube([10,30,10], center=true);
            translate([0,10,13]) color("blue") cube([10,10,14+3], center=true);
            translate([0,-0,7]) color("black") cube([5,3,5], center=true);
        }//union
    
    }//module

module suction_piping(){
    difference(){
        suction_piping_housing();
        union(){
            translate([0,-2.5,0]) rotate ([90,0,0]) color("red") cylinder(h=31,d=8.1,center=true);
            translate([0,10,14.5]) rotate ([0,0,0]) color("red") cylinder(h=29,d=6.1,center=true);
        }//union
    }//difference
}//module

module cup_with_holes(){
    difference(){
        cup();
        translate([0,40-28.5+12,-10.5]) mirror([-0,-1,0]) suction_piping_housing(); 
    }//difference
}//module




$fn=60;
cup_with_holes();
//suction_piping();


//rentgen sight of a cup itself
/*
difference(){
    difference(){cup();translate([0,40-28.5+12,-10.5]) mirror([-0,-1,0]) suction_piping_housing(); }
    translate([0,0,-10])cube([70,120,80]);}
*/

/*
// rentgen sight of pipe
difference(){
    union(){cup();translate([0,40-28.5+12,-10.5]) mirror([-0,-1,0]) suction_piping(); }
    translate([0,0,-10])cube([70,120,80]);}

*/