<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!-- Header Start -->
  <nav class="navbar navbar-expand-lg navbar-light bg-white shadow p-2">
    <div class="container-fluid">
      <!-- Logo and Brand Name -->
      <a href="index.do" class="navbar-brand d-flex align-items-center">
        <img src="static/media/images/logo1.png" alt="Logo" class="me-2" />
        <span class="fs-3 fw-bold"><span class="text-dark">Find</span><span class="text-warning">Space</span></span>
      </a>

      <!-- Navbar Toggler -->
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <!-- Navigation Links -->
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <a href="index.do" class="nav-link"><i class="fas fa-home"></i> Home</a>
          </li>
          <!-- when user in session show these tabs -->
          <!-- <c:choose>
          <c:when test="${not empty sessionScope.loggedUser}">
            
            
          </c:when>
        </c:choose> -->
          <li class="nav-item">
            <a href="listings.do" class="nav-link"><i class="fas fa-building"></i> Listings</a>
          </li>

          <li class="nav-item">
            <a href="#" class="nav-link"><i class="fas fa-map"></i> Explore</a>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link"><i class="fas fa-envelope"></i> Contact</a>
          </li>
        </ul>

        <!-- Search Box -->
        <form class="d-flex me-auto">
          <input type="text" class="form-control form-control-sm" placeholder="Search properties..."
            style="width: 220px" />
          <button class="btn btn-warning ms-2" type="submit">
            <i class="fas fa-search"></i>
          </button>
        </form>

        <c:choose>
          <c:when test="${not empty sessionScope.loggedUser}">
            <!-- Add New Property-->
            <div class="d-flex align-items-center">
              <a href="addNewProperty.do" class="nav-link me-4"><i class="fas fa-circle-plus"></i> Add New Property</a>
              <!-- User Profile Section Start -->
              <div class="dropdown">
                <a href="#" class="d-flex align-items-center text-decoration-none me-0" id="userDropdown"
                  data-bs-toggle="dropdown" aria-expanded="false">
                  <img
                    src="${sessionScope.loggedUser.profilePic != null ? sessionScope.loggedUser.profilePic : 'static/media/images/dummy_profile.png'}"
                    alt="User" class="rounded-circle me-2" width="40" height="40" />
                  <span class="fw-bold me-2">${sessionScope.loggedUser.name}</span>
                  <i class="fas fa-chevron-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                  <li>
                    <a href="dashboard.do" class="dropdown-item"><i class="fas fa-tachometer-alt me-2"></i> My
                      Dashboard</a>
                  </li>
                  <li>
                    <a href="#" class="dropdown-item"><i class="fas fa-user-cog me-2"></i> Account Settings</a>
                  </li>
                  <li>
                    <a href="logout.do" class="dropdown-item"><i class="fas fa-sign-out-alt me-2"></i> Logout</a>
                  </li>
                </ul>
              </div>
              <!-- User Profile Section End -->
            </div>
          </c:when>
          <c:otherwise>
            <!-- Register Button -->
            <a href="signin.do" class="btn btn-dark"><i class="fas fa-user-plus"></i> Register</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </nav>
  <!-- Header End -->