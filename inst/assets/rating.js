
// Changes color on hover
$(document).ready(function(){
var originalColors = [];
    // function at beginning of hover
    $(function() {
        $('.hover_rating').hover(function(){
          const i_click = $(this)
          const cumul = $(this).attr('cumulation');
          const number = $(this).attr('number')
          const i_number = $(this).attr('i_number')
          const rating_id = $(this).attr('rating_id')
          // cumul is true
          if (cumul == 'true'){
            for (var i = 1; i<= i_number; i++){
            var icon_id = $('i[id=' + rating_id + i + ']');
            originalColors[i-1] = icon_id.css('color');
            icon_id.css('color', icon_id.attr('on_color'));
          }
          // when clicked durng hover
          i_click.on('click',function(){
            for (var i = 1; i<= i_number; i++){
              var icon_id = $('i[id=' + rating_id + i + ']');
              var color = icon_id.attr('on_color')
              originalColors[i-1] = color;
              icon_id.css('color', color)
            }
            })
          }
          // cumul is false
          else {
            originalColors[$(this).index('.hover_rating')] = $(this).css('color');
            const color = $(this).attr('on_color')
            $(this).css('color', color);
            $(this).on('click',function(){
              originalColors[$(this).index('.hover_rating')] = color;
            })
          }
        },
        // function at end of hover
        function(){
          var i_click = $(this)
          var cumul = $(this).attr('cumulation');
          var number = $(this).attr('number')
          var i_number = $(this).attr('i_number')
          const rating_id = $(this).attr('rating_id')
          // cumul is true
          if (cumul == 'true'){
            for (var i = 1; i<= i_number; i++){
              var icon_id = $('i[id=' + rating_id + i + ']');
              icon_id.css('color', originalColors[i-1]);
            }
          }
          // cumul is false
          else{
           $(this).css('color', originalColors[$(this).index('.hover_rating')]);
          }
        });
    });
});

// animation
const animateCSS = (element, animation, prefix = 'animate__') =>
// We create a Promise and return it
  new Promise((resolve, reject) => {
    const animationName = `${prefix}${animation}`;
    const node = document.querySelector('i[id =' + element +']');

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
$(document).on('click', '.btn_rating', function(evt) {
// icon
const el_icon = $(evt.target);
// icon i_number
const i_number = el_icon.attr('i_number');
// icon id
const id = el_icon.attr('id');
// number
const number = el_icon.attr('number');
// rating_id
const rating_id = el_icon.attr('rating_id');
// el
const el = $('#' + rating_id)
// animation
const anim = el_icon.attr('anim');
const cumul = el_icon.attr('cumulation');


// change color
for (var i = 1; i<= number; i++){
  icon_id = $('i[id=' + rating_id + i + ']');
  var on_color = icon_id.attr('on_color');
  var off_color = icon_id.attr('off_color');

  if (cumul == 'true' && i <= i_number) {$('i[id=' + rating_id + i + ']').css("color", on_color);}
  else if (cumul == 'false' && i == i_number) {$('i[id=' + rating_id + i + ']').css("color", on_color);}
  else { $('i[id=' + rating_id + i + ']').css("color", off_color);}
  }

// animation of clicked icon
animateCSS(id, anim);
// change input value
el.text(parseInt(i_number));
el.attr('value', parseInt(i_number));
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
    return parseInt($(el).attr('value'));
  },
  // Used to retrieve the ID of the object
  // STANDARD
  getId: function(el) {
    return el.id;
  },
  // Used to change the value when update for example
  setValue: function(el, value) {
    $(el).text(value);
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
    const i_number = data.value;
    const number = $(el).attr('number')
    const rating_id = $(el).attr('id')
    // set the new value
    this.setValue(el, data.value);

// change color
for (var i = 1; i<= number; i++){
  icon_id = $('i[id=' + rating_id + i + ']');
  var on_color = icon_id.attr('on_color');
  var off_color = icon_id.attr('off_color');
  var cumul = icon_id.attr('cumulation');
  if (cumul == 'true' && i <= i_number) {
    $('i[id=' + rating_id + i + ']').css("color", on_color);
  }
  else if (cumul == 'false' && i == i_number) {
    $('i[id=' + rating_id + i + ']').css("color", on_color);
  }
  else { $('i[id=' + rating_id + i + ']').css("color", off_color);}
  }
    // fire
    $(el).trigger('fire');
  }
});

// Register this object as a Shiny Input
Shiny.inputBindings.register(rating_input);
