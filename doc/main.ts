const link = document.createElement('link');
link.setAttribute('rel', 'stylesheet');
link.setAttribute('type', 'text/css');
link.setAttribute('href', 'rapidoc.css');

const rapiDocEl = document.querySelector('rapi-doc');
rapiDocEl.addEventListener('spec-loaded', function () {
    rapiDocEl.shadowRoot.appendChild(link);
    rapiDocEl.shadowRoot.querySelectorAll('api-request,api-response')
        .forEach(function (el) {
            el.shadowRoot.appendChild(link.cloneNode(true))
        });
});
