# Parametric Top-Hat Plug (OpenSCAD)

A fully parametric, 3D-printable top-hat style plug generator written in OpenSCAD. This script generates a two-tiered cylinder model (a "crown" sitting on a wider "brim") with independent, dimensionally accurate edge fillets.

The model is meticulously designed for manufacturing and 3D printing: using a customized Minkowski rounding technique, it applies smooth fillets to the top outer edges while keeping the bottom surfaces completely flat for optimal bed adhesion and flush mounting.

---

## Features

- **Fully Parametric Design:** Easily customize all critical dimensions (diameters, heights, and thicknesses) using OpenSCAD's Customizer panel or directly via code variables.
- **Independent Fillets:** Separate rounding parameters for both the top crown and the bottom brim.
- **Dimensional Accuracy:** The mathematical compensation adjusts for `minkowski()` expansion, ensuring that your specified target diameters and heights match the final output exactly.
- **3D-Print Optimized:** Keeps the bottom mating surfaces perfectly flat, eliminating the need for support structures.

---

## Geometry Overview

The model consists of two main sections:

1. **The Crown (Top Part):** The primary plugging cylinder.
2. **The Brim (Bottom Part):** The wider collar that prevents the plug from slipping through an opening.






      ┌─────────────────┐
      │   Top Fillet    │
 ┌────┴─────────────────┴────┐
 │                           │  ▲
 │    Top Cylinder (Crown)   │  │ Top Height
 │                           │  ▼


┌───┴───────────────────────────┴───┐
│ Brim Fillet │ ▲ Brim
└───────────────────────────────────┘ ▼ Thickness
◄─────────────── Brim Diameter ─────►
◄─── Top Dia ───►



---

## Parameters & Default Values

The script initializes with the following default dimensions:

| Parameter | Variable Name | Default Value | Description |
| :--- | :--- | :--- | :--- |
| **Top Diameter** | `top_diameter` | `15.3 mm` | Outer diameter of the plug's top cylinder (crown). |
| **Top Height** | `top_height` | `8.0 mm` | Total height of the top cylinder segment. |
| **Top Fillet** | `top_fillet` | `1.5 mm` | Radius of the rounded top edge of the crown (set to `0` for sharp edge). |
| **Brim Diameter** | `brim_diameter` | `25.0 mm` | Outer diameter of the base collar (brim). |
| **Brim Thickness** | `brim_thickness` | `5.0 mm` | Thickness/height of the base collar. |
| **Brim Fillet** | `brim_fillet` | `1.0 mm` | Radius of the rounded outer edge of the brim (set to `0` for sharp edge). |
| **Rendering Quality** | `$fn` | `80` | Number of fragments per full circle. Controls curve smoothness. |

---

## How It Works Under the Hood

Standard OpenSCAD fillet methods utilizing spheres inside `minkowski()` can distort flat planes and enlarge the outer boundaries of your model. 

To solve this, this script uses a specialized compensation algorithm:
- It uses a flat-bottomed **cylinder** as the Minkowski rounding primitive instead of a sphere. This keeps the bottom face entirely flat.
- It subtracts the fillet radius from the raw cylinder dimensions prior to rendering:
  $$\text{Adjusted Height} = \text{Target Height} - \text{Fillet Radius}$$
  $$\text{Adjusted Diameter} = \text{Target Diameter} - (2 \times \text{Fillet Radius})$$

This ensures that when the Minkowski expansion adds the material back, your final export precisely matches your requested parameters.

---

## How to Use

1. **Download OpenSCAD:** Ensure you have [OpenSCAD](https://openscad.org/) installed (version 2021.01 or newer recommended).
2. **Copy the Code:** Paste the provided OpenSCAD code into a new `.scad` file.
3. **Customize Dimensions:**
   - **Via GUI:** Open the **Customizer** panel in OpenSCAD (`View -> Hide Customizer` to uncheck and reveal it) to use sliders/input fields.
   - **Via Code:** Directly modify the variable values at the top of the script.
4. **Render and Export:**
   - Press **F5** to quickly preview your adjustments.
   - Press **F6** to compile the final high-quality geometry (this may take a few seconds due to the Minkowski operation).
   - Press **F7** or click **File -> Export as STL** to save the file for your 3D slicer.

---

## Performance Customization Note

The `minkowski()` function recalculates geometry aggressively. For a fast workflow:
- Set `$fn = 30` or `$fn = 40` while actively tweaking dimensions in the Customizer.
- Bump `$fn` up to `80` or `100` right before hitting **F6** for a perfectly smooth final 3D printable model.


