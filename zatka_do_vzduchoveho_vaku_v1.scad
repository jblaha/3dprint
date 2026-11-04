// Redukce / zátka pro hrdlo vzduchového vaku se žebry
// Všechny rozměry v mm

// --- Parametry ---
hrdlo_d      = 22;   // vnější průměr zátky = průměr hrdla
hrdlo_hloubka = 12;   // hloubka zasunutí do hrdla
limec_d      = 35;   // průměr límce
limec_v      = 4;    // výška límce
otvor_d      = 4;    // průměr otvoru pro trubičku
dno_t        = 4;    // tloušťka dna
stena_t      = 3;    // tloušťka boční stěny (dutá zátka)


vule          = 0.4;  // vůle tělesa zátky vůči hrdlu (zmenšení průměru)

// --- Žebra ---
zebra_pocet   = 4;    // počet žeber
zebra_presah  = 0.5;  // o kolik žebro přesahuje průměr hrdla (stlačení)
zebra_v       = 1.2;  // výška (šířka) paty žebra
zebra_od_limce = 1.0; // odstup prvního žebra od límce

$fn = 120;

telo_d  = hrdlo_d - vule;            // průměr těla zátky
zebro_d = hrdlo_d + zebra_presah;    // vnější průměr žebra

// Jedno klínové žebro (rotační těleso): rovná strana směrem k límci,
// šikmá strana směrem ke dnu (snadné zasunutí)
module zebro(z) {
    translate([0, 0, z])
        rotate_extrude()
            polygon([
                [telo_d/2 - 0.01, 0],
                [zebro_d/2,       zebra_v],
                [telo_d/2 - 0.01, zebra_v]
            ]);
}

module zatka() {
    difference() {
        union() {
            // Zasouvací část
            cylinder(d = telo_d, h = hrdlo_hloubka);

            // Límec
            translate([0, 0, hrdlo_hloubka])
                cylinder(d = limec_d, h = limec_v);

            // Žebra (rozmístěná od límce směrem dolů)
            for (i = [0 : zebra_pocet - 1])
                zebro(hrdlo_hloubka - zebra_od_limce - zebra_v
                      - i * (zebra_v + 0.8));
        }

        // Dutina zespodu
        translate([0, 0, -0.01])
            cylinder(d = telo_d - 2 * stena_t,
                     h = hrdlo_hloubka - dno_t + 0.01);

        // Průchozí otvor pro trubičku
        translate([0, 0, -1])
            cylinder(d = otvor_d, h = hrdlo_hloubka + limec_v + 2);
    }
}

zatka();