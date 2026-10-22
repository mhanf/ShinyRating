(function() {
  'use strict';

  const SELECTORS = {
    ratingInput: '.rating_input',
    ratingIcon: '.btn_rating',
    hoverable: '.hover_rating'
  };

  function getIcons(ratingId) {
    return document.querySelectorAll(`div[id^="${ratingId}"][class*="btn_rating"]`);
  }

  function getIcon(ratingId, iNumber) {
    return document.getElementById(`${ratingId}${iNumber}`);
  }

  function applyIconColors(ratingId, targetNumber, cumul) {
    const icons = getIcons(ratingId);
    const total = icons.length;

    icons.forEach((icon, index) => {
      const i = index + 1;
      const onColor = icon.getAttribute('i_on_color');
      const offColor = icon.getAttribute('i_off_color');
      const isActive = cumul === 'true'
        ? i <= targetNumber
        : i === targetNumber;

      icon.style.color = isActive ? onColor : offColor;
    });

    return total;
  }

  function animateElement(elementId, animation, prefix = 'animate__') {
    return new Promise((resolve) => {
      const node = document.getElementById(elementId);
      if (!node || !animation || animation === 'none') {
        resolve();
        return;
      }

      const animationName = `${prefix}${animation}`;
      node.classList.add('animate__animated', animationName);

      const handleEnd = (event) => {
        event.stopPropagation();
        node.classList.remove('animate__animated', animationName);
        resolve();
      };

      node.addEventListener('animationend', handleEnd, { once: true });
    });
  }

  function storeOriginalColors(ratingId, targetNumber, cumul) {
    const icons = getIcons(ratingId);
    const colors = [];

    icons.forEach((icon, index) => {
      const i = index + 1;
      if (cumul === 'true') {
        if (i <= targetNumber) {
          colors[i - 1] = icon.style.color;
          icon.style.color = icon.getAttribute('i_on_color');
        }
      } else {
        colors[i - 1] = icon.style.color;
        icon.style.color = icon.getAttribute('i_on_color');
      }
    });

    return colors;
  }

  function restoreColors(ratingId, originalColors, targetNumber, cumul) {
    const icons = getIcons(ratingId);

    icons.forEach((icon, index) => {
      const i = index + 1;
      if (cumul === 'true') {
        if (i <= targetNumber) {
          icon.style.color = originalColors[i - 1] || icon.getAttribute('i_off_color');
        }
      } else if (i === targetNumber) {
        icon.style.color = originalColors[i - 1] || icon.getAttribute('i_off_color');
      }
    });
  }

  function setClickedColors(ratingId, targetNumber, cumul) {
    const icons = getIcons(ratingId);
    const colors = [];

    icons.forEach((icon, index) => {
      const i = index + 1;
      const onColor = icon.getAttribute('i_on_color');

      if (cumul === 'true' && i <= targetNumber) {
        colors[i - 1] = onColor;
        icon.style.color = onColor;
      } else if (cumul === 'false' && i === targetNumber) {
        colors[i - 1] = onColor;
        icon.style.color = onColor;
      } else {
        colors[i - 1] = icon.style.color;
      }
    });

    return colors;
  }

  function initHover() {
    document.addEventListener('mouseover', (e) => {
      const icon = e.target.closest(SELECTORS.hoverable);
      if (!icon || icon.dataset.hoverLocked === 'true') return;

      const ratingId = icon.getAttribute('rating_id');
      const iNumber = parseInt(icon.getAttribute('i_number'), 10);
      const cumul = icon.getAttribute('cumulation');

      icon.dataset.originalColors = JSON.stringify(
        storeOriginalColors(ratingId, iNumber, cumul)
      );
    });

    document.addEventListener('mouseout', (e) => {
      const icon = e.target.closest(SELECTORS.hoverable);
      if (!icon || icon.dataset.hoverLocked === 'true') return;

      const ratingId = icon.getAttribute('rating_id');
      const iNumber = parseInt(icon.getAttribute('i_number'), 10);
      const cumul = icon.getAttribute('cumulation');
      const originalColors = JSON.parse(icon.dataset.originalColors || '[]');

      restoreColors(ratingId, originalColors, iNumber, cumul);
    });

    document.addEventListener('click', (e) => {
      const icon = e.target.closest(SELECTORS.hoverable);
      if (!icon) return;

      const ratingId = icon.getAttribute('rating_id');
      const iNumber = parseInt(icon.getAttribute('i_number'), 10);
      const cumul = icon.getAttribute('cumulation');

      icon.dataset.hoverLocked = 'true';
      const colors = setClickedColors(ratingId, iNumber, cumul);
      icon.dataset.originalColors = JSON.stringify(colors);

      const input = document.getElementById(ratingId);
      if (input) {
        input.setAttribute('value', icon.getAttribute('i_value'));
        input.dispatchEvent(new CustomEvent('fire', { bubbles: false }));
      }
    });
  }

  function initClick() {
    document.addEventListener('click', (e) => {
      const icon = e.target.closest(SELECTORS.ratingIcon);
      if (!icon || icon.classList.contains('hover_rating')) return;

      const ratingId = icon.getAttribute('rating_id');
      const iNumber = parseInt(icon.getAttribute('i_number'), 10);
      const iValue = icon.getAttribute('i_value');
      const iAnim = icon.getAttribute('i_anim');
      const cumul = icon.getAttribute('cumulation');
      const iconId = icon.id;

      applyIconColors(ratingId, iNumber, cumul);
      animateElement(iconId, iAnim);

      const input = document.getElementById(ratingId);
      if (input) {
        input.setAttribute('value', iValue);
        input.dispatchEvent(new CustomEvent('fire', { bubbles: false }));
      }
    });
  }

  const ratingInputBinding = new Shiny.InputBinding();

  $.extend(ratingInputBinding, {
    find: function(scope) {
      return $(scope).find(SELECTORS.ratingInput);
    },

    getValue: function(el) {
      return $(el).attr('value');
    },

    getId: function(el) {
      return el.id;
    },

    setValue: function(el, value) {
      $(el).attr('value', value);
    },

    subscribe: function(el, callback) {
      $(el).on('fire.rating_input', callback);
    },

    unsubscribe: function(el) {
      $(el).off('.rating_input');
    },

    receiveMessage: function(el, data) {
      const iValue = data.value;
      const number = parseInt($(el).attr('number'), 10);
      const ratingId = $(el).attr('id');

      let iNumber = null;
      let normalizedValue = iValue;

      if (iValue != null) {
        const label = document.getElementById(`${ratingId}-label`);
        if (label) {
          const valueIcon = label.querySelector(`div[i_value="${iValue}"]`);
          iNumber = valueIcon ? parseInt(valueIcon.getAttribute('i_number'), 10) : null;
        }
        if (iNumber == null) {
          normalizedValue = '';
        }
      } else {
        normalizedValue = '';
      }

      this.setValue(el, normalizedValue);

      const icons = getIcons(ratingId);
      icons.forEach((icon, index) => {
        const i = index + 1;
        const onColor = icon.getAttribute('i_on_color');
        const offColor = icon.getAttribute('i_off_color');
        const cumul = icon.getAttribute('cumulation');

        const isActive = cumul === 'true'
          ? (iNumber != null && i <= iNumber)
          : (iNumber != null && i === iNumber);

        icon.style.color = isActive ? onColor : offColor;
      });

      $(el).trigger('fire');
    }
  });

  Shiny.inputBindings.register(ratingInputBinding, 'shiny.ratingInput');

  function init() {
    initHover();
    initClick();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  $(document).on('shiny:connected', init);
})();
