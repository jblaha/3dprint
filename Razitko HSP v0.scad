
mirror([-1,0,0]) scale([0.8,0.8,1]){
//mirror([-1,0,0]) scale([0.5,0.5,1]){
    lining=-7;
    height=2;
    color("LightBlue")translate ([-2,-30,-2]) cube([108,30,2.5], center=false);
    translate([0,1*lining,0])linear_extrude(height) text(text=str("Hygienická stanice hl.m. Prahy"), size=5.5);
    translate([7,2*lining,0])linear_extrude(height) text(text=str("ODBOR PROTIEPIDEMICKÝ"), size=4.8);
    translate([7,3*lining,0])linear_extrude(height) text(text=str("Rytířská 404/12, 110 00 Praha 1"), size=4.4);
    translate([25,4*lining,0])linear_extrude(height) text(text=str("Tel.: 269 336 708"), size=4.5);
}