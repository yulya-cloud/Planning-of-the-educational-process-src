// Initialize task list from localStorage
let tasks = JSON.parse(localStorage.getItem('tasks')) || [];

// Add task function
function addTask(taskName) {
  if (taskName.trim() === '') {
    return;
  }
  
  const task = {
    id: Date.now(),
    name: taskName,
    completed: false
  };
  
  tasks.push(task);
  saveTasks();
  renderTasks();
}

// Save tasks to localStorage
function saveTasks() {
  localStorage.setItem('tasks', JSON.stringify(tasks));
}

// Render tasks to the DOM
function renderTasks() {
  const taskList = document.getElementById('task-list');
  if (!taskList) return;
  
  taskList.innerHTML = '';
  
  tasks.forEach(task => {
    const li = document.createElement('li');
    li.textContent = task.name;
    if (task.completed) {
      li.style.textDecoration = 'line-through';
      li.style.opacity = '0.6';
    }
    taskList.appendChild(li);
  });
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
  renderTasks();
  
  const taskForm = document.getElementById('task-form');
  const taskInput = document.getElementById('task-input');
  
  if (taskForm) {
    taskForm.addEventListener('submit', function(e) {
      e.preventDefault();
      addTask(taskInput.value);
      taskInput.value = '';
    });
  }
});
