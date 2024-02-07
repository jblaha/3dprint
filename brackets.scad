bracket();

module bracket(thickness = 3, beam_width = 10, arm_length = 30, holes_diameter = 3) {
	difference() {
		cube([thickness+arm_length + beam_width, thickness+arm_length + beam_width, thickness]);

		translate([beam_width+thickness, beam_width+thickness, -0.1])
			cube([arm_length+0.1, arm_length+0.1, thickness+0.2]);

		translate([thickness+beam_width+5, thickness+beam_width/2, -0.1])
			cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
		translate([arm_length+beam_width-5, thickness+beam_width/2, -0.1])
			cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
		translate([thickness+beam_width/2, thickness+beam_width+5, -0.1])
			cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
		translate([thickness+beam_width/2, arm_length+beam_width-5, -0.1])
			cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
	}

	difference() {
		cube([thickness, thickness+arm_length+beam_width, beam_width+thickness]);

		rotate([0, 90, 0])
			translate([-thickness-beam_width/2, thickness+beam_width+5, -0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
		rotate([0, 90, 0])
			translate([-thickness-beam_width/2, arm_length+beam_width-5, -0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
	}

	difference() {
		cube([thickness+arm_length+beam_width, thickness, thickness+beam_width]);

		rotate([90, 0, 0])
			translate([thickness+beam_width+5, thickness+beam_width/2, -thickness-0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
		rotate([90, 0, 0])
			translate([arm_length+beam_width-5, thickness+beam_width/2, -thickness-0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
	}

	difference() {
		cube([thickness+beam_width, thickness, thickness+beam_width+arm_length]);

		rotate([90, 0, 0])
			translate([thickness+beam_width/2, thickness+beam_width+5, -thickness-0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
		rotate([90, 0, 0])
			translate([thickness+beam_width/2, arm_length+beam_width-5, -thickness-0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
	}

	difference() {
		cube([thickness, thickness+beam_width, thickness+beam_width+arm_length]);

		rotate([0, 90, 0])
			translate([-thickness-beam_width-beam_width/2, thickness+beam_width/2, -0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
		rotate([0, 90, 0])
			translate([-arm_length-beam_width+5, thickness+beam_width/2, -0.1])
				cylinder(r=holes_diameter/2, h=thickness+0.2, $fn=360);
	}
}