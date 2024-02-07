/*

*/
//magnet_bed();
drzak_A();

module magnet_bed(dia=19){
    
    diff=3;
    
    color ("Blue") translate([0,0,0]) rotate ([0,90,0]) cylinder(h=8, d=dia, center=true, $fn=50);
    color ("Blue") translate([0,0,dia+diff]) rotate ([0,90,0]) cylinder(h=8, d=dia, center=true, $fn=50);
    color ("Blue") translate([0,0,2*(dia+diff)]) rotate ([0,90,0]) cylinder(h=8, d=dia, center=true, $fn=50);
}//

module uchyt_repra(delka_rovneho_segmentu=20, delka_sikmeho_segmentu=37,sirka=25,tloustka=2.8){
    //delka_rovneho_segmentu=20;
    //delka_sikmeho_segmentu=37;
    //sirka=25;
    //tloustka=2.8;
    // -4 u promenne sirka je tam pro zuzeni, aby to nebylo sirsi nez zakladna
    
    translate([0,0,-0.5*(-delka_rovneho_segmentu+delka_sikmeho_segmentu)]){
        //color ("Lightgreen")translate ([0,(-6-1+sirka)/2,delka_sikmeho_segmentu-tloustka/2]) rotate ([90,0,0]) cylinder(h=sirka-4-3, r=tloustka/2, $fn=50);
        
        //color ("Lightgreen")translate ([0,(-6-1+sirka)/2,-delka_rovneho_segmentu]) rotate ([0,0,90]) cylinder(h=-tloustka/2+delka_sikmeho_segmentu+delka_rovneho_segmentu, r=tloustka/2, $fn=50);
        //color ("Lightgreen")translate ([0,-(-6-1+sirka)/2,0-delka_rovneho_segmentu]) rotate ([0,0,90]) cylinder(h=-tloustka/2+delka_sikmeho_segmentu+delka_rovneho_segmentu, r=tloustka/2, $fn=50);
        
        //color ("Green")translate ([0,(-6-1+sirka)/2,delka_sikmeho_segmentu-tloustka/2]) sphere(r=1*tloustka/2, $fn=50);
        //color ("Green")translate ([0,-(-6-1+sirka)/2,delka_sikmeho_segmentu-tloustka/2]) sphere(r=1*tloustka/2, $fn=50);
        
        color ("Khaki")translate ([1,0,0]) rotate ([0,0,0]) cylinder(h=0.95*delka_sikmeho_segmentu, r1=1.5, r2=1.0, $fn=50);
        color ("Yellow")translate ([0,0,(-0.5*tloustka+delka_sikmeho_segmentu)*0.5]) rotate ([90,0,90]) cube([sirka-6-tloustka/2,delka_sikmeho_segmentu-tloustka/2,tloustka], center=true);    
        color ("Gold")translate ([0,0,-0.5*delka_rovneho_segmentu]) rotate ([90,0,90]) cube([sirka-6/*+3*/,delka_rovneho_segmentu,tloustka], center=true);
    }//center translate
    
}//module

module uchyt_tabule(delka_rovneho_segmentu=20, delka_sikmeho_segmentu=37,sirka=25,tloustka=2.8){
    //delka_rovneho_segmentu=20;
    //delka_sikmeho_segmentu=37;
    //sirka=25;
    //tloustka=2.8;
    // -4 u promenne sirka je tam pro zuzeni, aby to nebylo sirsi nez zakladna
    
    
    
    
    translate([0,0,-0.5*(-delka_rovneho_segmentu+delka_sikmeho_segmentu)]){
        //color ("Lightgreen")translate ([0,(-6-1+sirka)/2,delka_sikmeho_segmentu-tloustka/2]) rotate ([90,0,0]) cylinder(h=sirka-4-3, r=tloustka/2, $fn=50);
        
        //color ("Lightgreen")translate ([0,(-6-1+sirka)/2,-delka_rovneho_segmentu]) rotate ([0,0,90]) cylinder(h=-tloustka/2+delka_sikmeho_segmentu+delka_rovneho_segmentu, r=tloustka/2, $fn=50);
        //color ("Lightgreen")translate ([0,-(-6-1+sirka)/2,0-delka_rovneho_segmentu]) rotate ([0,0,90]) cylinder(h=-tloustka/2+delka_sikmeho_segmentu+delka_rovneho_segmentu, r=tloustka/2, $fn=50);
        
        //color ("Green")translate ([0,(-6-1+sirka)/2,delka_sikmeho_segmentu-tloustka/2]) sphere(r=1*tloustka/2, $fn=50);
        //color ("Green")translate ([0,-(-6-1+sirka)/2,delka_sikmeho_segmentu-tloustka/2]) sphere(r=1*tloustka/2, $fn=50);
        
        //color ("Khaki")translate ([1,0,0]) rotate ([0,0,0]) cylinder(h=0.95*delka_sikmeho_segmentu, r1=1.5, r2=1.0, $fn=50);
        color ("Yellow")translate ([0,0,(-0.5*tloustka+delka_sikmeho_segmentu)*0.5]) rotate ([90,0,90]) cube([sirka-6 /*-tloustka/2*/,delka_sikmeho_segmentu-tloustka/2,tloustka], center=true);    
        color ("Gold")translate ([0,0,-0.5*delka_rovneho_segmentu]) rotate ([90,0,90]) cube([sirka-6/*+3*/,delka_rovneho_segmentu,tloustka], center=true);
    }//center translate
    
}//module

module drzak_A(){
    
    uchyt_delka_rovneho_segmentu=29;
    uchyt_delka_sikmeho_segmentu=37;
    uchyt_sirka=25;
    uchyt_tloustka=2.8;

    //podpera
/*
difference(){*/
    
    /*color("grey")  translate([0,0,-8-0.5*uchyt_tloustka]) rotate([0,0,0]) cube([60,40,23], center=true);
    }*/
    
    //to co se bude lepit ke stolu
    translate([-5,0,uchyt_tloustka*0.5]) rotate([0,0,90]) cube([/*uchyt_sirka*/ 20 ,15,uchyt_tloustka], center=true);
    
    //samotna uchytka
    prodlouzeni=14;
    translate([3.5,0,prodlouzeni/2+0.5*uchyt_delka_rovneho_segmentu+0.5*uchyt_delka_sikmeho_segmentu])
        uchyt_repra(delka_rovneho_segmentu=prodlouzeni+uchyt_delka_rovneho_segmentu,
        delka_sikmeho_segmentu=uchyt_delka_sikmeho_segmentu,
        sirka=uchyt_sirka,
        tloustka=uchyt_tloustka);

 
    //kus pro magnet
    difference(){
    prodlouzeni=10;
    uchyt_sirka=26.4;    
        union(){
            color ("green") translate([-02.8,0,37]) rotate([90,90,0]) cube([72,10,4], center=true);
            translate([-10,0,0.5*prodlouzeni+0.5*uchyt_delka_rovneho_segmentu+0.5*uchyt_delka_sikmeho_segmentu])
            uchyt_tabule(delka_rovneho_segmentu=prodlouzeni+uchyt_delka_rovneho_segmentu,delka_sikmeho_segmentu=uchyt_delka_sikmeho_segmentu,sirka=uchyt_sirka,tloustka=3+uchyt_tloustka);
            }//union
    translate([-5.4,0,12.9]) magnet_bed();
    }//diff
//translate([-9,0,30]) magnet_bed();
        
    //infotexty
    //color("black") rotate([0,0,0]) translate([2,3,uchyt_tloustka]) linear_extrude(1) text(text=str("DES.VER.4"), size=5);
    //color("black") rotate([0,0,0]) translate([2,-8,uchyt_tloustka]) linear_extrude(1) text(text=str("CEILING -->"), size=5);
    }//module




module drzak_B(){ }//mod