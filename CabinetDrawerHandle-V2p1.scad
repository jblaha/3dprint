/* Cabinet/Drawer Handle
   by Lyl3

Create a simple circular arc shaped handle for cabinets, cupboards, or drawers.

This code is published at:
https://www.thingiverse.com/thing:3911914
licensed under the Creative Commons - Attribution - Share Alike license (CC BY-SA 3.0)

V0.1 - basic working prototype with math worked out
V0.2 - filleted edges
V0.3 - added screw hole and nut hole
V0.4 - fine-tuning, set sane ranges for parameters
V0.5 - added tolerance parameters for the holes
V0.6 - fine-tuned ranges
V0.7 - added parameter and code to create test piece instead of whole handle.
V0.8 - added parameter and code to create nut hole plugs
V1.0 - removed the brim from the nut hole plugs
       ready for release
V1.1 - set resolution based on length of arc      
V1.2 - fixed calcualtion for mount radius
V1.3 - mount plate extended across handle, option for single screw hole or two screw holes
V1.4 - fine-tuning the math, set sane parameter ranges
V1.5 - added "mount pillars" to the design, made code more efficient, fixed math bugs
V1.6 - simplified code using 2D instead of 3D for the handle profile
V1.7 - added spherical-shaped handle option, moved back of handle to XZ plane, simplifying transformations
V1.8 - backplate all the way across the back for spherical handles
V1.9 - scaled height to allow handles shaped like spheroid sections instead of spherical sections
V2.0 - used cavity length parameter for spheroidal handles
V2.1 - fixed documentation, default parameter values
*/

/* [Handle parameters] */

// Resolution of arcs and circles. Set this to a low value to speed up processing while adjusting parameters and previewing them. Set to 1 for creating an STL mesh to be printed. Set it greater than 1 if you have a fast processor and want a super smooth mesh. 
resolution = 0.2; // [0.2:0.1:1.5]


// Type of handle: cylindrical or spheroidal
handleType = "cylindrical"; // [cylindrical,spheroidal]

// Part to create: whole handle, test piece for testing dimensions of holes, or nut hole plug(s) (to cover holes if handle will be mounted vertically)
createPart = "handle"; // [handle,test piece,nut hole plugs]
createTestPiece = (createPart=="test piece") ? true : false;
createNutHolePlugs = (createPart=="nut hole plugs") ? true : false;

// Length of the handle (mm)
handleLength = 124; // [30:0.1:300]

// Length of the cavity in the handle (mm)
cavityLength = 84; // [15:0.1:250]

// Height of the handle (oriented as it would be on a drawer) (mm)
handleHeight = 15; //[5:0.1:60]

// Depth of the handle (amount it protudes from the drawer or cupboard) (mm)
handleClearance = 25; // [20:0.1:50]

// Thickness of the handle (in the middle where you would grab it) (mm)
handleThickness = 5; // [3:0.1:15]

// Thickness of the back mounting plate (mm)
backplateThickness = 0; // [0:0.1:15]

// Radius of filleted edge (0 for no fillet) (mm)
fillet = 2; // [0:0.01:5]

/* [Screw Hole Parameters] */

// Number of screws
screwCount = 2; // [1:2]

// Distance between screws if two screws, ignored if only one screw (mm)
screwDistance = 95; // [1:0.1:250]

// Diameter of screw (mm). An M4 screw has a nominal diameter of 4 mm.
screwDiameter = 4; // [1:0.01:10]

// Length of screw hole (mm)
screwHoleLength = 8; // [2:0.1:25]

// Tolerance added to walls for the screw hole (mm). This is added to all sides of the hole: a screw diameter of 3 mm with tolerance of 0.05 mm would make the hole diameter 3.1 mm. 
screwHoleTolerance = 0.05;  // [0:0.01:0.2]

screwHoleDiameter = screwDiameter + 2*screwHoleTolerance;
screwHoleDepth = screwHoleLength + screwHoleTolerance;

/* [Nut Hole Parameters] */

// Create holes for inserting nuts?
withNutHoles = "yes"; // [yes,no]
createNutHoles = (withNutHoles=="yes") ? true : false;

// Distance from back of handle to the hole for inserting a nut (mm)
nutHoleOffset = 2.2; // [1:0.1:25]

// Width of nut across flats (between parallel sides) (mm). The ANSI M4 nut specification maximum is 7.00 mm and the minimum is 6.78 mm. The default of 6.89 is the average. 
nutWidth = 6.89; // [3:0.01:16]

// Thickness of nut (mm). The ANSI M4 nut specification maximum is 3.20 mm and the minimum is 2.90 mm. The default of 3.05 is the average. 
nutThickness = 3.05; // [1:0.01:12]

// Tolerance added to walls for the nut hole (mm). This is added to all sides of the hole: a nut width of 6 mm with a tolerance of 0.15 mm would make the nut hole width 6.3 mm. It doesn't have to be a tight fit, so the tolerance can be a bit loose.
nutHoleTolerance = 0.15;  // [0:0.01:0.2]

nutHoleWidth = nutWidth + 2*nutHoleTolerance;
nutHoleHeight = nutThickness + 2*nutHoleTolerance;
nutHoleDepth = handleHeight/2+nutHoleWidth/sqrt(3)+nutHoleTolerance;

/* [Advanced] */

/* [Hidden] */
fudge = 0.0001; // Value added or subtracted to various values to ensure each part is a single manifold mesh 
bigFudge = 5; // Large value to help debug boolean operations in conjunction with the debug modifer

/* Math references:
   https://en.wikipedia.org/wiki/Circular_segment
   https://en.wikipedia.org/wiki/Inscribed_angle
   https://en.wikipedia.org/wiki/Inverse_trigonometric_functions
*/
outerChord = handleLength;

outerRadiusActual = (handleClearance/2) + (outerChord*outerChord/8/handleClearance);

// Calculate the circle fragments based on the arc length and the  ratio of the arc to circumference
outerDiameter = 2*outerRadiusActual;
arcLength = (handleClearance < outerDiameter/2)
   ? PI/180 * asin(outerChord/outerDiameter) * outerDiameter
   : (PI - PI/180*asin(outerChord/outerDiameter)) * outerDiameter;
arcCircleRatio = arcLength / (outerDiameter * PI);
$fn = 100*resolution / arcCircleRatio; 

outerRadius = outerRadiusActual - fillet;
innerRadius = outerRadiusActual - handleThickness + fillet; 

sphereHandleHeight = sqrt( outerRadiusActual*outerRadiusActual - ((outerRadiusActual-handleClearance) * (outerRadiusActual-handleClearance))) ;
sphereHeightScale = handleHeight / sphereHandleHeight;

cutterCube = max(1,sphereHeightScale) * max(2*outerRadiusActual,handleHeight) + bigFudge; // Make cut cube large enough 

echo("Outer chord:",outerChord, "\nOuter diameter:",outerDiameter, "\nHandle clearance:",handleClearance, "\nArc length:",arcLength, "\nArc circle ratio:",arcCircleRatio, "\nSphere Height Scale",sphereHeightScale, "\n$fn:",$fn);

/*
Module to create the 2D handle shape, centered at X=0
*/

module handle_profile() {
  translate([0,-outerRadius+handleClearance-fillet,0])
  difference() {  // Create the 2D handle shape.
    circle(outerRadius);  // outer circle
    intersection() {
      circle(innerRadius);  // inner circle
      square([cavityLength+2*fillet, cutterCube],center=true);  // cavity
          translate([0,outerRadius-handleClearance/2+backplateThickness-fudge,0])  // "negative" of back plate, fudge factor required when backplateThickness=0
            square([outerChord+bigFudge, handleClearance], center=true);
    }
    // Have it extended a little (the fillet radius) beyond where the final cut will be made later,
    // so that the minkowski function covers the area all the way to the sides.
    translate([-cutterCube/2,-cutterCube+outerRadiusActual-handleClearance-fillet,0]) square(cutterCube);
  }
}
// %linear_extrude(0.0001) handle_profile();

/*
Create the part(s)
*/
//color("SteelBlue")
if (createNutHolePlugs) {
  if (screwCount == 1) {
    translate([0,0,1]) cube([nutWidth,nutThickness,2],center=true);
  } else {
    translate([-nutWidth-1,-nutThickness/2,0]) cube([nutWidth,nutThickness,2]);
    translate([1,-nutThickness/2,0]) cube([nutWidth,nutThickness,2]);
  }
}
else
{
  translate([0,-handleClearance/2,fillet])
  difference() {
      if (handleType == "spheroidal") {
        union() {
          intersection() { // Create the backplate shaped to the spheroid
            translate([0,handleClearance-outerRadiusActual,0]) scale([1,1,sphereHeightScale]) sphere(outerRadiusActual-handleThickness/2);
            translate([-cutterCube/2,0,-fillet]) cube([cutterCube, backplateThickness, cutterCube]);
          }
          intersection() { // Create the spheroidal shape
            translate([0,handleClearance-outerRadiusActual,0]) scale([1,1,sphereHeightScale]) difference() { 
              sphere(outerRadiusActual);
                intersection() {
                  sphere(outerRadiusActual-handleThickness);
                  cube([cavityLength, cutterCube, cutterCube],center=true);
                }
            }
            translate([-cutterCube/2,0,0]) cube([cutterCube, cutterCube, cutterCube]);
          }
          intersection() { // Create the filleted edge on the bottom
            minkowski() { 
              linear_extrude(0.001) handle_profile();
              sphere(fillet,$fn=30*resolution);
            }
            translate([-cutterCube/2,0,-fillet]) cube([cutterCube, cutterCube, fillet]);
          }
        }
      } else {
    // Create the filleted handle
    minkowski() { 
      linear_extrude(handleHeight - 2*fillet) handle_profile();
      sphere(fillet,$fn=30*resolution);
      }
    }
    // cut away material added by fillet at the back of the handle
    translate([-cutterCube/2,-cutterCube,-cutterCube/2+handleHeight/2-fillet]) cube(cutterCube);
    // cut out the screw hole(s)
    if (screwCount == 1) {
      translate([0,0,handleHeight/2-fillet]) rotate([-90,0,0]) cylinder(h=screwHoleDepth+fudge, d=screwHoleDiameter);
    } else {
      translate([-screwDistance/2,0,handleHeight/2-fillet]) rotate([-90,0,0]) cylinder(h=screwHoleDepth+fudge, d=screwHoleDiameter);
      translate([screwDistance/2,0,handleHeight/2-fillet]) rotate([-90,0,0]) cylinder(h=screwHoleDepth+fudge, d=screwHoleDiameter);
    }
    // cut out the nut holes
    if (createNutHoles) {
      if (screwCount == 1) {
        translate([-nutHoleWidth/2,nutHoleOffset,-fillet-fudge]) cube([nutHoleWidth,nutHoleHeight,nutHoleDepth]);
      } else {
        translate([-screwDistance/2-nutHoleWidth/2,nutHoleOffset,-fillet-fudge]) cube([nutHoleWidth,nutHoleHeight,nutHoleDepth]);
        translate([screwDistance/2-nutHoleWidth/2,nutHoleOffset,-fillet-fudge]) cube([nutHoleWidth,nutHoleHeight,nutHoleDepth]);
      }
    }
    // create test piece: cut away all other volume from 3 mm to the right of the nuthole and 4 mm in front of the mount plate
    if (createTestPiece) {
      if (screwCount == 1) {
        translate([nutWidth/2+3,-cutterCube/2,-cutterCube/2]) cube(cutterCube);
      } else {
        translate([-screwDistance/2+nutWidth/2+3,-cutterCube/2,-cutterCube/2]) cube(cutterCube);
      }  
      translate([-cutterCube/2,backplateThickness+4,-cutterCube/2]) cube(cutterCube);
    }
  }
}
