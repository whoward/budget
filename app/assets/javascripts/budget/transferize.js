
  $(document).on("click", "#transferize", function() {
    var $this = $(this);
    var checked = $("#transactions input[type=checkbox]:checked");

    if(checked.length !== 2) {
      alert("Must select exactly two transactions");
      return false;
    }

    var from_id = $("#transactions tr:has(.negative):has(:input:checked)").attr("data-id");
    var to_id = $("#transactions tr:has(.positive):has(:input:checked)").attr("data-id");

    if(!from_id || !to_id) {
      alert("Select one positive transaction and one negative transaction");
      return false;
    }

    $this.addClass("disabled");

    $.ajax({
      url: $this.attr("href").replace(":from_id", from_id).replace(":to_id", to_id),
      type: "PATCH",
      dataType: "json",
      success: function() {
        window.location.reload();
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(arguments);
        alert("no go :(");
      },
      complete: function() {
        $this.removeClass("disabled");
      }
    });

    return false;
  });
