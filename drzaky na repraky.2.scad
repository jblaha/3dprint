/*

*/
drzak_A();

module uchyt_repra(delka_rovneho_segmentu=20, delka_sikmeho_segmentu=37,sirka=25,tloustka=2.8){
    //delka_rovneho_segmentu=20;
    //delka_sikmeho_segmentu=37;
    //sirka=25;
    //tloustka=2.8;
    
    translate([0,0,-0.5*(-delka_rovneho_segmentu+delka_sikmeho_segmentu)]){
        color ("Khaki")translate ([1,0,0]) rotate ([0,0,0]) cylinder(h=0.95*delka_sikmeho_segmentu, r1=1.5, r2=1.0, $fn=50);
        color ("Khaki")translate ([1,0,0]) rotate ([0,0,0]) sphere(1.5, $fn=50);
        color ("Yellow")translate ([0,0,delka_sikmeho_segmentu*0.5]) rotate ([90,0,90]) cube([sirka,delka_sikmeho_segmentu,tloustka], center=true);    
        color ("Gold")translate ([0,0,-0.5*delka_rovneho_segmentu]) rotate ([90,0,90]) cube([sirka+3,delka_rovneho_segmentu,tloustka], center=true);
    }//center translate
    
}//module

module drzak_A(){
    
    uchyt_delka_rovneho_segmentu=29;
    uchyt_delka_sikmeho_segmentu=37;
    uchyt_sirka=25;
    uchyt_tloustka=2.8;

    //podpera
difference(){
    color ("green") translate([0,0,0]) rotate([90,45,0]) cube([20,20,4], center=true);
    color("grey")  translate([0,0,-8-0.5*uchyt_tloustka]) rotate([0,0,0]) cube([30,30,20], center=true);
    }
    
    //to co se bude lepit ke stolu
    translate([0,0,uchyt_tloustka*0.5]) rotate([0,0,90]) cube([/*uchyt_sirka*/20,80,uchyt_tloustka], center=true);
    
    //samotna uchytka
    translate([0,0,0.5*uchyt_delka_rovneho_segmentu+0.5*uchyt_delka_sikmeho_segmentu])
        uchyt_repra(delka_rovneho_segmentu=uchyt_delka_rovneho_segmentu,
        delka_sikmeho_segmentu=uchyt_delka_sikmeho_segmentu,
        sirka=uchyt_sirka,
        tloustka=uchyt_tloustka);
        
    color("black")    
        
        rotate([0,0,0]) translate([2,3,uchyt_tloustka])
            linear_extrude(1)
                text(text=str("DES.VER.2"), size=5);
    color("black")    
        rotate([0,0,0]) translate([2,-8,uchyt_tloustka])
            linear_extrude(1)
                text(text=str("CEILING -->"), size=5);
    }//module




module drzak_B(){
    
    
    
    }