/*
Dno lampicky pro Silvu, ktery se zlomilo
Jednoducha verze bez navijaku dlouheho kabelu
29.11.2020
vnejsi prumer je 125 mm
sirka plechu 0.575 mm
*/

/*
BACHA - je potreba zmensit limec, 66 outer a 65 inner diameter uz je moc, limec ma vuli tak cca 1 mm
*/
//dno_lampicky();
circlefine=250;

difference(){
    dno_lampicky();
    //color ("Red",alpha=0.99) translate([0,0,-4]) rotate([0,0,0]) cylinder(h=8, r=57.0, center=true, $fn=circlefine);
    //translate ([100,0,0]) cube(size=[200,200,100],center=true);
}
    

module dno_lampicky(){
difference(){
    difference(){
    //union(){
    color ("RoyalBlue",alpha=0.99) translate([0,0,0]) rotate([0,0,0]) cylinder(h=5, r=66.0, center=true, $fn=circlefine);
    color ("Blue",alpha=0.99) translate([0,0,1]) rotate([0,0,0]) cylinder(h=4, r=65.0, center=true, $fn=circlefine);
        //note pro dalsi tisk 65 a 66 prumery uz jsou moc, asi tak o 1-1,5mm je ten limec vetsi nez lampicka
    }
union(){
    color ("Red",alpha=0.99) translate([0,0,-1]) rotate([0,0,0]) cylinder(h=3, r=1.20, center=true, $fn=circlefine);
    color ("DarkRed",alpha=0.99) translate([0,0,-3.2]) rotate([0,0,0]) cylinder(h=3, r=3, center=true, $fn=circlefine);
    }//union
}
}//module