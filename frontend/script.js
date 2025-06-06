const API_URL = '/api';

// Function to add another name input field
function addNameInput() {
    const nameInputsContainer = document.getElementById('nameInputs');
    const newInput = document.createElement('input');
    newInput.type = 'text';
    newInput.classList.add('name-input');
    newInput.placeholder = 'Enter a name';
    nameInputsContainer.appendChild(newInput);
}

// Function to reset the form
function resetForm() {
    const nameInputsContainer = document.getElementById('nameInputs');
    nameInputsContainer.innerHTML = '<label for="names">Enter names:</label><input type="text" class="name-input" placeholder="Enter a name">';
    document.getElementById('number').value = 1;
    document.getElementById('result').innerHTML = '';
}

// Function to validate input and submit the form
function validateAndSubmit() {
    const numberInput = document.getElementById('number').value.trim();
    const resultDiv = document.getElementById('result');
    const count = Number(numberInput);

    if (!Number.isInteger(count) || count <= 0) {
        resultDiv.style.color = 'red'; // Change text color to red for invalid input
        resultDiv.innerHTML = 'The number must be a positive integer';
        return;
    }

    const nameInputs = document.querySelectorAll('.name-input');
    const names = [];
    nameInputs.forEach(input => {
        const name = input.value.trim();
        if (name) {
            names.push(name);
        }
    });

    if (names.length === 0) {
        resultDiv.innerHTML = 'Please enter at least one name';
        return;
    }

    submitForm(names, count);
}

// Function to handle form submission
async function submitForm(names, count) {
    const response = await fetch(`${API_URL}/randomize`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            names: names,
            count: count
        })
    });

    const result = await response.json();
    displayResult(result.randomChoices);
}

// Function to display the result with name and count
function displayResult(randomChoices) {
    const resultDiv = document.getElementById('result');

    // Extra Layer of Validation
    if (randomChoices.length === 0) {
        resultDiv.style.color = 'red'; // Change text color to red for no valid names
        resultDiv.innerHTML = 'No names were selected';
        return;
    }

    const ul = document.createElement('ul');
    ul.style.listStyleType = 'none';

    randomChoices.forEach(randomChoice => {
        const li = document.createElement('li');
        const timeText = randomChoice.count === 1 ? 'time' : 'times';
        li.innerHTML = `${randomChoice.name}: ${randomChoice.count} ${timeText}`;
        ul.appendChild(li);
    });

    // Clear previous results and set text color
    resultDiv.innerHTML = '';
    resultDiv.style.color = '#333'; // Reset text color for valid input
    resultDiv.appendChild(ul);
}
