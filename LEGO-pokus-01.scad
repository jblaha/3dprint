include <toybrick/toybrick.scad>;

$fn = 60;

toybrick(4, 4);
translate ([45,0,0])toybrick(5, 3);
translate ([45,45,0])toybrick(2, 2);
translate ([70,45,0])toybrick(2, 2);
translate ([25,45,0])toybrick(1, 1);
translate ([25,55,0])toybrick(1, 1);
translate ([25,65,0])toybrick(1, 1);