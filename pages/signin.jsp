<!-- sign in page final -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="static/css/signin.css">
    <title>FindSpace - Sign In</title>
</head>

<body>
    <!-- login fail status report -->
    <input type="hidden" id="user_signin_status" value="${param.signin_status}">

    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="col-md-5">
            <!-- Logo and Brand Name -->
            <div class="d-flex justify-content-center align-items-center mb-5">
                <a href="index.do" class="logo-brand d-flex align-items-center">
                    <img src="static/media/images/logo1.png" alt="Logo" class="me-2" />
                    <h2 class="fw-bold mb-0"><span class="text-dark">Find</span><span
                            class="text-warning">Space</span></h2>
                    <!-- <span class="fs-3 fw-bold"><span class="text-primary">Find</span><span class="text-danger">Space</span></span> -->
                </a>
            </div>

            <!-- Welcome Message -->
            <h3 class="text-center mb-3 fw-bold">Hey There!!! Welcome Back.</h3>

            <!-- Sign-in Form -->
            <form action="signin.do" method="post">
                <!-- Email Input -->
                <div class="mb-4">
                    <label class="form-label">Email <span class="text-danger">*</span></label>
                    <input type="email" name="email" class="form-control" placeholder="Enter Email" required />
                    <div id="email_error" class="text-danger text-center invisible">
                        <!-- display error message -->
                    </div>
                </div>

                <!-- Password Input with Toggle Icon -->
                <div class="mb-4 password-wrapper">
                    <label class="form-label">Password <span class="text-danger">*</span></label>
                    <input type="password" name="password" class="form-control" id="password"
                        placeholder="Enter Password" required />
                    <span class="toggle-password" onclick="togglePassword()">
                        <i class="fas fa-eye" id="togglePassword"></i>
                    </span>
                    <div id="password_error" class="text-danger text-center invisible">
                        <!-- display error message -->
                    </div>
                </div>

                <!-- Remember Me and Forgot Password -->
                <div class="d-flex justify-content-between mb-5">
                    <div>
                        <input type="checkbox" id="rememberMe" />
                        <label for="rememberMe"> Remember me</label>
                    </div>
                    <a href="#" class="text-danger">Forgot Password ?</a>
                </div>

                <!-- Sign In Button -->
                <button type="submit" class="btn btn-dark w-100">Sign In</button>

                <!-- Sign Up Link -->
                <p class="text-center mt-4 signup-link">Don't have an account? <a href="signup.do">Sign Up</a></p>
            </form>
        </div>
    </div>

    <!-- modal for account activation for status 2, 3 and 4 START-->
    <div class="modal fade" id="activation_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="status_title">
                        <!-- modal title for login fail -->
                    </h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>
                        <p id="message">
                            <!-- message for login fail -->
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="sendActivationLink">Send Activation Link</button>
                </div>
            </div>
        </div>
    </div>
    <!-- modal for account activation for status 2, 3 and 4 END-->
     
    <!-- show password icon script START -->
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
    <!-- show password icon script END -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- signin js file for authentication check user -->
    <script src="static/js/signin.js"> </script>
</body>

</html>