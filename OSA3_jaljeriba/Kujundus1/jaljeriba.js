// Jäljeriba (Breadcrumb) menüü jQuery abil
// HTML-is on pesastatud loend: Kodu > Tehtud tööd > praegune leht

// Kõik tehtud tööd rippmenüü jaoks (teed on Kujundus1 kausta suhtes)
var tehtudTood = [
    ['Teine veebilehe kujundus', '../Kujundus2/index.html'],
    ['Tabelid', 'Tood/Vormid/Tabelid/tabelid.html'],
    ['Iseseisvad tabelid', 'Tood/Vormid/IseseisvadTabelid/iseseisvadTabel.html'],
    ['Map area pilt', 'Tood/Vormid/Maparea/maparea.html'],
    ['Muusika küsimustik', 'Tood/Vormid/Kysimustik/kysimustik.html'],
    ['LehtToo', 'Tood/Vormid/LehtToo/lehtToo.html'],
    ['Piltide vahetus', 'Tood/Vormid/PiltideVahetus/piltideVahetus.html'],
    ['Programmeerimise küsimustik', 'Tood/Vormid/ProgrKysimustik/progrKysimustik.html'],
    ['Objektid ja meetodid', 'Tood/Vormid/Objektid ja meetodid/Obj_met.html'],
    ['Raamat ja raamatukogu', 'Tood/Vormid/Raamatukogu/raamatukogu.html'],
    ['Kalkulaatorid', 'Tood/Vormid/Kalkulaatorid/Kalkulaatorid.html'],
    ['Kuupäeva funktsioonid', 'Tood/Vormid/KuupevaFunktsioon/kuupevaFunktsioon.html'],
    ['jQuery kasutamine', 'Tood/Vormid/jQuery/jQuery.html'],
    ['Muusika küsimustik (jQuery valideerimine)', 'Tood/Vormid/Kysimustik_jQuery/kysimustik.html']
];


// Lühikirjeldused vihjemullide jaoks (teed on Kujundus1 kausta suhtes)
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
    'Tood/Vormid/Maparea/monitor.html': 'Map area alamleht: lühike info monitori kohta.',
    'Tood/Vormid/Maparea/keyboard.html': 'Map area alamleht: lühike info klaviatuuri kohta.',
    'Tood/Vormid/Maparea/mouse.html': 'Map area alamleht: lühike info arvutihiire kohta.',
    'Tood/Vormid/Maparea/phone.html': 'Map area alamleht: lühike info nutitelefoni kohta.',
    'Tood/Vormid/Maparea/plant.html': 'Map area alamleht: lühike info toataime kohta.',
    'Tood/Vormid/Maparea/speakers.html': 'Map area alamleht: lühike info kõlarite kohta.',
    'Tood/Vormid/Kysimustik/kysimustik.html': 'HTML vormiga küsimustik muusikamaitse kohta: nimi, stiil, platvorm ja lemmikmuusikud.',
    'Tood/Vormid/LehtToo/lehtToo.html': 'Harjutusleht HTML põhielementidega: pealkirjad, lõigud, loendid ja tabel.',
    'Tood/Vormid/PiltideVahetus/piltideVahetus.html': 'Juhuslik pilt ja mõistatus – arva ära, mis pildil on, ja vaheta pilte raadionuppudega.',
    'Tood/Vormid/ProgrKysimustik/progrKysimustik.html': 'Küsimustik programmeerimiskeelte ja programmeerimise õppimise kohta.',
    'Tood/Vormid/Objektid ja meetodid/Obj_met.html': 'JavaScripti objektid: auto objekt, autode massiiv ja massiivi meetodid.',
    'Tood/Vormid/Raamatukogu/raamatukogu.html': 'JavaScripti ülesanne: raamatu objekt ja raamatukogu.',
    'Tood/Vormid/Kalkulaatorid/Kalkulaatorid.html': 'Meetri/tolli teisendaja ja joogi hinna kalkulaator JavaScriptiga.',
    'Tood/Vormid/KuupevaFunktsioon/kuupevaFunktsioon.html': 'Kuupäeva ja kellaajaga töötamine JavaScripti funktsioonide abil.',
    'Tood/Vormid/KuupäevaFunktsioon/kuupäevaFunktsioon.html': 'Kuupäeva ja kellaajaga töötamine JavaScripti funktsioonide abil.',
    'Tood/Vormid/jQuery/jQuery.html': 'Esimesed jQuery katsetused: $(document).ready(), nupud ja efektid.',
    'Tood/Vormid/Kysimustik_jQuery/kysimustik.html': 'Muusika küsimustik, mille välju kontrollitakse jQuery valideerimisega.'
};

$(function () {
    // loendid muudetakse reaks (nagu Metsheina näites)
    $('#menyy, #menyy ul').addClass('ul_kujundus');
    // alamtasemete ette tuleb eraldaja
    $('#menyy ul li').addClass('li_kujundus');

    // esimene lüli on Kodu, viimane on leht, kus kasutaja praegu on
    $('#menyy li').first().addClass('esimene');
    $('#menyy li').last().addClass('praegune');

    // hover-efekt linkidel
    $('#menyy a').hover(function () {
        $(this).addClass('hover');
    }, function () {
        $(this).removeClass('hover');
    });

    looRippmenyy();
    looVihjed();
});

// Rippmenüü "Tehtud tööd" lüli juurde
function looRippmenyy() {
    // juurkausta tee saadakse Kodu lingist, nt "../../../index.html" -> "../../../"
    var kodu = $('#menyy .esimene > a').attr('href');
    if (!kodu) return;               // avalehel pole Kodu linki ega "Tehtud tööd" lüli
    var juur = kodu.replace('index.html', '');

    // "Tehtud tööd" lüli: link (alamlehtedel) või tekst (tood.html lehel)
    var $lyli = $('#menyy li > a[href$="tood.html"], #menyy li > span').filter(function () {
        return $.trim($(this).text()) === 'Tehtud tööd';
    }).first();
    if ($lyli.length === 0) return;   // nt avalehel pole seda lüli

    var $nupp = $('<button type="button" class="ripp-nupp" title="Näita kõiki töid">&#9662;</button>');
    var $loend = $('<ul class="rippmenyy"></ul>');
    var praeguneLeht = decodeURIComponent(location.pathname);

    $.each(tehtudTood, function (i, too) {
        var $a = $('<a></a>').attr('href', juur + too[1]).text(too[0]);
        // praegune töö märgitakse ära
        if (praeguneLeht.indexOf(too[1].replace('../', '')) !== -1) {
            $a.addClass('aktiivne');
        }
        $loend.append($('<li></li>').append($a));
    });

    // lüli, nupp ja loend pannakse ühte ümbrisesse
    $lyli.wrap('<span class="ripp-ymbris"></span>');
    $lyli.after($nupp, $loend);
    $loend.hide();

    // klikk noolel: rippmenüü avaneb/sulgub animatsiooniga
    $nupp.on('click', function (e) {
        e.stopPropagation();
        if ($loend.is(':visible')) {
            $loend.slideUp(250);
            $nupp.removeClass('avatud');
        } else {
            $loend.slideDown(250);
            $nupp.addClass('avatud');
        }
    });

    // klikk mujal lehel sulgeb menüü
    $(document).on('click', function (e) {
        if (!$(e.target).closest('.ripp-ymbris').length) {
            $loend.slideUp(250);
            $nupp.removeClass('avatud');
        }
    });

    // hover-efekt rippmenüü linkidel
    $loend.find('a').hover(function () {
        $(this).addClass('hover');
    }, function () {
        $(this).removeClass('hover');
    });
}

// Vihjemullid: hiirega lülile või rippmenüü lingile liikudes näidatakse lehe kirjeldust
function looVihjed() {
    // juurkaust: Kodu lingi järgi (avalehel on see sama kaust)
    var kodu = $('#menyy .esimene > a').attr('href') || 'index.html';
    var juur = kodu.replace('index.html', '');

    // kirjeldused absoluutse aadressi järgi, et iga link leiaks oma teksti
    var aadressiJargi = {};
    $.each(kirjeldused, function (tee, tekst) {
        aadressiJargi[new URL(juur + tee, location.href).href] = tekst;
    });

    var $vihje = $('<div id="vihje"></div>').appendTo('body').hide();

    function liiguta(e) {
        $vihje.css({ left: e.pageX + 15, top: e.pageY + 18 });
    }

    $('.jaljeriba').on('mouseenter', 'a, .praegune > span', function (e) {
        // link -> selle lehe kirjeldus, praegune lüli -> selle lehe kirjeldus
        var aadress = this.href ? this.href : location.href.split('#')[0];
        var tekst = aadressiJargi[aadress];
        if (!tekst) return;
        $vihje.text(tekst).stop(true, true).fadeIn(250);
        liiguta(e);
    }).on('mousemove', 'a, .praegune > span', liiguta)
      .on('mouseleave', 'a, .praegune > span', function () {
        $vihje.stop(true, true).fadeOut(200);
    });
}
