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

// Function to submit the form and fetch random names
async function submitForm() {
    const nameInputs = document.querySelectorAll('.name-input');
    const numberInput = document.getElementById('number').value;

    // Gather names from input fields, ignoring empty fields
    const names = [];
    nameInputs.forEach(input => {
        const name = input.value.trim();
        if (name) {
            names.push(name);
        }
    });

    // Handle case when there are no valid names entered
    if (names.length === 0) {
        document.getElementById('result').innerHTML = 'Please enter at least one name.';
        return;
    }

    // Send data to the backend API
    const response = await fetch(`${API_URL}/randomize`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            names: names,
            count: parseInt(numberInput)
        })
    });

    const result = await response.json();

    // Display the result
    displayResult(result.randomChoices);
}

// Function to display the result with name and count
function displayResult(randomChoices) {
    const resultDiv = document.getElementById('result');
    resultDiv.innerHTML = ''; // Clear previous results

    if (randomChoices.length === 0) {
        resultDiv.innerHTML = 'No names were selected.';
        return;
    }

    // Create an HTML list to display names and counts
    const ul = document.createElement('ul');

    randomChoices.forEach(randomChoice => {
        const li = document.createElement('li');
        li.innerHTML = `${randomChoice.name}: ${randomChoice.count} time(s)`;
        ul.appendChild(li);
    });

    resultDiv.appendChild(ul);
}
