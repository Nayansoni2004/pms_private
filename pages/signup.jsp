<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- final signup page design -->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Bootstrap and Font Awesome CSS Links -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
        <link rel="stylesheet" href="static/css/signup.css">
        <title>FindSpace - Sign Up</title>
    </head>

    <body>
        <!-- Container for Centering the Form -->
        <div class="container d-flex justify-content-center align-items-center min-vh-100">
            <div class="col-md-5">
                <!-- Logo and Header Section Start -->
                <div class="d-flex justify-content-center align-items-center mb-2">
                    <a href="index.do" class="logo-brand d-flex align-items-center">
                        <!-- Logo Image -->
                        <img src="static\media\images\logo1.png" alt="Logo" class="me-2" />
                        <h2 class="fw-bold mb-0"><span class="text-dark">Find</span><span class="text-warning">Space</span></h2>
                    </a>
                </div>
                <!-- Logo and Header Section End -->

                <!-- Form Title Section Start -->
                <h3 class="text-center mb-1 fw-bold">Signup!<br>New Account.</h3>
                <!-- Form Title Section End -->

                <!-- Signup Form Start -->
                <form action="signup.do" method="post" id="signup_form">
                    <!-- Full Name Input -->
                    <label class="form-label">Full Name <span class="text-danger">*</span></label>
                    <input type="text" name="name" class="form-control" placeholder="Enter Full Name" required />

                    <!-- Email Input -->
                    <label class="form-label">Email <span class="text-danger">*</span></label>
                    <input type="email" name="email" class="form-control" placeholder="Enter Email" required />

                    <!-- Password Input Section with Eye Icon -->
                    <label class="form-label">Password <span class="text-danger">*</span></label>
                    <div class="password-wrapper">
                        <input type="password" name="password" class="form-control" id="password" placeholder="Enter Password"
                            required />
                        <span class="toggle-password" onclick="togglePassword()">
                            <i class="fas fa-eye" id="togglePassword"></i>
                        </span>
                    </div>

                    <!-- City Input Start -->
                    <label class="form-label">City <span class="text-danger">*</span></label>
                    <input list="city_list" name="city" id="city" autocomplete="off" type="text" class="form-control" name="city" id="city" placeholder="Select City" required />
                    <!-- hidden field to get cities from application -->
                    <input type="hidden" name="city_id" id="city_id">
                    <datalist id="city_list">
                        <c:forEach var="ct" items="${cities}">
                            <option value="${ct.city}(${ct.state.state})" id="${ct.cityId}">
                        </c:forEach>
                    </datalist>
                    <!-- City Input End -->

                    <!-- Contact Input -->
                    <label class="form-label">Contact <span class="text-danger">*</span></label>
                    <input type="text" name="contact" class="form-control" placeholder="Enter Contact Number" maxlength="10" required />

                    <!-- <input type="hidden" name="status_id" value="2"> -->

                    <!-- Signup Button -->
                    <button type="submit" class="mt-3 btn btn-dark w-100">Sign Up</button>
                    <p class="text-center mt-2 signup-link">Already have account? <a href="signin.do">Sign In</a></p>
                </form>
                <!-- Signup Form End -->
            </div>
        </div>

        <!-- JavaScript for Password Toggle Functionality -->
        <script>
            function togglePassword() {
                const passwordInput = document.getElementById('password');
                const toggleIcon = document.getElementById('togglePassword');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    toggleIcon.classList.remove('fa-eye');
                    toggleIcon.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    toggleIcon.classList.remove('fa-eye-slash');
                    toggleIcon.classList.add('fa-eye');
                }
            }
        </script>

        <!-- Bootstrap JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- signup js file for city (datalist options) -->
        <script src="static/js/signup.js"> </script>
    </body>
    </html>