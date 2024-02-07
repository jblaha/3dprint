$fn = 100; // Set the number of facets for smooth curves

// Dimensions
cap_outer_diameter = 57;
cap_wall_thickness = 2;
cap_height = 10;
hole_diameter = 3;

pipe_length = 15;
pipe_outer_diameter = 6;
pipe_displacement = 10; // Displacement of the pipe from the cap center
pipe_top_length = 20;
pipe_wall_thickness = 2;

// Cap
difference() {
    cylinder(d = cap_outer_diameter, h = cap_height);
    translate([0, 0, -1]) { // Subtract a small amount to avoid interference with the pipe
        cylinder(d = cap_outer_diameter - 2 * cap_wall_thickness, h = cap_height + 2);
    }
    translate([0, 0, cap_height/2]) { // Create a hole in the middle of the cap
        cylinder(d = hole_diameter, h = cap_height + 2);
    }
    translate([0, 0, cap_height]) { // Create the upper part of the cap
        cylinder(d1 = cap_outer_diameter, d2 = cap_outer_diameter - 2 * cap_wall_thickness, h = cap_wall_thickness);
    }
}

// Sucking Pipe
difference() {
    translate([pipe_displacement, 0, 0]) { // Displace the pipe from the cap center
        cylinder(d = pipe_outer_diameter, h = pipe_length);
    }
    translate([pipe_displacement, 0, pipe_length]) { // Create a top part of the pipe
        cylinder(d = pipe_outer_diameter, h = pipe_top_length);
    }
    translate([pipe_displacement, 0, pipe_length + pipe_top_length]) { // Hollow out the top part of the pipe
        cylinder(d = pipe_outer_diameter - 2 * pipe_wall_thickness, h = pipe_wall_thickness);
    }
}
