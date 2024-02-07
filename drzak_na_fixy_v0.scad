drzak_na_fixy();

module drzak_na_fixy() {
color ("Blue", alpha=0.8) translate([0,0,0]) rotate([0,0,0]) cube(size=[60,90,1], center=true); //zada
color ("RoyalBlue", alpha=0.7) translate([0,0,-21]) rotate([0,0,0]) cube(size=[60,90,1], center=true); //prepazka
color ("RoyalBlue", alpha=0.6) translate([0,0,-37]) rotate([0,0,0]) cube(size=[60,90,1], center=true); //predni strana
color ("Green", alpha=0.8) translate([0,-44.5,-37/2]) rotate([0,0,0]) cube(size=[60,1,37], center=true); //L bok
color ("Green", alpha=0.8) translate([0,44.5,-37/2]) rotate([0,0,0]) cube(size=[60,1,37], center=true); //P bok
color ("Magenta", alpha=0.8) translate([-30.5,0,-37/2]) rotate([0,0,0]) cube(size=[1,90,38], center=true); //dno

color ("Gray", alpha=0.8) translate([-30+9.5,-44.5-11,-0.75]) difference(){
    cube(size=[21,21,2.5], center=true);
    translate ([0,0,-1.4]) cylinder(h=3, r=9.5, center=true);
    } //L magnet
color ("Gray", alpha=0.8) translate([-30+9.5,44.5+11,-0.75]) difference(){
    cube(size=[21,21,2.5], center=true);
    translate ([0,0,-1.4]) cylinder(h=3, r=9.5, center=true);
    } //R magnet
}