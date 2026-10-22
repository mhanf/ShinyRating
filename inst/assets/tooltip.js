(function() {
  'use strict';

  const initialized = new WeakSet();

  function initTooltip(el) {
    if (initialized.has(el) || typeof bootstrap === 'undefined') return;
    initialized.add(el);
    new bootstrap.Tooltip(el);
  }

  function initAllTooltips(scope) {
    const root = scope || document;
    const triggers = root.querySelectorAll('[data-bs-toggle="tooltip"]');
    triggers.forEach(initTooltip);
  }

  function observeDynamicContent() {
    if (typeof MutationObserver === 'undefined') return;

    const observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        mutation.addedNodes.forEach((node) => {
          if (node.nodeType !== Node.ELEMENT_NODE) return;
          if (node.matches('[data-bs-toggle="tooltip"]')) {
            initTooltip(node);
          }
          initAllTooltips(node);
        });
      });
    });

    observer.observe(document.body, { childList: true, subtree: true });
  }

  function init() {
    initAllTooltips();
    observeDynamicContent();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      setTimeout(init, 250);
    });
  } else {
    setTimeout(init, 250);
  }

  $(document).on('shiny:connected', () => {
    setTimeout(initAllTooltips, 250);
  });
})();
