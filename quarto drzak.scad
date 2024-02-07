rozmer_drzaku_x=96;rozmer_drzaku_y=96;

//lista_drzaku();
jedna_pozice_stojanku_s_pinem();

/*
difference(){
// testovani profilu supliku - vygeneruje jenom uzky profil a ne cely vec
translate([0,0,46])
    rotate([0,90,0])
        drzak_suplik();

translate([0,0,32]) cube([96,96,96], center=true);

}
*/

module drzak_suplik(){

    //translate([0,0,0.1])
    drzak_samotny();

    translate([0,-1*rozmer_drzaku_y*0.5,-1.5])
        rotate([0,90,180])
            lista_drzaku();

    translate([0,rozmer_drzaku_x*0.5,-1.5])
        rotate([0,90,0])
            lista_drzaku();

    translate([-1*rozmer_drzaku_x*0.5,0,-1.5])
        rotate([0,90,90])
            lista_drzaku();
}

module lista_drzaku(){

    translate([0,-6,0])
    difference(){
        difference(){
            color("pink", 0.9)
                linear_extrude(height = rozmer_drzaku_x, center = true, convexity = 10, twist = 0)
                    square(6);
                
            color("dimgrey", 0.6)
                linear_extrude(height = rozmer_drzaku_x, center = true, convexity = 10, twist = 0)
                    square(4); //nebo 4.5
            }
            

    color("red", 0.8)
        translate([4,0,0])
            linear_extrude(height = rozmer_drzaku_x, center = true, convexity = 10, twist = 0)
                square(0);
        }
}


module drzak_samotny(){
    color("grey", 0.5)
        cube([rozmer_drzaku_x,rozmer_drzaku_y,3], center=true);
    
}

//jedna_pozice_stojanku();


module jedna_pozice_stojanku_s_pinem(){
    vyska_stojanku = 5;
    sirka_stojanku = 1;
    polomer_stojanku = 9.1;
    
    offset_pinu_od_stredu = polomer_stojanku+sirka_stojanku;

    color("cyan", alpha=0.5)
        cube([25,25,1], center=true);
    
    color("blue")
        translate([0,0.5*sirka_stojanku+polomer_stojanku,vyska_stojanku/2])
            cylinder(h=vyska_stojanku, r=sirka_stojanku, center=true);
    
    mirror([0,1,0])
        color("red")
        translate([0,0.5*sirka_stojanku+polomer_stojanku,vyska_stojanku/2])
            cylinder(h=vyska_stojanku, r=sirka_stojanku, center=true);
    
    color("black")    
        translate([-8,-4,0.1])
            linear_extrude(1)
                text(text=str(polomer_stojanku), size=7);
          

}
module jedna_pozice_stojanku(){

    vyska_stojanku = 5;
    sirka_stojanku = 2;
    polomer_stojanku = 9.1;

    difference(){
    color("cyan", alpha=0.5)
        cube([25,25,1], center=true);
    
    color("white")    
        translate([-8,-4,-0.0])
        linear_extrude(1)
                text(text=str(polomer_stojanku), size=7);
    }      
    
        
    rotate(a=[0,0,30])
        color("red")
            rotate_extrude(angle=90)
                translate([polomer_stojanku, 0])
                    square([sirka_stojanku,vyska_stojanku]);
       

    mirror([0,1,0])
        rotate(a=[0,0,60])
            color("green")
                rotate_extrude(angle=90)
                    translate([polomer_stojanku, 0])
                        square([sirka_stojanku,vyska_stojanku]);
}

/*
color("cyan")
    translate([40, 0, 0])
        rotate_extrude($fn = 80)
            text("  J");

*/