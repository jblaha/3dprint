$fn=40;

//difference(){//diff rez
    
difference(){

    cube([180,15,2],true);
    union(){
        translate([0,-6,0.5])linear_extrude(height = 2, center = true)
            text(" GYN PROSEK  S.R.O. ", 12, halign = "center");
        translate([85,0,0]) cylinder(h=3,d1=0,d2=4,center=true);
        translate([-85,0,0]) cylinder(h=3,d1=0,d2=4,center=true);
    }//union
    
}//diff text

//color ("Red") translate([-90,-5,0]) cube([10,10,10],true);
//}//diff rez

/*
translate ([0,25,0]) difference(){

    cube([265,17,3],true);
    translate([0,-6.5,0.5])linear_extrude(height = 2, center = true)
          text("· NEVHAZUJTE LETÁKY, DĚKUJI ·", 12, halign = "center");
}
*/