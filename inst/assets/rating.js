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
// off_color
const off_color = el_icon.attr('off_color');
// on_color
const on_color = el_icon.attr('on_color');
// el
const el = $('#' + rating_id)
// animation
const anim = el_icon.attr('anim');
const cumul = el_icon.attr('cumulation');

console.log("off :" + off_color)
console.log("on :" + on_color)

if (cumul == 'true') {
// change icon color
$('i[rating_id=' + el.attr('id') + ']').slice(0,i_number).css("color", on_color);
$('i[rating_id=' + el.attr('id') + ']').slice(i_number, number).css("color", off_color);
} else {
$('i[rating_id=' + el.attr('id') + ']').slice(0, number).css("color", off_color);
$('i[id=' + id + ']').css("color", on_color);
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
    const on_color = $(el).attr('on_color')
    const off_color = $(el).attr('off_color')
    const id = $(el).attr('id')
    const cumul = $(el).attr('cumulation');

    // set the new value
    this.setValue(el, data.value);
if (cumul == 'true') {
    // change icon color
    $('i[rating_id=' + id + ']').slice(0,i_number).css("color", on_color);
    $('i[rating_id=' + id + ']').slice(i_number, number).css("color", off_color);
} else {
  $('i[rating_id=' + id + ']').slice(0,number).css("color", off_color);
  $('i[id=' + id + i_number + ']').css("color", on_color);
}
    // fire
    $(el).trigger('fire');
  }
});

// Register this object as a Shiny Input
Shiny.inputBindings.register(rating_input);
