module cap3d(outer_radius=20, height=10, walls_thickness=2, top_thickness=-1){
    /* module for round lid cap*/
    top_thickness = top_thickness <0 ? walls_thickness : top_thickness;
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
    
  $fn=90;
//  cap3d(top_thickness=0);