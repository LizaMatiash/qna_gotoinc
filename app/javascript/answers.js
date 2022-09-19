

$(document).on('turbolinks:load',function(){
  $('.answers').on('click', '.edit-answer-link', function(e){
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    $('form#edit-answer-' + answerId).show();
  });
  $('.answers').on('click', '.save-answer-link', function(e){
   var answerId = $(this).data('answerId');
   $('div.answer-' + answerId).hide();
  })
  $('.answers').on('click', '.destroy-file', function(e){
   var fileId = $(this).data('fileId');
   $(this).hide();
   $('div.file-' + fileId).hide();
  })
  $('.edit-question').on('click', '.edit-question-link', function(e){
    e.preventDefault();
    $(this).hide();
    $('.edit-question form').show();
  })
  $('.edit-question').on('click', '.destroy-file', function(e){
   var fileId = $(this).data('fileId');
   $(this).hide();
   $('div.file-' + fileId).hide();
  })
});
