<!-- final design -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.13.1/font/bootstrap-icons.min.css" integrity="sha512-t7Few9xlddEmgd3oKZQahkNI4dS6l80+eGEzFQiqtyVYdvcSG2D3Iub77R20BdotfRPA9caaRkg1tyaJiPmO0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    <title>FindSpace Header</title>
    <style>
      body {
        background-color: #f8f9fa;
      }

      .hero-section {
        position: relative;
        padding: 120px 0 100px;
      }

      .hero-bg-img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        z-index: -1;
        /*opacity: 0.3;*/
      }

      .hero-title {
        font-size: 2.5rem;
        font-weight: bold;
      }

      .hero-title span {
        color: #fdcc0d;
      }

      .hero-buttons a {
        padding: 14px 24px;
        border-radius: 10px;
        font-weight: 500;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        position: relative;
        color: #212529;
        transition: background-color 0.3s, color 0.3s;
        border: none;
        background-color: white;
      }

      .hero-buttons a i {
        margin-right: 8px;
      }

      .hero-buttons .active-btn {
        background-color: #0d6efd;
        color: #fff !important;
      }

      .hero-buttons .active-btn::after {
        content: "";
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 0;
        height: 0;
        border-left: 10px solid transparent;
        border-right: 10px solid transparent;
        border-top: 10px solid #0d6efd;
      }

      .hero-buttons a:hover {
        background-color: #0d6efd;
        color: #fff !important;
      }

      .search-box input,
      .search-box select {
        border-radius: 10px;
        background-color: #f8f9fa;
      }

      .search-box .btn {
        border-radius: 10px;
      }

      .search-box {
        opacity: 1;
        transition: opacity 0.5s ease, transform 0.5s ease;
        margin-top: 20px;
      }

      .search-box.hide {
        opacity: 0;
        transform: translateY(-20px);
        pointer-events: none;
      }

      /* slide 2 start */
      #how-it-works-section {
        background-color: #ffffff;
      }

      .divider-line {
        display: flex;
        justify-content: center;
        align-items: center;
      }

      .divider-line span {
        height: 6px;
        background-color: #fd0d5e;
        border-radius: 10px;
      }

      .divider-line .part1 {
        width: 25px;
        margin-right: 8px;
      }

      .divider-line .part2 {
        width: 50px;
      }

      .step-icon {
        width: 90px;
        height: 90px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        margin: 0 auto 20px;
      }

      .step-card {
        text-align: center;
        border: none;
        padding: 30px;
        border-radius: 15px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        opacity: 0;
        transform: translateY(-50px);
        flex-direction: column;
        min-height: 100%;
      }

      .step-card.animate {
        opacity: 1;
        transform: translateY(0);
      }

      .step-card.animate.delay-0 {
        transition: opacity 0.6s ease-out, transform 0.6s ease-out;
      }

      .step-card.animate.delay-1 {
        transition: opacity 0.6s ease-out 0.2s, transform 0.6s ease-out 0.2s;
      }

      .step-card.animate.delay-2 {
        transition: opacity 0.6s ease-out 0.4s, transform 0.6s ease-out 0.4s;
      }

      .step-card:hover {
        transform: translateY(-10px) scale(1.02);
        box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
      }

      /* slide 2 end */

      /*slide 3*/
      .ptype-carousel-wrapper {
        background-color: #0d1721;
        color: white;
        padding: 80px 0;
      }

      .ptype-card-wrapper {
        overflow: hidden;
        width: 100%;
      }

      .ptype-card-slider {
        display: flex;
        gap: 30px;
        transition: transform 0.6s ease-in-out;
      }

      .ptype-property-card {
        background-color: white;
        color: #0d1721;
        width: 200px;
        height: 250px;
        padding: 30px 20px;
        border-radius: 20px;
        text-align: center;
        flex-shrink: 0;
        transition: transform 0.3s ease;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        display: flex;
        flex-direction: column;
        justify-content: center;
      }

      .ptype-property-card h4 {
        margin: 15px 0 5px 0;
        font-weight: 600;
        font-size: 22px;
      }

      .ptype-property-card p {
        color: #6c757d;
        font-size: 18px;
      }

      .ptype-arrow-container {
        position: relative;
        display: flex;
        gap: 15px;
        align-items: center;
        margin-top: 20px;
      }

      .ptype-arrow-container::before {
        content: "";
        position: absolute;
        top: -10px;
        left: 0;
        right: 0;
        height: 5px;
        background-color: rgb(240, 240, 5);
        border-radius: 10px;
      }

      .ptype-arrow-btn {
        background: white;
        color: #0d1721;
        border-radius: 50%;
        width: 60px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 32px;
        font-weight: bold;
        border: none;
        position: relative;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
      }

      .ptype-arrow-btn:hover {
        background-color: #f0f0f0;
      }

      .ptype-property-card img {
        width: 80px;
        height: 80px;
      }

      .ptype-step-icon {
        border-radius: 50%;
        width: 100px;
        height: 100px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px auto;
        background-color: transparent;
        font-size: 80px;
      }

      /*slide 3*/

      /* slide 4 */
      .cities4-section {
        padding: 40px 0;
        text-align: center;
      }

      .cities4-section h2 {
        font-weight: 800;
        font-size: 36px;
        color: #212529;
      }

      .cities4-divider-line {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 10px auto 5px;
      }

      .cities4-divider-line span {
        height: 5px;
        border-radius: 5px;
        display: inline-block;
      }

      .cities4-pink {
        background-color: #e91e63;
        width: 20px;
        margin-right: 5px;
      }

      .cities4-purple {
        background-color: #6f42c1;
        width: 30px;
      }

      .cities4-section p {
        color: #6c757d;
        font-size: 18px;
        margin-bottom: 40px;
      }

      .cities4-slider {
        display: flex;
        transition: transform 1s ease-in-out;
      }

      .cities4-column {
        display: flex;
        flex-direction: column;
        gap: 24px;
        width: 410px;
        margin: 0 12px;
        flex-shrink: 0;
      }

      .cities4-card {
        position: relative;
        border-radius: 15px;
        overflow: hidden;
        transition: transform 0.4s ease;
        cursor: pointer;
        height: 260px;
      }

      .cities4-card img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
        transform-origin: center;
      }

      .cities4-card:hover img {
        transform: scale(1.1) rotate(4deg);
      }

      .cities4-card:hover .cities4-arrow-btn {
        opacity: 1;
        transform: scale(1);
      }

      .cities4-info {
        position: absolute;
        bottom: 15px;
        left: 20px;
        color: #fff;
        text-align: left;
      }

      .cities4-info h5 {
        font-size: 20px;
        font-weight: 700;
      }

      .cities4-info p {
        margin: 0;
        font-size: 14px;
        font-weight: 500;
        color: #ddd;
      }

      .cities4-arrow-btn {
        font-family: 'Arial Black', sans-serif;
        position: absolute;
        bottom: -10px;
        right: -8px;
        background-color: #00c28a;
        color: #fff;
        width: 70px;
        height: 70px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        font-weight: bold;
        border: none;
        opacity: 0;
        transform: translateY(20px) scale(0.5);
        transition: all 0.4s ease;
        z-index: 2;
      }

      .cities4-dot-nav {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px auto 0;
        padding: 0;
        list-style: none;
      }

      .cities4-dot-nav li {
        margin: 0 8px;
      }

      .cities4-dot-nav button {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        border: none;
        background-color: #ccc;
        transition: all 0.4s ease-in-out;
      }

      .cities4-dot-nav button.active {
        width: 36px;
        height: 12px;
        border-radius: 8px;
        background-color: #00c28a;
      }

      /* slide 4 */

      /* slide 5 */
      .overview-section-wrapper {
        align-items: center;
        min-height: 210px;
      }

      .stat-box {
        padding: 16px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease;
        height: auto;
      }

      .stat-box:hover {
        transform: translateY(-10px);
      }

      .stat-content {
        display: flex;
        align-items: center;
        gap: 15px;
      }

      .stat-box img {
        width: 64px;
        height: 64px;
      }

      .stat-text h5 {
        font-weight: 700;
        color: #212529;
        margin-bottom: 4px;
      }

      .stat-text p {
        margin: 0;
        font-weight: 500;
        color: #6c757d;
      }

      /* slide 5 */

      /* slide 6 */
      .faq-section-wrapper {
        font-family: 'Segoe UI', sans-serif;
        background: #f1f4f8;
      }

      .faq-section-wrapper .header {
        text-align: center;
        padding: 40px 20px 10px;
      }

      .faq-section-wrapper .header h2 {
        font-weight: 700;
        font-size: 32px;
        margin-bottom: 10px;
      }

      .color-line {
        display: flex;
        justify-content: center;
        gap: 4px;
        margin-bottom: 10px;
      }

      .color-line span {
        width: 20px;
        height: 4px;
        border-radius: 2px;
      }

      .green {
        background: #00e599;
      }

      .blue {
        background: #3b82f6;
      }

      .purple {
        background: #a855f7;
      }

      .sub-text {
        color: #6c757d;
        font-size: 16px;
      }

      .main-section {
        display: flex;
        padding: 0 60px 60px;
        gap: 20px;
        justify-content: center;
        align-items: stretch;
        min-height: 80vh;
      }

      .left-image {
        flex: 0 0 38%;
        display: flex;
        align-items: center;
      }

      .left-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
      }

      .right-faq {
        flex: 0 0 52%;
        background: #e4e4e4;
        padding: 24px;
        border-radius: 10px;
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
        display: flex;
        flex-direction: column;
        justify-content: center;
      }

      .accordion-button {
        font-weight: 600;
        color: #333;
        background-color: transparent;
      }

      .accordion-item {
        border-radius: 6px;
        overflow: hidden;
        border: 1px solid #ddd;
        margin-bottom: 12px;
      }

      .accordion-button:focus {
        box-shadow: none;
      }

      .accordion-body {
        font-size: 15px;
        color: #555;
      }

      @media (max-width: 768px) {
        .main-section {
          flex-direction: column;
          padding: 20px;
        }

        .left-image,
        .right-faq {
          width: 100%;
          flex: none;
          height: auto;
        }

        .left-image img {
          height: auto;
        }
      }

      /* slide 6 */
    </style>
  </head>

  <body>
    <div>
      <!-- header start -->
      <c:import url="pages/header.jsp" />
      <!-- header end -->

      <!-- main content start -->

      <!-- slide 1 start -->
      <div class="hero-wrapper">
        <section class="hero-section">
          <img src="static/media/images/hero-bg.jpg" alt="Background" class="hero-bg-img img-fluid" />
          <div class="container">
            <div class="row align-items-center">
              <div class="col-lg-6 text-center text-lg-start">
                <h1 class="hero-title mb-3">
                  Find Your Best Dream House for<br>
                  <span>Rental, Buy & Sell...</span>
                </h1>
                <p class="text-muted mb-4">Properties for buy / rent in your location. We have more than 3000+ listings
                  for you to choose.</p>
                <div class="hero-buttons d-flex gap-3 justify-content-center justify-content-lg-start mb-3">
                  <a href="#" class="active-btn" id="btnBuy"><i class="fas fa-house"></i> Buy a Property</a>
                  <a href="#" class="btn-outline-secondary" id="btnRent"><i class="fas fa-key"></i> Rent a Property</a>
                </div>
              </div>
              <div class="col-lg-6 d-none d-lg-block">
                <!-- <img src="https://i.ibb.co/VWhYmL5/hero-house.png" alt="Dream House" class="img-fluid" /> -->
              </div>
            </div>

            <div class="search-box bg-white shadow rounded-4 p-4" id="searchBox">
              <form class="row g-3">
                <div class="col-md-5">
                  <select class="form-select bg-light">
                    <option selected>Select City</option>
                    <option>Delhi</option>
                    <option>Mumbai</option>
                    <option>Bangalore</option>
                  </select>
                </div>
                <div class="col-md-5">
                  <select class="form-select bg-light">
                    <option selected>Property Type</option>
                    <option>Apartment</option>
                    <option>Studio</option>
                    <option>Shared Room</option>
                  </select>
                </div>
                <div class="col-md-2">
                  <button type="submit" class="btn btn-warning w-100 my-search-btn">
                    <i class="fas fa-search"></i>
                  </button>
                </div>
              </form>
            </div>
          </div>
        </section>
      </div>
      <!-- slide 1 end -->


      <!-- slide 2 start -->
      <!-- how-it-works.html -->
      <div id="how-it-works-section" class="py-5" style="padding-bottom: 4rem !important;">
        <div class="container text-center">
          <h2 class="fw-bold fs-2">How It Works</h2>
          <div class="divider-line mb-3">
            <span class="part1"></span>
            <span class="part2"></span>
          </div>
          <p class="text-muted mb-5 fw-semibold fs-5">Follow these 3 steps to book your place</p>

          <div class="row g-4 d-flex align-items-stretch h-100">
            <div class="col-md-4 d-flex">
              <div class="step-card delay-0 w-100 h-100">
                <div class="step-icon bg-primary">
                  <img src="https://img.icons8.com/ios-filled/50/ffffff/map-marker.png" alt="Search Icon" />
                </div>
                <h5 class="fw-semibold mt-3">01. Search for Location</h5>
                <p class="text-muted">Enter your desired city or area and explore available properties that match your
                  preferences.</p>
              </div>
            </div>
            <div class="col-md-4">
              <div class="step-card delay-1 w-100 h-100">
                <div class="step-icon" style="background-color: #ff3258;">
                  <img src="https://img.icons8.com/ios-filled/50/ffffff/real-estate.png" alt="Property Icon" />
                </div>
                <h5 class="fw-semibold mt-3">02. Select Property Type</h5>
                <p class="text-muted">Choose the type of property you want, such as an apartment, studio, or shared
                  room.
                </p>
              </div>
            </div>
            <div class="col-md-4">
              <div class="step-card delay-2 w-100 h-100">
                <div class="step-icon" style="background-color: #00c28a;">
                  <img src="https://img.icons8.com/ios-filled/50/ffffff/online-store.png" alt="Book Icon" />
                </div>
                <h5 class="fw-semibold mt-3">03. Book Your Property</h5>
                <p class="text-muted">Confirm your booking instantly and get ready to move into your new home with ease.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- slide 2 end -->

      <!-- slide 3 start -->
      <!-- Property Type Carousel Component -->
      <div class="ptype-carousel-wrapper">
        <div class="container">
          <div class="row align-items-center">
            <div class="col-md-3">
              <h2><strong>Explore by</strong><br>Property Type</h2>
              <p>Find the perfect type of property for your needs - from homes and offices to luxury villas and
                apartments.</p>
              <div class="ptype-arrow-container">
                <button class="ptype-arrow-btn" onclick="ptypeMoveLeft()"><i class="fas fa-chevron-left"></i></button>
                <button class="ptype-arrow-btn" onclick="ptypeMoveRight()"><i class="fas fa-chevron-right"></i></button>
              </div>
            </div>
            <div class="col-md-9">
              <div class="ptype-card-wrapper">
                <div class="ptype-card-slider" id="ptype-slider">
                  <div class="ptype-property-card">
                    <div class="ptype-step-icon">
                      <i class="bi bi-house-door"></i>
                    </div>
                    <h4>Houses</h4>
                    <p>30 Properties</p>
                  </div>
                  <div class="ptype-property-card">
                    <div class="ptype-step-icon">
                      <i class="bi bi-pc-display"></i>
                    </div>
                    <h4>Offices</h4>
                    <p>25 Properties</p>
                  </div>
                  <div class="ptype-property-card">
                    <div class="ptype-step-icon">
                      <i class="bi bi-buildings-fill"></i>
                    </div>
                    <h4>Villas</h4>
                    <p>40 Properties</p>
                  </div>
                  <div class="ptype-property-card">
                    <div class="ptype-step-icon">
                      <i class="bi bi-building"></i>
                    </div>
                    <h4>Apartment</h4>
                    <p>35 Properties</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- slide 3 end -->


      <!-- slide 4 start -->
      <!-- cities with listing  -->
      <div class="cities4-wrapper">
        <section class="cities4-section">
          <div class="container">
            <h2>Cities With Listing</h2>
            <div class="cities4-divider-line">
              <span class="cities4-pink"></span>
              <span class="cities4-purple"></span>
            </div>
            <p>Destinations we love the most</p>

            <div class="overflow-hidden">
              <div class="cities4-slider" id="cities4-slider">
                <!-- First Columns -->
                <div class="cities4-column">
                  <div class="cities4-card"><img src="static/media/images/punee.jpg" alt="Pune">
                    <div class="cities4-info">
                      <h5>Pune(Maharashtra)</h5>
                      <p>300 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                  <div class="cities4-card"><img src="static/media/images/ahmedabad.jpg" alt="Ahmedabad">
                    <div class="cities4-info">
                      <h5>Ahmedabad(Gujarat)</h5>
                      <p>740 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                </div>
                <!-- Second Columns -->
                <div class="cities4-column">
                  <div class="cities4-card"><img src="static/media/images/banglore.jpg" alt="Pune">
                    <div class="cities4-info">
                      <h5>Bangalore(Karnataka)</h5>
                      <p>400 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                  <div class="cities4-card"><img src="static/media/images/Chandigarhh.jpg" alt="Ahmedabad">
                    <div class="cities4-info">
                      <h5>Chandigarh(Haryana)</h5>
                      <p>1450 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                </div>
                <!-- Third Columns -->
                <div class="cities4-column">
                  <div class="cities4-card"><img src="static/media/images/hyderabad.jpg" alt="Pune">
                    <div class="cities4-info">
                      <h5>Hyderabad(Karnataka)</h5>
                      <p>300 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                  <div class="cities4-card"><img src="static/media/images/lucknow.jpg" alt="Ahmedabad">
                    <div class="cities4-info">
                      <h5>Lucknow(Uttar Pradesh)</h5>
                      <p>400 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                </div>
                <!-- Fourth Columns -->
                <div class="cities4-column">
                  <div class="cities4-card"><img src="static/media/images/delhi.jpg" alt="Pune">
                    <div class="cities4-info">
                      <h5>Delhi(Haryana)</h5>
                      <p>500 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                  <div class="cities4-card"><img src="static/media/images/jaipur.jpg" alt="Ahmedabad">
                    <div class="cities4-info">
                      <h5>Jaipur(Rajasthan)</h5>
                      <p>480 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                </div>
                <!-- Fifth Columns -->
                <div class="cities4-column">
                  <div class="cities4-card"><img src="static/media/images/bhopal.jpg" alt="Pune">
                    <div class="cities4-info">
                      <h5>Bhopal(Madhya Pradesh)</h5>
                      <p>920 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                  <div class="cities4-card"><img src="static/media/images/kochi.jpg" alt="Ahmedabad">
                    <div class="cities4-info">
                      <h5>Kochi(Kerala)</h5>
                      <p>610 Properties</p>
                    </div><button class="cities4-arrow-btn"><i class="fas fa-arrow-right"></i></button>
                  </div>
                </div>
              </div>
            </div>

            <ul class="cities4-dot-nav" id="cities4-dotNav">
              <li><button class="active" onclick="cities4SlideTo(0, this)"></button></li>
              <li><button onclick="cities4SlideTo(1, this)"></button></li>
              <li><button onclick="cities4SlideTo(2, this)"></button></li>
            </ul>
          </div>
        </section>
      </div>
      <!-- slide 4 end -->

      <!-- slide 5 start -->
      <div class="overview-section-wrapper">
        <section class="bg-dark text-light" style="padding-top: 80px; padding-bottom: 80px">
          <div class="container">
            <div class="row g-4 text-center">

              <div class="col-12 col-sm-6 col-lg-3">
                <div class="stat-box">
                  <div class="stat-content">
                    <img
                      src="static/media/images/listings-added.svg"
                      alt="Icon 1">
                    <div class="stat-text text-start">
                      <h5>50K</h5>
                      <p>Listings Added</p>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-12 col-sm-6 col-lg-3">
                <div class="stat-box">
                  <div class="stat-content">
                    <img
                      src="static/media/images/agents-listed.svg"
                      alt="Icon 2">
                    <div class="stat-text text-start">
                      <h5>3000+</h5>
                      <p>Agents Listed</p>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-12 col-sm-6 col-lg-3">
                <div class="stat-box">
                  <div class="stat-content">
                    <img
                      src="static/media/images/sales-completed.svg"
                      alt="Icon 3">
                    <div class="stat-text text-start">
                      <h5>2000+</h5>
                      <p>Sales Completed</p>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-12 col-sm-6 col-lg-3">
                <div class="stat-box">
                  <div class="stat-content">
                    <img
                      src="static/media/images/users.svg"
                      alt="Icon 4">
                    <div class="stat-text text-start">
                      <h5>5000+</h5>
                      <p>Users</p>
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </section>
      </div>
      <!-- slide 5 end -->

      <!-- slide 6 start -->
      <div class="faq-section-wrapper">
        <div class="header">
          <h2>Frequently Asked Questions</h2>
          <div class="color-line">
            <span class="green"></span>
            <span class="blue"></span>
            <span class="purple"></span>
          </div>
          <p class="sub-text">Ready to buy your dream home? find it here.</p>
        </div>

        <div class="container-fluid main-section">
          <div class="left-image">
            <img src="static/media/images/faq.jpg" alt="Home View" />
          </div>
          <div class="right-faq">
            <div class="accordion" id="faqAccordion">
              <!-- FAQ Item 1 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="headingOne">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapseOne">
                    What is real estate?
                  </button>
                </h2>
                <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">Real estate refers to land and any permanent structures on it, such as
                    homes or buildings.</div>
                </div>
              </div>

              <!-- FAQ Item 2 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="headingTwo">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapseTwo">
                    What types of properties are included in real estate?
                  </button>
                </h2>
                <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">Residential, commercial, industrial, and land properties are included in
                    real estate.</div>
                </div>
              </div>

              <!-- FAQ Item 3 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="headingThree">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapseThree">
                    How do I start the home-buying process?
                  </button>
                </h2>
                <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">Start by determining your budget, getting pre-approved, and finding a
                    reputable agent.</div>
                </div>
              </div>

              <!-- FAQ Item 4 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="headingSix">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapseSix">
                    Can I buy property without a real estate agent?
                  </button>
                </h2>
                <div id="collapseSix" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">Yes, it's possible to buy property without an agent, but an agent helps
                    with paperwork, negotiations, and ensures a smooth transaction.</div>
                </div>
              </div>

              <!-- FAQ Item 5 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="headingSeven">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapseSeven">
                    How long does the home-buying process take?
                  </button>
                </h2>
                <div id="collapseSeven" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">On average, the process takes 30 to 60 days, depending on financing,
                    inspections, and negotiations.</div>
                </div>
              </div>

              <!-- FAQ Item 6 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="headingFive">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapseFive">
                    What are closing costs?
                  </button>
                </h2>
                <div id="collapseFive" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">Closing costs are additional fees paid at the end of a real estate
                    transaction, including taxes, insurance, and lender fees.</div>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
      <!-- slide 6 end -->

      <!-- footer start -->
      <c:import url="pages/footer.jsp" />
      <!-- footer end -->
    </div>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      const btnBuy = document.getElementById('btnBuy');
      const btnRent = document.getElementById('btnRent');
      const searchBox = document.getElementById('searchBox');

      function toggleButtons(activeBtn, inactiveBtn) {
        activeBtn.classList.add('active-btn');
        activeBtn.classList.remove('btn-outline-secondary');
        inactiveBtn.classList.remove('active-btn');
        inactiveBtn.classList.add('btn-outline-secondary');
      }

      function animateSearchBox() {
        searchBox.classList.add('hide');
        setTimeout(() => searchBox.classList.remove('hide'), 400);
      }

      btnBuy.addEventListener('click', function (e) {
        e.preventDefault();
        toggleButtons(btnBuy, btnRent);
        animateSearchBox();
      });

      btnRent.addEventListener('click', function (e) {
        e.preventDefault();
        toggleButtons(btnRent, btnBuy);
        animateSearchBox();
      });

      // slide 2 start
      // Animate cards on scroll
      document.addEventListener("DOMContentLoaded", function () {
        const cards = document.querySelectorAll('.step-card');

        const observer = new IntersectionObserver(entries => {
          entries.forEach(entry => {
            if (entry.isIntersecting) {
              entry.target.classList.add('animate');
            }
          });
        }, {
          threshold: 0.2
        });

        cards.forEach(card => {
          observer.observe(card);
        });
      });

      // slide 2 end


      // ptype slide 3 start
      let ptypeIsAnimating = false;

      function ptypeMoveLeft() {
        if (ptypeIsAnimating) return;
        ptypeIsAnimating = true;

        const slider = document.getElementById('ptype-slider');
        const cards = slider.children;
        slider.insertBefore(cards[cards.length - 1], cards[0]);
        slider.style.transition = 'none';
        slider.style.transform = 'translateX(-230px)';

        requestAnimationFrame(() => {
          slider.style.transition = 'transform 0.6s ease-in-out';
          slider.style.transform = 'translateX(0)';
          setTimeout(() => {
            ptypeIsAnimating = false;
          }, 600);
        });
      }

      function ptypeMoveRight() {
        if (ptypeIsAnimating) return;
        ptypeIsAnimating = true;

        const slider = document.getElementById('ptype-slider');
        const card = slider.children[0];
        slider.style.transition = 'transform 0.6s ease-in-out';
        slider.style.transform = 'translateX(-230px)';

        setTimeout(() => {
          slider.appendChild(card);
          slider.style.transition = 'none';
          slider.style.transform = 'translateX(0)';
          ptypeIsAnimating = false;
        }, 600);
      }
      // ptype slide 3 end



      // slide 4 start
      function cities4SlideTo(index, btn) {
        index = parseInt(index); // ensure it's number
        const slider = document.getElementById('cities4-slider');
        const column = document.querySelector('.cities4-column');

        if (!slider || !column) {
          console.error("Slider or column not found");
          return;
        }

        const columnWidth = column.offsetWidth + 24;
        const translateX = index * columnWidth;

        // Console checks
        console.log("Slider:", slider);
        console.log("Column Width:", columnWidth);
        console.log("Index:", index);
        console.log("TranslateX Value:", `-${translateX}px`);
        console.log("Type of index:", typeof index);
        console.log("Type of columnWidth:", typeof columnWidth);

        // FIXED LINE
        const transformValue = "translateX(-" + translateX + "px)";
        console.log("Final transform string:", transformValue);

        slider.style.transform = transformValue;

        document.querySelectorAll('.cities4-dot-nav button').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
      }

      window.addEventListener('DOMContentLoaded', () => {
        const firstBtn = document.querySelector('.cities4-dot-nav button');
        if (firstBtn) cities4SlideTo(0, firstBtn);
      });
      // slide 4 end

    </script>
  </body>

  </html>