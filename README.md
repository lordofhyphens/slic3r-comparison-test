# slic3r-comparison-test

This is a shell script and some configurations intended to permit people to perform comparisons of filament usage across different versions of Slic3r.

Currently, you need the following to use this work:

* Bash shell  (MSYS from MinGW should do)
* Downloaded copies of the versions of Slic3r you want to compare
* A text editor
* Some experience reading and editing shell scripts (if modifying). 
* OpenSCAD (in your PATH)

The script generates an STL for a Xx100x10 cube and then slices it with Slic3r with different requested infills. 

It then tabulates the amount of filament reported by slic3r. All of the configurations provided were generated with 1.1.7 and assume a filament diameter of ~1.2 (which is close enough to yield the output in mm^3). 

My spreadsheet of results:
https://docs.google.com/spreadsheets/d/1op9u8sXXVkewqdp5VEFlTbZNUQypizXlKJtxaLtTMUA/edit?usp=sharing
