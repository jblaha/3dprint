// ============================================================
// LEGO Pneumatic - přepínač vzduchu (1 vstup, 2 výstupy)
// Všechny tři otvory v čelní stěně (z = 0), dostupné zezadu po sundání krytu.
// Osa rotoru = osa Z, vstup uprostřed, výstupy na ose X
// ============================================================
$fn = 64;

// ---------- zobrazení ----------
zobrazit = "sestava";   // "sestava", "telo", "kryt", "rotor", "paka", "tisk"
uhel_nahled = 0;        // náhled natočení rotoru (0 = oba výstupy zavřené)

// ---------- LEGO ----------
rastr = 8;
cep_d = 4.8;
cep_v = 1.8;
cepy_zapnout = true;

// ---------- bronzové trubičky (ZMĚŘ svůj límec!) ----------
trubka_otvor_d = 2.8;
lem_d = 4.4;
lem_v = 0.6;
lem_vule = 0.3;

// ---------- tělo ----------
sirka = 24;
vyska = 25.6;
delka_tela = 24;
celo = 3;
komora_r = 8.2;
vystup_r = 5.5;         // vzdálenost výstupů od osy (vstup je na ose)

// ---------- rotor ----------
hridel_r = 3.8;
plocha = 3.3;
vule_osove = 0.2;
rotor_vule_r = 0.25;
pad_v = 4;
okraj_r = 0.6;
rezerva = 5;
prirub_r = 4.9;
kavita_d = 5.2;         // dutina v čele rotoru nad vstupem
okno_w = 3;             // šířka okna z dutiny do komory

// ---------- kryt ----------
kryt_t = 3;
lem_h = 8;
zap_v = 0.8;

// ---------- páčka ----------
paka_t = 8;
paka_d = 24;
paka_vule = 0.1;
hl_osy = 10;

// ---------- odvozené hodnoty ----------
w = asin((trubka_otvor_d / 2 + okraj_r) / vystup_r);
vych_uhel = 2 * w + rezerva + 7;
z_rotor0 = celo + vule_osove;
pad_r = komora_r - rotor_vule_r;
hridel_konec = delka_tela + kryt_t + 0.5;
r_out = komora_r - 0.15;
r_in = komora_r - 1.5;

// ---------- pomocné moduly ----------
module sektor(r1, r2, a1, a2) {
    n = max(2, ceil((a2 - a1) / 5));
    vnejsi = [for (i = [0:n]) let(a = a1 + (a2 - a1) * i / n) [r2 * cos(a), r2 * sin(a)]];
    vnitrni = [for (i = [n:-1:0]) let(a = a1 + (a2 - a1) * i / n) [r1 * cos(a), r1 * sin(a)]];
    polygon(concat(vnejsi, vnitrni));
}

module kriz() {
    square([4.9, 1.95], center = true);
    square([1.95, 4.9], center = true);
}

module dd(r, p) {
    intersection() {
        circle(r = r);
        square([2 * r + 2, 2 * p], center = true);
    }
}

module cepy() {
    for (i = [-1:1]) for (j = [0:2])
        translate([i * rastr, vyska / 2, rastr / 2 + j * rastr])
            rotate([-90, 0, 0]) cylinder(d = cep_d, h = cep_v);
}

// ---------- TĚLO ----------
module telo() {
    difference() {
        union() {
            translate([-sirka / 2, -vyska / 2, 0]) cube([sirka, vyska, delka_tela]);
            if (cepy_zapnout) cepy();
        }
        // komora
        translate([0, 0, celo]) cylinder(r = komora_r, h = delka_tela);
        // tři otvory v čelní stěně: vstup uprostřed, dva výstupy + vybrání pro límce
        for (x = [-vystup_r, 0, vystup_r]) {
            translate([x, 0, -1]) cylinder(d = trubka_otvor_d, h = celo + 2);
            translate([x, 0, celo - lem_v - 0.1])
                cylinder(d = lem_d + lem_vule, h = lem_v + 0.2);
        }
        // kapsy pro západku krytu
        for (sx = [-1, 1])
            translate([sx * (komora_r + 0.6), 0, delka_tela - 5.2])
                cube([1.8, 5.4, 3.4], center = true);
    }
}

// ---------- KRYT (lokálně: deska z = 0..kryt_t, objímka do -Z) ----------
module vystupek() {
    rotate([90, 0, 0]) linear_extrude(height = 5, center = true)
        polygon([[r_out - 0.2, -6.5], [r_out + zap_v, -5.7],
                 [r_out + zap_v, -4.8], [r_out - 0.2, -4.0]]);
}

module kryt() {
    difference() {
        union() {
            translate([-sirka / 2, -vyska / 2, 0]) cube([sirka, vyska, kryt_t]);
            translate([0, 0, -lem_h]) cylinder(r = r_out, h = lem_h + 0.01);
            vystupek();
            mirror([1, 0, 0]) vystupek();
        }
        translate([0, 0, -lem_h - 1]) cylinder(r = r_in, h = lem_h + 1);
        translate([0, 0, -1]) cylinder(r = hridel_r + 0.3, h = kryt_t + 2);
        for (sx = [-1, 1]) for (sy = [-1, 1])
            translate([sx * (r_out + r_in) / 2, sy * 3.3, -lem_h / 2])
                cube([r_out - r_in + 2, 0.8, lem_h + 0.2], center = true);
    }
}

// ---------- ROTOR ----------
module rotor() {
    difference() {
        union() {
            translate([0, 0, z_rotor0]) cylinder(r = hridel_r, h = hridel_konec - z_rotor0);
            translate([0, 0, z_rotor0]) linear_extrude(pad_v) {
                sektor(hridel_r - 0.5, pad_r, -w - vych_uhel, w + rezerva);
                sektor(hridel_r - 0.5, pad_r, 180 - w - rezerva, 180 + w + vych_uhel);
            }
            translate([0, 0, delka_tela - (prirub_r - hridel_r)])
                cylinder(r1 = hridel_r, r2 = prirub_r, h = prirub_r - hridel_r);
            translate([0, 0, hridel_konec]) linear_extrude(paka_t) dd(hridel_r, plocha);
        }
        // dutina nad vstupem a okno do komory (v mezeře mezi záslepkami, směr +Y)
        translate([0, 0, z_rotor0 - 1]) cylinder(d = kavita_d, h = pad_v + 1.5);
        translate([-okno_w / 2, 0, z_rotor0 - 1]) cube([okno_w, hridel_r + 1, pad_v + 1]);
        // křížová díra pro LEGO osičku
        translate([0, 0, hridel_konec + paka_t - hl_osy])
            linear_extrude(hl_osy + 1) kriz();
    }
}

// ---------- PÁČKA ----------
module paka() {
    difference() {
        union() {
            cylinder(r = 6, h = paka_t);
            hull() {
                cylinder(r = 5, h = paka_t);
                translate([0, paka_d, 0]) cylinder(r = 3.5, h = paka_t);
            }
        }
        translate([0, 0, -1]) linear_extrude(paka_t + 2)
            dd(hridel_r + paka_vule, plocha + paka_vule);
    }
}

// ---------- SESTAVA / TISK ----------
module sestava() {
    color("lightgray") telo();
    color("steelblue") translate([0, 0, delka_tela]) kryt();
    rotate([0, 0, uhel_nahled]) {
        color("orange") rotor();
        color("tomato") translate([0, 0, hridel_konec]) paka();
    }
}

module tisk() {
    telo();
    translate([32, 0, kryt_t]) rotate([180, 0, 0]) kryt();
    translate([-30, 0, -z_rotor0]) rotor();
    translate([-30, -45, 0]) paka();
}

if (zobrazit == "sestava") sestava();
else if (zobrazit == "telo") telo();
else if (zobrazit == "kryt") kryt();
else if (zobrazit == "rotor") rotor();
else if (zobrazit == "paka") paka();
else tisk();