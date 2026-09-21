<!-- user dashboard page final design -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="static/css/myprofile.css">
    <title>User Dashboard</title>
    <style>
        body,
        html {
            height: 100%;
            margin: 0;
            overflow-x: hidden;
            /* background-color: #f8f9fa; */
        }

        .wrapper {
            display: flex;
            height: 100vh;
        }

        /* Sidebar Section */
        .sidebar {
            width: 310px;
            /* Adjusted Width */
            background-color: #fff;
            padding-top: 20px;
            display: flex;
            flex-direction: column;
            border-right: 1px solid #dee2e6;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 15px 50px;
            text-decoration: none;
            color: #495057;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #f8f9fa;
        }

        .sidebar .logout {
            margin-top: auto;
            border-top: 1px solid #dee2e6;
        }

        /* Content Area Section */
        .content-area {
            flex-grow: 1;
            padding: 30px;
            overflow-y: auto;
        }

        .breadcrumb {
            background-color: #fff;
            padding: 10px;
            border-radius: 8px;
        }

        .dummy-content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 150px);
            text-align: center;
        }

        img.dummy-img {
            max-width: 300px;
            margin-bottom: 20px;
        }

        /* Navbar Section */
        .navbar-brand img {
            width: 70px;
            height: 70px;
            object-fit: cover;
        }

        /* Responsive Section */
        @media (max-width: 768px) {
            .sidebar {
                width: 250px;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                position: fixed;
                z-index: 1000;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .navbar-brand img {
                width: 40px;
                height: 40px;
            }

            .navbar-brand span {
                font-size: 1.5rem;
            }
        }

        /* property card css start */
        .object-fit-cover {
            object-fit: cover;
        }

        .icon-thin {
            font-weight: 100;
            color: #6a4c9c;
        }

        .posted-label,
        .desc-label {
            font-weight: bold;
        }

        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
            border-radius: 50rem;
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
            border-color: #0a58ca;
        }

        .btn-sm {
            padding: 0.4rem 1.5rem;
        }

        /* Reduced card height */
        .property-card {
            perspective: 1500px;
            max-width: 1100px;
            margin: auto;
            height: 310px;
        }

        .card-inner {
            position: relative;
            width: 100%;
            height: 100%;
            transition: transform 0.8s;
            transform-style: preserve-3d;
        }

        .card-inner.flipped {
            transform: rotateX(180deg);
        }

        .card-front,
        .card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            backface-visibility: hidden;
            overflow: hidden;
            border-radius: 1rem;
        }

        .card-front {
            background-color: #fff;
            z-index: 2;
        }

        .card-back {
            transform: rotateX(180deg);
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* View Type Label Styles */
        .view-type-label {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(0, 0, 0, 0.6);
            color: #fff;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        /* Tighter footer padding */
        .card-footer {
            padding-top: 0rem !important;
            padding-bottom: 0.5rem !important;
            margin-top: -10px;
        }

        @media (max-width: 768px) {
            .property-card {
                height: auto;
            }

            .card-inner {
                height: auto;
            }

            .card-front,
            .card-back {
                position: relative;
                height: auto;
            }

            .card-inner.flipped {
                transform: none;
            }

            .carousel,
            .carousel-inner,
            .carousel-item img,
            .carousel-item video {
                height: 250px;
                border-radius: 1rem;
            }

            .row.g-0 {
                flex-direction: column;
            }

            .col-md-4,
            .col-md-8 {
                width: 100%;
            }

            .card-footer {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .view-type-label {
                bottom: 5px;
                font-size: 0.75rem;
            }

            .btn-sm {
                padding: 0.4rem 1rem;
                font-size: 0.875rem;
            }
        }

        /* property card css end */
    </style>
</head>

<body class="bg-light">
    <!-- button on small screens -->
    <button class="btn btn-primary d-md-none" onclick="toggleSidebar()">☰ Menu</button>

    <div class="wrapper">
        <!-- Sidebar start-->
        <div class="sidebar">
            <a href="index.do" class="navbar-brand d-flex align-items-center mb-1">
                <img src="static/media/images/logo1.png" alt="Logo" class="me-2" />
                <span class="fs-3 fw-bold"><span class="text-dark">Find</span><span
                        class="text-warning">Space</span></span>
            </a>
            <div class="text-center mt-0">
                <img src="${sessionScope.loggedUser.profilePic != null ? sessionScope.loggedUser.profilePic : 'static/media/images/dummy_profile.png'}"
                    class="rounded-circle" alt="Profile Picture" width="70" height="70" />
                <h6 class="mt-2">${sessionScope.loggedUser.name}</h6>
                <p class="text-muted">${sessionScope.loggedUser.email}</p>
            </div>
            <a href="#" onclick="showTab('properties')"><i class="fa-solid fa-house-user me-3"></i> My Properties</a>
            <a href="#" onclick="showTab('bookings')"><i class="fa-solid fa-calendar-check me-3"></i> My Bookings</a>
            <a href="#" onclick="showTab('wishlist')"><i class="fa-solid fa-heart me-3"></i> My Wishlist</a>
            <a href="#" onclick="showTab('profile')"><i class="fa-solid fa-user me-3"></i> My Profile</a>
            <a href="logout.do" class="logout" onclick="logout()"><i class="fa-solid fa-right-from-bracket me-3"></i>
                Logout</a>
        </div>
        <!-- Sidebar end-->

        <style>
            /* hide scrollbar from all tabs */
            .dummy-content {
                scrollbar-width: none;
                /* For Firefox */
                -ms-overflow-style: none;
                /* For Internet Explorer and Edge */
                overflow-y: scroll;
                /* Ensure content is scrollable */
            }

            .dummy-content::-webkit-scrollbar {
                display: none;
                /* For Chrome, Safari, and Opera */
            }
        </style>

        <!-- Content Area start -->
        <div class="content-area overflow-hidden">
            <div id="breadcrumb" class="breadcrumb shadow-sm">My Properties</div>

            <div id="properties" class="dummy-content d-block h-100 overflow-y-scroll">
                
                <!-- <a href="addNewProperty.do" class="btn btn-success mb-5"><i class="fa-solid fa-plus me-2"></i> Add New
                    Property</a> -->
            </div>

            <div id="bookings" class="dummy-content d-none">
                <img src="static/media/images/no_property_purchased.png" class="dummy-img" alt="No Bookings" />
                <p>No properties. Buy your first property right now!</p>
                <a href="#" class="btn btn-primary"><i class="fa-solid fa-shopping-cart me-2"></i> Buy Property</a>
            </div>

            <div id="wishlist" class="dummy-content d-none">
                <img src="static/media/images/no_property_in_wishlist.jpg" class="dummy-img" alt="No Wishlist" />
                <p>No properties added to wishlist.</p>
                <a href="#" class="btn btn-info"><i class="fa-solid fa-compass me-2"></i> Explore</a>
            </div>

            <div id="profile" class="dummy-content d-none">
                <!-- my profile page -->
                <%@ include file="myprofile.jsp" %>
                    <!-- my profile page -->
            </div>
        </div>
        <!-- Content Area end -->
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script src="static/js/dashboard.js" defer></script>
</body>

</html>