(function ($) {
    function init() {
        function copyNumericValue(source, target) {
            var val = source.val().replace(/,/g, "");
            if (!isNaN(val))
                target.val(val);
        }
        function copyBooleanValue(source, target) {
            var val = source[0].checked;
            target.val(val);
        }
        function recalcularTotal() {
            var total = 0;
            var $total = $("#gvDetalleLiquidacion tr input[type=text]#txvValorTotal").each(function () {
                var val = $(this).val();
                var $row = $(this).closest("tr");
                var deduccion = $row.find("#chkDeduccion").is(':checked');
                if (!isNaN(val)) {
                    if (!deduccion)
                        total += parseFloat(val);
                    else
                        total -= parseFloat(val);
                }
            });
            $("#txtTotal").val(total.toFixed(0));
        }
        function recalcularPorcentajes() {
            $("#gvDetalleLiquidacion tr input[type=checkbox]#chkValidaPorcentaje:checked").each(function () {
                var $parent = $(this).closest("tr");
                var totalBaseSeguridadSocial = 0;
                $("#gvDetalleLiquidacion tr input[type=checkbox]#chkBaseSeguridadSocial:checked").each(function () {
                    var $parent = $(this).closest("tr");
                    var val = $parent.find("input[type=hidden]#valorTotal").val();
                    if (!isNaN(val)) {
                        totalBaseSeguridadSocial += parseFloat(val);
                    }
                });
                $parent.find("input[type=text]#txvCantidad").val("1");
                var porcentaje = $parent.find("input[type=text]#txvPorcentaje").val();
                var result = 0;
                if (!isNaN(porcentaje) && !isNaN(totalBaseSeguridadSocial)) {
                    result = totalBaseSeguridadSocial * porcentaje / 100;
                }
                $parent.find("input[type=text]#txvValorUnitario, input[type=text]#txvValorTotal").val(result.toFixed(0));
                $parent.find("input[type=text]#txvValorUnitario, input[type=text]#txvValorTotal, input[type=text]#txvCantidad").trigger('updateValues');

            });
        }
        $("td input[type=text]#txvCantidad").bind('updateValues', function () {
            var $parent = $(this).closest("tr");
            var $target = $parent.find("input[type=hidden]#cantidad");
            copyNumericValue($(this), $target);
        }).keyup();
        $("td input[type=text]#txvValorUnitario").bind('updateValues', function () {
            var $parent = $(this).closest("tr");
            var $target = $parent.find("input[type=hidden]#valorUnitario");
            copyNumericValue($(this), $target);
        }).keyup();
        $("td input[type=text]#txvValorTotal").bind('updateValues', function () {
            var $parent = $(this).closest("tr");
            var $target = $parent.find("input[type=hidden]#valorTotal");
            copyNumericValue($(this), $target);
        }).change();
        /*$("td input[type=text]#txvPorcentaje").keyup(function () {
            var $parent = $(this).closest("tr");
            var $target = $parent.find("input[type=hidden]#Porcentaje");
            copyNumericValue($(this), $target);
        }).keyup();
        $("td input[type=text]#chkDeduccion").change(function () {
            var $parent = $(this).closest("tr");
            var $target = $parent.find("input[type=hidden]#Deduccion");
            copyBooleanValue($(this), $target);
        }).change();
        $("td input[type=text]#chkValidaPorcentaje").change(function () {
            var $parent = $(this).closest("tr");
            var $target = $parent.find("input[type=hidden]#ValidaPorcentaje");
            copyBooleanValue($(this), $target);
        }).change();
        $("td input[type=text]#chkBaseSeguridadSocial").change(function () {
            var $parent = $(this).closest("tr");
            var $target = $parent.find("input[type=hidden]#BaseSeguridadSocial");
            copyBooleanValue($(this), $target);
        }).change();*/

        $("td input[type=text]#txvCantidad, td input[type=text]#txvValorUnitario").keyup(function () {
            var $parent = $(this).closest("tr");
            var $total = $parent.find("td input[type=text]#txvValorTotal");
            var $cantidad = $parent.find("td input[type=text]#txvCantidad").val().replace(/,/g, "");
            var $valor_unitario = $parent.find("td input[type=text]#txvValorUnitario").val().replace(/,/g, "");
            if (isNaN($cantidad) || isNaN($valor_unitario)) {
                return;
            }
            var total = $cantidad * $valor_unitario;
            $total.val(total.toFixed(0));
            recalcularPorcentajes();
            recalcularTotal();
            $parent.find("input[type=text]#txvValorUnitario, input[type=text]#txvValorTotal, input[type=text]#txvCantidad").trigger('updateValues');
        }).keyup();

    }
    $(document).ready(function () {
        init();
    });
})(jQuery)
