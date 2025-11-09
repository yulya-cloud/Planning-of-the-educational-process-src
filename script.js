function addReminder() {
    const reminderInput = document.getElementById('reminderInput');
    const reminderText = reminderInput.value.trim();

    // Проверяем, что поле не пустое
    if (reminderText === '') {
        alert("Введите текст напоминания!");
        return;
    }

    // Создаем элемент списка
    const reminderList = document.getElementById('reminderList');
    const li = document.createElement('li');
    li.innerHTML = `
        <span>${reminderText}</span>
        <div>
            <button onclick="markDone(this)">✅</button>
            <button onclick="this.parentElement.parentElement.remove()">🗑️</button>
        </div>
    `;

    reminderList.appendChild(li);

    // Очищаем поле ввода
    reminderInput.value = '';
    reminderInput.focus();
}

function markDone(button) {
    const li = button.closest('li');
    li.querySelector('span').style.textDecoration = 'line-through';
    li.querySelector('span').style.color = '#777';
}
