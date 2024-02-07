    //  Lens Holders & Spiral Baffles for Optical Benches \\
   // Items; stand-alone-lens-holder-std, spiral baffle,   \\
  //   spiral-baffle-cap-holder, spiral-baffle-plug-holder  \\
 //   Options; guide-rods, set-screws, retaining-rings       \\
//        Rob Sheldon  30-Aug-2016  (OpenSCAD 15.03)          \\
//OPTIONS with //* are easily changed w/o affecting others    \\
//============================================================\\

//====speed up the visualization ===
speedup = 11; //* 11=fast visualize, 1=slow final print resolution

// USE/OMIT fasteners
 retain = true; //* use a threaded retaining ring to hold lens
 setscr = true; //* use a set-screw and nut-trap to hold lens
 guider = true;//* use a vertical guide-rod stand
 guidss = true; //* use a set screw on the guide-rod

//MACHINE VARIABLES
eps=.01; //a small number to spare OpenSCAD zero-thick boundary
mep=0.3; //Ultimaker2 horiz. resolution (depends on print head)
mina=2; //* minimum angle a facet makes with neighbor; small->smooth
Pi = 3.1415926535897;

//OUTER-TUBE (not lens holder)
x=38.1; //  Outer tube diameter       (38.1mm = 1-1/2")
y=38.1; //* Total length: 101.6=4"; 38.1=1.5", 152.4=6" 
        //* Outer tube+threads; y-z = just baffle length
z=12.7; //  Threaded z-distance (12.7mm = 1/2")
w=3.17; //  wall r-thickness (3.17mm = 1/8")
bpit=2.5;//* baffle pitch = revol/inch = 2.5

//Square PIPE-THREADS (on outer tube)
hRadO=(x+w)/2;   //outer radius of pipe threads
hRadI=(x-eps)/2;//inner radius of pipe threads
hLen=z+mep;    //length of threaded cylinder
hpit=1;       //helix pitch = revolutions per inch; 1 rev/1"
hN=8;        //number of sectors (where DNA=2) 
taper=3;    //* z-mm of top thread tapering (shrinking radius)
hGap=8;    //gap between threads (arbitrary units due to skew)
          //hGap depends on twist, sector, and radius, so 
         //use the test-thread routine to find the best hGap
thread_expand = 1.2; //extra clearance for female threads

//LENS-HOLDER (inner tube, no baffle)
yy  = 9;      //* lens-holder length or z-thickness
v   = 25.4;  //* Inner filter diameter (25.4mm = 1")
thr = 35;   // The "peakedness" of the thread profile, 0=steep, 90=flat
lpit= 20;  //  Pitch of retainer threads, revolutions / inch
lipz= 1.5;//* Lens Holder lip z-thickness
lipr= 2; //* Lens Holder lip r-thickness (v-lipr)--> optical diameter
ltxt="1\"-holder";  //* description of lens-holder; diameter
lfontxt="LiberationSerif"; //* your favorite font here
tgap = 3*mep/4; //gap between male - female threads; 0.75*0.3

//SET-SCREW (metal hardware #4-40 3/8"-1/2" works well)
a=3;   //Set-Screw Diameter
b=6;   //Set-Screw Nut Diameter (b+3 < y)!
c=3;   //Set-Screw Nut Thickness

//GUIDE-ROD
d=12.7;     //* Guide Rod Diameter (12.7mm = 1/2")
e=19;      //* Guide Rod holder Length   (19.0mm = 3/4")
rodpos=0; //* Guide Rod at:-1.0=female end, 0=middle, 1.0=male end
gtxt="1/2\" i";  //* embossed description of guide-rod; 1/2" imperial units
gfontxt="LiberationSansNarrow"; //* your favorite font here

//NOTATION EMBOSSED on Cylinder
btxt="1x1.5\"-baffle";  //* embossed description of baffle;  size
bfontxt="LiberationSansNarrow"; //* your favorite font here

//KNURLED THUMB-SCREW (fits over metal screw head)
f=3;   //Thumb-Screw Head Height
g=6;   //Thumb-Screw Head Diameter
i=3;   //Thumb-Screw Diameter

//====sneaky stuff to speed up the visualization===
$fs=speedup*mep;  //smallest facet is resolution of printer
$fa=speedup*mina; //smallest facet angle allowed
thread_res = speedup*1.; //usually 1.0, smaller=finer

///this flattens the base, which shouldnt be necessary
///difference(){union(){

//======= M A I N ============================================ 
echo("This design doesn't include metal hardware shown in pink");

    // CHOOSE WHICH ITEMS TO MAKE BY UNCOMMENTING 
  translate([0,    0,  0])spiral_baffle(guiderod=guider);
  translate([w-x,w-x,0])lens_holder_plug(setscrew=setscr,retainer=retain);
  translate([w-x,x-w,0])lens_holder_cap(setscrew=setscr,retainer=retain);
  translate([x-w,w-x,0])lens_hold_flush_plug(retainer=retain);
  translate([+x+w,+x+w,0])rotate([0,0,180])
     lens_holder_std(guiderod=true,setscrew=setscr,retainer=retain);

//   print/slice these separately with thin top layer
 if (retain){ //these are the retainer rings
//   translate([0,-x-w,0])retain_ring(thick=5);
//   translate([-x-w,0,0])retain_ring(thick=3);
  // translate([-v-w-w-x,0,0]) retain_ring(thick=2);
  }
 //* * * prints separately in center of tube if there's room. * *
  if (guider) translate([0,0,0])thumbscrew(); 


 ///}//end-union
 ///translate([0,0,-75-eps])cube([150,150,150],center=true);
 ///}//end-diff kludge

// + + + test square helicoid thread parameters (see below) + + + + +
// test_threads(); //if changing parameters on square_helicoid
//==================================================================

module retain_ring(thick=3){
  difference(){
   union(){
     cylinder(thick,v/2,v/2);
     male_retain_thread(thickness=thick);
    for (i=[0:2]){
     #rotate([0,0,i*120])translate([-v/2,0,thick-mep])finger_hold();
    }//end-for
   }//end-union
   union(){
    translate([0,0,-eps])cylinder(2*thick+3*lipz,(v-lipr)/2,(v-lipr)/2);
   }//end-union
  }//end-difference
}//end-retain-ring

module finger_hold(){
  difference(){
    intersection(){
      hull(){
        cube([lipr*2,w,2*lipz]);
        translate([0,-w,-1])cube([lipr*2,3*w,1]);
      }//end-hull
      translate([v/2,0,-lipz])cylinder(4*lipz,v/2,v/2);
    }//end-intersect
    translate([(v)/2,0,-lipz])cylinder(4*lipz,(v-lipr)/2,(v-lipr)/2);
    translate([-x,-x,-1-eps])cube([2*x,2*x,1]);
  }//end-diff
}//end-finger-hold

module lens_holder_plug( //total length = yy + z
    setscrew=true
    ,retainer=false
 ){
 difference(){
  union(){
     //lens-holder cylinder
   cylinder(yy,(v/2)+w,(v/2)+w);
     //threaded cylinder for baffle 
   translate([0,0,yy-eps])cylinder(z,x/2,x/2);
      //transition to avoid print overhang
   translate([0,0,yy-3+eps])cylinder(3,v/2+w,x/2);
   translate([0,0,yy])male_pipe_thread();
   if (setscrew) translate([0,(v/2+w),0])set_screw(add=true,offset=yy/2);
   notate(text=ltxt,font=lfontxt);
  }//end-union add
  union(){
      //optic thru
   translate([0,0,-1])cylinder(z+yy+2,(v-lipr)/2,(v-lipr)/2); 
      //optic thread thru
   translate([0,0,yy])cylinder(z+1,(x-w)/2,(x-w)/2); 
      // lens-holder thru
   if (setscrew) {
    translate([0,0,-eps])cylinder((yy-lipz)/2,(v/2),(v*1.03)/2); 
    translate([0,0,(yy-lipz)/2])cylinder((yy-lipz)/2,(v*1.03)/2,(v/2));
    translate([0,(v/2+w),0])set_screw(add=false,offset=(yy)/2,up=90);
    translate([-3,v/2+2.5*w,.5])rotate([180,0,0])logo(size=6);
   }
   else { // else don't put groove & etch logo in cylinder
    translate([0,0,-eps])cylinder((yy-lipz),v/2,v/2);
    rotate([0,0,180])notate(text="W",font="Wingdings");
   }//end-if-setscrew
   if (retainer) translate([0,0,-eps])female_retain_thread(thickness=yy-lipz+mep);
  }//end-union
 }//end-difference
         // *  *  *  * the baffle in the tube  *  *  *  *
 bafr=x-v;// baffle diameter that leaves "v" open in the center.
 if (bafr < 0) {bafr=0.; lipr=0; echo("No BAFFLE!");} 
 else {
  Twi=bpit*(-360)*z/25.4;
  translate([0,0,yy-mep])
   intersection(){ 
    linear_extrude(
            height=z,
            center=false,
            convexity=10,
            twist=Twi,
            slices=10*bpit*z,
            scale=1.0)
        translate([x/2-bafr/4+1,0,0])circle(1+bafr/4);
    cylinder(z+eps,(x/2-mep),(x/2-mep));
   }//end-intersection
 }//end-if-bafr  
}//end-lens_holder    

module lens_hold_flush_plug( //no setscrew, sits inside the threaded section
    retainer=false
 ){
 yyz=(yy>z?yy:z);
 difference(){
  union(){
     //lens-holder cylinder
   cylinder(yy,(v/2)+w,(v/2)+w);
     //threaded cylinder for baffle 
   cylinder(z,x/2,x/2);
   male_pipe_thread();
   notate(text=ltxt,font=lfontxt);
  }//end-union add
  union(){
      //optic through
   translate([0,0,-1])cylinder(yy+z+2,(v-lipr)/2,(v-lipr)/2); 
      //threaded optic through
   translate([0,0,yy])cylinder(z+1,(x-w)/2,(x-w)/2); 
      // lens-holder through
   translate([0,0,-eps])cylinder((yy-lipz),v/2,v/2);
   rotate([0,0,180])notate(text="W",font="Wingdings");
   if (retainer) translate([0,0,-eps])female_retain_thread(thickness=yy-lipz+mep);
  }//end-union minus
 }//end-difference
}//end-lens_hold_flush_plug    

module lens_holder_cap(
    setscrew=true
    ,retainer=false
 ){
 difference(){
  union(){
   cylinder(yy,(v/2)+w,(v/2)+w); //lens-holder
   translate([0,0,yy-eps])cylinder(z,w+x/2,w+x/2);//female ext
      //transition to avoid print overhang
   translate([0,0,yy-3+eps])cylinder(3,v/2+w,w+x/2);
   if (setscrew) translate([0,(v/2+w),0])set_screw(add=true,offset=(yy)/2);
   notate(text=ltxt,font=lfontxt);
  }//end-union
  union(){   //optic thru
   translate([0,0,-1])cylinder(yy+z+2,(v-lipr)/2,(v-lipr)/2); 
      //optic thru female extension
   translate([0,0,yy-mep])cylinder(z+1,(x+mep)/2,(x+mep)/2); 
      // lens-holder thru
   if (setscrew) {
    translate([0,0,-eps])cylinder((yy-lipz)/2,(v/2),(v*1.03)/2);
    translate([0,0,(yy-lipz)/2])cylinder((yy-lipz)/2,(v*1.03)/2,(v/2)); 
    translate([0,(v/2+w),0])set_screw(add=false,offset=(yy)/2,up=90);
    translate([-3,v/2+2.5*w,.5])rotate([180,0,0])logo(size=6); //logo engraved
   }//end-setscrew  
   else { 
    translate([0,0,-eps])cylinder((yy-lipz),v/2,v/2); //straight
    rotate([0,0,180])notate(text="W",font="Wingdings"); //logo engraved on cylinder
   }   
   translate([0,0,yy-mep])female_pipe_thread();
   if (retainer) translate([0,0,-eps])female_retain_thread(thickness=yy-lipz+mep);
  }//end-union
 }//end-difference
}//end-lens-holder-cap 

module lens_holder_std(
     guiderod=true
    ,setscrew=true
    ,retainer=false
  ){
 rodmid=((yy-d-w)*(rodpos+1)>0?(yy-d-w)*(rodpos+1)/2:0.0);
 difference(){
  union(){
   cylinder(yy,(v/2)+w,(v/2)+w); //outer cylinder
   notate(text=ltxt,font=lfontxt);
   if (setscrew) translate([0,(v/2+w),0])set_screw(add=true,offset=yy/2);
   if (guiderod) {
       translate([v/2+w/2,0,rodmid])guide_rod(add=true,bafl=false,ofst=rodmid);//rod-holder
   }//end-if-guiderod
  }//end-union
  union(){
   cylinder((yy*2),(v-lipr)/2,(v-lipr)/2); //optic through
   if (setscrew) { //conical
     translate([0,0,-eps])cylinder((yy-lipz)/2,(v/2),(v*1.03)/2);
     translate([0,0,(yy-lipz)/2])cylinder((yy-lipz)/2,(v*1.03)/2,(v/2));
     translate([0,(v/2+w),0]) set_screw(add=false,offset=yy/2,up=0);
     translate([-3,v/2+2.5*w,.5])rotate([180,0,0])logo(size=6);
   } 
   else { //straight
     translate([0,0,-eps])cylinder((yy-lipz),v/2,v/2);
   }//end-if-setscrew    
   if (guiderod) {
       translate([v/2+w/2,0,rodmid])guide_rod(add=false,bafl=false,ofst=rodmid);
       translate([10,5,rodmid+.5])rotate([180,0,-90])logo(size=10);
   }
   else {
      translate([0,0,1])textCylinder( //logo engraved
            text="W",
            r=v/2+w-.5,
            h=1,
            size=7,
            rotate=[0,0,145],
            font="Wingdings", 
            spacing=.99, 
            valign="bottom"); 
   };//end-if-guiderod
   if (retainer) translate([0,0,-eps])female_retain_thread(thickness=yy-lipz+mep);
  }//end-union
//  translate([-x-w,0,-eps])cube([2*x,2*x,2*y]); // see thread profile
 }//end-difference
 if (guider) translate([0,0,0])thumbscrew(); 
}//end-lens_holder-std

module spiral_baffle(guiderod=true){
 rodmid=((y-z-d-w)*(rodpos+1)>0?(y-z-d-w)*(rodpos+1)/2:0.0);
 union(){ 
  difference(){
   union(){
    cylinder(y-z,(x/2)+w,(x/2)+w); //outer tube cylinder
    cylinder(y,(x/2),(x/2));     //male extension
    translate([0,0,y-z])male_pipe_thread();
    if (guiderod) 
        translate([x/2+w/2,0,rodmid])
           guide_rod(add=true,bafl=true,ofst=rodmid); //addition
    translate([0,0,1])textCylinder( //baffle text embossed
                text=btxt,
                r=x/2+w-.5,
                h=1,
                size=5,
                rotate=[0,0,-45],
                font=bfontxt, 
                spacing=.99, 
                valign="bottom");
   }//end-union
   union(){
    translate([0,0,-1])cylinder((y+2),(x-w)/2,(x-w)/2);//optic through
    translate([0,0,-1])cylinder((y-z-w-w+1),mep+x/2,mep+x/2); //female thru
    translate([0,0,y-z-w-w-1-mep])cylinder((w+2),x/2-mep,(x-w-1)/2);//transition
    translate([0,0,-eps])female_pipe_thread();
    if (guiderod) {
        translate([x/2+w/2,0,rodmid])
           guide_rod(add=false,bafl=true,ofst=rodmid);
    } else {
        translate([0,0,1])textCylinder( //logo engraved
                text="W",
                r=x/2+w-.5,
                h=1,
                size=7,
                rotate=[0,0,180],
                font="Wingdings", 
                spacing=.99, 
                valign="bottom");
    }//end-if-guiderod
   }//end-union
  }//end-difference-tube
          // *  *  *  * the baffle in the tube  *  *  *  *
  bafr=(x-v)/4;// baffle radius that leaves "v" open in the center.
  if (bafr < 0) {bafr=0.; lipr=0; echo("No BAFFLE!");} else {
   Twi=bpit*(-360)*(y-z)/25.4;
   translate([0,0,z-mep])rotate([0,0,180]) 
    intersection(){ 
     linear_extrude( //baffle
        height=y-z,
        center=false,
        convexity=10,
        twist=Twi,
        slices=10*bpit*z,
        scale=1.0)
        translate([x/2-bafr+1,0,0])circle(1+bafr);
     union(){ //trim baffle to fit
      translate([0,0,-eps])
       cylinder(y-z-z+eps,(x/2+w-mep),(x/2+w-mep));
      translate([0,0,y-z-z])
       cylinder(z+eps,(x/2-mep),(x/2-mep));
     }//end-union for baffle-outer-cylinder
    }//end-intersection
   }//end-if-bafr  
  }//end-union w/threaded tube
 }//end-spiral-baffle

module female_pipe_thread()
{ square_helicoid(
      rOut=hRadO+mep,
      rIn=hRadI,
      Length=hLen+3,
      DegPit=hpit,
      N=hN,
      Gap=hGap*thread_expand,
      Taper=0);
}
module male_pipe_thread()
{ difference(){
    square_helicoid(
        rOut=hRadO-mep-mep,
        rIn=hRadI,
        Length=hLen,
        DegPit=hpit,
        N=hN,
        Gap=hGap,
        Taper=taper+.5);
    union(){     //trim top + bottom
        translate([0,0, -1-eps])cube([x+3*w,x+3*w,2],center=true);
        translate([0,0,z+1+eps])cube([x+3*w,x+3*w,2],center=true);
    }//end-union
   }//end-difference
}//end-male_pipe_thread

module male_retain_thread(thickness=2)
{screw_thread(
      od = (v+ tan(thr)*50.4/lpit) //outer diameter 
     ,st = 25.4/lpit //step, traveling length per rev
     ,lf0 =thr //Degrees tooth profile 0=xy, 90=z
     ,lt = thickness //z-length of thread
     ,rs = 0.5*thread_res //resolution one face, smaller=finer,
     ,cs = 0); //countersink style
}

module female_retain_thread(thickness=12.7)
{screw_thread(
     od = (v+ tan(thr)*50.4/lpit+tgap)   //outer diameter 
    ,st = (25.4/lpit) //step, traveling length per rev
    ,lf0 =thr        //Degrees tooth profile 0=xy, 90=z
    ,lt =thickness  //z-length of thread
    ,rs = 0.5*thread_res    //resolution one face of perimeter "0.5"
    ,cs = 0);     //countersink style
}

module gnotate(text="?"){ // put writing on the side 
  linear_extrude(height=1) text(text=text,font=gfontxt,size=5);
} //end-notate

module guide_rod(add=true,bafl=true,ofst=0.0){
  offs= 0.5 * max(b+3,d+w);//center setscrew if possible
  zz=(((rodpos<=-1)||!bafl)? 0.0:ofst);
  difference(){
   union(){
    if (add){ //addition
        //rod-holder base
      hull(){
      translate([e/2-w/4,0,(d+w)/4.0])cube([e, d+w,(d+w)/2.0], center = true);
      translate([1-w/4,0,1-zz])cube([2,d+w,2],center=true);
      } 
        //notation
     translate([0,.5-(d+w)/2,1])rotate([90,0,0])gnotate(text=gtxt);
        //rod-holder cylinder
     translate([e/2-w/4,0,(d+w)/2])rotate([0,90,0])cylinder(e,(d+w)/2,(d+w)/2,center=true);
        //set-screw
     if (guidss) translate([e-(b+3)/2-w/4,(d/2+w/4),0])set_screw(add=true,offset=offs);
    }//end-if-add
   }//end-union
  union(){
   if (!add) { //subtraction
       //snug guide rod hole
    translate([e/2+w/2,0,(d+w)/2])rotate([0,90,0])cylinder(e+1,(d+.5)/2,(d+.5)/2,center=true);
       //set-screw subtraction
    if (guidss) translate([e-(b+3)/2-w/4,(d/2+w/4),0])set_screw(add=false,offset=offs,up=0);
       // logo engraved
    angle = -1*atan2(zz+eps,e);
       #translate([e/2+w+w,5,(.5-zz*.17)])
          rotate([0,angle,0])
            rotate([180,0,-90])
             logo(size=10);
       // some rods need a vertical screw hole, which goes here
    translate([e/2+w/4,0,(d+w)/2])rotate([0,90,0])cylinder(e,(a+1)/2,(a+1)/2,center=true); 
   }else{ //round-off error needed some cleanup
     translate([0,0,-10-eps-zz])cube([100,100,20],center=true);
   }//end-if-!add
  }//end-union
 }//end-difference
}//end-guide_rod

module notate(  // put writing on the lens-holder cylinder
   text="?",
   font="LiberationNarrowSans"
   ){  
   translate([0,0,1])textCylinder(
                text=text,
                r=v/2+w-.5,
                h=1,
                size=5,
                rotate=[0,0,-90],
                font=font, 
                spacing=.99, 
                valign="bottom");
} //end-notate

module logo(size=10){
    // personalize the back
    linear_extrude(height=1)text("W",font="Wingdings", size=size);
}
module thumbscrew(){//fits over the metal screw head
 difference(){
  union(){
   cylinder(f+2,(g+6)/2, (g+6)/2);
   for (i=[0:8]){rotate(i*360/8,[0,0,1])
    translate([(g+6)/2,0,0])cylinder(5,3,3); //flower-petal
	}//end-for
  }//end-union
  union(){ 
   translate([0,0,2])cylinder(5,(g+1)/2,(g+1)/2);
   cylinder(5,(i+1)/2,(i+1)/2);
  }//end-union
 }//end-difference
}//end-thumbscrew

module set_screw(
    add=true
    ,offset=1
    ,up=0
 ){
 difference(){
  union(){
   if (add){
    //set-screw catch    
   translate([0,c+3*w/4,offset])rotate([90,0,0])
       cylinder(c+w,(b+3)/2, (b+3)/2); 
    //set-screw base
   translate([-(b+3)/2,-w/4,0])cube([(b+3),c+w,offset]);
   }//end-add
  }//end-union
  union(){
   if (!add){
       //view metal screw
   #translate([0,10,offset]) rotate([90,0,0])cylinder(x/2,(a+1)/2, (a+1)/2); 
       //setscrew hole
   translate([0,6,offset])rotate([90,0,0])cylinder(12,(a+1)/2, (a+1)/2);
       //nuttrap rotated to "up" direction
   translate([0,0,offset])rotate([0,up,0])translate([0,3*w/4,0])nuttrap(); 
   }//end-add
  }//end-union
 }//end-difference
}//end-set_screw

module nuttrap(){
     //hex cavity
  translate([0,(c+1)/2,0])rotate([90,0,0])hexagon(c+1,(b+1)/2);
     //access slot
  translate([0,0,(b*3)/2])cube([b+1,c+1,b*3],center = true); 
     //visualize metal nut
  translate([0,c/2,0])rotate([90,0,0])hexagon(c,(b+1)/2,(b+1)/2);
}//end-nuttrap

module reg_polygon(sides,radius){
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}//end-reg_polygon

module hexagon(hight,rad) {
  linear_extrude(height=hight) reg_polygon(6,rad);
}//end-hexagon

module square_helicoid(
    rOut=14.3    //outer radius of helicoid
    ,rIn=12.7    //inner radius of helicoid
    ,Length=12.7 // z-length of helicoid (negative puts taper on bottom)
    ,DegPit=1 //either rotation>16 degrees, or pitch<16 rev/inch
    ,N=1      //number of sectors, or parallel threads (DNA has 2)
    ,Gap=8    //width of a thread (arbitrary due to skewing)
    ,Taper=3  // mm of taper (reduction in rOut) at end
  ){
 // added the ability to send it either degrees>16, or pitch.
 aL=abs(Length); pit=DegPit; hS=30*pit*aL; tr=0;flip=0;
 //echo("helicoid",rOut,rIn,aL,DegPit,N,Gap,Taper);
 hTwi=(pit*360*aL)/25.4;   //assume DegPit=pitch, unless > 16
 if (abs(DegPit)>16) {hTwi=DegPit; hS=20*aL; pit=25.4*hTwi/(360*aL);}
 if (Length < 0) {flip=180;tr=aL;} else {flip=0;tr=0;}
 translate([0,0,tr])rotate([flip,0,0]) //put taper on other end
 intersection(){
  union(){ //note hTwi<0 is right-handed
  linear_extrude(height=aL,twist=-hTwi,center=false,slices=hS)
   projection(cut=true){
    for(i=[1:N]){
     rotate(a=[0,0,(360*i)/N])
      translate([-Gap*pit,-Gap*pit/2,-1]) 
        cube([rOut+1*pit+Gap*pit,Gap*pit,2]);
    }//end-for
   }//end-projection
  }//end-union
  union(){
   difference(){//this annulus trims helicoid b/c skewing
    union(){
     translate([0,0,-eps])cylinder(aL-Taper+eps+eps,rOut,rOut);
     translate([0,0,aL-Taper])cylinder(Taper+eps,rOut,rIn);
    }//end-union-tapered cylinder
    translate([0,0,-eps])cylinder(aL+eps+eps,rIn,rIn);
   }//end-difference (the annulus)
  }//end-union
 }//end-intersection (with annulus) 
}//end-helicoid

//THIS ROUTINE SHOULD BE USED TO FIND OPTIMAL HGAP for Square_Helicoid
// unfortunately OpenSCAD doesn't do pipe threads very well, so...
//0) uncomment "test_thread"
//1) set rotate_angle to 0, thread_expand to 1.2
//2) set gap to about 8 | visually set thread-gap = thread-width
//   by putting a "#" on the male threads. Then remove it for 3)
//3) adjust hgap to not overlap, nothing shows up in preview
//   note that preview/F5 is not as accurate as the render/F6
//4  change rotate_angle to +/- 1 degree. Check for overlap
//5  adjust thread_expand until +/- 1 degree do not overlap.
module test_thread(){//test overlap between male-female threads
rotate_angle = 1;   
 intersection(){ //Visualize by putting "#" in front of "difference"
   difference(){ //this makes the male
    union(){
     //male extension
     cylinder(z,(x/2),(x/2));
     //male thread
     rotate([0,0,rotate_angle])translate([0,0,-eps])male_pipe_thread();
    }//end-union
    union(){
      //tube through hole
     translate([0,0,-1])cylinder((z+2),(x-w)/2,(x-w)/2);
    }//end-union    
   }//end-difference
   difference(){ //this makes the female
    union(){
     //outer tube cylinder
      cylinder(z,(x/2)+w,(x/2)+w);
    }//end-union
    union(){
      //female fitting
     translate([0,0,-1])cylinder((z+2),mep+x/2,mep+x/2);
      //female thread 
     translate([0,0,-eps])female_pipe_thread();
    }//end-union    
   }//end-difference
 }//end-intersection
}//end-test-thread

//This Library added for wrapping text around a cylinder
// textManipulation.scad
// by MichaelAtOz  - Public Domain
// Due to text() sizing being approximate, manually adjust position.
//	Technique stretches the sides of larger text. (or smaller r)

module textCylinder(	
    text="TEST"     // text
	,r=30           // cylinder radius
	,h=2			// embossed height of letters
	,size=10		// text(size=)
	,rotate=[0,0,0]	// | y= rotate face of text
					// | z= rotate around the circumference
                    // | x is ignored
	,font=undef		// : these allow default value in text()
	,spacing=undef  // : undef gets rid of WARNING unknown variable	
	,language=undef // : undef gets rid of WARNING unknown variable
	,script=undef   // : undef gets rid of WARNING unknown variable
	,valign=undef   // : undef gets rid of WARNING unknown variable
	,halign="center"// centered due to the technique used here
	,direction=undef// : undef gets rid of WARNING unknown variable
	) { 
	s=0.1; s2=s*2;	// small, for difference etc.
	l=3;			// large (multiplier) allows text size irregularity
	tall=( rotate!=[0,0,0] || direction=="btt" || direction=="ttb" );
	_h= (	tall	// keep cut cylinders to reasonable size
			? (size*len(text)*l) 
			: size*l ); 
	_r=(r+h)*l;
	//echo(r=r,h=h,text=text,size=size,rotate=rotate);
	//echo(l=l,tall=tall,_h=_h,_r=_r);
	difference() {
		rotate([90,rotate[1],rotate[2]])
			linear_extrude(height=r+h,convexity=5)
				text(text,size,halign="center"
						,font=font
						,spacing=spacing
						,language=language
						,script=script
						,valign=valign
						,direction=direction
				);
		// -
		translate([0,0,size/2]) {
			cylinder(r=r,h=_h,center=true);
			difference() {
				cylinder(r=_r,h=_h+s,center=true);
				// -
				cylinder(r=r+h,h=_h+s2,center=true);
			} //d
		} // t
	} // d
} // textCylinder

//library   polyScrewThread
/*    polyScrewThread_r1.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing;8796
 *
 * CC Public Domain
 */

module screw_thread(
     od = 15 //outer diameter 
    ,st = 4  //step, traveling length per rev
    ,lf0 =55 //Degrees tooth profile 0=xy, 90=z
    ,lt =100 //z-length of thread
    ,rs = Pi/2 //resolution one face each "PI/2" mm of the perimeter,
    ,cs = 0){ //countersink style
/*            -2 - Not even flat ends
 *            -1 - Bottom (countersink'd and top flat)
 *             0 - None (top and bottom flat)
 *             1 - Top (bottom flat)
 *             2 - Both (countersink'd)
 */
    or=od/2;
    ir=or-st/2*cos(lf0)/sin(lf0);
    pf=2*PI*or;
    sn=floor(pf/rs);
    lfxy=360/sn;
    ttn=round(lt/st+1);
    zt=st/sn;
    intersection()    {
        if (cs >= -1)        {
           thread_shape(cs,lt,or,ir,sn,st);
        }
        full_thread(ttn,st,sn,zt,lfxy,or,ir);
    }
}
module hex_nut(df,hg,sth,clf,cod,crs){
    difference()    {
        hex_head(hg,df);
        hex_countersink_ends(sth/2,cod,clf,crs,hg);
        screw_thread(cod,sth,clf,hg,crs,-2);
    }
}
module hex_screw(od,st,lf0,lt,rs,cs,df,hg,ntl,ntd){
    ntr=od/2-(st/2)*cos(lf0)/sin(lf0);
    union()    {
        hex_head(hg,df);
        translate([0,0,hg])
        if ( ntl == 0 )        {
            cylinder(h=0.01, r=ntr, center=true);
        }
        else        {
            if ( ntd == -1 )            {
                cylinder(h=ntl+0.01, r=ntr, $fn=floor(od*PI/rs), center=false);
            }
            else if ( ntd == 0 )            {
                union()                {
                    cylinder(h=ntl-st/2,
                             r=od/2, $fn=floor(od*PI/rs), center=false);
                    translate([0,0,ntl-st/2])
                    cylinder(h=st/2,
                             r1=od/2, r2=ntr, 
                             $fn=floor(od*PI/rs), center=false);
                }
            }
            else            {
                cylinder(h=ntl, r=ntd/2, $fn=ntd*PI/rs, center=false);
            }
        }
        translate([0,0,ntl+hg]) screw_thread(od,st,lf0,lt,rs,cs);
    }
}
module hex_screw_0(od,st,lf0,lt,rs,cs,df,hg,ntl,ntd){
    ntr=od/2-(st/2)*cos(lf0)/sin(lf0);
    union()    {
        hex_head_0(hg,df);
        translate([0,0,hg])
        if ( ntl == 0 )        {
            cylinder(h=0.01, r=ntr, center=true);
        }
        else        {
            if ( ntd == -1 )            {
                cylinder(h=ntl+0.01, r=ntr, $fn=floor(od*PI/rs), center=false);
            }
            else if ( ntd == 0 )            {
                union()                {
                    cylinder(h=ntl-st/2,
                             r=od/2, $fn=floor(od*PI/rs), center=false);
                    translate([0,0,ntl-st/2])
                    cylinder(h=st/2,
                             r1=od/2, r2=ntr, 
                             $fn=floor(od*PI/rs), center=false);
                }
            }
            else            {
                cylinder(h=ntl, r=ntd/2, $fn=ntd*PI/rs, center=false);
            }
        }
        translate([0,0,ntl+hg]) screw_thread(od,st,lf0,lt,rs,cs);
    }
}
module thread_shape(cs,lt,or,ir,sn,st){
    if ( cs == 0 )    {
        cylinder(h=lt, r=or, $fn=sn, center=false);
    }
    else    {
        union()        {
            translate([0,0,st/2])
              cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);
            if ( cs == -1 || cs == 2 )            {
                cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
            }
            else            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }
            translate([0,0,lt-st/2])
            if ( cs == 1 || cs == 2 )            {
                  cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
            }
            else            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }
        }
    }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir){
  if(ir >= 0.2)  {
    for(i=[0:ttn-1])    {
        for(j=[0:sn-1]){
			pt = [	[0,                  0,                  i*st-st            ],
                    [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                    [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
					[0,                  0,                  i*st               ],
                    [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                    [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                    [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                    [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                    [0,                  0,                  i*st+st            ]	];
            polyhedron(points=pt,
              		  faces=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4],
								[0,1,2],[1,4,2],[2,4,5],[5,4,6],[5,6,7],[7,6,8],
								[7,8,3],[0,2,3],[3,2,7],[7,2,5]	]);
        }
    }
  }
  else  {
    echo("Step Degrees too aggressive, the thread will not be made!!");
    echo("Try to increase the value for the degrees and/or...");
    echo(" decrease the pitch value and/or...");
    echo(" increase the outer diameter value.");
  }
}
module hex_head(hg,df){
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;
	intersection()	{
	   cylinder(h=hg, r=rd0, $fn=6, center=false);
		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}
module hex_head_0(hg,df){
    cylinder(h=hg, r=df/2/sin(60), $fn=6, center=false);
}
module hex_countersink_ends(chg,cod,clf,crs,hg){
    translate([0,0,-0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2, 
             r2=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             $fn=floor(cod*PI/crs), center=false);
    translate([0,0,hg-chg+0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             r2=cod/2, 
             $fn=floor(cod*PI/crs), center=false);
}
