function deploy_fairing {
    set fairings to ship:partsdubbedpattern("^fairingsize").
    for fairing in fairings {
        set myModule to fairing:getModule("ModuleProceduralFairing").
        myModule:doAction("deploy", true).
    }
}

function deploy_solar_panels {
    IF not PANELS {
        PANELS ON.
    }
}