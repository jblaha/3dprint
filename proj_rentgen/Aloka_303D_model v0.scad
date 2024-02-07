$fn=75;

module aloka(){
difference(){
//union(){
    union(){
        difference(){
            union(){
                color("Blue")translate([0,0,0]) cylinder(d=9,h=134.4+10+10,center=true);//piny
                color("Blue")translate([0,0,0]) cylinder(d=34,h=134.5,center=true);//patice
            }//union
            translate([0,0,0]) cylinder(d=41,h=81,center=true);//tělo
        }//diff
        color("Lavender",alpha=0.5) hull(){
            color()translate([0,0,0]) cylinder(d=34,h=81,center=true);//patice
            color()translate([0,0,0]) cylinder(d=41,h=46.5,center=true);//tělo
        }//hull
    }//union
    color("Red")union(){
        translate([+6.0,0,2+(134.51+10)/2]) cube(10, center=true);
        translate([-6.0,0,2+(134.51+10)/2]) cube(10, center=true);//piny
        }//union
}//difference
}//module
//aloka();