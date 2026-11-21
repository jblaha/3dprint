// ============================================================
// LEGO Pneumatic - přepínač vzduchu (1 vstup, 2 výstupy)
// Všechny tři otvory v čelní stěně (z = 0), dostupné zezadu po sundání krytu.
// Osa rotoru = osa Z, vstup uprostřed, výstupy na ose X.
// Páčka: zarážky rozsahu (kolík v drážce) + aretace (pružný jazýček v kroužku)
// Dno: dutiny pro LEGO ťupky (ventil jde nasadit na jinou kostičku)
// ============================================================
$fn = 64;

// ---------- zobrazení ----------
// "sestava", "telo", "kryt", "rotor", "paka", "tisk"
// "rez_x" (řez rovinou x = 0), "rez_y" (řez rovinou y = 0),
// "rez_z" (řez rovinou kolmou na osu, z = rez_z_poloha), "rezy" (všechny tři vedle sebe)
zobrazit = "tisk";
uhel_nahled = 0;        // náhled natočení rotoru (0 = oba výstupy zavřené)
rez_z_poloha = 5.2;     // poloha příčného řezu na ose Z (5.2 = střed záslepek)
rezy_rozestup = 45;     // vzdálenost mezi sestavami v zobrazení "rezy"

// ---------- LEGO ----------
rastr = 8;
cep_d = 4.8;
cep_v = 1.8;
cepy_zapnout = true;
dno_zapnout = true;     // dutiny pro ťupky ve dně
dno_d = 4.9;            // průměr dutiny (ťupka má 4.8; uprav 4.85-5.0 podle tiskárny)
dno_h = 2.2;            // hloubka dutiny (ťupka má 1.7-1.8)

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
kavita_d = 3.2;         // dutina v čele rotoru nad vstupem
okno_d = 3.2;           // kruhové okno do komory (za záslepkami)
okno_z = 1.6;           // výška středu okna nad zadní plochou záslepek

// ---------- kryt ----------
kryt_t = 3;
lem_h = 8;
zap_v = 0.8;
ring_h = 4;             // výška kroužku aretace na krytu
ring_vule = 0.5;        // předpětí aretace (kroužek je o tuto hodnotu větší než náboj páčky)

// ---------- páčka ----------
paka_t = 8;
paka_d = 24;
paka_vule = 0.1;
hl_osy = 10;
R_h = 9;                // poloměr náboje páčky
r_g = 6;                // poloměr, na kterém je kolík zarážky a drážka v krytu
pin_d = 2.4;
pin_len = 1.8;
gw = 2.8;               // šířka drážky pro kolík
groove_hl = 2;          // hloubka drážky v krytu
fing_a1 = 215;          // pružný jazýček: začátek (zde je pevně spojen)
fing_a2 = 325;          // pružný jazýček: volný konec
fing_r1 = 6.7;          // vnitřní poloměr štěrbiny
fing_r2 = 7.5;          // vnější poloměr štěrbiny (tloušťka jazýčku = R_h - fing_r2)
ryska_sirka = 0.8;
ryska_hl = 0.5;

// ---------- odvozené hodnoty ----------
w = asin((trubka_otvor_d / 2 + okraj_r) / vystup_r);
vych_uhel = 2 * w + rezerva + 7;          // úhel, do kterého záslepka ještě těsní
stop_uhel = 2 * w + rezerva + 3.5;        // poloha zarážek a aretace (střed těsnicího okna)
z_rotor0 = celo + vule_osove;
pad_r = komora_r - rotor_vule_r;
hridel_konec = delka_tela + kryt_t + 0.5;
r_out = komora_r - 0.15;
r_in = komora_r - 1.5;
R_ring = R_h + ring_vule;
pin_half = asin((pin_d / 2) / r_g);
fb = fing_a2 - 14;                        // úhel výstupku aretace na jazýčku
paka_rameno_z0 = ring_h - (hridel_konec - delka_tela - kryt_t) + 0.5;  // rameno páčky nad kroužkem

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

module ryska(r1, r2, ang, z_top) {   // vrytá ryska
    rotate([0, 0, ang])
        translate([r1, -ryska_sirka / 2, z_top - ryska_hl])
            cube([r2 - r1, ryska_sirka, ryska_hl + 0.1]);
}

module cepy() {
    for (i = [-1:1]) for (j = [0:2])
        translate([i * rastr, vyska / 2, rastr / 2 + j * rastr])
            rotate([-90, 0, 0]) cylinder(d = cep_d, h = cep_v);
}

module dno_dutiny() {    // dutiny pro ťupky jiné kostičky (stejný rastr jako ťupky nahoře)
    for (i = [-1:1]) for (j = [0:2])
        translate([i * rastr, -vyska / 2 - 0.01, rastr / 2 + j * rastr])
            rotate([-90, 0, 0]) {
                cylinder(d = dno_d, h = dno_h + 0.01);
                cylinder(d1 = dno_d + 0.8, d2 = dno_d, h = 0.4);   // náběhové zkosení
            }
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
        // dutiny pro ťupky ve dně
        if (dno_zapnout) dno_dutiny();
    }
}

// ---------- KRYT (lokálně: deska z = 0..kryt_t, objímka do -Z, kroužek do +Z) ----------
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
            // kroužek aretace
            translate([0, 0, kryt_t - 0.01]) cylinder(r = R_ring + 2, h = ring_h + 0.01);
        }
        // vnitřek objímky a otvor pro hřídel
        translate([0, 0, -lem_h - 1]) cylinder(r = r_in, h = lem_h + 1);
        translate([0, 0, -1]) cylinder(r = hridel_r + 0.3, h = kryt_t + 2);
        // drážky tvořící pružné jazýčky západky
        for (sx = [-1, 1]) for (sy = [-1, 1])
            translate([sx * (r_out + r_in) / 2, sy * 3.3, -lem_h / 2])
                cube([r_out - r_in + 2, 0.8, lem_h + 0.2], center = true);
        // vnitřek kroužku + náběhové zkosení
        translate([0, 0, kryt_t]) cylinder(r = R_ring, h = ring_h + 1);
        translate([0, 0, kryt_t + ring_h - 0.8]) cylinder(r1 = R_ring, r2 = R_ring + 0.8, h = 0.81);
        // vruby aretace (nula a obě krajní polohy)
        for (a = [fb, fb + stop_uhel, fb - stop_uhel])
            rotate([0, 0, a]) translate([0, 0, kryt_t - 0.01]) linear_extrude(ring_h + 0.02)
                polygon([[R_ring - 0.2, -1.9], [R_ring + 0.9, -0.8],
                         [R_ring + 0.9, 0.8], [R_ring - 0.2, 1.9]]);
        // drážka pro kolík zarážky (omezuje rozsah páčky)
        translate([0, 0, kryt_t - groove_hl]) linear_extrude(groove_hl + 0.1)
            sektor(r_g - gw / 2, r_g + gw / 2, 90 - stop_uhel - pin_half, 90 + stop_uhel + pin_half);
        // vrypy na nulovou a krajní polohy
        for (a = [270, 270 + stop_uhel, 270 - stop_uhel])
            ryska(R_ring + 0.3, R_ring + 1.8, a, kryt_t + ring_h);
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
        // vstupní dutina a kruhové okno do komory za záslepkami (směr +Y)
        translate([0, 0, z_rotor0 - 1])
            cylinder(d = kavita_d, h = pad_v + 1 + okno_z + okno_d / 2 + 0.3);
        translate([0, 0, z_rotor0 + pad_v + okno_z]) rotate([-90, 0, 0])
            cylinder(d = okno_d, h = hridel_r + 1);
        // křížová díra pro LEGO osičku
        translate([0, 0, hridel_konec + paka_t - hl_osy])
            linear_extrude(hl_osy + 1) kriz();
    }
}

// ---------- PÁČKA (lokálně: čelní plocha z = 0, kolík do -Z) ----------
module paka() {
    difference() {
        union() {
            cylinder(r = R_h, h = paka_t);
            translate([0, 0, paka_rameno_z0]) hull() {
                cylinder(r = 5, h = paka_t - paka_rameno_z0);
                translate([0, paka_d, 0]) cylinder(r = 3.5, h = paka_t - paka_rameno_z0);
            }
            // výstupek aretace na pružném jazýčku
            rotate([0, 0, fb]) linear_extrude(paka_t)
                polygon([[R_h - 0.4, -1.5], [R_h + 1.0, -0.5],
                         [R_h + 1.0, 0.5], [R_h - 0.4, 1.5]]);
            // kolík zarážky
            translate([0, r_g, -pin_len]) cylinder(d = pin_d, h = pin_len + 0.01);
        }
        // otvor na stopku hřídele
        translate([0, 0, -1]) linear_extrude(paka_t + 2)
            dd(hridel_r + paka_vule, plocha + paka_vule);
        // pružný jazýček: oblouková štěrbina + radiální řez u volného konce
        translate([0, 0, -1]) linear_extrude(paka_t + 2) sektor(fing_r1, fing_r2, fing_a1, fing_a2);
        rotate([0, 0, fing_a2]) translate([fing_r1, -0.4, -1])
            cube([R_h + 3 - fing_r1, 0.8, paka_t + 2]);
        // vrytá ryska ukazatele (na náboji a na rameni)
        ryska(R_h - 1.2, R_h - 0.2, 270, paka_t);
        ryska(R_h + 1, paka_d - 1.5, 90, paka_t);
    }
}

// ---------- SESTAVA / ŘEZY / TISK ----------
module sestava() {
    color("lightgray") telo();
    color("steelblue") translate([0, 0, delka_tela]) kryt();
    rotate([0, 0, uhel_nahled]) {
        color("orange") rotor();
        color("tomato") translate([0, 0, hridel_konec]) paka();
    }
}

// Řez sestavou: odstraní polovinu za rovinou. Všechny roviny procházejí osou (x, y)
// nebo vybraným místem na ose Z (příčný řez).
module rez_x() {   // rovina x = 0 (svislý podélný řez, vidět vstupní dutinu a okno)
    difference() {
        sestava();
        translate([0, -100, -100]) cube([200, 200, 400]);
    }
}

module rez_y() {   // rovina y = 0 (vodorovný podélný řez, vidět oba výstupy a límce trubiček)
    difference() {
        sestava();
        translate([-100, 0, -100]) cube([200, 200, 400]);
    }
}

module rez_z() {   // rovina kolmá na osu, z = rez_z_poloha (vidět záslepky a komoru)
    difference() {
        sestava();
        translate([-100, -100, rez_z_poloha]) cube([200, 200, 400]);
    }
}

module rezy() {
    translate([-rezy_rozestup, 0, 0]) rez_x();
    rez_y();
    translate([rezy_rozestup, 0, 0]) rez_z();
}

module tisk() {
    telo();
    translate([27, 0, kryt_t + ring_h]) rotate([180, 0, 0]) kryt();
    translate([+33, -20, -z_rotor0]) rotor();
    translate([-5, -25, paka_t]) rotate([180, 0, 90]) paka();
}

if (zobrazit == "sestava") sestava();
else if (zobrazit == "telo") telo();
else if (zobrazit == "kryt") kryt();
else if (zobrazit == "rotor") rotor();
else if (zobrazit == "paka") paka();
else if (zobrazit == "rez_x") rez_x();
else if (zobrazit == "rez_y") rez_y();
else if (zobrazit == "rez_z") rez_z();
else if (zobrazit == "rezy") rezy();
else tisk();