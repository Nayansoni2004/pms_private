<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Property Submission</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .content-box {
            max-width: 700px;
            margin: 60px auto;
            border: none;
        }

        .content-img {
            border-radius: 10px;
        }

        /* Navbar logo start*/
        .navbar-brand img {
            width: 70px;
            height: 70px;
            /* border-radius: 50%; */
            object-fit: cover;
        }

        @media (max-width: 768px) {
            .navbar-brand img {
                width: 40px;
                height: 40px;
            }
        }

        @media (max-width: 480px) {
            .navbar-brand img {
                width: 30px;
                height: 30px;
            }
        }
        /* Navbar logo end */
    </style>
</head>

<body>
    <!-- Navbar Start -->
    <nav class="navbar navbar-expand-lg bg-white shadow-sm p-2 py-2 sticky-top">
        <div class="container-fluid">
            <!-- Logo and Brand Name -->
            <a href="#" class="navbar-brand d-flex align-items-center">
                <img src="static/media/images/logo1.png" alt="logo" class="me-2" />
                <span class="fs-3 fw-bold"><span class="text-primary">Find</span><span
                        class="text-danger">Space</span></span>
            </a>

            <div class="d-flex align-items-center">
                <img src="${sessionScope.loggedUser.profilePic != null ? sessionScope.loggedUser.profilePic : 'static/media/images/dummy_profile.png'}"
                    alt="User Profile" class="profile-img">
                <span class="fw-bold">${sessionScope.loggedUser.name}</span>
            </div>
        </div>
    </nav>
    <!-- Navbar End -->

    <%-- Success Box --%>
        <% if("success".equals(request.getParameter("next"))) { %>
            <div class="card p-4 text-center shadow content-box">
                <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                <h2 class="text-success fw-semibold">Property Posted Successfully!</h2>
                <p class="text-muted">Your listing has been submitted and is now live on the platform.</p>
                <img src="https://via.placeholder.com/600x300?text=Property+Posted" alt="Posted Property" class="img-fluid my-3 content-img">
                <a href="dashboard.do" class="btn btn-success rounded-pill px-4">
                    <i class="fas fa-arrow-left me-2"></i>Go to Dashboard
                </a>
            </div>

            <% } else if("error".equals(request.getParameter("next"))) { %>
                <%-- Error Box --%>
                    <div class="card p-4 text-center shadow content-box">
                        <i class="fas fa-times-circle fa-3x text-danger mb-3"></i>
                        <h2 class="text-danger fw-semibold">Something Went Wrong!</h2>
                        <p class="text-muted">We couldn't post your property. Please try again later.</p>
                        <img src="https://via.placeholder.com/600x300?text=Error+Posting+Property" alt="Error"
                            class="img-fluid my-3 content-img">
                        <a href="addNewProperty.do" class="btn btn-danger rounded-pill px-4">
                            <i class="fas fa-redo me-2"></i>Try Again
                        </a>
                    </div>
                    <% } else if("expired".equals(request.getParameter("next"))) { %>
                        <%-- Session Expired Box --%>
                            <div class="card p-4 text-center shadow content-box">
                                <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                                <h2 class="text-warning fw-semibold">Session Expired!</h2>
                                <p class="text-muted">Your session has expired due to inactivity. Please sign in again
                                    to continue.</p>
                                <img src="https://via.placeholder.com/600x300?text=Session+Expired"
                                    alt="Session Expired" class="img-fluid my-3 content-img">
                                <a href="signin.do" class="btn btn-warning rounded-pill px-4 text-white">
                                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                </a>
                            </div>
                            <% } %>

                                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>