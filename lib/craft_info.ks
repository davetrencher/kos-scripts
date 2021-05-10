function get_isp {
    LIST ENGINES in engineList.

    print "Current stage " + STAGE:NUMBER.

    for engine in engineList {
        print "Stage " +engine:STAGE.
        if (engine:STAGE = STAGE:NUMBER and not engine:FLAMEOUT) {
            print "An engine exists with ISP = " + engine:ISP.
            print "An engine exists with sea level ISP = " + engine:SLISP.
            print "An engine exists with valcuum ISP = " + engine:VISP.
            print "An engine exists with ISPAT(0.25) = " + engine:ISPAT(0.25).
        }
    }
}

function get_total_vacuum_isp {
    LIST ENGINES in engineList.

    print "Current stage " + STAGE:NUMBER.
    SET visp to 0.0.

    for engine in engineList {
        SET visp to visp + engine:VISP.
    }

    return visp.
}