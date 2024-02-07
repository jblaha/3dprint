module arc2d_double(radius1, radius2, angle1, angle2)
{
    points1 = [for(a = [angle1:1:angle2]) [radius1 * cos(a), radius1 * sin(a)]];
    points2 = [for(a = [angle1:1:angle2]) [radius2 * cos(a), radius2 * sin(a)]];
    square_patch_size_x=abs(radius1-radius2);
    square_patch_size_y=abs(radius1-radius2);
        
    difference(){
        difference(){
            polygon(concat([[0, 0]], points1));
            polygon(concat([[0, 0]], points2));
            }//union
        
        union(){
            color("red")
                translate([radius2 * cos(angle1), radius2 * sin(angle1),0])
                    square([square_patch_size_x,2*square_patch_size_y], center=false);
            color("red")
                translate([-square_patch_size_y+radius2 * cos(angle2),radius2 * sin(angle2),0])
                    square([square_patch_size_x,2*square_patch_size_y], center=false);
            }//union
    }//difference
}//module   

module arc_top_2d(radius, height, angle)
{
    angle1=-0.5*angle;
    angle2=+0.5*angle;
    points = [for(a = [angle1:0.5:angle2]) [radius * cos(a), radius * sin(a)]];
        
    //polygon(concat([[-1*radius * cos(angle1), radius-height],[+1*radius * cos(angle2), radius-height]], points));
    polygon(points);
    
}//module   



arc_top_2d(25,10,40);