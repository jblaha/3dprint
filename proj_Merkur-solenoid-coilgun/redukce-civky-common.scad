include <redukce-civky-parametry.scad>

module barrel(length=10, r_inner=5, r_outer=9 ) {
    difference(){
        //straight_pipe3d(r_inner=barrel_inner_r, r_outer=barrel_outer_r, length=length);
        //translate ([0,0,0.5*(length-2)]) cylinder(h=2,r2 = 0.5*8.7, r1=0.5*5, center=true);
        
        /* genericka verze pro hlaven */
        
        straight_pipe3d(r_inner=r_inner, r_outer=r_outer, length=length);
        translate ([0,0,0.5*(length-2)]) cylinder(h=2,r2 = r_outer, r1=r_inner, center=true);
        
    }//difference
}//module



module xray(){
    difference(){
        //barrel();
        children();
        translate ([0,15,0]) cube([100,30,100],center=true);
    }//diff
}//module
