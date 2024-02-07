/* design podložky a klouboučku pro šrouby do dřeva pro prolejzačku Jungle Gym
*/

//ver 1 - redesign kloubouku - zvýšení, zmenšení délky drážek
//ver 2 - zmenšení poloměru o 4 mm, přidání kolmého držátka na vyndání klobouku
//ver 3 - klobouk bude přes podložku a nikoliv do. Proč taky, tvl?
//ver 4 - zpet na zuzeni klobouku a drazka pro zapustnou hlavu sroubu

podlozka();
translate([30,0,-1.35]) mirror ([0,0,1]) klobouk();
//klobouk();

render_circle=250;

module podlozka(){
    //color ("Red",alpha=0.4) translate([0,0,-2.125]) rotate([0,0,0]) cylinder(h=2, r=6.4, center=true, $fn=render_circle); //dira pro zavit
    difference(){
        
        color ("RoyalBlue",alpha=0.9) translate([0,0,0]) rotate([0,0,0]) cylinder(h=8.5, r=12, center=true, $fn=render_circle);
        
        union(){
            
                color ("Blue",alpha=0.8) translate([0,0,0]) rotate([0,0,0]) cylinder(h=9, r=4.2, center=true, $fn=render_circle); //dira pro zavit
                color ("DarkBlue",alpha=0.8) translate([0,0,-2.125]) rotate([0,0,0]) cylinder(h=2, r=7, center=true, $fn=render_circle); //dira pro zavit
                //color ("Red",alpha=0.99) translate([0,0,-10]) rotate([0,0,0]) cylinder(h=5, r1=0.1, r2=50, center=true, $fn=render_circle); //zkoseni hrany
            
            color ("MediumBlue",alpha=0.7) translate([0,0,3.2]) rotate([0,0,0]) cylinder(h=9, r=10, center=true, $fn=render_circle); //dira pro hlavu 
        }//union
    }//difference
    
    
}//module

module klobouk(){

    
    difference(){
        difference(){
            union(){
                color ("SpringGreen", alpha=0.8) translate([0,0,0]) rotate([0,0,0]) cylinder(h=5.8, r=14.00, center=true, $fn=render_circle); //samotny telo klobouku
                color ("SpringGreen", alpha=0.8) translate([0,0,2.1]) rotate([0,0,0]) cube(size=[32,4,1.5], center=true); //madlo na vyndani
                color ("SpringGreen", alpha=0.8) translate([0,0,2.1]) rotate([0,0,90]) cube(size=[28,4,1.5], center=true); //madlo na vyndani

            }//union
            color ("DarkGreen", alpha=0.5) translate([0,0,-1]) rotate([0,0,0]) cylinder(h=4.8, r=11.9, center=true, $fn=render_circle); //dira
        }//difference_inner
    union(){
        //drazky pro snazsi vyndavani
        angle_offset=22;
        color ("YellowGreen", alpha=0.7) translate([0,0,-2.5]) rotate([0,0,0+angle_offset]) cube(size=[33,0.6,4], center=true);
        color ("YellowGreen", alpha=0.6) translate([0,0,-2.5]) rotate([0,0,45+angle_offset]) cube(size=[33,0.6,4], center=true);
        color ("YellowGreen", alpha=0.5) translate([0,0,-2.5]) rotate([0,0,90+angle_offset]) cube(size=[33,0.6,4], center=true);        
        color ("YellowGreen", alpha=0.4) translate([0,0,-2.5]) rotate([0,0,135+angle_offset]) cube(size=[33,0.6,4], center=true);
    }//union
        
    }//difference outer

}//module