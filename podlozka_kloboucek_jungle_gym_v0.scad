/* design podložky a klouboučku pro šrouby do dřeva pro prolejzačku Jungle Gym
*/

podlozka();
translate([40,0,0]) mirror ([0,0,1]) klobouk();

render_circle=250;

module podlozka(){
    
    difference(){
        color ("RoyalBlue",alpha=0.9) translate([0,0,0]) rotate([0,0,0]) cylinder(h=8.5, r=16, center=true, $fn=render_circle);
        union(){
            color ("Blue",alpha=0.8) translate([0,0,0]) rotate([0,0,0]) cylinder(h=9, r=4.0, center=true, $fn=render_circle); //dira pro zavit
            color ("MediumBlue",alpha=0.7) translate([0,0,3.2]) rotate([0,0,0]) cylinder(h=9, r=14, center=true, $fn=render_circle); //dira pro hlavu 
        }//union
    }//difference
    
    
}//module

module klobouk(){

    
    difference(){
        difference(){
            union(){
                color ("SpringGreen", alpha=0.8) translate([0,0,0]) rotate([0,0,0]) cylinder(h=5.2, r=13.95, center=true, $fn=render_circle);
                color ("SpringGreen", alpha=0.8) translate([0,0,1.85]) rotate([0,0,0]) cube(size=[33,4,1.5], center=true);
            }//union
            color ("DarkGreen", alpha=0.5) translate([0,0,-1]) rotate([0,0,0]) cylinder(h=4.2, r=13, center=true, $fn=render_circle); //dira pro hlavu 
        }//difference_inner
    union(){
        angle_offset=25;
        color ("YellowGreen", alpha=0.7) translate([0,0,-1]) rotate([0,0,0+angle_offset]) cube(size=[29,0.6,4], center=true);
        color ("YellowGreen", alpha=0.6) translate([0,0,-1]) rotate([0,0,45+angle_offset]) cube(size=[29,0.6,4], center=true);
        color ("YellowGreen", alpha=0.5) translate([0,0,-1]) rotate([0,0,90+angle_offset]) cube(size=[29,0.6,4], center=true);        
        color ("YellowGreen", alpha=0.4) translate([0,0,-1]) rotate([0,0,135+angle_offset]) cube(size=[29,0.6,4], center=true);
    }//union
        
    }//difference outer

}//module