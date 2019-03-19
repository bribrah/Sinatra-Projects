const input = document.querySelector("input");
console.log("ASJDASDJASDJASDJ")
input.addEventListener('keyup', e => {
    console.log('Caret at: ', e.target.selectionStart)
})