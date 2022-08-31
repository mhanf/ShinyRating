
// Hover
$(document).ready(function(){
var originalColors = [];
    // function at beginning of hover
    $(function() {
        $('.hover_rating').hover(function(){
          const i_click = $(this)
          // cumul is true
          if (i_click.attr('cumulation') == 'true'){
            for (var i = 1; i<= i_click.attr('i_number'); i++){
            var icon_id = $('span[id=' + i_click.attr('rating_id') + i + ']');
            originalColors[i-1] = icon_id.css('color');
            icon_id.css('color', icon_id.attr('i_on_color'));
          }
          // when clicked during hover
          i_click.on('click',function(){
            for (var i = 1; i<= i_click.attr('i_number'); i++){
              var icon_id = $('span[id=' + i_click.attr('rating_id') + i + ']');
              var color = icon_id.attr('i_on_color')
              originalColors[i-1] = color;
              icon_id.css('color', color)
            }
            })
          }
          // cumul is false
          else {
            originalColors[$(this).index('.hover_rating')] = $(this).css('color');
            const color = $(this).attr('i_on_color')
            $(this).css('color', color);
            $(this).on('click',function(){
              originalColors[$(this).index('.hover_rating')] = color;
            })
          }
        },
        // function at end of hover
        function(){
          const i_click = $(this)
          // cumul is true
          if (i_click.attr('cumulation') == 'true'){
            for (var i = 1; i<= $(this).attr('i_number'); i++){
              var icon_id = $('span[id=' + $(this).attr('rating_id') + i + ']');
              icon_id.css('color', originalColors[i-1]);
            }
          }
          // cumul is false
          else{
           i_click.css('color', originalColors[i_click.index('.hover_rating')]);
          }
        });
    });
});
// animation
const animateCSS = (element, animation, prefix = 'animate__') =>
// We create a Promise and return it
  new Promise((resolve, reject) => {
    const animationName = `${prefix}${animation}`;
    const node = document.querySelector('span[id =' + element +']');

    node.classList.add(`${prefix}animated`, animationName);

    // When the animation ends, we clean the classes and resolve the Promise
    function handleAnimationEnd(event) {
      event.stopPropagation();
      node.classList.remove(`${prefix}animated`, animationName);
      resolve('Animation ended');
    }
    node.addEventListener('animationend', handleAnimationEnd, {once: true});
  });
// Define an event on click
$(document).on('click', '.btn_rating', function() {
// icon
const el_icon = $(this);
// icon i_number
const i_number = el_icon.attr('i_number');
// icon i_value
const i_value = el_icon.attr('i_value');
// icon id
const id = el_icon.attr('id');
// number
const number = el_icon.attr('number');
// rating_id
const rating_id = el_icon.attr('rating_id');
// el
const el = $('#' + rating_id)
// animation
const i_anim = el_icon.attr('i_anim');
const cumul = el_icon.attr('cumulation');
// change color
for (var i = 1; i<= number; i++){
  icon_id = $('span[id=' + rating_id + i + ']');
  var i_on_color = icon_id.attr('i_on_color');
  var i_off_color = icon_id.attr('i_off_color');

  if (cumul == 'true' && i <= i_number) {$('span[id=' + rating_id + i + ']').css("color", i_on_color);}
  else if (cumul == 'false' && i == i_number) {$('span[id=' + rating_id + i + ']').css("color", i_on_color);}
  else { $('span[id=' + rating_id + i + ']').css("color", i_off_color);}
  }
// animation of clicked icon
animateCSS(id, i_anim);
// change input value
// el.text(i_value);
el.attr('value', i_value);
// trigger
el.trigger('fire');
})
// Create a new InputBinding object
var rating_input = new Shiny.InputBinding();
// Extend this object with methods
$.extend(rating_input, {

  // How to find the object
  find: function(scope) {
    return $(scope).find('.rating_input');
  },
  // How to get the value from the objet
  getValue: function(el) {
    return $(el).attr('value');
  },
  // Used to retrieve the ID of the object
  // STANDARD
  getId: function(el) {
    return el.id;
  },
  // Used to change the value when update for example
  setValue: function(el, value) {
    //$(el).text(value);
    $(el).attr('value', value);
  },
  // Register the event, and validate callback
  subscribe: function(el, callback) {
    $(el).on('fire.rating_input', function(e) {
      callback();
    });
  },
  // To remove the binding
  unsubscribe: function(el) {
    $(el).off('.rating_input');
  },
  // What to do when you use
  // session$sendCustomMessage()
  receiveMessage: function(el, data) {
    // var definition
    var i_value = data.value;
    const number = $(el).attr('number')
    const rating_id = $(el).attr('id')
    // find the i_number value associated with i_value
    var i_number = null
    if (i_value != null){
      i_number = $('#' + rating_id + "-label").find('span[i_value =' + i_value + ']').attr('i_number')
      if (i_number == null){
        i_value = ""
      }
    }
    // standardize null i_values
    else{
      i_value = ""
    }
    // set the new value
    this.setValue(el, i_value);
    // change color
    for (var i = 1; i<= number; i++){
      var icon_id = $('span[id=' + rating_id + i + ']');
      var i_on_color = icon_id.attr('i_on_color');
      var i_off_color = icon_id.attr('i_off_color');
      var cumul = icon_id.attr('cumulation');
      if (cumul == 'true' && i <= i_number) {
        icon_id.css("color", i_on_color);
      }
      else if (cumul == 'false' && i == i_number) {
        icon_id.css("color", i_on_color);
      }
      else {
        icon_id.css("color", i_off_color);
      }
    }
    // fire
    $(el).trigger('fire');
  }
});

// Register this object as a Shiny Input
Shiny.inputBindings.register(rating_input);
