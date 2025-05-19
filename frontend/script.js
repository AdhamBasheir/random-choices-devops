const API_URL = 'http://localhost:3000/api';

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
    resultDiv.style.color = 'red';

    const count = Number(numberInput);

    if (!Number.isInteger(count) || count <= 0) {
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
    resultDiv.innerHTML = ''; // Clear previous results
    resultDiv.style.color = '#333'; // Normal text color for valid result

    // Extra Layer of Validation
    if (randomChoices.length === 0) {
        resultDiv.style.color = 'red';
        resultDiv.innerHTML = 'No names were selected';
        return;
    }

    const ul = document.createElement('ul');

    randomChoices.forEach(randomChoice => {
        const li = document.createElement('li');
        const timeText = randomChoice.count === 1 ? 'time' : 'times';
        li.innerHTML = `${randomChoice.name}: ${randomChoice.count} ${timeText}`;
        ul.appendChild(li);
    });

    resultDiv.appendChild(ul);
}
