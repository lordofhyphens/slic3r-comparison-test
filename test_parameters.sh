#!/bin/bash


for z in 10; do
	for y in 100; do
		for x in `seq 1 0.1 2`; do
			sed -e "s|#Z|$z|" -e "s|#X|$x|" -e "s|#Y|$y|" openscad_box1.scad > tmp.scad && openscad tmp.scad -o box.stl
			for infill in `seq 0  5 100`; do
				echo "fill_density = $infill" >> infill_variance.ini
					for slicer in slic3r-linux-x86-0-9-10b slic3r-linux-x86-0-9-7 slic3r-linux-x86-0-9-8 slic3r-linux-x86-0-9-9 slic3r-linux-x86-1-0-0-RC1 slic3r-linux-x86-1-0-0-RC2 slic3r-linux-x86-1-0-0-RC3 slic3r-linux-x86-1-0-0-stable slic3r-linux-x86-1-0-1-stable slic3r-linux-x86-1-1-0-experimental slic3r-linux-x86-1-1-1-experimental slic3r-linux-x86-1-1-2-experimental slic3r-linux-x86-1-1-3-experimental slic3r-linux-x86-1-1-4 slic3r-linux-x86-1-1-5-stable slic3r-linux-x86-1-1-6-stable slic3r-linux-x86-1-1-7-stable slic3r-linux-x86-1-2-0-experimental slic3r-linux-x86-1-2-1-experimental slic3r-linux-x86-1-2-2-experimental slic3r-linux-x86-1-2-3-experimental slic3r-linux-x86-1-2-4-experimental slic3r-linux-x86-1-2-5-experimental slic3r-linux-x86-1-2-6-experimental slic3r-linux-x86-1-2-7-experimental slic3r-linux-x86-1-2-8-experimental; do  
						./$slicer/bin/slic3r box.stl --load config-1.1.7-test.ini --fill_density ${infill} -o boxtest-${x}.${y}.${z}_$infill-${slicer}.gcode
						# parse the gcode file 
						perim=$(grep "perimeter$" boxtest-${x}.${y}.${z}_$infill-${slicer}.gcode | awk ' { print $4 } ' | cut -c2- | paste -sd+ - | bc)
						u_infill=$(grep "infill$" boxtest-${x}.${y}.${z}_$infill-${slicer}.gcode | awk ' { print $4 } ' | cut -c2- | paste -sd+ - | bc)
						total=$(grep "filament used" | awk '{ print $5}' | awk -Fm '{ print $1 }' | paste -sd+ - | bc)
						echo "[ $X,$Y,$Z ] - $slicer,$perim,$u_infill,$total" >> output.csv
					done
			done
		done
	done
done
