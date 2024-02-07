module stitek_na_dvere(text, fsize=12,thickness=3){
    label_len = (len(text)-1)*fsize*1;
    hole_offset=0.45*label_len;
    hole_d=4;
    
    
    difference(){
        cube([label_len,fsize+6.5,thickness],center=true);
        union(){
            translate([-1*hole_offset,0,0.5]) cylinder(h=20, d=hole_d,center=true);
            translate([+1*hole_offset,0,0.5]) cylinder(h=20, d=hole_d,center=true);
            translate([0,-6.5,0.5])linear_extrude(height = 1.25*thickness, center = true) text(text, fsize, halign = "center");
            }//union
        }//diff
    
}//module


stitek_na_dvere(" JOCHEN NOWAK ", 12);
translate([0,20,0]) stitek_na_dvere("NEVHAZUJTE LETÁKY, DĚKUJI", 12);
//translate([0,40,0]) stitek_na_dvere(" GYN PROSEK S.R.O. ", 12);
