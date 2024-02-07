include <toybrick/toybrick.scad>;

$fn = 60;

/*
toybrick(3, 3);
translate ([45,0,0])toybrick(5, 3);
translate ([45,45,0])toybrick(2, 2);
translate ([70,45,0])toybrick(2, 2);
translate ([25,45,0])toybrick(1, 1);
translate ([25,55,0])toybrick(1, 1);
translate ([25,65,0])toybrick(1, 1);
*/

xdiff=20;

//translate ([0,0,0])toybrick(3, 3);

//translate (/*[0,xdiff*1.3,0]*/[xdiff*1.3,xdiff*1.0,0])toybrick(2, 2);
translate ([xdiff*1.3,xdiff*0,0])toybrick(2, 2);
//translate ([xdiff*1.3,xdiff*2,0])toybrick(2, 3);

//translate ([0,xdiff*1.3,0])toybrick(3,2);
//translate ([0,xdiff*2.2,0])toybrick(3,2);