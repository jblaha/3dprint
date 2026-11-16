// ===== Klip ve tvaru Π pro uchycení kapsáře na čelo šuplíku =====
// (verze s výstupky na vnitřních stranách ramen)

// --- Parametry (mm) ---
inner_w   = 24;   // vnitřní šířka mezi rameny (tloušťka čela šuplíku)
tol       = 0;    // přidaná vůle k vnitřní šířce
thick     = 5;    // tloušťka materiálu (příčka i ramena)
leg_len   = 30;   // délka ramen (od spodní strany příčky)
clip_w    = 20;   // šířka klipu (rozměr podél hrany šuplíku)
round_r   = 1;    // zaoblení vnějších hran (0 = ostré)
tip_chamf = 1.5;  // zkosení konců ramen zvenku (0 = vypnuto)

// --- Výstupky (zuby) ---
bump_on     = true;  // zapnout/vypnout výstupky
bump_h      = 1.2;   // výška výstupku (do vnitřní mezery)
bump_pitch  = 4;     // rozteč zubů (délka jednoho zubu podél ramene)
bump_n      = 5;     // počet zubů na každém rameni
bump_start  = 4;     // vzdálenost prvního zubu od konce ramene

$fn = 48;

iw = inner_w + tol;
ow = iw + 2*thick;
oh = leg_len + thick;

// jeden zub: pozvolný náběh zespoda, strmá hrana nahoře (proti vytažení)
module tooth() {
    polygon([
        [0,      0],
        [bump_h, bump_pitch*0.9],
        [0,      bump_pitch]
    ]);
}

module teeth() {
    for (i = [0 : bump_n-1]) {
        y0 = bump_start + i*bump_pitch;
        // levé rameno
        translate([-iw/2, y0]) tooth();
        // pravé rameno (zrcadlově)
        translate([ iw/2, y0]) mirror([1,0]) tooth();
    }
}

// 2D profil klipu (písmeno Π)
module profile() {
    union() {
        difference() {
            offset(r = round_r) offset(delta = -round_r)
            polygon([
                [-ow/2 + tip_chamf, 0],
                [ ow/2 - tip_chamf, 0],
                [ ow/2,             tip_chamf],
                [ ow/2,             oh],
                [-ow/2,             oh],
                [-ow/2,             tip_chamf]
            ]);
            translate([-iw/2, -1]) square([iw, leg_len + 1]);
        }
        if (bump_on) teeth();
    }
}

module pi_clip() {
    rotate([90, 0, 0])
        linear_extrude(height = clip_w, center = true)
            profile();
}

pi_clip();