// Redukce / zátka pro hrdlo vzduchového vaku
// Všechny rozměry v mm

// --- Parametry ---
hrdlo_d      = 22;   // vnější průměr zátky = průměr hrdla
hrdlo_hloubka = 12;   // hloubka zasunutí do hrdla
limec_d      = 35;   // průměr límce
limec_v      = 4;    // výška límce
otvor_d      = 4;    // průměr otvoru pro trubičku
dno_t        = 4;    // tloušťka dna
stena_t      = 3;    // tloušťka boční stěny (dutá zátka)

// Vůle pro 3D tisk (zmenšení průměru zasouvané části)
vule         = 0.2;

$fn = 120;

module zatka() {
    difference() {
        union() {
            // Zasouvací část (do hrdla)
            cylinder(d = hrdlo_d - vule, h = hrdlo_hloubka);

            // Límec (zarážka) nad zasouvací částí
            translate([0, 0, hrdlo_hloubka])
                cylinder(d = limec_d, h = limec_v);
        }

        // Dutina zespodu (vnitřek vaku)
        translate([0, 0, -0.01])
            cylinder(d = hrdlo_d - vule - 2 * stena_t,
                     h = hrdlo_hloubka - dno_t + 0.01);

        // Průchozí otvor pro trubičku
        translate([0, 0, -1])
            cylinder(d = otvor_d, h = hrdlo_hloubka + limec_v + 2);
    }
}

zatka();