# Setting --------------------
reset
set nokey
set term gif animate delay 5 size 720, 720
set output 'cardioid.gif'

set size ratio -1
set xl "{/TimesNewRoman:Italic=24 x}"
set yl "{/TimesNewRoman:Italic=24 y}"
set tics font 'TimesNewRoman,20'
set xr[-2.5:4.5]
set yr[-3.5:3.5]
set xtics 1
set ytics 1
set grid

# Cardioid --------------------
a = 2.
x(t) = a*(1+cos(t))*cos(t)
y(t) = a*(1+cos(t))*sin(t)
X(t) = 1+a*cos(t)
Y(t) = a*sin(t)

# Parameter --------------------
cut = 20
n = 0.          # [rad]
d2r = pi/180.   # [deg] -> [rad]
dn = 2*d2r/cut  # [rad]
N = 360*d2r     # [rad]
R = 0.1	        # radius
r = R*0.1       # trajectory

# Plot --------------------
set obj 1 circ at 1, 0 size a/2 fs transparent border lc rgb 'black'
set arrow 1 nohead from -2.5, 0 to 4.5, 0 lc -1 lw 1 back    # x-axis
set arrow 2 nohead from 0, -3.5 to 0, 3.5 lc -1 lw 1 back    # y-axis

do for [j=1:4]{
    if(j%2 != 0){   # Turn old objects smaller
        unset obj N/dn+3
        set obj 3 circ  at x(n), y(n) size R fc rgb 'royalblue' fs solid front

        do for [i=1:N/dn]{
    	    n = n + dn
            set obj i+2 size r
    	    set obj i+3 circ at x(n), y(n) size R fc rgb 'royalblue' fs solid front
    	    if(i%cut == 0){
    	    	set obj 2 circ at X(n), Y(n) size a/2 fs transparent border lc rgb 'black'
    	    	set arrow 3 nohead from X(n), Y(n) to x(n), y(n) lc rgb 'red'
                plot 1/0
            }
        }
    } else {        # Remove old objects
        set obj N/dn+3 size r
        do for [i=1:N/dn]{
    	    n = n + dn
            unset obj i+2
    	    set obj i+3 circ at x(n), y(n) size R fc rgb 'royalblue' fs solid front
    	    if(i%cut == 0){
    	    	set obj 2 circ at X(n), Y(n) size a/2 fs transparent border lc rgb 'black'
    	    	set arrow 3 nohead from X(n), Y(n) to x(n), y(n) lc rgb 'red'
                plot 1/0
            }
        }
    }
}

set out