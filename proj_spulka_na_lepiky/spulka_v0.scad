include <../_lib_/straight_pipe3d.scad>
include <../_lib_/cap3d.scad>


cap3d(outer_radius=28, height=125, walls_thickness=1.5, top_thickness=2.5);
straight_pipe3d(r_inner=9.5, r_outer=11, length=125);


//cap3d(outer_radius=29.0, height=8, walls_thickness=0.8, top_thickness=1.0);
//straight_pipe3d(r_inner=8.5, r_outer=9, length=10);

