// ============================================================
// Drzak na vzdusovy kompresorek - kompatibilni s LEGO
// Osa kompresorku = osa X. Vklada se zezadu (od x = L), tlustym koncem napred.
// Bajonet: privodni trubicka se zasune vodorovne (+Y) a otoci o lock_angle dolu.
// Spodek: podelne Technic traverzy po stranach s dirami pro osicky.
// ============================================================
$fn = 96;

// ---------- LEGO konstanty ----------
pitch   = 8.0;    // rozteč ťupků
brick_h = 9.6;    // výška kostičky
stud_d  = 4.8;    // průměr ťupku
stud_h  = 1.7;    // výška ťupku
wall    = 1.2;    // stěna spodku kostičky
top_t   = 1.0;    // strop dutiny pod základnou
beam_t  = 1.6;    // tloušťka podélných vnitřních stěn (traverz)
pin_d   = 4.9;    // díra pro lego osičku

// ---------- Kompresor ----------
d_thick  = 31;    // tlustší válec
l_thick  = 26;
d_thin   = 24;    // tenčí válec
l_thin   = 31;
d_out    = 4;     // výstupní trubička v čele
d_in     = 6;     // boční přívodní trubička
x_in     = 22;    // osa přívodu od čela s výstupem
tube_len = 8;     // ODHAD délky přívodní trubičky od pláště - ZMĚŘ A UPRAV
clr      = 0.3;   // vůle kolem tlustého válce

// ---------- Držák ----------
nx          = 6;     // délka základny v ťupcích
ny          = 5;     // šířka základny v ťupcích
top_nx      = 5;     // počet ťupků nahoře v délce (4 nebo 5, max nx)
front_wall  = 2.4;   // tloušťka přední stěny (doraz)
floor_t     = 1.6;   // tloušťka dna pod kompresorem nad základnou
top_wall    = 2.2;   // tloušťka stropu nad kompresorem
rib_int     = 0.15;  // přesah žeber (přitlačení)
rib_w       = 1.4;   // šířka žebra
lock_angle  = 35;    // úhel pootočení bajonetu
slot_clr    = 0.6;   // vůle drážky kolem trubičky

// ---------- Odvozené ----------
L      = nx * pitch;
W      = ny * pitch;
r_body = d_thick / 2;
r_cav  = r_body + clr;
R_out  = W / 2;
z0     = brick_h + floor_t + r_cav;       // výška osy kompresoru
z_top  = z0 + r_cav + top_wall;           // horní useknutá plocha
x_t    = front_wall + x_in;               // poloha přívodní trubičky
ws     = d_in + slot_clr;                 // šířka drážky
slot_len = r_body + tube_len + 0.5;

top_chord = 2 * sqrt(R_out*R_out - (z_top - z0)*(z_top - z0));
assert(top_chord >= 16, "Horni plocha je prilis uzka pro 2 rady tupku");
assert(top_nx <= nx, "top_nx musi byt <= nx");
echo(delka_kompresoru = l_thick + l_thin, delka_drzaku = L,
     sirka_horni_plochy = top_chord, vyska_celkem = z_top + stud_h);

// ---------- Vnější tvar ----------
module outer_profile() {
    intersection() {
        union() {
            translate([-W/2, 0]) square([W, z0]);
            translate([0, z0]) circle(r = R_out);
        }
        translate([-W/2, 0]) square([W, z_top]);
    }
}

module body_solid() {
    rotate([90, 0, 90]) linear_extrude(L) outer_profile();
}

// ---------- Spodek LEGO kostičky ----------
module underside_cavity() {
    translate([wall, -W/2 + wall, -0.01])
        cube([L - 2*wall, W - 2*wall, brick_h - top_t + 0.01]);
}

// podélné Technic traverzy po stranách (mezi sloupci ťupků)
module beams() {
    for (j = [1, ny - 1])
        translate([wall - 0.01, -W/2 + j * pitch - beam_t/2, 0])
            cube([L - 2*wall + 0.02, beam_t, brick_h - top_t + 0.01]);
}

// příčné díry pro lego osičky (mezi ťupky, v poloviční výšce kostičky)
module pin_holes() {
    for (k = [1 : nx - 1])
        translate([k * pitch, 0, brick_h / 2])
            rotate([90, 0, 0]) cylinder(d = pin_d, h = W + 2, center = true);
}

// ---------- Kompresor ----------
module compressor_cavity() {
    translate([front_wall, 0, z0])
        rotate([0, 90, 0]) cylinder(r = r_cav, h = L - front_wall + 1);
}

module front_hole() {      // otvor pro výstupní trubičku
    translate([-0.1, 0, z0])
        rotate([0, 90, 0]) cylinder(d = d_out + 4, h = front_wall + 0.2);
}

// ---------- Bajonet ----------
module tube_cyl(a, x) {    // válec ve směru úhlu a (0 = +Y, záporný = dolů)
    translate([x, 0, z0]) rotate([a, 0, 0]) rotate([-90, 0, 0])
        cylinder(d = ws, h = slot_len);
}

module bayonet_slot() {
    steps = 7;
    intersection() {
        union() {
            // vstupní drážka k zadnímu konci
            hull() { tube_cyl(0, x_t); tube_cyl(0, L + ws); }
            // obloukový zámek
            for (i = [0 : steps - 1])
                hull() {
                    tube_cyl(-lock_angle * i / steps, x_t);
                    tube_cyl(-lock_angle * (i + 1) / steps, x_t);
                }
        }
        // neprorážet strop spodní dutiny
        translate([-1, -W, brick_h]) cube([L + 3*ws, 2*W, 100]);
    }
}

// ---------- Žebra ----------
module ribs() {
    x0 = front_wall + 0.5;
    x1 = x_t - ws/2 - 1;       // žebra jen před drážkou přívodu
    for (a = [45, 135, 225, 315])
        translate([0, 0, z0]) rotate([a, 0, 0]) hull() {
            translate([x0, r_body - rib_int, -rib_w/2])
                cube([x1 - x0 - 3, (r_cav + 0.5) - (r_body - rib_int), rib_w]);
            translate([x1 - 0.01, r_cav, -rib_w/2])
                cube([0.01, 0.5, rib_w]);
        }
}

// ---------- Horní ťupky ----------
module studs() {
    x_off = (nx - top_nx) * pitch / 2;
    for (i = [0 : top_nx - 1])
        for (j = [0 : 1])
            translate([x_off + pitch/2 + i*pitch, -pitch/2 + j*pitch, z_top - 0.01])
                cylinder(d = stud_d, h = stud_h + 0.01);
}

// ---------- Sestavení ----------
union() {
    difference() {
        union() {
            difference() {
                body_solid();
                underside_cavity();
            }
            beams();
        }
        compressor_cavity();
        front_hole();
        bayonet_slot();
        pin_holes();
    }
    ribs();
    studs();
}
