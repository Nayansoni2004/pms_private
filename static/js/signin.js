const user_signin_status = document.querySelector('#user_signin_status'); //address bar url parameters
const email_error = document.querySelector('#email_error'); //div element
const password_error = document.querySelector('#password_error'); //div element 

const activation_modal = new bootstrap.Modal('#activation_modal'); //get modal
const status_title = document.querySelector('#status_title'); //modal heading tag
const message = document.querySelector('#message'); //modal body
const sendActivationLink = document.querySelector('#sendActivationLink'); //button

if(user_signin_status.value) { //check if value is comming or not..
    switch(parseInt(user_signin_status.value)) //url is in string so parse it
    {
        case -1:
            email_error.innerText = 'Email not found. Please check or register.';
            email_error.classList.remove('invisible');
            break;
        case 0:
            password_error.innerText = 'Incorrect Password';
            password_error.classList.remove('invisible');
            break;
        case 2:
            status_title.innerText = 'Your Account is Inactive';
            message.innerText = 'To activate your account, click the button below to receive an activation link on your registered email!';
            activation_modal.show();
            break;
        case 3:
            status_title.innerText = 'Account Blocked - Access Restricted';
            message.innerText = 'Your account has been blocked due to security reasons or policy violations.';
            sendActivationLink.classList.add("d-none");
            activation_modal.show();
            break;
        case 4:
            status_title.innerText = 'Account Closed - Access Disabled';
            message.innerText = 'To reactivate your account, click the button below to receive an reactivation link on your registered email!!';
            activation_modal.show();   
    }
}

//login fail modal event for send activation link button...
sendActivationLink.addEventListener('click', function() {
    window.location.href = 'send_activation_link.do?email=${param.email}';
});

