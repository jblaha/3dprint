/*
Limec pro opravu pumpicky na mice, co rozbil Mates
*/

$fn=150;

difference(){
    translate([0,0,0])cylinder(h=12, d=38.5, center=false); //vnejsi obal
    union(){
        cylinder(h=20, r=16.5, center=false); //dira na hridel
        translate([0,0,+1])cylinder(h=20, d=37.5, center=false); //dira na pist
        }//union
}//diff