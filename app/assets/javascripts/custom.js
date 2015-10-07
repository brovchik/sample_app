function initializeCounter() {
    var POST_LETTERS_INITIAL_COUNT = 140;
    var counterContainer = document.getElementById('remaining-counter');
    var postInputEl = document.getElementById('micropost_content');

    counterContainer.innerText = POST_LETTERS_INITIAL_COUNT - postInputEl.value.length +
            ' symbols remaining';

    postInputEl.addEventListener('keyup', function(e) {
        var postLength = postInputEl.value.length;
        var remain = POST_LETTERS_INITIAL_COUNT - postLength;
        counterContainer.innerText = remain + ' symbols remaining';
    });
}
