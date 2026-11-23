// Rippmenüü "Tehtud tööd" peamenüüs + vihjemullid jQuery abil

// Lühikirjeldused vihjemullide jaoks (lingi href -> tekst)
var kirjeldused = {
    'index.html': 'Avaleht: tervitus ja jQuery efektid – peida/kuva, liiguta ja lohista pealkirja ning pilte.',
    'tutvustus.html': 'Lühike tutvustus minust ja sellest veebilehest.',
    'lingid.html': 'Kasulikud lingid: HTML ja CSS validaator, Moodle ja w3schools.',
    'tood.html': 'Kõik tunnis tehtud tööd ühes nimekirjas – vali töö, mida vaadata.',
    'meedia.html': 'Meedia: pildigalerii, YouTube video, kaart ja muusika.',
    '../Kujundus2/index.html': 'Sama veebileht teistsuguse kujundusega.',
    'Tood/Vormid/Tabelid/tabelid.html': 'HTML tabelid ühendatud lahtritega (colspan, rowspan) ja riikide lipud.',
    'Tood/Vormid/IseseisvadTabelid/iseseisvadTabel.html': 'Iseseisev töö: värviline tabel, kus lahtrid on ühendatud keerulise mustri järgi.',
    'Tood/Vormid/Maparea/maparea.html': 'Arvutilaua pilt klikitavate aladega – vali monitor, klaviatuur, hiir, telefon, kõlarid või taim.',
    'Tood/Vormid/Kysimustik/kysimustik.html': 'HTML vormiga küsimustik muusikamaitse kohta: nimi, stiil, platvorm ja lemmikmuusikud.',
    'Tood/Vormid/LehtToo/lehtToo.html': 'Harjutusleht HTML põhielementidega: pealkirjad, lõigud, loendid ja tabel.',
    'Tood/Vormid/PiltideVahetus/piltideVahetus.html': 'Juhuslik pilt ja mõistatus – arva ära, mis pildil on, ja vaheta pilte raadionuppudega.',
    'Tood/Vormid/ProgrKysimustik/progrKysimustik.html': 'Küsimustik programmeerimiskeelte ja programmeerimise õppimise kohta.',
    'Tood/Vormid/Objektid ja meetodid/Obj_met.html': 'JavaScripti objektid: auto objekt, autode massiiv ja massiivi meetodid.',
    'Tood/Vormid/Raamatukogu/raamatukogu.html': 'JavaScripti ülesanne: raamatu objekt ja raamatukogu.',
    'Tood/Vormid/Kalkulaatorid/Kalkulaatorid.html': 'Meetri/tolli teisendaja ja joogi hinna kalkulaator JavaScriptiga.',
    'Tood/Vormid/KuupevaFunktsioon/kuupevaFunktsioon.html': 'Kuupäeva ja kellaajaga töötamine JavaScripti funktsioonide abil.',
    'Tood/Vormid/jQuery/jQuery.html': 'Esimesed jQuery katsetused: $(document).ready(), nupud ja efektid.',
    'Tood/Vormid/Kysimustik_jQuery/kysimustik.html': 'Muusika küsimustik, mille välju kontrollitakse jQuery valideerimisega.'
};

$(function () {
    var $ripp = $('nav li.ripp');
    var $alammenyy = $ripp.children('ul.alammenyy');

    // alammenüü on alguses peidus
    $alammenyy.hide();

    // hiir "Tehtud tööd" peale -> menüü libiseb alla, hiir ära -> üles
    $ripp.hover(function () {
        $alammenyy.stop(true, true).slideDown(250);
    }, function () {
        $alammenyy.stop(true, true).slideUp(200);
    });

    // hover-efekt kõigil menüü linkidel
    $('nav a').hover(function () {
        $(this).addClass('hover');
    }, function () {
        $(this).removeClass('hover');
    });

    // vihjemull, mis järgneb hiirele
    var $vihje = $('<div id="vihje"></div>').appendTo('body').hide();

    function liiguta(e) {
        $vihje.css({ left: e.pageX + 15, top: e.pageY + 18 });
    }

    $('nav a').on('mouseenter', function (e) {
        var tekst = kirjeldused[$(this).attr('href')];
        if (!tekst) return;
        $vihje.text(tekst).stop(true, true).fadeIn(250);
        liiguta(e);
    }).on('mousemove', liiguta).on('mouseleave', function () {
        $vihje.stop(true, true).fadeOut(200);
    });
});
