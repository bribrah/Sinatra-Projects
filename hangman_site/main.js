const input = document.querySelector("input");
input.addEventListener('keyup', e => {
    console.log('Caret at: ', e.target.selectionStart)
})