// Trip type toggle
document.addEventListener('DOMContentLoaded', function() {
    const tripTypeRadios = document.querySelectorAll('input[name="tripType"]');
    const returnDateGroup = document.getElementById('returnDateGroup');

    if (tripTypeRadios.length > 0 && returnDateGroup) {
        tripTypeRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                if (this.value === 'round-trip') {
                    returnDateGroup.style.display = 'block';
                } else {
                    returnDateGroup.style.display = 'none';
                }
            });
        });
    }

    // Set minimum date to today
    const dateInputs = document.querySelectorAll('input[type="date"]');
    const today = new Date().toISOString().split('T')[0];
    dateInputs.forEach(input => {
        input.setAttribute('min', today);
    });
});

// Form validation
function validateSearchForm() {
    const source = document.querySelector('select[name="source"]').value;
    const destination = document.querySelector('select[name="destination"]').value;
    const departDate = document.querySelector('input[name="departDate"]').value;

    if (source === destination) {
        alert('Source and destination cannot be the same!');
        return false;
    }

    if (!departDate) {
        alert('Please select departure date!');
        return false;
    }

    return true;
}

function validateBookingForm() {
    const passengerName = document.querySelector('input[name="passengerName"]').value;
    const passengerEmail = document.querySelector('input[name="passengerEmail"]').value;
    const passengerPhone = document.querySelector('input[name="passengerPhone"]').value;
    const seats = document.querySelector('input[name="seats"]').value;

    if (passengerName.trim().length < 3) {
        alert('Please enter a valid passenger name!');
        return false;
    }

    if (!passengerEmail.includes('@')) {
        alert('Please enter a valid email address!');
        return false;
    }

    if (passengerPhone.length < 10) {
        alert('Please enter a valid phone number!');
        return false;
    }

    if (seats < 1 || seats > 10) {
        alert('Please select between 1 and 10 seats!');
        return false;
    }

    return true;
}

function validateRegisterForm() {
    const username = document.querySelector('input[name="username"]').value;
    const password = document.querySelector('input[name="password"]').value;
    const email = document.querySelector('input[name="email"]').value;
    const phone = document.querySelector('input[name="phone"]').value;

    if (username.length < 3) {
        alert('Username must be at least 3 characters!');
        return false;
    }

    if (password.length < 6) {
        alert('Password must be at least 6 characters!');
        return false;
    }

    if (!email.includes('@')) {
        alert('Please enter a valid email address!');
        return false;
    }

    if (phone.length < 10) {
        alert('Please enter a valid phone number!');
        return false;
    }

    return true;
}
