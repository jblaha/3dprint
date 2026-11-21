// ============================================================
// LEGO Pneumatic - přepínač vzduchu (1 vstup, 2 výstupy)
// Osa rotoru = osa Z, čelo s výstupy je v z = 0, vstup směřuje dolů (-Y)
// ============================================================
$fn = 64;

// ---------- zobrazení ----------
zobrazit = "tisk";   // "sestava", "telo", "kryt", "rotor", "paka", "tisk"
uhel_nahled = 0;        // náhled natočení rotoru (0 = oba výstupy zavřené)

// ---------- LEGO ----------
rastr = 8;
cep_d = 4.8;
cep_v = 1.8;
cepy_zapnout = true;

// ---------- bronzové trubičky (ZMĚŘ svůj límec!) ----------
trubka_otvor_d = 2.8;   // otvor pro trubičku
lem_d = 4.4;            // průměr límce trubičky
lem_v = 0.6;            // tloušťka límce
lem_vule = 0.3;         // vůle ve vybrání pro límec

// ---------- tělo ----------
sirka = 24;
vyska = 19.2;
delka_tela = 24;
celo = 3;               // tloušťka čelní stěny
komora_r = 7;
rozestup_vystupu = 8;
z_vstup = 11.5;         // poloha vstupu na ose Z (za rotorem)

// ---------- rotor ----------
hridel_r = 3.8;
plocha = 3.3;           // polovina vzdálenosti plošek na stopce
vule_osove = 0.2;       // vůle mezi rotorem a čelní stěnou
rotor_vule_r = 0.25;
pad_v = 4;              // tloušťka záslepek
okraj_r = 0.6;          // přesah záslepky přes okraj trubičky
rezerva = 5;
prirub_r = 4.9;

// ---------- kryt ----------
kryt_t = 3;
lem_h = 8;              // délka zasouvací objímky
zap_v = 0.8;            // výška zapadajícího výstupku (nastavuje sílu držení)

// ---------- páčka ----------
paka_t = 8;
paka_d = 24;            // délka ramene
paka_vule = 0.1;        // těsnost nasazení (0.05 - 0.15)
hl_osy = 10;            // hloubka křížové díry

// ---------- odvozené hodnoty ----------
w = asin((trubka_otvor_d / 2 + okraj_r) / (rozestup_vystupu / 2));
vych_uhel = 2 * w + rezerva + 7;      // max. natočení na každou stranu
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

module kriz() {          // LEGO osička s vůlí
    square([4.9, 1.95], center = true);
    square([1.95, 4.9], center = true);
}

module dd(r, p) {        // profil "double-D" (kruh s ploškami)
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
        // výstupy + vybrání pro límce trubiček (zevnitř)
        for (sx = [-1, 1]) {
            translate([sx * rozestup_vystupu / 2, 0, -1])
                cylinder(d = trubka_otvor_d, h = celo + 2);
            translate([sx * rozestup_vystupu / 2, 0, celo - lem_v - 0.1])
                cylinder(d = lem_d + lem_vule, h = lem_v + 0.2);
        }
        // vstup dolů (-Y) + vybrání pro límec
        translate([0, 0, z_vstup]) rotate([90, 0, 0])
            cylinder(d = trubka_otvor_d, h = vyska / 2 + 1);
        translate([0, 0, z_vstup]) rotate([90, 0, 0])
            cylinder(d = lem_d + lem_vule, h = komora_r + lem_v + 0.1);
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
        // drážky tvořící pružné jazýčky
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
            // osová zámka (zkosená, tiskne se bez podpor)
            translate([0, 0, delka_tela - (prirub_r - hridel_r)])
                cylinder(r1 = hridel_r, r2 = prirub_r, h = prirub_r - hridel_r);
            // stopka pro páčku
            translate([0, 0, hridel_konec]) linear_extrude(paka_t) dd(hridel_r, plocha);
        }
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
    translate([30, 0, kryt_t]) rotate([180, 0, 0]) kryt();
    translate([-20, 0, -z_rotor0]) rotor();
    translate([-20, -40, 0]) paka();
}

if (zobrazit == "sestava") sestava();
else if (zobrazit == "telo") telo();
else if (zobrazit == "kryt") kryt();
else if (zobrazit == "rotor") rotor();
else if (zobrazit == "paka") paka();
else tisk();