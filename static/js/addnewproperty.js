// Initialize current step
let currentStep = 1;
const totalSteps = 6;

// script to set city_id hidden field based on user dropdown selection for city
document.getElementById("city").addEventListener("change", function () {
  var selectedOption = this.options[this.selectedIndex];
  var cityId = selectedOption.getAttribute("data-id");
  document.getElementById("city_id").value = cityId;
});

// Function to move & display the next step and hide current step
function nextStep() {
  document
    .querySelector(`.step[data-step="${currentStep}"]`)
    .classList.remove("active");
  currentStep++;
  document
    .querySelector(`.step[data-step="${currentStep}"]`)
    .classList.add("active");
  updateProgressBar();
}

// Function to return to the previous step & hide current step
function prevStep() {
  if (currentStep > 1) {
    document
      .querySelector(`.step[data-step="${currentStep}"]`)
      .classList.remove("active");
    currentStep--;
    document
      .querySelector(`.step[data-step="${currentStep}"]`)
      .classList.add("active");
    updateProgressBar();
  }
}

// --------------------Toggle property options based on category selection-------------------
// function togglePropertyOptions(category) {
//   document.getElementById("residentialOptions").classList.add("d-none");
//   document.getElementById("commercialOptions").classList.add("d-none");

//   if (category === "residential") {
//     document.getElementById("residentialOptions").classList.remove("d-none");
//   } else {
//     document.getElementById("commercialOptions").classList.remove("d-none");
//   }
// }
function togglePropertyOptions(category) {
  const res = document.getElementById("residentialOptions");
  const com = document.getElementById("commercialOptions");

  const resSelect = document.getElementById("residentialSelect");
  const comSelect = document.getElementById("commercialSelect");

  // Hide both and remove required
  res.classList.add("d-none");
  com.classList.add("d-none");
  resSelect.removeAttribute("required");
  comSelect.removeAttribute("required");

  // Show selected and set required
  if (category === "residential") {
    res.classList.remove("d-none");
    resSelect.setAttribute("required", "required");
  } else {
    com.classList.remove("d-none");
    comSelect.setAttribute("required", "required");
  }
}

// store total area in session storage to calculate price per sq. ft.
const totalAreaInput = document.getElementById("totalPlotArea");

totalAreaInput.addEventListener("input", () => {
  const totalArea = totalAreaInput.value;
  sessionStorage.setItem("totalArea", totalArea);
});

// additional areas input field (to show and hide when unchecked)
function toggleInput(inputId) {
  const inputField = document.getElementById(inputId);
  inputField.classList.toggle("hidden");
  inputField.required = !inputField.classList.contains("hidden");
}

// if user tick not applicabel in additonal areas then disable & hide other areas in step 3
function handleNotApplicable() {
  const isChecked = document.getElementById("notApplicable").checked;

  // Disable all checkboxes and inputs if Not Applicable is checked
  const checkboxes = ["addCarpetArea", "addTerraceArea", "addParkingArea"];
  const inputs = ["carpetArea", "terraceArea", "parkingArea"];

  checkboxes.forEach((id) => {
    const checkbox = document.getElementById(id);
    checkbox.disabled = isChecked;
    if (isChecked) checkbox.checked = false; // untick the checkbox
  });

  inputs.forEach((id) => {
    const inputField = document.getElementById(id);
    inputField.disabled = isChecked;
    inputField.classList.add("hidden");
    inputField.required = false;
    inputField.value = "";
    //Hide error message also when not applicable is ticked.
    document.getElementById("areaTypeSumMessage").style.display = "none";
  });
}

// Real-time check for additional areas sum must be less than or equal to total area
document.getElementById("carpetArea").addEventListener("input", checkTotalArea);
document
  .getElementById("terraceArea")
  .addEventListener("input", checkTotalArea);
document
  .getElementById("parkingArea")
  .addEventListener("input", checkTotalArea);

function checkTotalArea() {
  const carpetAreaInput = document.getElementById("carpetArea");
  const terraceAreaInput = document.getElementById("terraceArea");
  const parkingAreaInput = document.getElementById("parkingArea");
  const totalAreaInput = document.getElementById("totalPlotArea");

  const carpetArea = carpetAreaInput.value
    ? parseFloat(carpetAreaInput.value)
    : 0;
  const terraceArea = terraceAreaInput.value
    ? parseFloat(terraceAreaInput.value)
    : 0;
  const parkingArea = parkingAreaInput.value
    ? parseFloat(parkingAreaInput.value)
    : 0;
  const totalArea = totalAreaInput.value ? parseFloat(totalAreaInput.value) : 0;

  // Check if the sum of additional areas is greater than the total area
  const sumOfAreas = carpetArea + terraceArea + parkingArea;

  if (sumOfAreas > totalArea) {
    document.getElementById("areaTypeSumMessage").style.display = "block"; // Show error message
  } else {
    document.getElementById("areaTypeSumMessage").style.display = "none"; // Hide error message
  }
}

// step 4 upload property images/videos
const mediaInput = document.getElementById("propertyMedia");
const previewContainer = document.getElementById("previewContainer");

// Display media preview
mediaInput.addEventListener("change", function () {
  if (mediaInput.files.length > 5) {
    alert("You can upload a maximum of 5 media files.");
    mediaInput.value = "";
    return;
  }

  // previewContainer.innerHTML = ""; // Clear previous previews
  // Array.from(mediaInput.files).forEach((file) => {
  //   if (file.size <= 10 * 1024 * 1024) {
  //     const reader = new FileReader();
  //     reader.onload = function (event) {
  //       if (file.type.startsWith("image/")) {
  //         const img = document.createElement("img");
  //         img.src = event.target.result;
  //         img.classList.add("img-thumbnail");
  //         previewContainer.appendChild(img);
  //       } else if (file.type.startsWith("video/")) {
  //         const video = document.createElement("video");
  //         video.src = event.target.result;
  //         video.controls = true;
  //         previewContainer.appendChild(video);
  //       }
  //     };
  //     reader.readAsDataURL(file);
  //   } else {
  //     alert(
  //       "Invalid file type or size. Please upload images or videos under 10MB."
  //     );
  //   }
  // });

  previewContainer.innerHTML = ""; // Clear previous previews

  previewContainer.insertAdjacentHTML(
    "beforeend",
    `
  <div class="d-flex align-items-center gap-2 mb-3">
    <span class="badge text-bg-warning rounded-pill">New Feature</span>
    <span class="text-muted">Now you can select the view type for your image/video</span>
  </div>
    `
  );

  Array.from(mediaInput.files).forEach((file, index) => {
    if (file.size <= 10 * 1024 * 1024) {
      const reader = new FileReader();
      reader.onload = function (event) {
        // Inside reader.onload
        const wrapper = document.createElement("div");
        wrapper.classList.add("preview-wrapper");

        //Create label and dropdown container for view type
        const viewTypeContainer = document.createElement("div");
        viewTypeContainer.classList.add("view-type-container");

        // Label
        const label = document.createElement("label");
        label.innerText = "View Type:";
        label.classList.add("view-label");

        // Dropdown
        const select = document.createElement("select");
        // const baseName = file.name.replace(/\W+/g, "_"); //file name m () or space ko remove kr dena h
        const baseName = file.name; //file name m () or space ko remove kr dena h
        // const uniqueKey = `${baseName}_${Math.random().toString(36).substr(2, 5)}_${index}`; //unique no. generate krna h, length 5 ka
        const uniqueKey = `${baseName}`; //unique no. generate krna h, length 5 ka
        select.name = `view_type_id_${uniqueKey}`; //select tag ka name m unique key set kr dega jo ki (file name + unique no. + loop index) ka combination h.
        // select.name = `view_type_id[]`;
        select.classList.add("form-select", "view-type-select");

        const isVideo = file.type.startsWith("video/"); //disable(Main Card Img)option for videos i.e.option 5

        select.innerHTML = `
          <option value="1">Interior</option>
          <option value="2">Exterior</option>
          <option value="3">Outside View</option>
          <option value="4" selected>Not Specified</option>
          <option value="5" ${isVideo ? 'disabled style="display:none"' : ''}>Main Card Image</option>
        `;
        //Combine label and select tag
        viewTypeContainer.appendChild(label);
        viewTypeContainer.appendChild(select);
        // Label aur dropdown ko ek container me daala

        // Media
        let media;
        if (file.type.startsWith("image/")) {
          media = document.createElement("img");
          media.src = event.target.result;
          media.classList.add("img-thumbnail");
        } else if (file.type.startsWith("video/")) {
          media = document.createElement("video");
          media.src = event.target.result;
          media.controls = true;
        }

        media.classList.add("media-preview");

        // Append
        wrapper.appendChild(viewTypeContainer);
        wrapper.appendChild(media);
        previewContainer.appendChild(wrapper);

        // hidden field to set the media key also with unique key same as view_type_id with a unique no.
        // const hiddenInput = document.createElement("input");
        // hiddenInput.type = "hidden";
        // hiddenInput.name = "media_key[]";
        // hiddenInput.value = uniqueKey;
        // wrapper.appendChild(hiddenInput);

        // debug kr rha hu yaha
        console.log(
          "File:",
          file.name,
          "| Default View Type ID:",
          select.value
        );
        //yaha pe event listener add kro or isko baad m hata dunga me kyuki ye console k liye h
        select.addEventListener("change", function () {
          console.log(
            "File:",
            file.name,
            "| Updated View Type ID:",
            this.value
          );
        });
      };
      reader.readAsDataURL(file);
    } else {
      alert(
        "Invalid file type or size. Please upload images or videos under 10MB."
      );
    }
  });
});

//check which image is selected as(main image)and disable(main card image)option from other dropdowns...
function updateMainCardImageOption() {
  const allSelects = document.querySelectorAll(".view-type-select");
  let selectedMainCardImg = null;

  allSelects.forEach((select) => {
    if (select.value === "5") {
      selectedMainCardImg = select;
    }
  });

  allSelects.forEach((select) => {
    const option = select.querySelector('option[value="5"]');
    if (option) {
      option.disabled = !!selectedMainCardImg && select !== selectedMainCardImg;
    }
  });
}

// Attach event listener to all select boxes
document.addEventListener("change", function (e) {
  if (e.target.classList.contains("view-type-select")) {
    updateMainCardImageOption();
  }
});

// step 5 get total area from session storage to calc. price per sq. ft.
const totalArea = sessionStorage.getItem("totalArea");
const expectedPriceInput = document.getElementById("expectedPrice");
const pricePerSqFtInput = document.getElementById("pricePerSqFt");

// Calculate and Display Price per Sq Ft
expectedPriceInput.addEventListener("input", function () {
  const expectedPrice = parseFloat(expectedPriceInput.value);
  if (expectedPrice && totalArea > 0) {
    const pricePerSqFt = (expectedPrice / totalArea).toFixed(2);
    pricePerSqFtInput.value = "\u20B9 " + `${pricePerSqFt}`;
  } else {
    pricePerSqFtInput.value = "";
  }
});

// step 6 features script for input type number
document.querySelectorAll(".feature-checkbox").forEach((checkbox) => {
  checkbox.addEventListener("change", function () {
    const featureId = this.value; // feature_id from value (form checkbox id)
    const label = this.dataset.label;
    let inputField = this.parentElement.querySelector(".input-distance");

    if (this.checked) {
      if (!inputField) {
        inputField = document.createElement("input");
        inputField.type = "number";
        inputField.className = "input-distance form-control";
        inputField.id = `input-${featureId}`; // set id for backend reference
        inputField.placeholder = `${label}`;
        inputField.required = true; // Required attribute add karna
        this.parentElement.appendChild(inputField);
      }
    } else if (inputField) {
      inputField.remove();
    }
  });
});

// step 6 features script for input type text
document.querySelectorAll(".feature-checkbox-other").forEach((checkbox) => {
  checkbox.addEventListener("change", function () {
    const featureId = this.value; // feature_id from value (form checkbox id)
    const label = this.dataset.label;
    let inputField = this.parentElement.querySelector(".input-description");

    if (this.checked) {
      if (!inputField) {
        inputField = document.createElement("input");
        inputField.type = "text";
        inputField.className = "input-description form-control";
        inputField.id = `input-${featureId}`; // set id for backend reference
        inputField.placeholder = `${label}`;
        inputField.required = true;
        this.parentElement.appendChild(inputField);
      }
    } else if (inputField) {
      inputField.remove();
    }
  });
});

// script to make json object of selected features and their description, and this json will be sent to backend during from submit.
// document.querySelector("form").addEventListener("submit", function (e) {
//   const selectedFeatures = [];

//   // Dono tarah ke checkboxes select karo
//   document.querySelectorAll('.feature-checkbox:checked, .feature-checkbox-other:checked').forEach(checkbox => {
//       const featureId = checkbox.value;
//       const inputField = document.querySelector(`#input-${featureId}`);
//       const description = inputField ? inputField.value : "";

//       selectedFeatures.push({
//           feature_id: parseInt(featureId),
//           description: description
//       });
//   });

//   // Add JSON to hidden input
//   document.getElementById("features-json").value = JSON.stringify(selectedFeatures);
// });

// script to make json object of selected features and their description, and this json will be sent to backend during from submit.
document.querySelector("form").addEventListener("submit", function (e) {
  const selectedFeatures = [];

  // Dono tarah ke checkboxes select karo
  document
    .querySelectorAll(
      ".feature-checkbox:checked, .feature-checkbox-other:checked"
    )
    .forEach((checkbox) => {
      const featureId = parseInt(checkbox.value);
      const inputField = document.querySelector(`#input-${featureId}`);
      const description = inputField ? inputField.value : "";

      selectedFeatures.push({
        propertyFeatureId: null, // new entry hai, isliye null
        property: null, // backend me set hoga
        feature: {
          featureId: featureId,
          title: null, // frontend pe title set nahi kar rahe, backend me ho sakta hai
        },
        description: description,
      });
    });

  // Add JSON to hidden input
  document.getElementById("features-json").value =
    JSON.stringify(selectedFeatures);
});

// Function to show the modal with a dynamic message
function showModal(message) {
  const modalMessageElement = document.getElementById("errorMessage"); // Target modal body by ID
  modalMessageElement.textContent = message; // Update the modal message
  const modal = new bootstrap.Modal(document.getElementById("errorModal"));
  modal.show(); // Show the modal
}

// script to select atleast one property feature
document
  .getElementById("propertyForm")
  .addEventListener("submit", function (event) {
    const checkboxes = document.querySelectorAll(
      ".feature-checkbox, .feature-checkbox-other"
    );
    const isChecked = Array.from(checkboxes).some(
      (checkbox) => checkbox.checked
    );

    if (!isChecked) {
      event.preventDefault();
      showModal("Please select at least one feature before submitting.");
    }
  });

//check additional areas checkbox is ticked or not
function validateAreaSelection() {
  const carpet = document.getElementById("addCarpetArea").checked;
  const terrace = document.getElementById("addTerraceArea").checked;
  const parking = document.getElementById("addParkingArea").checked;
  const notApplicable = document.getElementById("notApplicable").checked;

  if (!carpet && !terrace && !parking && !notApplicable) {
    showModal('Please select at least one area type or "Not Applicable".');
    return false;
  }
  return true; // If valid, return true
}

const validateAreaSum = () => {
  const carpetInput = document.getElementById("carpetArea");
  const terraceInput = document.getElementById("terraceArea");
  const parkingInput = document.getElementById("parkingArea");
  const totalAreaInput = document.getElementById("totalPlotArea");

  const carpet = parseFloat(carpetInput.value) || 0;
  const terrace = parseFloat(terraceInput.value) || 0;
  const parking = parseFloat(parkingInput.value) || 0;
  const total = parseFloat(totalAreaInput.value) || 0;

  const sum = carpet + terrace + parking;

  if (sum > total) {
    document.getElementById("areaTypeSumMessage").style.display = "block"; // Show error message
    return false;
  } else {
    document.getElementById("areaTypeSumMessage").style.display = "none"; // Hide error message
    return true;
  }
};

// next button step validation for empty fields
function validateAndNextStep() {
  const currentStepElement = document.querySelector(".step.active");
  const requiredFields = currentStepElement.querySelectorAll("[required]");

  let allValid = true;

  for (let field of requiredFields) {
    if (!field.reportValidity()) {
      allValid = false;
      break;
    }
  }

  if (currentStep === 3) {
    // condition to check additional areas input field
    if (!validateAreaSelection() || !validateAreaSum()) {
      //check if sum of additional areas is greater then total area.
      allValid = false;
    }
  }

  //checking for step 4 that any image is selected with(Main Card Image) as viewtype then only form processd to next step
  if (currentStep === 4) {
    // Check if any image is input first
    const imageInputs = document.querySelectorAll(
      'input[type="file"][required]'
    );
    const anyImageSelected = Array.from(imageInputs).some(
      (input) => input.files.length > 0
    );

    if (!anyImageSelected) {
      allValid = false;
      // Let default browser validation handle this (no alert needed)
      return;
    }

    const allFiles = mediaInput.files;
    const hasImage = Array.from(allFiles).some((file) => file.type.startsWith("image/"));
    //hasImage returns true aur false boolean result...
    //if not a image in list then dont move to next step
    if(!hasImage) {
      allValid = false;
      alert('Please Upload atleast One Image (Main Card Image Required)');
      return;
    }

    //Check if any image has 'Main Card Image' (value 5) selected
    const selects = document.querySelectorAll(".view-type-select");
    const isMainCardImgSelected = Array.from(selects).some((select) => select.value === "5");
    if (!isMainCardImgSelected) {
      allValid = false;
      alert("Please select 'Main Card Image' for at least one image.");
    }

  }

  if (allValid && currentStep < totalSteps) {
    nextStep(); // Only proceed if all fields are valid
  }
}

// Function to Update Progress Bar Based on Current Step
function updateProgressBar() {
  const steps = document.querySelectorAll(".progress-step");
  steps.forEach((step) => {
    const stepNum = parseInt(step.dataset.step);
    if (stepNum < currentStep) {
      step.classList.add("completed");
      step.classList.remove("active");
    } else if (stepNum === currentStep) {
      step.classList.add("active");
      step.classList.remove("completed");
    } else {
      step.classList.remove("active", "completed");
    }
  });
}

// Generate Progress Bar Dynamically
const stepProgressContainer = document.getElementById("stepProgress");
const stepNames = [
  "Location Info",
  "Basic Info",
  "Property Info",
  "Upload Media",
  "Price Info",
  "Feature Info",
];
const stepDetails = [
  "Provide location details",
  "Provide basic property details",
  "Enter detailed property info",
  "Upload property images or videos",
  "Provide pricing information",
  "Provide unique features of property",
];

for (let i = 1; i <= totalSteps; i++) {
  console.log("Current Step: ", i);
  stepProgressContainer.innerHTML += `
        <div class="progress-step ${i == 1 ? "active" : ""}" data-step="${i}">
          <div class="circle">${i}</div>
          ${i <= totalSteps ? '<div class="line"></div>' : ""}
          <div class="step-text">
            <h5>${stepNames[i - 1]}</h5>
            <p>${stepDetails[i - 1]}</p>
          </div>
        </div>`;
}
