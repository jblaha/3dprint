module straight_pipe3d(r_inner=4, r_outer=6, length=10){

        difference(){
            color("blue")cylinder(h=length ,r=r_outer ,center=true); //outer
            color("red") cylinder(h=length ,r=r_inner ,center=true); //inner
        }//difference

    }//module
    
/*
$fn=60;
translate([0,0,-3]) straight_pipe3d();
translate([0,3,0]) rotate([90,0,0]) straight_pipe3d();
    */