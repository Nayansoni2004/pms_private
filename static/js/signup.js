const signup_form = document.getElementById("signup_form");
// console.log(signup_form);
const city_list = document.querySelector("#city_list"); //datalist
const input_city = document.querySelector("#city"); //user input city
const city_id = document.querySelector("#city_id"); //hidden field

signup_form.addEventListener('submit', (ev) => {
    ev.preventDefault();

    const options = city_list.options;
    let found = false;
    for(let i = 0 ; i < options.length ; i++) {
        if(options[i].value == input_city.value) {
            console.log(options[i].id);
            city_id.value = options[i].id;
            found = true;
            break;
        }
    }

    //validation for city input...
    if(found == false) {
        alert("Please select a valid city from the list.");
        return;
    }
    signup_form.submit();
});