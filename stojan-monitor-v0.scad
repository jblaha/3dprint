module mainboxsocket(thickness=5, height=30, length=175, width=75,pin_dia=30){
    pin_height=5;
        
    //color("Salmon") translate([0,length*1/3,-0.5*pin_height-height+pin_height-0.1]) cylinder(h=pin_height,d=pin_dia,center=true);
    difference(){
        color("Blue", alpha=0.5) translate([0,(length+thickness)/2,-1*height/2]) cube([width+2*thickness,length+thickness,height],center=true);
        union(){
            color("Red") translate([0,length/2,-thickness/2]) cube([width,length,thickness],center=true);
            color("Salmon") translate([0,length*1/3,-0.5*pin_height-height+pin_height-0.1]) cylinder(h=pin_height,d=pin_dia,center=true);
            color("Salmon") translate([0,length*3/4,-0.5*pin_height-height+pin_height-0.1]) cylinder(h=pin_height,d=pin_dia,center=true);
            
            }//uni
        }//diff
    }//module


module mainbox(thickness=5, height=30, length=175, width=75,pin_dia=30){
    pin_height=3;
        
    //color("Salmon") translate([0,length*1/3,-0.5*pin_height-height+pin_height-0.1]) cylinder(h=pin_height,d=pin_dia,center=true);
    color("Navy") translate([0,length*1/3,0.5*pin_height+0*height+0*pin_height-0.1]) cylinder(h=pin_height,d=pin_dia*0.9,center=true);
    color("Navy") translate([0,length*3/4,0.5*pin_height+0*height+0*pin_height-0.1]) cylinder(h=pin_height,d=pin_dia*0.9,center=true);

    difference(){
        color("Blue", alpha=0.5) translate([0,(length+thickness)/2,-1*height/2]) cube([width+2*thickness,length+thickness,height],center=true);
        union(){
            color("Salmon") translate([0,length*1/3,-0.5*pin_height-height+pin_height-0.1]) cylinder(h=pin_height,d=pin_dia,center=true);
            color("Salmon") translate([0,length*3/4,-0.5*pin_height-height+pin_height-0.1]) cylinder(h=pin_height,d=pin_dia,center=true);
            
            }//uni
        }//diff
    }//module
    
    
/*
vyska=20;
mainboxsocket(height=vyska);
translate ([70,0,0]) mainboxsocket(height=vyska, length=75, width=30,pin_dia=15);
translate ([-70,0,0]) mainboxsocket(height=vyska, length=75, width=30, pin_dia=15);
*/

vyska=40;
mainbox(height=vyska);
translate ([70,0,0]) mainbox(height=vyska, length=75, width=30,pin_dia=15);
translate ([-70,0,0]) mainbox(height=vyska, length=75, width=30, pin_dia=15);
    
 