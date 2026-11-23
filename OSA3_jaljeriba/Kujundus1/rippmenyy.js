// "Tehtud tööd" alammenüü hover-efekt jQuery abil (Metsheina näite järgi)
$(function () {
    $('nav a').hover(function (event) {
        $(this).addClass('hover');
    },
    function () {
        $(this).removeClass('hover');
    });
});
