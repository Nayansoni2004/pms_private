<!-- final  -->
<!-- step-1,2,3,4,5 and 6 final design -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="utils.NameFormatter" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Multi-Step Property Form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="static/css/addnewproperty.css">
</head>

<body class="overflow-y-hidden">
    <!-- Navbar Section -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm p-2 sticky-top" style="height: 13vh;">
        <div class="container-fluid">
            <!-- Logo and Brand Name -->
            <a href="index.do" class="navbar-brand d-flex align-items-center">
                <img src="static/media/images/logo1.png" alt="logo" class="me-2" />
                <span class="fs-3 fw-bold"><span class="text-dark">Find</span><span
                        class="text-warning">Space</span></span>
            </a>

            <div class="ms-auto d-flex align-items-center">
                <div class="profile-pic">
                    <img src="${sessionScope.loggedUser.profilePic != null ? sessionScope.loggedUser.profilePic : 'static/media/images/dummy_profile.png'}"
                        alt="Profile Picture" class="rounded-circle me-2" width="40" height="40" />
                </div>
                <span class="fw-bold me-2">${sessionScope.loggedUser.name}</span>
                <div class="dropdown">
                    <i class="fa-solid fa-chevron-down user-dropdown" data-bs-toggle="dropdown"></i>
                    <ul class="dropdown-menu dropdown-menu-end mt-3">
                        <li>
                            <a href="dashboard.do" class="dropdown-item">
                                <i class="fa-solid fa-house"></i>
                                My Dashboard
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- Form & Progress BAr Container -->
    <div class="container overflow-y-hidden" style="height: 88vh;">

        <!-- Progress Bar Section -->
        <div class="step-progress w-25 mt-5" id="stepProgress">
            <!-- Steps will be dynamically inserted here -->
        </div>

        <div class="form-container w-50 py-5 overflow-y-scroll overflow-x-hidden" style="height: 100%;">
            <form action="addNewProperty.do" method="post" id="propertyForm" enctype="multipart/form-data">

                <!-- Step 1: Property Location with Floating Labels -->
                <div class="step active" data-step="1">
                    <!-- Set the first name from session -->
                    <c:set var="firstName" value="${sessionScope.loggedUser.name}" />
                    <!-- Display the formatted first name -->
                    <h4 class="mb-3"><i class="fa-regular fa-thumbs-up"></i> Welcome back, <%= NameFormatter.getFormattedFirstName((String) pageContext.getAttribute("firstName")) %>!</h4>
                    
                    <h5><i class="fa-solid fa-location-dot"></i> Where is your property located?</h5>
                    <p>An accurate location helps you connect with the right buyers.</p>

                    <div class="form-floating mb-3">
                        <select name="city" id="city" class="form-select" required>
                            <option value="" disabled selected>Select City</option>
                            <c:forEach var="ct" items="${cities}">
                                <option value="${ct.city}(${ct.state.state})" data-id="${ct.cityId}">
                                    ${ct.city} (${ct.state.state})
                                </option>
                            </c:forEach>
                        </select>
                        <!-- Hidden field to get cities from application -->
                        <input type="hidden" name="city_id" id="city_id">
                        <label for="city"><i class="fa-solid fa-city"></i> City</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" id="address" name="address" class="form-control" placeholder="Address"
                            required />
                        <label for="address"><i class="fa-solid fa-road"></i> Address</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" id="society" name="society" class="form-control" placeholder="Society Name"
                            required />
                        <label for="society"><i class="fa-solid fa-building"></i> Society Name</label>
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn btn-primary" onclick="validateAndNextStep()"><i
                                class="fa-solid fa-arrow-right"></i> Next</button>
                    </div>
                </div>

                <!-- Step 2: Basic Details -->
                <div class="step" data-step="2">
                    <h4 class="mb-3"><i class="fa-solid fa-file-alt"></i> Fill out basic details</h4>
                    <h5><i class="fa-solid fa-handshake"></i> I'm looking to:</h5>
                    <div class="btn-group mb-3" role="group">
                        <input type="radio" class="btn-check" name="action_Type" id="sell" value="Sell" required>
                        <label class="btn btn-outline-primary" for="sell"><i class="fa-solid fa-tag"></i> Sell</label>

                        <input type="radio" class="btn-check" name="action_Type" id="rent" value="Rent" required>
                        <label class="btn btn-outline-primary" for="rent"><i class="fa-solid fa-key"></i> Rent</label>
                    </div>

                    <h5><i class="fa-solid fa-building"></i> What type of property do you have?</h5>
                    <div class="btn-group mb-3" role="group">
                        <input type="radio" class="btn-check" name="category" id="residential"
                            value="Residential" required onclick="togglePropertyOptions('residential')">
                        <label class="btn btn-outline-primary" for="residential"><i class="fa-solid fa-house-user"></i>
                            Residential</label>

                        <input type="radio" class="btn-check" name="category" id="commercial" value="Commercial"
                            required onclick="togglePropertyOptions('commercial')">
                        <label class="btn btn-outline-primary" for="commercial"><i class="fa-solid fa-store"></i>
                            Commercial</label>
                    </div>

                    <div id="residentialOptions" class="d-none">
                        <label><i class="fa-solid fa-building-circle-check"></i> Select Residential Type:</label>
                        <select class="form-select" name="propertyTypeId" id="residentialSelect">
                            <option value="" disabled selected>Select</option>
                            <option value="1">Flat/Apartment</option>
                            <option value="2">Independent House</option>
                            <option value="3">Residential Plot/Land</option>
                            <option value="4">Farmhouse</option>
                            <option value="5">Bungalow</option>
                            <option value="6">Rowhouse</option>
                        </select>
                    </div>

                    <div id="commercialOptions" class="d-none">
                        <label><i class="fa-solid fa-building-flag"></i> Select Commercial Type:</label>
                        <select class="form-select" name="propertyTypeId" id="commercialSelect">
                            <option value="" disabled selected>Select</option>
                            <option value="7">Office</option>
                            <option value="8">Retail Shop</option>
                            <option value="9">Commercial Plot/Land</option>
                            <option value="10">Warehouse</option>
                            <option value="11">Godown</option>
                            <option value="12">Commercial Building</option>
                        </select>
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn btn-secondary" onclick="prevStep()"><i
                                class="fa-solid fa-arrow-left"></i> Back</button>
                        <button type="button" class="btn btn-primary" onclick="validateAndNextStep()"><i
                                class="fa-solid fa-arrow-right"></i> Next</button>
                    </div>
                </div>

                <!-- Step 3: property details -->
                <div class="step" data-step="3">
                    <h4 class="mb-3"><i class="fa-solid fa-building icon-label"></i> Tell us about your property</h4>
                    <p>Please provide the essential details about your property to help potential buyers or renters find
                        it
                        easily.</p>

                    <!-- Property Name Input -->
                    <div class="form-floating mb-3">
                        <input type="text" id="propertyName" name="propertyName" class="form-control"
                            placeholder="e.g., Green Valley Apartments" required />
                        <label for="propertyName"><i class="fa-solid fa-pen icon-label"></i> Property Name /
                            Title</label>
                    </div>

                    <!-- Number of Floors Input -->
                    <div class="form-floating mb-3">
                        <input type="number" id="floors" name="floors" class="form-control"
                            placeholder="Number of Floors" min="1" step="1" required />
                        <label for="floors"><i class="fa-solid fa-layer-group icon-label"></i> Number of Floors</label>
                    </div>

                    <!-- Number of BHK Input -->
                    <div class="form-floating mb-3">
                        <input type="number" id="bhk" name="bhk" class="form-control" placeholder="Number of BHK"
                            min="1" step="1" required />
                        <label for="bhk"><i class="fa-solid fa-bed icon-label"></i> Number of BHK</label>
                    </div>

                    <!-- Area Details Section -->
                    <h5><i class="fa-solid fa-ruler-combined icon-label"></i> Add Area Details!</h5>
                    <p>At least one area type is mandatory</p>
                    <div class="form-floating mb-3">
                        <input type="number" id="totalPlotArea" name="totalArea" class="form-control"
                            placeholder="Total Plot Area" min="1" step="1" required />
                        <label for="totalPlotArea"><i class="fa-solid fa-chart-area icon-label"></i> Total Area (in
                            sq.
                            ft.)</label>
                    </div>

                    <!-- inline error msg -->
                    <div id="areaTypeSumMessage" style="color: red; display: none;">
                        The sum of additional area types cannot be greater than total area.
                    </div>

                    <!-- Additional Areas Section -->
                    <h6>Additional Area Types</h6>
                    <div>
                        <input type="checkbox" name="areaTypeIds" value="1" id="addCarpetArea" onchange="toggleInput('carpetArea')" /> Add Carpet
                        Area
                        <input type="number" name="areaValue_1" id="carpetArea" class="form-control mt-2 hidden"
                            placeholder="Carpet Area (in sq. ft.)" min="0" step="1" />
                    </div>

                    <div>
                        <input type="checkbox" name="areaTypeIds" value="4" id="addTerraceArea" onchange="toggleInput('terraceArea')" /> Add Terrace
                        Area
                        <input type="number" name="areaValue_4" id="terraceArea" class="form-control mt-2 hidden"
                            placeholder="Terrace Area (in sq. ft.)" min="0" step="1" />
                    </div>

                    <div>
                        <input type="checkbox" name="areaTypeIds" value="9" id="addParkingArea" onchange="toggleInput('parkingArea')" /> Add Parking
                        Area
                        <input type="number" name="areaValue_9" id="parkingArea" class="form-control mt-2 hidden"
                            placeholder="Parking Area (in sq. ft.)" min="0" step="1" />
                    </div>

                    <!-- Not Applicable Option -->
                    <div>
                        <input type="checkbox" name="areaTypeIds" value="12" id="notApplicable" onchange="handleNotApplicable()" />
                        Not Applicable
                    </div>

                    <!-- Property Description Section -->
                    <h5 class="mt-4"><i class="fa-solid fa-star icon-label"></i> What makes your property unique?</h5>
                    <div class="form-floating mb-3">
                        <textarea id="propertyDescription" name="propertyDescription" class="form-control"
                            placeholder="Describe your property" required style="height: 100px"></textarea>
                        <label for="propertyDescription">Property Description</label>
                    </div>

                    <!-- Button Section -->
                    <div class="button-group">
                        <!-- <button type="button" class="btn btn-secondary" onclick="window.history.back()"><i
                            class="fa-solid fa-arrow-left"></i> Back</button>
                    <button type="button" class="btn btn-teal"><i class="fa-solid fa-arrow-right"></i> Next</button> -->
                        <button type="button" class="btn btn-secondary" onclick="prevStep()"><i
                                class="fa-solid fa-arrow-left"></i> Back</button>
                        <button type="button" class="btn btn-primary" onclick="validateAndNextStep()"><i
                                class="fa-solid fa-arrow-right"></i> Next</button>
                    </div>
                </div>

                <!-- step 4: upload property images/videos -->
                <div class="step" data-step="4">
                    <h4 class="mb-3"><i class="fa-solid fa-camera icon-label"></i> Upload Property Media</h4>
                    <p>Upload up to 5 images or videos to showcase your property.</p>

                    <!-- File Upload Section -->
                    <div class="mb-3">
                        <label for="propertyMedia" class="form-label">Select Images or Videos</label>
                        <input class="form-control" type="file" id="propertyMedia" name="propertyMedia[]" required
                            multiple accept="image/*,video/*" />
                        <small class="text-muted">Only JPG, PNG, JPEG images and MP4 videos are allowed. Max size: 10MB
                            per
                            media.</small>
                    </div>

                    <!-- Preview Section -->
                    <div id="previewContainer" class="mt-3 d-flex flex-wrap gap-3"></div>

                    <!-- Buttons -->
                    <div class="button-group">
                        <button type="button" class="btn btn-secondary" onclick="prevStep()"><i
                                class="fa-solid fa-arrow-left"></i> Back</button>
                        <button type="button" class="btn btn-primary" onclick="validateAndNextStep()"><i
                                class="fa-solid fa-arrow-right"></i> Continue</button>
                    </div>
                </div>

                <!-- step 5: price details -->
                <div class="step" data-step="5">
                    <h4 class="mb-4"><i class="fa-solid fa-tag icon-label"></i> Add Price Details!</h4>

                    <!-- Price Input Fields -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="expectedPrice" class="form-label">Expected Price</label>
                            <input type="number" id="expectedPrice" name="amount" class="form-control"
                                placeholder="Enter expected price" required />
                        </div>
                        <div class="col-md-6">
                            <label for="pricePerSqFt" class="form-label">Price per sq. ft.</label>
                            <input type="text" id="pricePerSqFt" name="pricePerSqFt" class="form-control"
                                placeholder="auto evaluate" readonly />
                        </div>
                    </div>

                    <!-- Checkboxes -->
                    <div class="mb-3">
                        <input type="checkbox" id="allInclusive" name="allInclusive" />
                        <label for="allInclusive">All inclusive price</label>
                    </div>

                    <div class="mb-3">
                        <input type="checkbox" id="taxExcluded" name="taxExcluded" />
                        <label for="taxExcluded">Tax and government charges excluded</label>
                    </div>

                    <!-- Buttons -->
                    <div class="button-group">
                        <button type="button" class="btn btn-secondary" onclick="prevStep()"><i
                                class="fa-solid fa-arrow-left"></i> Back</button>
                        <button type="button" class="btn btn-primary" onclick="validateAndNextStep()"><i
                                class="fa-solid fa-arrow-right"></i> Next</button>
                    </div>
                </div>

                <!-- step 6: property features -->
                <div class="step" data-step="6">
                    <h4 class="mb-3"><i class="fa-solid fa-star"></i> Add Unique Features!</h4>

                    <!-- Location Advantages Section -->
                    <div class="section">
                        <h5><i class="fa-solid fa-location-dot"></i> Location Advantages!</h5>
                        <p>Highlight the nearby landmarks</p>
                        <div class="feature-group">
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="1" data-label="In Kilometers">
                                 Distance from City Center
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="2" data-label="In Kilometers">
                                 Distance from Railway Station
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="3" data-label="In Kilometers">
                                 Distance from Airport
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="4" data-label="In Kilometers">
                                 Distance from Bus Terminal
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="5" data-label="In Kilometers">
                                 Nearest Hospital Distance
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="6" data-label="In Kilometers">
                                 Nearest School Distance
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="7" data-label="In Kilometers">
                                 Nearest Garden Distance
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="8" data-label="In Kilometers">
                                 Nearest Worship Place Distance
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox" value="9" data-label="In Kilometers">
                                 Nearest Community Area
                            </label>
                        </div>
                    </div>

                    <!-- Safety and Security Section -->
                    <div class="section">
                        <h5><i class="fa-solid fa-shield-halved"></i> Safety and Security</h5>
                        <div class="feature-group">
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="10" data-label="Describe this feature">
                                24/7 Security Guard
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="11" data-label="Describe this feature">
                                CCTV Surveillance
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="12" data-label="Describe this feature">
                                Gated Community
                            </label>
                        </div>
                    </div>

                    <!-- Utilities and Infrastructure Section -->
                    <div class="section">
                        <h5><i class="fa-solid fa-bolt"></i> Utilities and Infrastructure</h5>
                        <div class="feature-group">
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="13" data-label="Describe this feature">
                                Water Supply (24/7)
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="14" data-label="Describe this feature">
                                Electricity Supply
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="15" data-label="Describe this feature">
                                Power Backup
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="16" data-label="Describe this feature">
                                EV Charging Station
                            </label>
                        </div>
                    </div>

                    <!-- Parking Features Section -->
                    <div class="section">
                        <h5><i class="fa-solid fa-car"></i> Parking Features</h5>
                        <div class="feature-group">
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="17" data-label="Describe this feature">
                                Parking
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="18" data-label="Describe this feature">
                                Open Parking
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="19" data-label="Describe this feature">
                                Covered Parking
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="20" data-label="Describe this feature">
                                Visitor Parking
                            </label>
                        </div>
                    </div>

                    <!-- Building Amenities Section -->
                    <div class="section">
                        <h5><i class="fa-solid fa-building"></i> Building Amenities</h5>
                        <div class="feature-group">
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="21" data-label="Describe this feature">
                                Lift Facility
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="22" data-label="Describe this feature">
                                Swimming Pool
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="23" data-label="Describe this feature">
                                Fitness Centre/Gym
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="24" data-label="Describe this feature">
                                Clubhouse
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="25" data-label="Describe this feature">
                                Kids Play Area
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="26" data-label="Describe this feature">
                                Garden / Lawn
                            </label>
                        </div>
                    </div>

                    <!-- Property Furnishing Section -->
                    <div class="section">
                        <h5><i class="fa-solid fa-couch"></i> Property Furnishing</h5>
                        <div class="feature-group">
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="27" data-label="Describe this feature">
                                Fully Furnished
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="28" data-label="Describe this feature">
                                Semi Furnished
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="29" data-label="Describe this feature">
                                Un-furnished
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="30" data-label="Describe this feature">
                                Modular Kitchen
                            </label>
                            <label>
                                <input type="checkbox" class="feature-checkbox-other" value="31" data-label="Describe this feature">
                                Smart Home Features
                            </label>
                        </div>
                    </div>

                    <!-- hidden field to send json object in backend for the selected features and their description -->
                    <input type="hidden" id="features-json" name="features_json" />

                    <p class="mt-4 text-danger">Please provide correct information otherwise your property might get
                        blocked.</p>

                    <!-- Buttons -->
                    <div class="button-group">
                        <button type="button" class="btn btn-secondary" onclick="prevStep()"><i
                                class="fa-solid fa-arrow-left"></i> Back</button>
                        <button type="submit" class="btn btn-success"><i class="fa-solid fa-paper-plane"></i>
                            Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Validation Error Modal to select atleast one feature & atleast one additional area type-->
    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="featureModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="featureModalLabel">Selection Required</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="errorMessage">
                    <!-- dynamic message aayega yaha pr -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <script src="static/js/addnewproperty.js"> </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>