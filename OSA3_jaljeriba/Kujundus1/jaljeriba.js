// Jäljeriba (Breadcrumb) menüü jQuery abil
// HTML-is on pesastatud loend: Kodu > Tehtud tööd > praegune leht
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
});
