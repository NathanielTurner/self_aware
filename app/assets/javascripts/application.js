// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery-ui/datepicker
//= require jquery-ui/button
//= require jquery-ui/slider
//= require jquery-ui/tabs
//= require d3.v3
//= require_tree .
$(function() {
  $(document).foundation({
    reveal : {
      animation_speed: 150,
      animation: 'fade'
    }
  });
});

$(function() {
  $( "#tabs" ).tabs();
});

$(document).ready(function() {

    var weeklyInput = $('input#budget_weekly_limit');
    var monthlyInput = $('input#budget_monthly_limit');
  //  monthlyInput.val() == '1';
    $(weeklyInput).on('click', function(){
      if( $(weeklyInput).prop('checked')){
        $(monthlyInput).prop('checked', false);
      }
      if( !($(weeklyInput).prop('checked'))){
        $(monthlyInput).prop('checked', true);
      }
    });
    $(monthlyInput).on('click', function(){
      if( $(monthlyInput).prop('checked')){
        $(weeklyInput).prop('checked', false);
      }
      if( !($(monthlyInput).prop('checked'))){
        $(weeklyInput).prop('checked', true);
      }
    });


});

//sets the checkboxes on task forms to buttons
$(function() {
  $( "#task_sunday" ).button();
  $( "#task_monday" ).button();
  $( "#task_tuesday" ).button();
  $( "#task_wednesday" ).button();
  $( "#task_thursday" ).button();
  $( "#task_friday" ).button();
  $( "#task_saturday" ).button();
});

//gives date fields a calander box to choose dates
$(function() {
  $( "#datepicker" ).datepicker({
    dateFormat: "yy-mm-dd",
    showButtonPanel: true,
    changeMonth: true,
    changeYear: true
  });
});

//builds and sets values for difficulty sliders on task forms
$(document).ready(function() {
  var difficulties = [
    "easy",
    "normal",
    "hard",
    "very hard",
    "nightmarish"
  ];
  //gets the current input value to set the slider and h6 html
  var initialValue = $('input#task_difficulty').val();
  //sets html of the h6 box next to the slider on page load
  $('h6.difficulty-name').html(difficulties[initialValue]);
  $(".difficulty-value").slider({
    value: initialValue,
    min: 0,
    max: 4,
    step: 1,
    slide: function(event, ui) {
      //sets the input value to the value of the slider position.
      $('.new_task').find('#task_difficulty').prop('value', ui.value);
      //sets the html on the h6 next to slider each time slider is moved
      $(this).parent().find('h6.difficulty-name').html(difficulties[ui.value]);
    }
  });
});

//submits a form that sets completed to true and hides the task
function toDoFinishLoad() {
  $('td.to-do-finish').on('click', function(){
    $(this).closest('tr').hide();
    var frm = $(this).find("form");
    frm.on('submit', function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('action'),
        type: $(this).attr('method'),
        data: $(this).serialize(),
      });
    });
    frm.submit();
  });
};

//submits a form that creates a submit table linked to the task cliked on
//it then highlights the task row gray to hint completion
function habitFinishLoad() {
  $('td.habit-finish').on('click', function(){
    $(this).closest('tr').addClass('grayed');
    var frm = $(this).find("form");
    frm.on('submit', function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('action'),
        type: $(this).attr('method'),
        data: $(this).serialize()
      });
    });
    frm.submit();
  });
}
$(document).ready(function(){
  $('td.submit-marker').each(function() {
  var col = $(this);
  if (col.text() === 'true') {
     col.closest('tr').addClass('grayed');
  }
  });
});

// calls these functions on load. They later get called on each task create
$(function(){
  toDoFinishLoad();
  habitFinishLoad();
});

//methods to find and display form messages.
$(document).ready(function(){

  //catches, parses, and sends withdrawal validation errors to renderer
  $('#new_withdrawal').on('ajax:error', function( e, data ){
console.log('withdraw error');
    $(e.currentTarget).render_form_errors( $.parseJSON(data.responseText) );
  });

  //catches, parses, and sends budget validation errors to renderer
  $('#new_budget').on('ajax:error', function( e, data ){
console.log('budget error');
    $(e.currentTarget).render_form_errors( $.parseJSON(data.responseText) );
  });

  //catches, parses, and sends to_do validation errors to renderer
  $('#new_to_do').on('ajax:error', function( e, data ){
console.log('habit error');
    $(e.currentTarget).render_form_errors( $.parseJSON(data.responseText) );
  });

  //catches, parses, and sends habit validation errors to renderer
  $('#new_habit').on('ajax:error', function( e, data ){
console.log('to do error');
    $(e.currentTarget).render_form_errors( $.parseJSON(data.responseText) );
  });
});

//functions for dealing with forms rendered via ajax in modals
(function($) {

  //function for when forms are submitted successfuly in the modals
  $.fn.modal_success = function(){
console.log('on modal success');
    // clicks the reset button on the form
    this.find('form input[type=reset]').trigger('click');
console.log('trigger reset button');
    // closes the modal
    this.find('.close-reveal-modal').trigger('click');
console.log('close modal');
  };


  //function to render error messages by changing field classes and adding html
  //error messages to error boxes
  $.fn.render_form_errors = function(errors){
console.log('error renderer');
    $form = this;
    this.clear_previous_errors();
    model = this.data('model');

    $.each(errors, function(field, messages){
console.log('error class adder');
      //finds the input field the error is about
      $input = $form.find('#' + model + '_' + field);
      //adds a custom error class to the div wrapping the input field.
      $input.closest('.field-input').addClass('field-errors').find('.error-box').html( messages.join(' & ') );
    });

    //clear current error html when clicking reset button
    $('input[type=reset]').click(function(){
console.log('clear error when reset button clicked');
      $form.clear_previous_errors();
    });
  };

  //clears errors by removing the error class and the html in the error box
  $.fn.clear_previous_errors = function(){
console.log('error class remover');
    $('.field-input.field-errors', this).each(function(){
      $('.error-box', $(this)).html('');
      $(this).removeClass('field-errors');
    });
  };

}(jQuery));
