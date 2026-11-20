// ============================================================
// Drzak na vzdusovy kompresorek - kompatibilni s LEGO
//
// Osa kompresorku = osa X.
//  - x = 0 je OTEVRENE CELO drzaku (sem je privrene tlusté čelo s vyvodem vzduchu)
//  - kompresorek se zasouva TENKOU casti napred, az se zarazi o prechod
//    tenka/tlusta cast (doraz = stupen v dutine pri x = l_thick)
//  - pak se pootoci o lock_angle: boční privodní trubicka (na tlusté casti)
//    zapadne do obloukoveho vyrezu = bajonet
//  - zadni cela s kontakty zustava cele pristupne
// Spodek: jedna podelna rada Technic traverz podel kazde strany, mezi stenou
// a traverzou pricky u kazdeho tupku (zebricek) - tupky krajnich rad jsou
// obejmuty ze vsech stran. Vnitrek zustava volny (snadny tisk bez podpor).
// Diry pro osicky prochazeji traverzami i prickami.
// Parametr long_all = true prida vnitrni podelne traverzy a pricky pres celou sirku.
// ============================================================
$fn = 96;

// ---------- LEGO konstanty ----------
pitch   = 8.0;    // rozteč ťupků
brick_h = 9.6;    // výška kostičky
stud_d  = 4.8;    // průměr ťupku
stud_h  = 1.7;    // výška ťupku
wall    = 1.5;    // vnější stěna spodku
top_t   = 1.0;    // strop dutiny pod základnou
cell_open = 5.0;  // světlost buňky kolem ťupku (ťupek 4,8 + vůle; při těsnosti zvětši)
long_all  = false; // true = podélné traverzy v každé řadě, false = jen po stranách
cross_walls = true; // true = příčky u každého ťupku (u long_all=false jen po stranách)
pin_d   = 4.9;    // díra pro lego osičku

// ---------- Kompresor ----------
d_thick  = 31;    // tlustší válec (vývod vzduchu v čele + boční přívod)
l_thick  = 26;
d_thin   = 24;    // tenčí válec (kontakty na konci)
l_thin   = 31;
d_out    = 4;     // výstupní trubička v čele (vyčnívá ven z otevřeného čela)
d_in     = 6;     // boční přívodní trubička
x_in     = 22;    // osa přívodu od čela s výstupem
tube_len = 8;     // ODHAD délky přívodní trubičky od pláště - ZMĚŘ A UPRAV
clr      = 0.3;   // vůle kolem válců
thin_extra_d = 1.0; // dutina pro tenký válec je o tolik mm širší v průměru (tolerance tisku)

// ---------- Držák ----------
nx          = 7;     // délka základny v ťupcích
ny          = 5;     // šířka základny v ťupcích
top_nx      = nx;    // počet ťupků nahoře v délce (výchozí = všechny, co se vejdou)
floor_t     = 1.6;   // tloušťka dna pod kompresorem nad základnou
top_wall    = 2.2;   // tloušťka stropu nad kompresorem
rib_int     = 0.15;  // přesah žeber (přitlačení)
rib_w       = 1.4;   // šířka žebra
rib_ramp    = 3;     // délka náběhu žebra
lock_angle  = 35;    // úhel pootočení bajonetu
slot_clr    = 0.6;   // vůle drážky kolem trubičky

// ---------- Odvozené ----------
L      = nx * pitch;
W      = ny * pitch;
r_body = d_thick / 2;
r_cav  = r_body + clr;                    // dutina pro tlustou část
r_thin = d_thin / 2;
r_thin_cav = r_thin + clr + thin_extra_d/2; // dutina pro tenkou část
comp_end = l_thick + l_thin;              // konec kompresoru (čelo s kontakty)
stop_x = l_thick;                         // doraz: přechod tenká/tlustá část
R_out  = W / 2;
z0     = brick_h + floor_t + r_cav;       // výška osy kompresoru
z_top  = z0 + r_cav + top_wall;           // horní useknutá plocha
x_t    = x_in;                            // poloha přívodní trubičky (od x = 0)
ws     = d_in + slot_clr;                 // šířka drážky
slot_len = r_body + tube_len + 0.5;
grid_t = pitch - cell_open;               // tloušťka vnitřních traverz

top_chord = 2 * sqrt(R_out*R_out - (z_top - z0)*(z_top - z0));
assert(top_chord >= 16, "Horni plocha je prilis uzka pro 2 rady tupku");
assert(top_nx <= nx, "top_nx musi byt <= nx");
assert(L > stop_x + 6, "Drzak je prilis kratky - zvetsi nx");
assert(x_t + ws/2 < stop_x, "Privod je prilis blizko dorazu");
echo(delka_kompresoru = comp_end, delka_drzaku = L,
     sirka_horni_plochy = top_chord, vyska_celkem = z_top + stud_h,
     tloustka_traverz = grid_t);

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

// traverzy: podélné (osa X) po stranách + příčky (osa Y) u každého ťupku
module grid_walls() {
    h  = brick_h - top_t + 0.01;
    js = long_all ? [1 : ny - 1] : [1, ny - 1];
    // podélné traverzy
    for (j = js)
        translate([wall - 0.01, -W/2 + j * pitch - grid_t/2, 0])
            cube([L - 2*wall + 0.02, grid_t, h]);
    // příčné příčky (osa Y) u každého ťupku
    if (cross_walls)
        for (k = [1 : nx - 1]) {
            if (long_all) {
                // přes celou šířku (plná mřížka)
                translate([k * pitch - grid_t/2, -W/2 + wall - 0.01, 0])
                    cube([grid_t, W - 2*wall + 0.02, h]);
            } else {
                // jen mezi vnější stěnou a boční traverzou (žebříček po stranách)
                translate([k * pitch - grid_t/2, -W/2 + wall - 0.01, 0])
                    cube([grid_t, pitch - wall + 0.01, h]);
                translate([k * pitch - grid_t/2, W/2 - pitch, 0])
                    cube([grid_t, pitch - wall + 0.01, h]);
            }
        }
}

// příčné díry pro lego osičky (mezi ťupky, v poloviční výšce kostičky)
// V příčkách vyříznou drážku; zůstane spodní pás 2,35 mm (objímá ťupek)
// a horní pás pro tuhost.
module pin_holes() {
    for (k = [1 : nx - 1])
        translate([k * pitch, 0, brick_h / 2])
            rotate([90, 0, 0]) cylinder(d = pin_d, h = W + 2, center = true);
}

// ---------- Dutina pro kompresor ----------
module compressor_cavity() {
    // tlustá část: od otevřeného čela (x = 0) až k dorazu
    translate([-1, 0, z0]) rotate([0, 90, 0])
        cylinder(r = r_cav, h = stop_x + 1);
    // tenká část: za dorazem až na konec držáku (doraz = stupeň r_cav -> r_thin_cav)
    translate([stop_x - 0.01, 0, z0]) rotate([0, 90, 0])
        cylinder(r = r_thin_cav, h = L - stop_x + 1.01);
    // je-li držák delší než kompresor, uvolni okolí zadního čela s kontakty
    if (L > comp_end)
        translate([comp_end, 0, z0]) rotate([0, 90, 0])
            cylinder(r = r_cav, h = L - comp_end + 1);
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
            // vstupní drážka: od otevřeného čela (x < 0) k poloze trubičky
            hull() { tube_cyl(0, -ws); tube_cyl(0, x_t); }
            // obloukový zámek
            for (i = [0 : steps - 1])
                hull() {
                    tube_cyl(-lock_angle * i / steps, x_t);
                    tube_cyl(-lock_angle * (i + 1) / steps, x_t);
                }
        }
        // neprorážet strop spodní dutiny
        translate([-3*ws, -W, brick_h]) cube([L + 6*ws, 2*W, 100]);
    }
}

// ---------- Žebra (přítlačná, s náběhem na vstupní straně) ----------
module rib_set(r_nom, r_cl, x0, x1) {
    for (a = [45, 135, 225, 315])
        translate([0, 0, z0]) rotate([a, 0, 0]) hull() {
            // začátek žebra: bez přesahu (náběh)
            translate([x0, r_cl, -rib_w/2])
                cube([0.01, 0.5, rib_w]);
            // plný přesah
            translate([x0 + rib_ramp, r_nom - rib_int, -rib_w/2])
                cube([x1 - x0 - rib_ramp, (r_cl + 0.5) - (r_nom - rib_int), rib_w]);
        }
}

module ribs() {
    // tlustá část: jen před drážkou přívodu
    rib_set(r_body, r_cav, 0.5, x_t - ws/2 - 1);
    // tenká část: od dorazu po konec kompresoru / držáku
    rib_set(r_thin, r_thin_cav, stop_x + 0.5, min(L, comp_end) - 1);
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
            grid_walls();
        }
        compressor_cavity();
        bayonet_slot();
        pin_holes();
    }
    ribs();
    studs();
}
