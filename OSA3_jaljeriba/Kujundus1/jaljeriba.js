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
