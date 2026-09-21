<!-- Profile Card Start -->
<div class="profile-card">
    <!-- Profile Picture and User Info Start -->
    <div class="profile-section">
        <img src="${sessionScope.loggedUser.profilePic != null ? sessionScope.loggedUser.profilePic : 'static/media/images/dummy_profile.png'}" alt="Profile Picture" />
        <h4>${sessionScope.loggedUser.name}</h4>
        <p class="text-muted">${sessionScope.loggedUser.email}</p>
    </div>
    <!-- Profile Picture and User Info End -->
    
    <!-- User Details Section Start -->
    <div class="mt-1 row row-cols-1 row-cols-md-2 g-5">
        <!-- Left Column Start -->
        <div class="col">
            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-user"></i> Full Name:</span>
                <span>${sessionScope.loggedUser.name}</span>
            </div>
            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-envelope"></i> Email:</span>
                <span>${sessionScope.loggedUser.email}</span>
            </div>
            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-calendar"></i> Date of Birth:</span>
                <span>${empty sessionScope.loggedUser.dob ? 'Not Provided' : sessionScope.loggedUser.dob}</span>
            </div>
            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-venus-mars"></i> Gender:</span>
                <span>${empty sessionScope.loggedUser.gender ? 'Not Provided' : sessionScope.loggedUser.gender}</span>
            </div>
        </div>
        <!-- Left Column End -->
    
        <!-- Right Column Start -->
        <div class="col">
            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-map-marker-alt"></i> Address:</span>
                <span>${empty sessionScope.loggedUser.address ? 'Not Provided' : sessionScope.loggedUser.address}</span>
            </div>
            <!-- city id -->
            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-city"></i> City Name:</span>
                <span>${sessionScope.loggedUser.city.city}(${sessionScope.loggedUser.city.state.state})</span>
            </div>

            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-phone"></i> Contact:</span>
                <span>${sessionScope.loggedUser.contact}</span>
            </div>

            <div class="info-row">
                <span class="info-label"><i class="fa-solid fa-toggle-on"></i> Account Status:</span>
                <span class="text-${sessionScope.loggedUser.status.status eq 'Active' ? 'success' : 'danger'}">${sessionScope.loggedUser.status.status}</span>
            </div>
            
        </div>
        <!-- Right Column End -->
    </div>
    <!-- User Details Section End -->

    <!-- Edit Profile Button Start -->
    <div class="text-center mt-4">
        <button class="btn btn-primary edit-btn"><i class="fa-solid fa-pen"></i> Edit Profile</button>
    </div>
    <!-- Edit Profile Button End -->
</div>
<!-- Profile Card End -->