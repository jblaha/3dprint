/*difference(){

    cube([160,15,2],true);
    translate([0,-6,0.5])linear_extrude(height = 2, center = true)
          text("· JOCHEN NOWAK ·", 12, halign = "center");
}
*/

translate ([0,25,0]) difference(){

    cube([265,17,3],true);
    union(){
    dira_offset=125;
    dira_d=4;
    translate([-1*dira_offset,0,0.5]) cylinder(h=20, d=dira_d,center=true);
    translate([+1*dira_offset,0,0.5]) cylinder(h=20, d=dira_d,center=true);
    translate([0,-6.5,0.5])linear_extrude(height = 2, center = true)
          text("  NEVHAZUJTE LETÁKY, DĚKUJI  ", 12, halign = "center");
    }//uni
}//diff


translate ([0,-10,0]) difference(){

    text="  JOCHEN NOWAK  ";
    fontsize=12;
    text_len = len (text);
    echo ("******************************");
    echo (text_len);
    echo ("******************************");
    len=265;
    cube([len,17,3],true);
    union(){
    dira_offset=0.45*len;
    dira_d=4;
    translate([-1*dira_offset,0,0.5]) cylinder(h=20, d=dira_d,center=true);
    translate([+1*dira_offset,0,0.5]) cylinder(h=20, d=dira_d,center=true);
    translate([0,-6.5,0.5])linear_extrude(height = 2, center = true)
          text(text, fontsize, halign = "center");
    }//uni
}//diff
