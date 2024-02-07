
 
 module base(){
 linear_extrude(height = 20, center = true, convexity = 10, twist = 0)
  polygon( points=[ 
  [-11,0], //0
  [-13,0], //1
  [-9,19], //2
  
  [-34,19], //3
  [-32,35], //4
  
  [-32,35], //5
  [-32,21], //6
  [8,21], //7 
  [8,25], //8
  [10,25], //9
  
  [10,19], //10
  [9,19], //11
  [13,0], //12
  [11,0], //13
  [6,19], //14
  
  [-6,19], //15
  
  [-9,21], //16
  [9,21]], //17
  
  
  //paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]],convexity=10);
  
  paths=[[0,1,2,16,17,11,12,13,14,15]],
  convexity=10);
  }//mod
  
module tubus(){
    difference(){
        difference(){
            cylinder(h=15,d=9.5,center=true);
            cylinder(h=15,d=8.0,center=true);
            }//diff
    translate ([0,4.5,0]) cube([1,3,15],center=true);
        }//diff
    }//mod
    
module support(){
 linear_extrude(height = 5, center = true, convexity = 10, twist = 0)
  polygon( points=[ 
  
  [0,0], //
  [-9.5,0], //
  [-9.5,9.5]], //
   
  
  paths=[[0,1,2,0]], convexity=10);
    
    }//mod
    
module supporttubus(){
    difference(){
        difference(){
            cube([18,18,20],center=true);                
            translate ([0,6.5,0]) rotate ([0,90,-40]) cylinder(h=60,d=8.0,center=true);
        }//diff
    color("Red")translate ([7,7,0]) cube([10,10,1],center=true);    
    }//diff outer
    
    }//mod
    
    
    base();
    /*
    translate([7.1,25,-0]) rotate ([0,90,-45]) translate ([0,0,-4]) tubus();
    translate([6,20,0]) support();
    */
    translate([-0.0,28,0])supporttubus();