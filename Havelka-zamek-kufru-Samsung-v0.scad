$fn=150;

difference(){
    cube([47,19,8.5], center=true); //main body 
        
    union(){
        color ("red") translate([27/2,0,5/2])cube([20,19,5], center=true); //madylko
        color ("red") translate([47/2-4.4,19/2-3,0])cube([1,1,20], center=true); //hole1
        color ("red") translate([47/2-4.4,-19/2+3,0])cube([1,1,20], center=true); //hole2
        color ("red") translate([47/2-4.4,0,1])cube([4,16,3], center=true); //snizeni u hole1 a hole2 zeshora
        color ("red") translate([47/2-4.4,0,-5/2-2])cube([4,16,3], center=true); //snizeni u hole1 a hole2 zespoda
        color ("red") translate([-47/2+4+9,0,6])cylinder(h=5, r=7, center=true); //ozdoba za zamecek
        color ("red") translate([-47/2+4+9,0,0])cube([9,2,15], center=true); //fake klicenka
        color ("red") translate([27/2+5,0,5/2])cylinder(h=5, r=19, center=true); //vykrojeni madla
        color ("red") translate([-27/2-6.5,0,0])rotate([0,90,0])cylinder(h=7, r=2.5, center=true);  //vodici dira vepredu nalezato

    }//union
    
}//difference

//color ("red") translate([-47/2+4+9,0,2])cube([9,2,2], center=true); //fake klicenka