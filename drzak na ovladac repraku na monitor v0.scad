complete();

module complete(){
    
    union(){
        color("Red") translate([-10,42/2+4,0]) cube([10,2,2.6]);
        cutoff_base();
        }//uni
    
    }//mod
module cutoff_base(){
    difference()
    //union()
    {
        scale_base=260/215;
        scale([scale_base,scale_base,scale_base]) base();
        union(){
            translate ([-30,25,-25])cube([50,80,50]);
            translate ([-61,22,-25])cube([50,80,50]);
            //translate ([-61,25,-25])cube([50,80,50]);
            }//uni

        }//diff
}//module

module base(){
 linear_extrude(height = 25, center = true, convexity = 10, twist = 0)
  polygon( points=[ 
  [-11,0],
  [-13,0],
  [-9,19],
  
  [-40+6+0*12+0,19+0],
  [-40+6+0*12+2,35+0],
  
  [-38+6+0*12+2,35+0],
  [-38+6+0*12+0,21+0],
  [38-30+0*12+0,21],
  [38-30+0*12+0,35-10],
  [40-30+0*12,35-10],
  
  [40-30+0*12,19],
  [9,19],
  [13,0],
  [11,0],
  [6,19],
  
  [-6,19]],
  
  paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]],
  convexity=10);
  
  }