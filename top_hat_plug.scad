// --- Parametric Variables ---
// (All dimensions are in millimeters)
// OpenSCad code by Dr Evangelos Himonides 2026

/* [Top Cylinder (The "Crown")] */
top_diameter   = 15.3; 
top_height     = 8.0;
top_fillet     = 0.5;   // Radius of the top edge rounding (0 for sharp edge)

/* [Bottom Cylinder (The "Brim")] */
brim_diameter  = 25.0;
brim_thickness = 5.0;
brim_fillet    = 0.5;   // Radius of the brim edge rounding (0 for sharp edge)

/* [Rendering Quality] */
$fn = 80; // Smoothness of curves (Note: Minkowski can be slow if this is too high)


// --- Main Module ---
module top_hat_plug() {
    union() {
        // 1. The Brim (Bottom part)
        if (brim_fillet > 0) {
            // Apply fillet to the top outer edge of the brim
            minkowski() {
                cylinder(
                    h = brim_thickness - brim_fillet, 
                    d = brim_diameter - (2 * brim_fillet), 
                    center = false
                );
                // The rounding shape (shifted so the bottom remains flat)
                cylinder(h = brim_fillet, r = brim_fillet);
            }
        } else {
            cylinder(h = brim_thickness, d = brim_diameter, center = false);
        }
        
        // 2. The Top Part (Stacked on top of the brim)
        translate([0, 0, brim_thickness]) {
            if (top_fillet > 0) {
                // Apply fillet to the top outer edge of the crown
                minkowski() {
                    cylinder(
                        h = top_height - top_fillet, 
                        d = top_diameter - (2 * top_fillet), 
                        center = false
                    );
                    // The rounding shape
                    cylinder(h = top_fillet, r = top_fillet);
                }
            } else {
                cylinder(h = top_height, d = top_diameter, center = false);
            }
        }
    }
}

// Render the plug
top_hat_plug();