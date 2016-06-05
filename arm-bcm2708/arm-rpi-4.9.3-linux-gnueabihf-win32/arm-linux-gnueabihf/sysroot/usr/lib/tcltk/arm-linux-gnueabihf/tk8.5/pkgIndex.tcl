if {[catch {package present Tcl 8.5.0}]} return
package ifneeded Tk 8.5.17 [list load [file normalize [file join /usr/lib/arm-linux-gnueabihf libtk8.5.so]] Tk]
