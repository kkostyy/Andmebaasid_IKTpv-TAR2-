// Rippmenüü "Tehtud tööd" peamenüüs jQuery abil

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
});
