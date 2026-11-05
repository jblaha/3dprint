// Adapter: bateriovy mlynek -> kovovy filtr prekapavace
// Zespodu: sukne obepina limec filtru zvenku, deska lezi na limci (nepropadne),
// nahore: hrdlo (soket) pro valec mlynku. Kava propada otvorem primo do filtru.

$fn = 180;

// ---------- rozmery (mm) ----------
cup_od   = 71.5;     // vnejsi prumer nadobky = prumer valce mlynku, ktery se zasouva
cup_id   = 62.5;   // vnitrni prumer nadobky (otvor pro kavu)
col_id   = 83;     // filtr - vnitrni prumer limce
col_od   = 108;     // filtr - vnejsi prumer limce
handle_w = 18;     // sirka drzatka filtru

// ---------- tolerance ----------
fit        = 0.4;  // celkova vule na prumer (u tisku dolad podle tiskarny)
slot_extra = 2;    // rezerva ve sirce drzatka

// ---------- konstrukce ----------
skirt_h    = 05;   // vyska sukne na limci
skirt_wall = 3;    // sila steny sukne
plate_t    = 5;    // sila desky (dosedaci plocha na limec + dno hrdla)
sock_h     = 25;   // vyska hrdla pro mlynek (vyssi = stabilnejsi)
sock_wall  = 3;    // sila steny hrdla
cone_h     = 6;    // prechod mezi suknou a hrdlem
hole_d     = cup_id - 5;  // pruchozi otvor pro kavu, orig cup_id + 0.5

// ---------- zebra pro pevne dosednuti (proti vibracim) ----------
rib_n      = 6;
rib_w      = 1.6;
skirt_rib  = 0.35; // vystup zeber do sukne (zebra se pri nasazeni zmackne)
sock_rib   = 0.30; // vystup zeber v hrdle

slot_angle = 0;    // natoceni vyrezu pro drzatko filtru (stupne)

// ---------- odvozene ----------
skirt_id = col_od + fit;
skirt_od = skirt_id + 2*skirt_wall;
sock_id  = cup_od + fit;
sock_od  = sock_id + 2*sock_wall;
slot_w   = handle_w + slot_extra;
z_floor  = skirt_h + plate_t;      // dno hrdla = horni plocha desky
z_top    = z_floor + sock_h;

module body() {
    difference() {
        union() {
            cylinder(h = skirt_h + plate_t, d = skirt_od);                // sukne + deska
            translate([0, 0, z_floor])
                cylinder(h = cone_h, d1 = skirt_od, d2 = sock_od);        // prechod
            translate([0, 0, z_floor])
                cylinder(h = sock_h, d = sock_od);                        // hrdlo
        }
        // vnitrek sukne (nasazuje se na limec)
        translate([0, 0, -1]) cylinder(h = skirt_h + 1, d = skirt_id);
        // vnitrek hrdla (zasouva se mlynek)
        translate([0, 0, z_floor]) cylinder(h = sock_h + 1, d = sock_id);
        // pruchozi otvor pro kavu
        translate([0, 0, -1]) cylinder(h = z_top + 2, d = hole_d);
        // vyrez pro drzatko filtru - otevreny dolu, cela vyska sukne
        rotate([0, 0, slot_angle])
            translate([0, -slot_w/2, -1]) cube([skirt_od, slot_w, skirt_h + 1]);
    }
}

module ribs() {
    // zebra v sukni (mimo vyrez drzatka)
    for (i = [0 : rib_n - 1])
        rotate([0, 0, slot_angle + 30 + i * 360 / rib_n])
            translate([skirt_id/2 - skirt_rib, -rib_w/2, 0])
                cube([skirt_rib + 0.5, rib_w, skirt_h]);
    // zebra v hrdle
    for (i = [0 : rib_n - 1])
        rotate([0, 0, i * 360 / rib_n])
            translate([sock_id/2 - sock_rib, -rib_w/2, z_floor])
                cube([sock_rib + 0.5, rib_w, sock_h]);
}

union() {
    body();
    ribs();
}
