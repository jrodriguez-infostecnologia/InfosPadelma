(function ($) {
    function init() {
        $("td .txvCantidad, td .txvValorUnitario").keyup(function () {
            var $parent = $(this).closest("tr");
            var $total = $parent.find("td .txvValorTotal");
            var $cantidad = $parent.find("td .txvCantidad").val().replace(/,/g,"");
            var $valor_unitario = $parent.find("td .txvValorUnitario").val().replace(/,/g, "");;
            if (isNaN($cantidad)) {
                return;
            }
            if (isNaN($valor_unitario)) {
                return;
            }
            var total = $cantidad * $valor_unitario;
            $total.val(total.toFixed(2));
        });
    }
    $(document).ready(function () {
        init();
    });
})(jQuery)
