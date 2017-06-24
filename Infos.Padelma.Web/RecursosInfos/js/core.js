function confirmSwal($this,title,text) {
    swal({
        title: title,
        text: text,
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "Aceptar",
        cancelButtonText: "Cancelar"
    }).then(function () {
        $this.onclick='';
		//$this= $($this);
        $this.click();
    });
    return false;
}

function addTab(title, url) {
	if (contador < 8) {
		if ($('#tt').tabs('exists', title)) {
			$('#tt').tabs('select', title);
		} else {
			contador++;
			var content = '<iframe  frameborder="0"  src="' + url + '" style="width:100%;min-height:100vh;" onload="resizeIframe(this);"></iframe>';
			$('#tt').tabs('add', {
				title: title,
				content: content,
				closable: true
			});
		}
	}
}

function resizeIframe(obj) {
	obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}

$(window).load(function () {
	$(".loading").fadeOut(750);
});