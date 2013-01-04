jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {
  
  start_time = new Date;
  
  # when the dictionary file selector changes upload the file by creating
  # an iframe to the dictionary upload action. when complete show a clear
  # anagram search form.
  $('#file_form input').change(function(){
    $(this).parent().ajaxSubmit({
      beforeSubmit: function(a,f,o) {
        o.url = o.url + ".js";
        o.dataType = 'json';
        $('#dictionary_loading_image').show();
        start_time = new Date;
        $("#anagram_form #word").val("");
        $('#dictionary_information').hide();
        $('#anagram_search').hide();  
        $('#anagram_results').html("");
      },
      complete: function(XMLHttpRequest, textStatus) {
        file_info = XMLHttpRequest.responseText;
        end_time = new Date;
        loading_time = end_time.getTime() - start_time.getTime();
        $('#dictionary_loading_image').hide();
        $('#dictionary_information').html("Loaded " + file_info + " in " + loading_time + " ms.");
        $('#dictionary_information').show();
        $('#anagram_search').show();        
      }
    });
  });
  
  
  # make the anagram search form submit ajax requests
  # calculate query times, display a loading image during the query,
  # and clear the search field when complete
  $('#anagram_form').ajaxForm({
    beforeSubmit: function(a,f,o) {
      o.dataType = 'json';
      o.url = o.url + ".js";
      $('#anagram_loading_image').show();
      start_time = new Date;
    },
    complete: function(XMLHttpRequest, textStatus) {
      $("#anagram_results").prepend(XMLHttpRequest.responseText);
      end_time = new Date;
      loading_time = end_time.getTime() - start_time.getTime();
      $("#anagram_form #word").val("");
      $(".anagram_result_information:first").append(loading_time + " ms.");
      $('#anagram_loading_image').hide();
      $('#anagram_results').show();
    }
  });
  
  // destroy the dictionary and close the session when the window is closed
  window.onunload = function(){
    $.post("/dictionary/destroy", null, null, null);
  }

});

